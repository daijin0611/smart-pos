# 销售汇总重构设计

## 背景

当前销售汇总将支付明细按 `active_type`（消费/充值）分为两套统计，导致：
- 前端展示复杂，需要两套支付方式字段
- 总营业额和总实收的计算逻辑不够直观（混用 order_info 字段和 payment_detail 字段）

## 目标

简化销售汇总逻辑：
1. **总营收** = 所有支付方式汇总（不再区分消费/充值）
2. **总实收** = 总营收 - 会员卡支付
3. **不再区分充值和订单数据**

## 改动范围

### 1. OrderSummaryVO 字段变更

**删除字段：**
- `qrRecharge` — 收款码充值金额
- `cashRecharge` — 现金充值金额
- `posRecharge` — POS充值金额
- `douyinRecharge` — 抖音充值金额
- `meituanRecharge` — 美团充值金额

**保留字段（语义变更，合并消费+充值）：**
- `qrPayment` — 扫码支付金额（消费扫码 + 充值扫码）
- `cashPayment` — 现金支付金额（消费现金 + 充值现金）
- `posPayment` — POS支付金额（消费POS + 充值POS）
- `douyinPayment` — 抖音支付金额（消费抖音 + 充值抖音）
- `meituanPayment` — 美团支付金额（消费美团 + 充值美团）
- `memberCardPayment` — 会员卡支付金额（仅消费，充值场景无会员卡）

**语义变更：**
- `totalTurnover`（总营收）= 所有 payment_detail 中 payment_status=PAID 的金额汇总
- `totalActualReceipt`（总实收）= 总营收 - 会员卡支付

### 2. OrderSalesSummaryServiceImpl 计算逻辑变更

**原逻辑：**
```
totalTurnover = sum(order_info.totalAmount) + 充值金额
totalActualReceipt = sum(order_info.actualAmount) + 充值金额
支付按 active_type 分两套统计（消费 + 充值）
```

**新逻辑：**
```
totalTurnover = sum(payment_detail.totalAmount where payment_status=PAID)
totalActualReceipt = totalTurnover - memberCardPayment
支付不区分 active_type，统一按 payment_type 汇总到单一字段
```

**具体代码变更：**
- 移除 `active_type` 判断分支，遍历所有已支付记录统一按 `payment_type` 累加
- 移除充值相关变量（`qrRecharge` 等）
- `totalTurnover` 从 payment_detail 汇总，不再从 order_info 取值
- `totalActualReceipt` = `totalTurnover` - `memberCardPayment`

### 3. 不变的部分

- Controller 层接口不变（`POST /order/summary`）
- 查询条件不变（`OrderSummaryQuery`）
- 分组逻辑不变（按 orgId + 日期分组）
- 排序逻辑不变（按日期排序）
- 门店信息填充不变
- 订单明细统计不变（`totalSingleTime`、`totalPeopleTime`、`totalProjectCount`）

## 前端对接影响

### 字段删除
前端需要移除对以下字段的引用：
- `qrRecharge`、`cashRecharge`、`posRecharge`、`douyinRecharge`、`meituanRecharge`

### 字段语义变更
以下字段现在包含消费+充值的合计值：
- `qrPayment`、`cashPayment`、`posPayment`、`douyinPayment`、`meituanPayment`

### 汇总指标变更
- `totalTurnover` 改为所有支付方式的汇总（含充值）
- `totalActualReceipt` 改为总营收减去会员卡支付

## 涉及文件

| 文件 | 改动类型 |
|------|----------|
| `pos-common/.../vo/order/OrderSummaryVO.java` | 删除充值字段 |
| `pos-server/.../impl/OrderSalesSummaryServiceImpl.java` | 重构计算逻辑 |
