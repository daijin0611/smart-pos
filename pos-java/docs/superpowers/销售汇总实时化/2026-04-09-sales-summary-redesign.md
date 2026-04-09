# 销售汇总重构 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 简化销售汇总——总营收=所有支付方式汇总，总实收=总营收-会员卡支付，不再区分消费/充值

**Architecture:** 修改 OrderSummaryVO 删除充值字段，重构 OrderSalesSummaryServiceImpl 的支付聚合逻辑，统一按 payment_type 汇总

**Tech Stack:** Java 17, Spring Boot, MyBatis-Plus, Lombok

---

### Task 1: 修改 OrderSummaryVO — 删除充值字段

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java`

- [ ] **Step 1: 删除 5 个充值字段**

删除以下字段及其注释和 @Schema 注解：

```java
// 删除这些字段：
private BigDecimal qrRecharge;
private BigDecimal cashRecharge;
private BigDecimal posRecharge;
private BigDecimal douyinRecharge;
private BigDecimal meituanRecharge;
```

- [ ] **Step 2: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java
git commit -m "refactor(summary): 移除OrderSummaryVO充值统计字段"
```

---

### Task 2: 重构 OrderSalesSummaryServiceImpl 计算逻辑

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java`

- [ ] **Step 1: 重写支付聚合逻辑**

将支付聚合部分（约第 131-194 行）替换为新逻辑：

原逻辑区分 `active_type`，分消费/充值两套统计。
新逻辑统一按 `payment_type` 汇总，不再区分。

```java
// 聚合支付数据
List<PaymentDetail> groupPayments = paymentsByGroup.getOrDefault(key, Collections.emptyList());
BigDecimal totalTurnover = BigDecimal.ZERO;
BigDecimal qrPayment = BigDecimal.ZERO;
BigDecimal cashPayment = BigDecimal.ZERO;
BigDecimal posPayment = BigDecimal.ZERO;
BigDecimal douyinPayment = BigDecimal.ZERO;
BigDecimal meituanPayment = BigDecimal.ZERO;
BigDecimal memberCardPayment = BigDecimal.ZERO;

for (PaymentDetail payment : groupPayments) {
    if (payment.getTotalAmount() == null) {
        continue;
    }
    BigDecimal amount = payment.getTotalAmount();
    totalTurnover = totalTurnover.add(amount);
    Integer paymentType = payment.getPaymentType();

    switch (paymentType) {
        case 0 -> qrPayment = qrPayment.add(amount);
        case 1 -> cashPayment = cashPayment.add(amount);
        case 2 -> posPayment = posPayment.add(amount);
        case 3 -> douyinPayment = douyinPayment.add(amount);
        case 4 -> meituanPayment = meituanPayment.add(amount);
        case 5 -> memberCardPayment = memberCardPayment.add(amount);
        default -> log.warn("未知的支付类型: {}", paymentType);
    }
}

vo.setTotalTurnover(totalTurnover);
vo.setTotalActualReceipt(totalTurnover.subtract(memberCardPayment));
vo.setQrPayment(qrPayment);
vo.setCashPayment(cashPayment);
vo.setPosPayment(posPayment);
vo.setDouyinPayment(douyinPayment);
vo.setMeituanPayment(meituanPayment);
vo.setMemberCardPayment(memberCardPayment);
```

- [ ] **Step 2: 删除订单金额聚合逻辑**

原来的订单数据聚合部分（约第 106-116 行）计算 `totalTurnover` 和 `totalActualReceipt` 从 `order_info`，新逻辑从 `payment_detail` 计算，所以删除这段中关于 `totalTurnover` 和 `totalActualReceipt` 的累加，只保留 `totalSingleTime`：

```java
// 聚合订单数据（仅保留订单数量统计）
List<OrderInfoEntity> groupOrders = ordersByGroup.getOrDefault(key, Collections.emptyList());
vo.setTotalSingleTime(groupOrders.size());
```

- [ ] **Step 3: 清理未使用的 import**

移除不再需要的 import（如果有），确保编译通过。

- [ ] **Step 4: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java
git commit -m "refactor(summary): 总营收改为支付汇总，总实收=总营收-会员卡支付"
```

---

### Task 3: 验证构建

- [ ] **Step 1: 编译项目**

```bash
mvn clean compile -DskipTests
```

Expected: BUILD SUCCESS

- [ ] **Step 2: Commit 设计文档**

```bash
git add docs/superpowers/specs/2026-04-09-sales-summary-redesign-design.md docs/superpowers/plans/2026-04-09-sales-summary-redesign.md
git commit -m "docs: 添加销售汇总重构设计文档和实现计划"
```
