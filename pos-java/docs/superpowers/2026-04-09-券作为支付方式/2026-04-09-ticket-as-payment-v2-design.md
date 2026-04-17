# 券作为支付方式 — 重新设计

**日期**：2026-04-09
**状态**：已确认

## 1. 背景

当前系统中，代金券和项目券的使用仅在 `VipInfoTicket` 表中更新状态和记录订单号，券的抵扣金额没有作为支付记录写入 `PaymentDetail` 表。资金流向不完整：一笔 300 元的订单（用了 100 元代金券 + 200 元现金），支付流水中只能看到 200 元现金。

目标：将代金券和项目券作为支付方式，纳入支付记录体系，实现完整的资金流向追踪。

## 2. 已完成的前置工作

以下变更已提交到 dev 分支，无需重复：

- `PaymentTypeEnum` 已新增 `TICKET_ITEM("6", "项目券")` 和 `TICKET_CONSUMER("7", "代金券")`
- `OrderSettleDTO` 已包含 `ticketUseList` 和 `paymentInfoList`
- 结算流程已重构为传递 `OrderSettleDTO`
- `OrderTicketUseDTO` 已简化（`detailName` 替代 `businessName`/`businessCode`）
- `VipInfoTicket` 已新增 `amount`（面额）字段
- 销售汇总已重构：总营收 = Σ PaymentDetail，总实收 = 总营收 - 会员卡
- KPI 服务已适配 `OrderSettleDTO`，`handelPerformance()` 方法签名已定义（返回 null）

## 3. 方案

### 3.1 前端提交方式

前端在 `paymentInfoList` 中包含券支付条目：
- 代金券：`paymentType = 6`，`paymentAmount = 券面值`
- 项目券：`paymentType = 7`，`paymentAmount = 对应订单明细的 stdPrice`

`ticketUseList` 提交方式不变。后端不做额外交叉校验——券核销校验由 `VipInfoTicketServiceImpl.handelOrder()` 负责。

### 3.2 资金等式

```
订单总金额 = 实收金额 + 优惠金额
实收金额 = Σ paymentInfoList（含券支付）
总营收 = Σ 所有 PaymentDetail 金额（含券）
总实收 = 总营收 - 会员卡(5) - 代金券(6) - 项目券(7)
```

### 3.3 KPI 业绩规则

- 普通项目：业绩 = `truePrice`（不变）
- 项目券抵扣的项目：业绩 = 券的 `amount`（前端传递，后端可通过 `ticketUseList` 校验）
- 代金券：不参与业绩分配（整体抵扣，不关联具体项目）

### 3.4 冲正逻辑

无需变更。订单冲正时按 `activeCode`（订单号）将所有 `PaymentDetail` 状态更新为 `ROLLBACK`，券支付记录会被自动覆盖。券状态回滚由现有冲正逻辑处理。

## 4. 改动范围

### 4.1 OrderSummaryVO — 新增券支付字段

**文件**：`pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java`

新增两个字段：

```java
@Schema(description = "代金券支付金额")
private BigDecimal ticketConsumerPayment;

@Schema(description = "项目券支付金额")
private BigDecimal ticketItemPayment;
```

### 4.2 OrderSalesSummaryServiceImpl — 统计券支付

**文件**：`pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java`

1. switch 新增 `case 6`（代金券）和 `case 7`（项目券）
2. 总实收改为排除会员卡 + 券：`totalTurnover - memberCardPayment - ticketConsumerPayment - ticketItemPayment`
3. 设置新增的 VO 字段

### 4.3 KpiDetailServiceImpl — 实现业绩计算

**文件**：`pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java`

1. 实现 `handelPerformance()` 方法：
   - 从 `ticketUseList` 中查找项目券（`ticketType = 1`）
   - 通过 `detailId` 匹配当前订单明细
   - 返回匹配到的项目券的 `amount`；无匹配则返回 `truePrice`
2. 修改 `handelOrder()` 中的业绩计算逻辑：
   - 当前：`performance = truePrice / count`
   - 改为：`performance = handelPerformance(detailSettleDTO, ticketUseList) / count`

### 4.4 不需要改动的文件

| 文件 | 原因 |
|------|------|
| `PaymentDetailServiceImpl.java` | 前端把券支付包含在 `paymentInfoList`，后端统一写入，无需特殊处理 |
| `PaymentTypeEnum.java` | 已有 `TICKET_ITEM(6)` 和 `TICKET_CONSUMER(7)` |
| `VipInfoTicketServiceImpl.java` | 券核销校验逻辑不变 |
| `PaymentDetail` 表结构 | 无需新增字段 |
| `OrderTicketUseDTO.java` | 已简化完成 |

## 5. 涉及文件汇总

| 文件 | 改动类型 |
|------|----------|
| `pos-common/.../vo/order/OrderSummaryVO.java` | 新增 2 个券支付字段 |
| `pos-server/.../impl/OrderSalesSummaryServiceImpl.java` | switch 加 case 6/7，总实收排除券 |
| `pos-server/.../impl/KpiDetailServiceImpl.java` | 实现 handelPerformance，修改业绩计算 |
