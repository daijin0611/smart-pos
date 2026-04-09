# 券作为支付方式 — 设计文档

**日期**：2026-04-09
**状态**：已确认

## 1. 背景

当前系统中，代金券和项目券的使用仅在 `VipInfoTicket` 表中更新状态和记录订单号，券的抵扣金额没有作为支付记录写入 `PaymentDetail` 表。这导致资金流向不完整：一笔 300 元的订单（用了 100 元代金券 + 200 元现金），支付流水中只能看到 200 元现金，无法追溯另外 100 元的来源。

目标：**实现完整的资金流向追踪**，每一分钱都有出处。

## 2. 方案概述

将代金券和项目券作为两种新的支付方式，纳入现有支付记录体系。前端在提交结算时将券的支付信息包含在 `paymentInfoList` 中，后端校验券支付金额与实际券值一致后写入 `PaymentDetail` 表。

## 3. 详细设计

### 3.1 枚举变更

**文件**：`pos-common/src/main/java/org/haut/common/enums/PaymentTypeEnum.java`

新增两个枚举值：

```java
TICKET_CONSUMER("6", "代金券"),
TICKET_ITEM("7", "项目券"),
```

### 3.2 前端变更

前端在结算时，`OrderSettleDTO.paymentInfoList` 中增加券的支付条目：

- **代金券**：`paymentType = 6`，`paymentAmount = 券面值(ticketValue)`
- **项目券**：`paymentType = 7`，`paymentAmount = 对应订单明细的stdPrice`

`ticketUseList` 的提交方式不变。

### 3.3 后端校验

**文件**：`pos-server/src/main/java/org/haut/server/payment/service/impl/PaymentDetailServiceImpl.java`

在 `handelOrder()` 方法中，对 `paymentInfoList` 中 paymentType 为 6 或 7 的条目进行额外校验：

1. 验证券在 `ticketUseList` 中存在（防止凭空调用券支付类型）
2. 代金券：金额必须等于券面值 `ticketValue`
3. 项目券：金额必须等于对应订单明细的 `stdPrice`
4. 券未被使用且未过期（与 `VipInfoTicketServiceImpl.validateTickets` 逻辑一致）

校验通过后，券支付记录与常规支付记录一起通过 `saveBatch` 写入 `PaymentDetail` 表。

### 3.4 资金等式

变更后的资金流向：

```
订单总金额(totalAmount) = 实收金额(actualAmount) + 优惠金额(discountAmount)
实收金额(actualAmount) = Σ paymentInfoList
                       = 现金 + 收款码 + POS + 会员卡 + ...
                       + 代金券面值 + 项目券标准价
```

等式天然成立，因为前端计算 actualAmount 时已包含券抵扣部分。

### 3.5 冲正逻辑

无需变更。订单冲正时按 `activeCode`（订单号）将所有 `PaymentDetail` 状态更新为 `ROLLBACK`，新增的券支付记录会被自动覆盖。券状态回滚由 `VipInfoTicketServiceImpl` 的现有冲正逻辑处理。

### 3.6 报表查询

销售数据汇总的核心指标定义：

| 指标 | 计算方式 | 含义 |
|------|---------|------|
| **总营业额** | Σ 全部 PaymentDetail 金额 | 所有支付方式的汇总，含会员卡和券 |
| **总实收** | Σ paymentType NOT IN (5,6,7) | 排除会员卡(5)、代金券(6)、项目券(7)后的实际收款 |

按支付方式的细分查询：

| 查询场景 | 过滤条件 | 含义 |
|---------|---------|------|
| 会员卡消费 | paymentType = 5 | 会员卡储值消费 |
| 券核销金额 | paymentType IN (6,7) | 券覆盖的价值总额 |
| 代金券核销 | paymentType = 6 | 代金券使用统计 |
| 项目券核销 | paymentType = 7 | 项目券使用统计 |

> **注意**：现有销售汇总统计需按上述口径调整，确保总营业额包含券支付，总实收排除会员卡和券。

## 4. 变更范围

| 文件 | 变更内容 |
|------|---------|
| `PaymentTypeEnum.java` | 新增 `TICKET_CONSUMER(6)` 和 `TICKET_ITEM(7)` |
| `PaymentDetailServiceImpl.handelOrder()` | 增加券支付金额的后端校验逻辑 |
| 前端结算页面 | `paymentInfoList` 中包含券支付条目 |

**不需要变更的**：
- `PaymentDetail` 表结构（无需新增字段）
- `VipInfoTicketServiceImpl`（券状态更新逻辑不变）
- 订单状态流转和冲正逻辑
- 会员余额计算

## 5. 注意事项

- 项目券使用时，前端会将对应订单明细的 `truePrice` 设为 0。券支付记录的金额取 `stdPrice`（标准价），不依赖 `truePrice`。
- 券支付校验需要 `ticketUseList` 和 `paymentInfoList` 的信息交叉验证，校验逻辑需要访问券信息和订单明细。
