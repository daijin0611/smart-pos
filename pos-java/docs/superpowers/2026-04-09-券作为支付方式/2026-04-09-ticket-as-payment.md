# 券作为支付方式 — 实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将代金券和项目券作为支付方式，写入 PaymentDetail 表，实现完整的资金流向追踪。

**Architecture:** 在现有支付记录体系中新增两种支付类型（代金券=6、项目券=7），前端将券支付信息包含在 paymentInfoList 中提交，后端校验后统一写入 PaymentDetail。销售汇总统计按新口径调整：总营业额含所有支付方式，总实收排除会员卡和券。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus, MapStruct

---

### Task 1: 新增支付类型枚举

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/enums/PaymentTypeEnum.java:13-20`

- [ ] **Step 1: 在 PaymentTypeEnum 中新增两个枚举值**

将第 19 行 `MEMBER_CARD("5", "会员卡"),` 之后添加：

```java
TICKET_CONSUMER("6", "代金券"),
TICKET_ITEM("7", "项目券"),
```

修改后的枚举：

```java
public enum PaymentTypeEnum {

    QR("0", "收款码"),
    CASH("1", "现金"),
    POS("2", "POS"),
    DOUYIN("3", "抖音"),
    MEITUAN("4", "美团"),
    MEMBER_CARD("5", "会员卡"),
    TICKET_CONSUMER("6", "代金券"),
    TICKET_ITEM("7", "项目券"),
    ;
```

- [ ] **Step 2: 验证编译通过**

Run: `mvn compile -pl pos-common -q`
Expected: BUILD SUCCESS

- [ ] **Step 3: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/enums/PaymentTypeEnum.java
git commit -m "feat(payment): 新增代金券(6)和项目券(7)支付类型枚举"
```

---

### Task 2: 支付服务增加券支付校验

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/payment/service/impl/PaymentDetailServiceImpl.java:58-95`

- [ ] **Step 1: 添加券支付校验逻辑**

在 `handelOrder()` 方法中，现有支付金额校验（第 73-79 行）之后、会员资产处理（第 82 行）之前，插入券支付校验：

```java
// 1.5 校验券支付（paymentType 6/7 必须有对应的 ticketUseList）
List<PaymentInfoDTO> ticketPayments = paymentInfoList.stream()
        .filter(p -> p.getPaymentType() != null
                && (p.getPaymentType() == 6 || p.getPaymentType() == 7))
        .toList();
if (!ticketPayments.isEmpty()) {
    List<OrderTicketUseDTO> ticketUseList = dto.getTicketUseList();
    if (CollectionUtil.isEmpty(ticketUseList)) {
        throw new BusinessException("券支付记录存在，但未选择优惠券");
    }
    long consumerPaymentCount = ticketPayments.stream()
            .filter(p -> p.getPaymentType() == 6).count();
    long itemPaymentCount = ticketPayments.stream()
            .filter(p -> p.getPaymentType() == 7).count();
    long consumerTicketCount = ticketUseList.stream()
            .filter(t -> Integer.valueOf(0).equals(t.getTicketType())).count();
    long itemTicketCount = ticketUseList.stream()
            .filter(t -> Integer.valueOf(1).equals(t.getTicketType())).count();
    if (consumerPaymentCount != consumerTicketCount) {
        throw new BusinessException("代金券支付数量与使用的代金券数量不一致");
    }
    if (itemPaymentCount != itemTicketCount) {
        throw new BusinessException("项目券支付数量与使用的项目券数量不一致");
    }
}
```

需要添加 import：

```java
import org.haut.common.domain.dto.order.OrderTicketUseDTO;
```

- [ ] **Step 2: 验证编译通过**

Run: `mvn compile -pl pos-server -q`
Expected: BUILD SUCCESS

- [ ] **Step 3: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/payment/service/impl/PaymentDetailServiceImpl.java
git commit -m "feat(payment): 支付服务增加券支付类型校验"
```

---

### Task 3: 销售汇总 VO 新增券支付字段

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java:110-145`

- [ ] **Step 1: 在 OrderSummaryVO 中添加券支付字段**

在第 114 行 `memberCardPayment` 字段之后、第 119 行 `qrRecharge` 字段之前，插入：

```java
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

- [ ] **Step 2: 验证编译通过**

Run: `mvn compile -pl pos-common -q`
Expected: BUILD SUCCESS

- [ ] **Step 3: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java
git commit -m "feat(statistics): 销售汇总VO新增代金券和项目券支付字段"
```

---

### Task 4: 销售汇总统计调整

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java:100-194`

这是最关键的变更。需要：
1. 将 `totalTurnover` 和 `totalActualReceipt` 的数据源从订单金额改为支付金额
2. switch 中添加 case 6（代金券）和 case 7（项目券）

- [ ] **Step 1: 修改汇总计算逻辑**

将第 105-116 行的订单聚合逻辑（从 order.getTotalAmount/ActualAmount 计算 totalTurnover/totalActualReceipt）替换为从支付明细聚合。同时在 switch 中添加 case 6 和 7。

修改后的完整代码块（第 105-194 行替换为）：

```java
            // 聚合订单数据（仅用于单次数量统计）
            List<OrderInfoEntity> groupOrders = ordersByGroup.getOrDefault(key, Collections.emptyList());
            vo.setTotalSingleTime(groupOrders.size());

            // 聚合订单明细数据
            List<OrderDetailEntity> groupDetails = detailsByGroup.getOrDefault(key, Collections.emptyList());
            int totalPeopleTime = groupDetails.size();
            int totalProjectCount = 0;
            for (OrderDetailEntity detail : groupDetails) {
                if (detail.getQuantity() != null) {
                    totalProjectCount += detail.getQuantity();
                }
            }
            vo.setTotalPeopleTime(totalPeopleTime);
            vo.setTotalProjectCount(totalProjectCount);

            // 聚合支付数据
            List<PaymentDetail> groupPayments = paymentsByGroup.getOrDefault(key, Collections.emptyList());
            BigDecimal totalTurnover = BigDecimal.ZERO;
            BigDecimal totalActualReceipt = BigDecimal.ZERO;
            BigDecimal qrPayment = BigDecimal.ZERO;
            BigDecimal cashPayment = BigDecimal.ZERO;
            BigDecimal posPayment = BigDecimal.ZERO;
            BigDecimal douyinPayment = BigDecimal.ZERO;
            BigDecimal meituanPayment = BigDecimal.ZERO;
            BigDecimal memberCardPayment = BigDecimal.ZERO;
            BigDecimal ticketConsumerPayment = BigDecimal.ZERO;
            BigDecimal ticketItemPayment = BigDecimal.ZERO;
            BigDecimal qrRecharge = BigDecimal.ZERO;
            BigDecimal cashRecharge = BigDecimal.ZERO;
            BigDecimal posRecharge = BigDecimal.ZERO;
            BigDecimal douyinRecharge = BigDecimal.ZERO;
            BigDecimal meituanRecharge = BigDecimal.ZERO;

            for (PaymentDetail payment : groupPayments) {
                if (payment.getTotalAmount() == null) {
                    continue;
                }
                BigDecimal amount = payment.getTotalAmount();
                Integer paymentType = payment.getPaymentType();

                if (PaymentActiveTypeEnum.CONSUMER.getValue().equals(payment.getActiveType())) {
                    // 消费支付 — 总营业额包含所有支付方式
                    totalTurnover = totalTurnover.add(amount);
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
                    // 总实收：排除会员卡(5)、代金券(6)、项目券(7)
                    if (paymentType != 5 && paymentType != 6 && paymentType != 7) {
                        totalActualReceipt = totalActualReceipt.add(amount);
                    }
                } else if (PaymentActiveTypeEnum.RECHARGER.getValue().equals(payment.getActiveType())) {
                    // 充值（排除会员卡）
                    if (PaymentTypeEnum.MEMBER_CARD.getCode().equals(String.valueOf(paymentType))) {
                        continue;
                    }
                    switch (paymentType) {
                        case 0 -> qrRecharge = qrRecharge.add(amount);
                        case 1 -> cashRecharge = cashRecharge.add(amount);
                        case 2 -> posRecharge = posRecharge.add(amount);
                        case 3 -> douyinRecharge = douyinRecharge.add(amount);
                        case 4 -> meituanRecharge = meituanRecharge.add(amount);
                        default -> log.warn("未知的充值支付类型: {}", paymentType);
                    }
                    // 充值金额计入营业额和实收
                    totalTurnover = totalTurnover.add(amount);
                    totalActualReceipt = totalActualReceipt.add(amount);
                }
            }

            vo.setTotalTurnover(totalTurnover);
            vo.setTotalActualReceipt(totalActualReceipt);
            vo.setQrPayment(qrPayment);
            vo.setCashPayment(cashPayment);
            vo.setPosPayment(posPayment);
            vo.setDouyinPayment(douyinPayment);
            vo.setMeituanPayment(meituanPayment);
            vo.setMemberCardPayment(memberCardPayment);
            vo.setTicketConsumerPayment(ticketConsumerPayment);
            vo.setTicketItemPayment(ticketItemPayment);
            vo.setQrRecharge(qrRecharge);
            vo.setCashRecharge(cashRecharge);
            vo.setPosRecharge(posRecharge);
            vo.setDouyinRecharge(douyinRecharge);
            vo.setMeituanRecharge(meituanRecharge);
```

关键变更点：
- `totalTurnover` 来源从 `order.getTotalAmount()` 改为支付明细汇总（所有支付方式）
- `totalActualReceipt` 来源从 `order.getActualAmount()` 改为支付明细汇总（排除 type 5/6/7）
- switch 新增 `case 6`（代金券）和 `case 7`（项目券）
- 新增 `ticketConsumerPayment` 和 `ticketItemPayment` 字段赋值

- [ ] **Step 2: 验证编译通过**

Run: `mvn compile -pl pos-server -q`
Expected: BUILD SUCCESS

- [ ] **Step 3: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java
git commit -m "feat(statistics): 销售汇总按支付明细聚合，新增券支付统计"
```

---

### Task 5: 全量构建验证

- [ ] **Step 1: 执行全量构建**

Run: `mvn clean package -DskipTests`
Expected: BUILD SUCCESS

- [ ] **Step 2: 检查无遗漏**

确认以下变更均已提交：
- `PaymentTypeEnum.java` — 新增 TICKET_CONSUMER(6)、TICKET_ITEM(7)
- `PaymentDetailServiceImpl.java` — 券支付校验逻辑
- `OrderSummaryVO.java` — ticketConsumerPayment、ticketItemPayment 字段
- `OrderSalesSummaryServiceImpl.java` — 按支付明细聚合 + case 6/7
