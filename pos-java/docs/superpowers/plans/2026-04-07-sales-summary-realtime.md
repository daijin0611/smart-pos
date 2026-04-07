# 销售数据汇总实时计算改造 实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将销售数据汇总从定时任务写入汇总表改为查询时实时聚合计算，同时将充值统计字段与支付枚举对齐。

**Architecture:** Service 层直接查询 order_info、order_detail、payment_detail 三个原始表，按 (orgId, LocalDate) 分组在 Java 内存中聚合，返回结果。移除汇总表实体、Mapper 和定时任务。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus 3.5.11, Lombok

---

## File Structure

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| Modify | `pos-common/.../enums/PaymentTypeEnum.java` | QR 标签改为"收款码" |
| Modify | `pos-common/.../vo/order/OrderSummaryVO.java` | 替换 3 个充值字段为 5 个 |
| Modify | `pos-server/.../service/OrderSalesSummaryService.java` | 移除 IService 继承和 executeSummaries |
| Rewrite | `pos-server/.../service/impl/OrderSalesSummaryServiceImpl.java` | 实时计算逻辑 |
| Delete | `pos-server/.../entity/OrderSalesSummary.java` | 汇总表实体 |
| Delete | `pos-server/.../mapper/OrderSalesSummaryMapper.java` | Mapper 接口 |
| Delete | `pos-server/src/main/resources/mapper/order/OrderSalesSummaryMapper.xml` | Mapper XML |
| Delete | `pos-server/.../task/ScheduledTaskService.java` | 定时任务 |

---

### Task 1: 修改 PaymentTypeEnum 标签

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/enums/PaymentTypeEnum.java`

- [ ] **Step 1: 修改 QR 枚举标签**

将第 14 行：
```java
QR("0", "扫码"),
```
改为：
```java
QR("0", "收款码"),
```

- [ ] **Step 2: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/enums/PaymentTypeEnum.java
git commit -m "feat(payment): 支付方式扫码改为收款码"
```

---

### Task 2: 更新 OrderSummaryVO 充值字段

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java`

- [ ] **Step 1: 替换充值字段**

移除旧字段（第118-132行附近）：
```java
/**
 * 现金充值金额
 */
@Schema(description = "现金充值金额")
private BigDecimal cashRecharge;

/**
 * 微信充值金额
 */
@Schema(description = "微信充值金额")
private BigDecimal wechatRecharge;

/**
 * 其他方式充值
 */
@Schema(description = "其他方式充值")
private BigDecimal otherRecharge;
```

替换为：
```java
/**
 * 收款码充值金额
 */
@Schema(description = "收款码充值金额")
private BigDecimal qrRecharge;

/**
 * 现金充值金额
 */
@Schema(description = "现金充值金额")
private BigDecimal cashRecharge;

/**
 * POS充值金额
 */
@Schema(description = "POS充值金额")
private BigDecimal posRecharge;

/**
 * 抖音充值金额
 */
@Schema(description = "抖音充值金额")
private BigDecimal douyinRecharge;

/**
 * 美团充值金额
 */
@Schema(description = "美团充值金额")
private BigDecimal meituanRecharge;
```

- [ ] **Step 2: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java
git commit -m "feat(order): 销售汇总VO充值字段与支付枚举对齐"
```

---

### Task 3: 重构 Service 接口

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/OrderSalesSummaryService.java`

- [ ] **Step 1: 移除 IService 继承和 executeSummaries 方法**

将整个文件内容替换为：
```java
package org.haut.server.order.service;

import org.haut.common.domain.query.order.OrderSummaryQuery;
import org.haut.common.domain.vo.order.OrderSummaryVO;

import java.util.List;

/**
 * 销售数据汇总服务（实时计算）
 */
public interface OrderSalesSummaryService {

    /**
     * 实时获取销售汇总数据
     * @param query 查询条件
     * @return 销售汇总列表
     */
    List<OrderSummaryVO> getOrderSummaries(OrderSummaryQuery query);
}
```

- [ ] **Step 2: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/OrderSalesSummaryService.java
git commit -m "refactor(order): 销售汇总Service接口移除IService继承"
```

---

### Task 4: 重写 Service 实现

**Files:**
- Rewrite: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java`

- [ ] **Step 1: 重写整个实现类**

替换文件全部内容为：
```java
package org.haut.server.order.service.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ArrayUtils;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.order.OrderSummaryQuery;
import org.haut.common.domain.vo.order.OrderSummaryVO;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import org.haut.common.enums.OrderStatusEnum;
import org.haut.common.enums.PaymentActiveTypeEnum;
import org.haut.common.enums.PaymentStatusEnum;
import org.haut.common.enums.PaymentTypeEnum;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.haut.server.order.service.OrderSalesSummaryService;
import org.haut.server.payment.entity.PaymentDetail;
import org.haut.server.payment.service.PaymentDetailService;
import org.haut.server.system.service.SysOrgService;
import org.haut.server.system.service.SysOrgUserService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Slf4j
public class OrderSalesSummaryServiceImpl implements OrderSalesSummaryService {

    private final OrderInfoService orderInfoService;
    private final OrderDetailService orderDetailService;
    private final PaymentDetailService paymentDetailService;
    private final SysOrgService sysOrgService;
    private final SysOrgUserService sysOrgUserService;

    @Override
    public List<OrderSummaryVO> getOrderSummaries(OrderSummaryQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        List<Long> orgIds = sysOrgUserService.resolveOrgIds(auth.getUserId(), auth.getOrgId(), query.getOrgIds());
        LocalDate[] date = query.getDate();

        // 构建日期范围条件
        Date startTime = null;
        Date endTime = null;
        if (ArrayUtils.isNotEmpty(date) && date.length == 2) {
            startTime = java.sql.Date.valueOf(date[0]);
            endTime = java.sql.Date.valueOf(date[1].plusDays(1));
        }

        // 1. 查询订单（已结算 + 已对账）
        List<OrderInfoEntity> orderList = orderInfoService.lambdaQuery()
                .in(OrderInfoEntity::getOrgId, orgIds)
                .ge(startTime != null, OrderInfoEntity::getCreateTime, startTime)
                .lt(endTime != null, OrderInfoEntity::getCreateTime, endTime)
                .in(OrderInfoEntity::getOrderStatus,
                        OrderStatusEnum.SETTLED.getCode(), OrderStatusEnum.RECONCILED.getCode())
                .list();

        // 2. 查询订单明细
        List<OrderDetailEntity> detailList = orderDetailService.lambdaQuery()
                .in(OrderDetailEntity::getOrgId, orgIds)
                .ge(startTime != null, OrderDetailEntity::getCreateTime, startTime)
                .lt(endTime != null, OrderDetailEntity::getCreateTime, endTime)
                .list();

        // 3. 查询支付明细（已结算）
        List<PaymentDetail> paymentList = paymentDetailService.lambdaQuery()
                .in(PaymentDetail::getOrgId, orgIds)
                .ge(startTime != null, PaymentDetail::getCreateTime, startTime)
                .lt(endTime != null, PaymentDetail::getCreateTime, endTime)
                .eq(PaymentDetail::getPaymentStatus, PaymentStatusEnum.PAID.getStatus())
                .list();

        // 4. 按门店+日期分组聚合
        Map<String, List<OrderInfoEntity>> ordersByGroup = orderList.stream()
                .collect(Collectors.groupingBy(o -> groupKey(o.getOrgId(), o.getCreateTime())));
        Map<String, List<OrderDetailEntity>> detailsByGroup = detailList.stream()
                .collect(Collectors.groupingBy(d -> groupKey(d.getOrgId(), d.getCreateTime())));
        Map<String, List<PaymentDetail>> paymentsByGroup = paymentList.stream()
                .collect(Collectors.groupingBy(p -> groupKey(p.getOrgId(), p.getCreateTime())));

        // 合并所有出现的分组key
        Set<String> allKeys = new HashSet<>();
        allKeys.addAll(ordersByGroup.keySet());
        allKeys.addAll(detailsByGroup.keySet());
        allKeys.addAll(paymentsByGroup.keySet());

        List<OrderSummaryVO> result = new ArrayList<>();
        for (String key : allKeys) {
            String[] parts = key.split("\\|");
            Long orgId = Long.parseLong(parts[0]);
            LocalDate statsDate = LocalDate.parse(parts[1]);

            OrderSummaryVO vo = new OrderSummaryVO();
            vo.setOrgId(orgId);
            vo.setStatsDate(statsDate);

            // 聚合订单数据
            List<OrderInfoEntity> groupOrders = ordersByGroup.getOrDefault(key, Collections.emptyList());
            BigDecimal totalTurnover = BigDecimal.ZERO;
            BigDecimal totalActualReceipt = BigDecimal.ZERO;
            for (OrderInfoEntity order : groupOrders) {
                if (order.getTotalAmount() != null) {
                    totalTurnover = totalTurnover.add(order.getTotalAmount());
                }
                if (order.getActualAmount() != null) {
                    totalActualReceipt = totalActualReceipt.add(order.getActualAmount());
                }
            }
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
            BigDecimal qrPayment = BigDecimal.ZERO;
            BigDecimal cashPayment = BigDecimal.ZERO;
            BigDecimal posPayment = BigDecimal.ZERO;
            BigDecimal douyinPayment = BigDecimal.ZERO;
            BigDecimal meituanPayment = BigDecimal.ZERO;
            BigDecimal memberCardPayment = BigDecimal.ZERO;
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
                    // 消费支付
                    switch (paymentType) {
                        case 0 -> qrPayment = qrPayment.add(amount);
                        case 1 -> cashPayment = cashPayment.add(amount);
                        case 2 -> posPayment = posPayment.add(amount);
                        case 3 -> douyinPayment = douyinPayment.add(amount);
                        case 4 -> meituanPayment = meituanPayment.add(amount);
                        case 5 -> memberCardPayment = memberCardPayment.add(amount);
                        default -> log.warn("未知的支付类型: {}", paymentType);
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
            vo.setQrRecharge(qrRecharge);
            vo.setCashRecharge(cashRecharge);
            vo.setPosRecharge(posRecharge);
            vo.setDouyinRecharge(douyinRecharge);
            vo.setMeituanRecharge(meituanRecharge);

            result.add(vo);
        }

        // 5. 按日期排序
        result.sort(Comparator.comparing(OrderSummaryVO::getStatsDate));

        // 6. 批量填充门店信息
        if (!result.isEmpty()) {
            Map<Long, OrgSimpleVO> orgMap = sysOrgService.getOrgSimpleMapByIds(
                    result.stream().map(OrderSummaryVO::getOrgId).collect(Collectors.toSet()));
            result.forEach(vo -> {
                OrgSimpleVO org = orgMap.get(vo.getOrgId());
                if (org != null) {
                    vo.setOrgName(org.getOrgName());
                    vo.setOrgCode(org.getOrgCode());
                }
            });
        }

        return result;
    }

    /**
     * 生成分组key: orgId|yyyy-MM-dd
     */
    private String groupKey(Long orgId, Date date) {
        LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        return orgId + "|" + localDate;
    }
}
```

- [ ] **Step 2: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java
git commit -m "feat(order): 销售汇总改为实时计算"
```

---

### Task 5: 删除汇总表实体和 Mapper

**Files:**
- Delete: `pos-server/src/main/java/org/haut/server/order/entity/OrderSalesSummary.java`
- Delete: `pos-server/src/main/java/org/haut/server/order/mapper/OrderSalesSummaryMapper.java`
- Delete: `pos-server/src/main/resources/mapper/order/OrderSalesSummaryMapper.xml`

- [ ] **Step 1: 删除三个文件**

```bash
rm pos-server/src/main/java/org/haut/server/order/entity/OrderSalesSummary.java
rm pos-server/src/main/java/org/haut/server/order/mapper/OrderSalesSummaryMapper.java
rm pos-server/src/main/resources/mapper/order/OrderSalesSummaryMapper.xml
```

- [ ] **Step 2: 提交**

```bash
git add -A pos-server/src/main/java/org/haut/server/order/entity/OrderSalesSummary.java pos-server/src/main/java/org/haut/server/order/mapper/OrderSalesSummaryMapper.java pos-server/src/main/resources/mapper/order/OrderSalesSummaryMapper.xml
git commit -m "refactor(order): 移除销售汇总表实体和Mapper"
```

---

### Task 6: 删除定时任务

**Files:**
- Delete: `pos-server/src/main/java/org/haut/server/task/ScheduledTaskService.java`

- [ ] **Step 1: 删除定时任务类**

```bash
rm pos-server/src/main/java/org/haut/server/task/ScheduledTaskService.java
```

- [ ] **Step 2: 提交**

```bash
git add -A pos-server/src/main/java/org/haut/server/task/ScheduledTaskService.java
git commit -m "refactor(task): 移除销售数据统计定时任务"
```

---

### Task 7: 编译验证

- [ ] **Step 1: 编译项目确认无错误**

```bash
cd D:/Codes/pos/pos-java && mvn clean compile -DskipTests
```

预期：BUILD SUCCESS，无编译错误。

- [ ] **Step 2: 如有编译错误，修复后重新编译**

常见问题：其他模块可能引用了已删除的类，需要清理引用。
