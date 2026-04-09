# 订单明细多人业绩分配功能设计

## 功能目标

对订单明细实现多人业绩分配模式，支持多个技师共享同一条明细的业绩，业绩按平均分配方式计算。

## 数据模型变更

### 1. 新建表 `order_detail_technician`

订单明细与技师的多对多关联表。

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT AUTO_INCREMENT | 主键 |
| detail_id | BIGINT NOT NULL | 订单明细ID |
| user_id | BIGINT NOT NULL | 技师ID |
| user_name | VARCHAR(50) NOT NULL | 技师姓名 |
| create_time | DATETIME | 创建时间 |
| update_time | DATETIME | 更新时间 |
| is_delete | TINYINT DEFAULT 0 | 删除状态(0存在 1删除) |

索引：`idx_detail_id(detail_id)`、`idx_user_id(user_id)`

### 2. 修改表 `kpi_detail`

新增字段：

| 字段 | 类型 | 说明 |
|------|------|------|
| detail_id | BIGINT NULL | 订单明细ID |
| detail_code | VARCHAR(50) NULL | 订单明细编号 |

索引：`idx_detail_id(detail_id)`

### 3. `order_detail` 表

`userId/userName` 字段保留，语义调整为收银员/操作员。技师信息全部通过 `order_detail_technician` 管理。

## DTO/VO 变更

### 新增

**`OrderDetailTechnicianDTO`** — 技师信息

| 字段 | 类型 | 说明 |
|------|------|------|
| userId | Long | 技师ID |
| userName | String | 技师姓名 |

### 修改

**`OrderDetailCreateDTO`：**
- 移除 `userId`、`userName`
- 新增 `List<OrderDetailTechnicianDTO> technicians`
- `serverType` 保留在明细级别不变

**`OrderDetailSettleDTO`：**
- 移除 `userId`、`userName`
- 新增 `List<OrderDetailTechnicianDTO> technicians`
- `serverType` 保留在明细级别不变

**`OrderDetailVO`：**
- `userId/userName` 语义改为收银员
- 新增 `List<OrderDetailTechnicianDTO> technicians`（查询时填充）

## 接口改造

| 接口 | 改动 |
|------|------|
| POST /order/add-detail/{orderId} | DTO 支持 technicians 列表，创建时同时保存技师关联 |
| POST /order/settle-order | 结算时按技师列表分配业绩，每人生成独立 KPI 记录 |
| PUT /order/update-server-employee/{detailId} | 改为接收技师列表，操作关联表 |
| PUT /order/update-server-type/{detailId} | 无需改动，serverType 保持明细级别 |
| GET /order/query-by-id/{orderId} | 查询时填充 technicians 列表 |

## 业绩计算流程

结算时对每条明细执行：

1. 获取明细的技师列表 `technicians`，参与人数 `count = technicians.size()`
2. 根据提成规则的基准（标准价/实际价）确定业绩总额：
   - `performanceTotal = stdPrice * quantity` 或 `truePrice * quantity`
3. 平分业绩：`perPerformance = performanceTotal / count`
4. 对每个技师计算提成并平分：
   - `commission = handelCommission(detail)` — 复用现有提成计算，按明细的 serverType 查对应提成值
   - `perCommission = commission / count`
5. 为每个技师生成独立 KPI 记录，关联 `detailId` 和 `detailCode`

## 新增代码文件

| 层级 | 文件 | 说明 |
|------|------|------|
| Entity | `OrderDetailTechnicianEntity` | 技师关联实体 |
| Mapper | `OrderDetailTechnicianMapper` | MyBatis Mapper |
| Service | `OrderDetailTechnicianService` | 技师关联 Service 接口 |
| Service Impl | `OrderDetailTechnicianServiceImpl` | 技师关联 Service 实现 |
| DTO | `OrderDetailTechnicianDTO` | 技师信息 DTO |

## 改造代码文件

| 文件 | 改动 |
|------|------|
| `OrderDetailCreateDTO` | 移除 userId/userName，新增 technicians |
| `OrderDetailSettleDTO` | 移除 userId/userName，新增 technicians |
| `OrderDetailVO` | 新增 technicians 字段 |
| `OrderDetailEntity` | 无结构变更，userId/userName 语义变更 |
| `OrderDetailServiceImpl` | addDetails、settleOrderDetailAndReturn、updateServerEmployee、queryByOrderId 改造 |
| `KpiDetailServiceImpl` | handelOrder 改造为多人分配逻辑 |
| `KpiDetail` | 新增 detailId、detailCode 字段 |
| `OrderController` | update-server-employee 接口参数变更 |

## 向后兼容

- 单人模式下 technicians 列表只有一条记录，平分结果即 100%
- order_detail 表结构不变
- kpi_detail 查询逻辑不变，新增字段不影响现有统计
- 现有前端如果只传一个技师，后端按一人处理，行为等同于当前逻辑

## 验收标准

1. 项目可成功编译运行
2. 开单接口支持选择多个技师
3. 结算接口按多人平分方式生成业绩记录
4. 修改技师接口支持多人模式
5. 业绩明细中体现与订单明细的关联（detailId）
6. 查询订单时返回每个明细的技师列表
