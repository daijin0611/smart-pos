# 多门店查询改造 - 接口变动汇总

> 日期：2026-04-04
> 分支：`dev`
> 目的：所有分页/列表查询接口统一支持多门店过滤，响应中补充门店信息

---

## 一、通用规则

### 请求参数变更

所有涉及门店过滤的查询接口，原 `orgId: Long` 单门店字段统一改为：

```json
{
  "orgIds": [1, 2, 3]
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `orgIds` | `List<Long>` | 门店ID列表。**传入**则按指定门店查询；**不传或传空**则自动查询当前用户关联的所有门店 |

### 响应字段新增

涉及门店的响应 VO 统一新增以下字段（具体哪些接口新增见下表）：

| 字段 | 类型 | 说明 |
|------|------|------|
| `orgId` | `Long` | 门店ID（部分接口原本没有，新增） |
| `orgName` | `String` | 门店名称 |
| `orgCode` | `String` | 门店编码 |

---

## 二、各接口变动明细

### 1. 充值记录查询

- **接口路径**：`GET /vip/recharge-history/page`
- **Query 变更**：`RechargeHistoryQuery` 新增 `orgIds` 字段
- **响应 VO 变更**：`RechargeHistoryVO` 新增 `orgName`、`orgCode`

### 2. 销售记录（订单）分页查询

- **接口路径**：`GET /order/page`
- **Query 变更**：`OrderPageQuery` 中 `orgId (Long)` → `orgIds (List<Long>)`
- **响应 VO 变更**：`OrderInfoVO` 新增 `orgName`、`orgCode`

### 3. 销售汇总查询

- **接口路径**：`GET /order/sales/summary`
- **Query 变更**：`OrderSummaryQuery` 新增 `orgIds` 字段
- **响应 VO 变更**：`OrderSummaryVO` 新增 `orgName`、`orgCode`

### 4. 销售明细查询

- **接口路径**：`GET /order/detail/page`
- **Query 变更**：`OrderDetailPageQuery` 新增 `orgIds` 字段
- **响应 VO 变更**：`OrderDetailVO` 新增 `orgId`、`orgName`、`orgCode`

### 5. 绩效明细查询

- **接口路径**：`GET /kpi/detail/list`
- **Query 变更**：`KpiListQuery` 中 `orgId (Long)` → `orgIds (List<Long>)`
- **响应 VO 变更**：`KpiListVO` 新增 `orgId`、`orgCode`（原已有 `orgName`）

### 6. 绩效汇总查询

- **接口路径**：`GET /kpi/detail/summary`
- **Query 变更**：`KpiSummaryQuery` 中 `orgId (Long)` → `orgIds (List<Long>)`
- **响应 VO 变更**：`KpiSummaryVO` 新增 `orgCode`（原已有 `orgId`、`orgName`）

### 7. 会员分页查询

- **接口路径**：`GET /vip/info/page`
- **Query 变更**：`VipListQuery` 新增 `orgIds` 字段
- **响应 VO 变更**：`VipInfoVO` 新增 `orgName`、`orgCode`（原已有 `orgId`）

### 8. 用户列表查询

- **接口路径**：`GET /system/user/page`
- **Query 变更**：`UserListQuery` 中 `orgId (Long)` → `orgIds (List<Long>)`
- **响应 VO 变更**：无新增（原已包含门店列表 `orgs`）

---

## 三、前端对接要点

1. **传参方式**：所有门店过滤参数由单个 `orgId` 改为 `orgIds` 数组。前端需将门店选择器改为多选，传入选中的门店ID列表。
2. **不传或传空**：后端自动查询当前登录用户关联的所有门店数据，等价于"全部门店"。
3. **响应新增字段**：`orgName`、`orgCode` 由后端自动填充，前端可直接展示，无需额外查询。
4. **字段删除**：`OrderPageQuery`、`KpiListQuery`、`KpiSummaryQuery`、`UserListQuery` 中原 `orgId (Long)` 字段已移除，请改用 `orgIds (List<Long>)`。
