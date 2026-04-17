# 券作为支付方式 v2 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将代金券和项目券作为支付方式纳入支付记录体系，实现完整的资金流向追踪和业绩计算。

**Architecture:** 前端在 paymentInfoList 中包含券支付条目（paymentType=6/7），后端统一写入 PaymentDetail。销售汇总统计券支付金额（总实收排除券），KPI 业绩中项目券按券面额计算、代金券不参与分配。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus, Lombok

---

### Task 1: OrderSummaryVO 新增券支付字段

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java`

- [ ] **Step 1: 在 memberCardPayment 字段之后添加两个券支付字段**

```java
    /**
     * 会员卡支付金额
     */
    @Schema(description = "会员卡支付金额")
    private BigDecimal memberCardPayment;

    /**
     * 代金券支付金额
     */
    @Schema(description = "代金券支付金额")
    private BigDecimal ticketConsumerPayment;

    /**
     * 项目券支付金额
     */
    @Schema(description = "项目券支付金额")
    private BigDecimal ticketItemPayment;
```

- [ ] **Step 2: 验证编译**

Run: `mvn compile -pl pos-common -q`
Expected: BUILD SUCCESS

- [ ] **Step 3: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java
git commit -m "feat(summary): 销售汇总VO新增代金券和项目券支付字段"
```

---

### Task 2: OrderSalesSummaryServiceImpl 统计券支付

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java`

- [ ] **Step 1: 在支付聚合逻辑中添加券支付变量和 case**

将第 121-155 行的支付聚合代码替换为：

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
            BigDecimal ticketConsumerPayment = BigDecimal.ZERO;
            BigDecimal ticketItemPayment = BigDecimal.ZERO;

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
                    case 6 -> ticketConsumerPayment = ticketConsumerPayment.add(amount);
                    case 7 -> ticketItemPayment = ticketItemPayment.add(amount);
                    default -> log.warn("未知的支付类型: {}", paymentType);
                }
            }

            vo.setTotalTurnover(totalTurnover);
            vo.setTotalActualReceipt(totalTurnover
                    .subtract(memberCardPayment)
                    .subtract(ticketConsumerPayment)
                    .subtract(ticketItemPayment));
            vo.setQrPayment(qrPayment);
            vo.setCashPayment(cashPayment);
            vo.setPosPayment(posPayment);
            vo.setDouyinPayment(douyinPayment);
            vo.setMeituanPayment(meituanPayment);
            vo.setMemberCardPayment(memberCardPayment);
            vo.setTicketConsumerPayment(ticketConsumerPayment);
            vo.setTicketItemPayment(ticketItemPayment);
```

关键变更：
- 新增 `ticketConsumerPayment` 和 `ticketItemPayment` 变量
- switch 新增 `case 6`（代金券）和 `case 7`（项目券）
- `totalActualReceipt` = `totalTurnover` - 会员卡 - 代金券 - 项目券
- VO 设置新增的两个券支付字段

- [ ] **Step 2: 验证编译**

Run: `mvn compile -pl pos-server -q`
Expected: BUILD SUCCESS

- [ ] **Step 3: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java
git commit -m "feat(summary): 销售汇总统计券支付，总实收排除券"
```

---

### Task 3: KpiDetailServiceImpl 实现项目券业绩计算

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java`

- [ ] **Step 1: 实现 handelPerformance 方法**

将第 366-368 行的空实现替换为：

```java
    /**
     * 计算明细业绩金额
     * 如果该明细被项目券抵扣，业绩 = 券的面额(amount)
     * 否则业绩 = truePrice
     *
     * @param detailSettleDTO 订单明细
     * @param ticketUseDTOS 券使用列表
     * @return 业绩金额
     */
    public BigDecimal handelPerformance(OrderDetailSettleDTO detailSettleDTO, List<OrderTicketUseDTO> ticketUseDTOS) {
        if (ticketUseDTOS == null || ticketUseDTOS.isEmpty()) {
            return detailSettleDTO.getTruePrice();
        }
        // 查找项目券（ticketType=1）中关联当前明细的券
        for (OrderTicketUseDTO ticket : ticketUseDTOS) {
            if (Integer.valueOf(1).equals(ticket.getTicketType()) && ticket.getAmount() != null) {
                // 通过 detailId 或 detailName 匹配
                boolean matched = false;
                if (ticket.getDetailId() != null && ticket.getDetailId().equals(detailSettleDTO.getId())) {
                    matched = true;
                } else if (ticket.getDetailName() != null && ticket.getDetailName().equals(detailSettleDTO.getBusinessName())) {
                    matched = true;
                }
                if (matched) {
                    return ticket.getAmount();
                }
            }
        }
        return detailSettleDTO.getTruePrice();
    }
```

- [ ] **Step 2: 修改 handelOrder 中的业绩计算逻辑**

将第 168-170 行：

```java
            // 实收金额作为业绩金额
            BigDecimal performance = orderDetailSettleDTO.getTruePrice()
                    .divide(BigDecimal.valueOf(count), 2, RoundingMode.HALF_UP);
```

替换为：

```java
            // 业绩金额：项目券抵扣的项目取券面额，否则取实收金额
            BigDecimal totalPerformance = handelPerformance(orderDetailSettleDTO, orderSettleDTO.getTicketUseList());
            BigDecimal performance = totalPerformance
                    .divide(BigDecimal.valueOf(count), 2, RoundingMode.HALF_UP);
```

- [ ] **Step 3: 验证编译**

Run: `mvn compile -pl pos-server -q`
Expected: BUILD SUCCESS

- [ ] **Step 4: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java
git commit -m "feat(kpi): 项目券业绩按券面额计算"
```

---

### Task 4: 全量构建验证并提交文档

- [ ] **Step 1: 全量构建**

Run: `mvn clean compile -DskipTests`
Expected: BUILD SUCCESS

- [ ] **Step 2: 提交设计文档和实现计划**

```bash
git add docs/superpowers/2026-04-09-券作为支付方式/2026-04-09-ticket-as-payment-v2-design.md docs/superpowers/2026-04-09-券作为支付方式/2026-04-09-ticket-as-payment-v2.md
git commit -m "docs: 券作为支付方式v2设计文档和实现计划"
```
