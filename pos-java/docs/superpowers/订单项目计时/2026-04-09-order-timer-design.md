# 订单项目计时功能设计

## 概述

为 POS 系统的订单服务项目添加计时功能。开单后，员工可为订单中的每个服务项目手动启动计时，系统基于服务项目的标准时长（`server_item.server_time`）自动到期结束，并在到期前 5 分钟发送提醒。支持暂停/恢复计时。

## 业务场景

1. 前台开单后，订单处于"未结算"状态，关联床位变为"服务中"
2. 员工通过前端界面为订单中的服务项目手动启动计时
3. 前端轮询床位状态和订单信息，展示各服务项目的倒计时
4. 服务时间到期前 5 分钟系统自动提醒
5. 到期后自动停止计时，记录实际服务时长

## 需求决策

| 项 | 决定 |
|---|---|
| 触发时机 | 手动开始 |
| 计时粒度 | 按 OrderDetail 独立计时 |
| 结束时机 | 到期自动结束（基于 serverTime） |
| 到期提醒 | 到期前 5 分钟 |
| 前端展示 | 纯后端 API，前端轮询 + 本地计算倒计时 |
| 加钟处理 | 独立计时（加钟项目各自开始计时） |
| 到期后行为 | 自动停止，记录实际时长 |
| 暂停功能 | 支持暂停/恢复，暂停期间不计时 |

## 技术方案

### 方案：订单明细表增加计时字段 + Scheduled Task

在 `order_detail` 表增加计时相关字段，使用 Spring Scheduled Task 每 30 秒扫描到期和提醒条件。

选择理由：
- POS 系统并发量不高，轮询方案完全够用
- 改动最小，不引入新的基础设施依赖
- 计时数据直接在订单明细上，查询方便

### 数据库变更

`order_detail` 表增加字段：

| 字段 | 类型 | 默认值 | 说明 |
|---|---|---|---|
| `timer_status` | TINYINT | 0 | 计时状态：0=未开始, 1=进行中, 2=已暂停, 3=已结束 |
| `timer_start_time` | DATETIME | NULL | 计时开始时间 |
| `timer_end_time` | DATETIME | NULL | 预计结束时间（= 开始时间 + serverTime - 暂停时长） |
| `timer_paused_duration` | INT | 0 | 累计已暂停总时长（秒） |
| `timer_last_pause_time` | DATETIME | NULL | 最近一次暂停的开始时间 |
| `actual_duration` | INT | NULL | 实际服务时长（秒），结束后填写 |
| `timer_warned` | TINYINT | 0 | 是否已发送到期前 5 分钟提醒 |

### 计时状态枚举

新增枚举类 `TimerStatusEnum`：

```
NOT_STARTED(0, "未开始")
RUNNING(1, "进行中")
PAUSED(2, "已暂停")
FINISHED(3, "已结束")
```

状态流转：
```
NOT_STARTED ──手动开始──→ RUNNING ──到期自动──→ FINISHED
                               ↕
                           PAUSED
```

- RUNNING 可暂停为 PAUSED
- PAUSED 可恢复为 RUNNING（恢复时延长 timer_end_time）
- FINISHED 为终态

### API 设计

#### 1. 开始计时

```
POST /order/detail/timer/start/{detailId}
```

**前置条件**：
- OrderDetail 存在且属于当前用户的组织
- `timer_status` 为 `NOT_STARTED(0)`
- 关联订单状态为 `UNSETTLED(1)`

**逻辑**：
1. 查询 OrderDetail，获取 `serverItemId`（通过 `bid` 字段）
2. 查询 `ServerItem.serverTime` 获取标准服务时长（分钟）
3. 设置：
   - `timer_status = 1 (RUNNING)`
   - `timer_start_time = NOW()`
   - `timer_end_time = NOW() + serverTime分钟`
   - `timer_warned = 0`

**响应**：更新后的 OrderDetail 信息

#### 2. 暂停计时

```
POST /order/detail/timer/pause/{detailId}
```

**前置条件**：
- `timer_status` 为 `RUNNING(1)`

**逻辑**：
1. 设置：
   - `timer_status = 2 (PAUSED)`
   - `timer_last_pause_time = NOW()`

#### 3. 恢复计时

```
POST /order/detail/timer/resume/{detailId}
```

**前置条件**：
- `timer_status` 为 `PAUSED(2)`

**逻辑**：
1. 计算本次暂停时长：`pauseDuration = NOW() - timer_last_pause_time`
2. 累加到总暂停时长：`timer_paused_duration += pauseDuration`
3. 延长预计结束时间：`timer_end_time += pauseDuration`
4. 设置：
   - `timer_status = 1 (RUNNING)`
   - `timer_last_pause_time = NULL`

#### 4. 手动停止计时

```
POST /order/detail/timer/stop/{detailId}
```

**前置条件**：
- `timer_status` 为 `RUNNING(1)` 或 `PAUSED(2)`

**逻辑**：
1. 如果当前是 PAUSED，先计算暂停时长并累加
2. 计算 `actual_duration = NOW() - timer_start_time - timer_paused_duration`（秒）
3. 设置：
   - `timer_status = 3 (FINISHED)`
   - `actual_duration = 计算值`
   - `timer_end_time = NOW()`（覆盖为实际结束时间）

### 前端展示

**不新增查询接口**。计时信息通过现有接口返回：

1. 前端轮询 `GET /room/bed/query-all` 获取床位列表
2. 对状态为"服务中"(status=1) 的床位，调用 `GET /order/query-by-bed-id/{bedId}` 获取订单详情
3. 订单详情中的 `orderDetail` 列表已包含计时字段，前端据此计算展示：
   - **倒计时**：`timer_end_time - NOW()`（如果 timer_status=1）
   - **暂停中**：显示"已暂停"标签
   - **已结束**：显示实际服务时长
   - **到期提醒**：倒计时 <= 5 分钟时高亮显示

### 后台定时任务

新增 `TimerScheduleTask`，每 30 秒执行一次：

1. **到期自动结束**：
   ```sql
   UPDATE order_detail
   SET timer_status = 3,
       actual_duration = TIMESTAMPDIFF(SECOND, timer_start_time, NOW()) - timer_paused_duration,
       timer_end_time = NOW()
   WHERE timer_status = 1
     AND timer_end_time <= NOW()
   ```

2. **到期前 5 分钟提醒标记**：
   ```sql
   UPDATE order_detail
   SET timer_warned = 1
   WHERE timer_status = 1
     AND timer_warned = 0
     AND timer_end_time <= DATE_ADD(NOW(), INTERVAL 5 MINUTE)
   ```

### 结算联动

订单结算（`settleOrder`）时，自动结束该订单下所有未结束的计时：
```sql
UPDATE order_detail
SET timer_status = 3,
    actual_duration = CASE WHEN timer_status = 1
        THEN TIMESTAMPDIFF(SECOND, timer_start_time, NOW()) - timer_paused_duration
        ELSE timer_paused_duration END,
    timer_end_time = COALESCE(timer_end_time, NOW())
WHERE order_id = #{orderId}
  AND timer_status IN (1, 2)
```

取消订单时同理，结束所有计时。

### 数据迁移

新增 SQL 迁移脚本 `V1.0.9__add_order_detail_timer_fields.sql`：

```sql
ALTER TABLE order_detail
    ADD COLUMN timer_status TINYINT DEFAULT 0 COMMENT '计时状态：0未开始,1进行中,2已暂停,3已结束',
    ADD COLUMN timer_start_time DATETIME DEFAULT NULL COMMENT '计时开始时间',
    ADD COLUMN timer_end_time DATETIME DEFAULT NULL COMMENT '预计结束时间',
    ADD COLUMN timer_paused_duration INT DEFAULT 0 COMMENT '累计暂停时长(秒)',
    ADD COLUMN timer_last_pause_time DATETIME DEFAULT NULL COMMENT '最近暂停开始时间',
    ADD COLUMN actual_duration INT DEFAULT NULL COMMENT '实际服务时长(秒)',
    ADD COLUMN timer_warned TINYINT DEFAULT 0 COMMENT '是否已发送到期提醒';
```

## 涉及的文件变更

### 新增文件
- `pos-server/src/main/java/org/haut/server/order/enums/TimerStatusEnum.java` - 计时状态枚举
- `pos-server/src/main/java/org/haut/server/order/task/TimerScheduleTask.java` - 计时定时任务
- `pos-server/src/main/java/org/haut/server/order/controller/OrderTimerController.java` - 计时 API（或在现有 OrderController 中添加）
- `sql/V1.0.9__add_order_detail_timer_fields.sql` - 数据库迁移

### 修改文件
- `pos-server/src/main/java/org/haut/server/order/entity/OrderDetailEntity.java` - 增加计时字段
- `pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java` - 结算/取消时结束计时
- 订单查询返回的 VO 可能需要调整，增加计时相关字段

## 边界情况

1. **服务项无 serverTime**：如果 ServerItem 的 serverTime 为 0 或 null，不允许开始计时，返回错误提示
2. **重复操作**：已在 RUNNING 状态再次调用 start 返回错误；已在 PAUSED 再次调用 pause 返回错误
3. **订单已结算/取消**：对已结束订单的项目调用计时操作返回错误
4. **并发安全**：使用乐观锁或数据库行锁确保计时操作不会并发冲突
5. **跨组织隔离**：所有操作需验证 OrderDetail 属于当前用户的组织
