# 支付类型重构 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将支付方式从旧的7种（微信/支付宝/现金/会员卡/优惠券/美团/抖音/未知）重构为新的6种（扫码/现金/POS/抖音/美团/会员卡）

**Architecture:** 重构 PaymentTypeEnum 枚举值，同步修改 OrderSalesSummary 实体/VO/DTO/数据库表的字段结构，以及所有引用旧枚举值的业务逻辑。数据库迁移脚本 V1.0.11 已处理 payment_detail 表的 payment_type 数据迁移，需新增 DDL 迁移脚本处理 order_sales_summary 表结构变更。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus 3.5.11, MySQL, MapStruct 1.6.3

---

### 新编码方案

| 编码 | 枚举名 | 中文 | 旧编码来源 |
|------|--------|------|-----------|
| 0 | QR | 扫码 | 原0(微信)+1(支付宝)+4(优惠券)+99(未知) 合并 |
| 1 | CASH | 现金 | 原2(现金) |
| 2 | POS | POS | 新增 |
| 3 | DOUYIN | 抖音 | 原6(抖音) |
| 4 | MEITUAN | 美团 | 原5(美团) |
| 5 | MEMBER_CARD | 会员卡 | 原3(会员卡/ASSET) |

---

### Task 1: 重写 PaymentTypeEnum

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/enums/PaymentTypeEnum.java`

- [ ] **Step 1: 重写 PaymentTypeEnum 枚举**

将枚举替换为新的6种支付类型：

```java
package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author 丁铭瀚
 * @version 2.0
 */
@Getter
@AllArgsConstructor
public enum PaymentTypeEnum {

    QR("0", "扫码"),
    CASH("1", "现金"),
    POS("2", "POS"),
    DOUYIN("3", "抖音"),
    MEITUAN("4", "美团"),
    MEMBER_CARD("5", "会员卡"),
    ;

    private final String code;
    private final String label;

    /**
     * 根据 code 获取枚举
     */
    public static PaymentTypeEnum getByCode(String code) {
        for (PaymentTypeEnum e : values()) {
            if (e.code.equals(code)) {
                return e;
            }
        }
        return null;
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/enums/PaymentTypeEnum.java
git commit -m "feat(payment): 重写PaymentTypeEnum为新的6种支付类型"
```

---

### Task 2: 新增数据库迁移脚本

**Files:**
- Create: `sql/V1.0.12__refactor_order_sales_summary_columns.sql`

- [ ] **Step 1: 编写 DDL 迁移脚本**

新增列、迁移数据、删除旧列：

```sql
-- V1.0.12: 重构 order_sales_summary 支付方式字段，对齐新 PaymentTypeEnum

-- 1. 新增6个支付方式列
ALTER TABLE order_sales_summary
    ADD COLUMN qr_payment            DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT '扫码支付金额' AFTER total_project_count,
    ADD COLUMN pos_payment           DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT 'POS支付金额' AFTER cash_payment,
    ADD COLUMN douyin_payment        DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT '抖音支付金额' AFTER pos_payment,
    ADD COLUMN meituan_payment       DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT '美团支付金额' AFTER douyin_payment;

-- 2. 迁移数据：旧字段 → 新字段
-- 扫码 = 原微信 + 原支付宝 + 原电子券 + 原其他
UPDATE order_sales_summary
SET qr_payment = COALESCE(wechat_payment, 0) + COALESCE(alipay_payment, 0) + COALESCE(electronic_coupon_payment, 0) + COALESCE(other_payment, 0);

-- 会员卡保持不变（membership_card_payment 列名不变，后续 Task 3 处理实体字段重命名）
-- 现金保持不变（cash_payment 列名不变）
-- 抖音 = 0（旧系统无此列，历史数据无抖音支付）
-- 美团 = 0（旧系统无此列，历史数据无美团支付）
-- POS = 0（旧系统无此列，历史数据无POS支付）

-- 3. 删除旧列
ALTER TABLE order_sales_summary
    DROP COLUMN wechat_payment,
    DROP COLUMN alipay_payment,
    DROP COLUMN bank_card_payment,
    DROP COLUMN electronic_coupon_payment,
    DROP COLUMN other_payment;

-- 4. 重命名 membership_card_payment → member_card_payment（对齐枚举命名）
ALTER TABLE order_sales_summary
    CHANGE COLUMN membership_card_payment member_card_payment DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT '会员卡支付金额';
```

- [ ] **Step 2: Commit**

```bash
git add sql/V1.0.12__refactor_order_sales_summary_columns.sql
git commit -m "feat(payment): 新增order_sales_summary表结构迁移脚本"
```

---

### Task 3: 重构 OrderSalesSummary 实体

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/entity/OrderSalesSummary.java`

- [ ] **Step 1: 重写 OrderSalesSummary 实体字段**

将旧的7个支付字段替换为新的6个：

```java
package org.haut.server.order.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 销售数据汇总表，整合销售、支付、充值相关数据
 * @TableName order_sales_summary
 */
@TableName(value ="order_sales_summary")
@Data
@Accessors(chain = true)
public class OrderSalesSummary {
    @TableId(type = IdType.AUTO)
    private Long id;

    private Long orgId;

    private LocalDateTime createTime;

    private LocalDate statsDate;

    private BigDecimal totalTurnover;

    private BigDecimal totalActualReceipt;

    private Integer totalSingleTime;

    private Integer totalPeopleTime;

    private Integer totalProjectCount;

    /** 扫码支付金额 */
    private BigDecimal qrPayment;

    /** 现金支付金额 */
    private BigDecimal cashPayment;

    /** POS支付金额 */
    private BigDecimal posPayment;

    /** 抖音支付金额 */
    private BigDecimal douyinPayment;

    /** 美团支付金额 */
    private BigDecimal meituanPayment;

    /** 会员卡支付金额 */
    private BigDecimal memberCardPayment;

    /** 现金充值金额 */
    private BigDecimal cashRecharge;

    /** 微信充值金额 */
    private BigDecimal wechatRecharge;

    /** 其他方式充值 */
    private BigDecimal otherRecharge;
}
```

- [ ] **Step 2: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/entity/OrderSalesSummary.java
git commit -m "feat(payment): 重构OrderSalesSummary实体字段"
```

---

### Task 4: 重构 OrderSummaryVO

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java`

- [ ] **Step 1: 重写 OrderSummaryVO 支付字段**

将旧的7个支付字段替换为新的6个，充值字段保持不变：

```java
package org.haut.common.domain.vo.order;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @author 丁铭瀚
 * @version 2.0
 */
@Data
@Accessors(chain = true)
@Schema(description = "销售数据统计")
public class OrderSummaryVO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long orgId;

    private String orgName;

    private String orgCode;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    private LocalDate statsDate;

    private BigDecimal totalTurnover;

    private BigDecimal totalActualReceipt;

    private Integer totalSingleTime;

    private Integer totalPeopleTime;

    private Integer totalProjectCount;

    @Schema(description = "扫码支付金额")
    private BigDecimal qrPayment;

    @Schema(description = "现金支付金额")
    private BigDecimal cashPayment;

    @Schema(description = "POS支付金额")
    private BigDecimal posPayment;

    @Schema(description = "抖音支付金额")
    private BigDecimal douyinPayment;

    @Schema(description = "美团支付金额")
    private BigDecimal meituanPayment;

    @Schema(description = "会员卡支付金额")
    private BigDecimal memberCardPayment;

    @Schema(description = "现金充值金额")
    private BigDecimal cashRecharge;

    @Schema(description = "微信充值金额")
    private BigDecimal wechatRecharge;

    @Schema(description = "其他方式充值")
    private BigDecimal otherRecharge;
}
```

- [ ] **Step 2: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java
git commit -m "feat(payment): 重构OrderSummaryVO支付字段"
```

---

### Task 5: 重构 OrderSummaryDTO

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/order/OrderSummaryDTO.java`

- [ ] **Step 1: 重写 OrderSummaryDTO 支付字段**

与 OrderSummaryVO/OrderSalesSummary 保持一致：

```java
package org.haut.common.domain.dto.order;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @author 丁铭瀚
 * @version 2.0
 */
public class OrderSummaryDTO {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long orgId;

    private LocalDateTime createTime;

    private LocalDate statsDate;

    private BigDecimal totalTurnover;

    private BigDecimal totalActualReceipt;

    private Integer totalSingleTime;

    private Integer totalPeopleTime;

    private Integer totalProjectCount;

    /** 扫码支付金额 */
    private BigDecimal qrPayment;

    /** 现金支付金额 */
    private BigDecimal cashPayment;

    /** POS支付金额 */
    private BigDecimal posPayment;

    /** 抖音支付金额 */
    private BigDecimal douyinPayment;

    /** 美团支付金额 */
    private BigDecimal meituanPayment;

    /** 会员卡支付金额 */
    private BigDecimal memberCardPayment;

    /** 现金充值金额 */
    private BigDecimal cashRecharge;

    /** 微信充值金额 */
    private BigDecimal wechatRecharge;

    /** 其他方式充值 */
    private BigDecimal otherRecharge;
}
```

- [ ] **Step 2: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/dto/order/OrderSummaryDTO.java
git commit -m "feat(payment): 重构OrderSummaryDTO支付字段"
```

---

### Task 6: 重构 OrderSalesSummaryMapper.xml

**Files:**
- Modify: `pos-server/src/main/resources/mapper/order/OrderSalesSummaryMapper.xml`

- [ ] **Step 1: 更新 ResultMap 和 Column List**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="org.haut.server.order.mapper.OrderSalesSummaryMapper">

    <resultMap id="BaseResultMap" type="org.haut.server.order.entity.OrderSalesSummary">
            <id property="id" column="id" />
            <result property="statsDate" column="stats_date" />
            <result property="totalTurnover" column="total_turnover" />
            <result property="totalActualReceipt" column="total_actual_receipt" />
            <result property="totalSingleTime" column="total_single_time" />
            <result property="totalPeopleTime" column="total_people_time" />
            <result property="totalProjectCount" column="total_project_count" />
            <result property="qrPayment" column="qr_payment" />
            <result property="cashPayment" column="cash_payment" />
            <result property="posPayment" column="pos_payment" />
            <result property="douyinPayment" column="douyin_payment" />
            <result property="meituanPayment" column="meituan_payment" />
            <result property="memberCardPayment" column="member_card_payment" />
            <result property="cashRecharge" column="cash_recharge" />
            <result property="wechatRecharge" column="wechat_recharge" />
            <result property="otherRecharge" column="other_recharge" />
    </resultMap>

    <sql id="Base_Column_List">
        id,stats_date,total_turnover,total_actual_receipt,total_single_time,total_people_time,
        total_project_count,qr_payment,cash_payment,pos_payment,douyin_payment,meituan_payment,
        member_card_payment,cash_recharge,wechat_recharge,other_recharge
    </sql>
</mapper>
```

- [ ] **Step 2: Commit**

```bash
git add pos-server/src/main/resources/mapper/order/OrderSalesSummaryMapper.xml
git commit -m "feat(payment): 重构OrderSalesSummaryMapper映射"
```

---

### Task 7: 重构 OrderSalesSummaryServiceImpl 统计逻辑

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java`

- [ ] **Step 1: 重写 execute() 方法中的支付统计逻辑**

替换 `execute(SysOrg org)` 方法中第3部分的支付统计代码（约第316-386行），将旧的7种支付改为新的6种：

**旧变量声明（替换）：**
```java
// 旧
BigDecimal alipayPayment = BigDecimal.ZERO;
BigDecimal bankCardPayment = BigDecimal.ZERO;
BigDecimal cashPayment = BigDecimal.ZERO;
BigDecimal electronicCouponPayment = BigDecimal.ZERO;
BigDecimal membershipCardPayment = BigDecimal.ZERO;
BigDecimal otherPayment = BigDecimal.ZERO;
BigDecimal wechatPayment = BigDecimal.ZERO;
```

**新变量声明：**
```java
BigDecimal qrPayment = BigDecimal.ZERO;
BigDecimal cashPayment = BigDecimal.ZERO;
BigDecimal posPayment = BigDecimal.ZERO;
BigDecimal douyinPayment = BigDecimal.ZERO;
BigDecimal meituanPayment = BigDecimal.ZERO;
BigDecimal memberCardPayment = BigDecimal.ZERO;
```

**旧 if-else 块（替换）：**
```java
// 旧
if (PaymentTypeEnum.WECHAT.getCode().equals(String.valueOf(paymentType))) {
    wechatPayment = wechatPayment.add(amount);
} else if (PaymentTypeEnum.ALIPAY.getCode().equals(String.valueOf(paymentType))) {
    alipayPayment = alipayPayment.add(amount);
} else if (PaymentTypeEnum.CASH.getCode().equals(String.valueOf(paymentType))) {
    cashPayment = cashPayment.add(amount);
} else if (PaymentTypeEnum.ASSET.getCode().equals(String.valueOf(paymentType))) {
    membershipCardPayment = membershipCardPayment.add(amount);
} else {
    otherPayment = otherPayment.add(amount);
}
```

**新 switch 块：**
```java
switch (paymentType) {
    case 0 -> qrPayment = qrPayment.add(amount);
    case 1 -> cashPayment = cashPayment.add(amount);
    case 2 -> posPayment = posPayment.add(amount);
    case 3 -> douyinPayment = douyinPayment.add(amount);
    case 4 -> meituanPayment = meituanPayment.add(amount);
    case 5 -> memberCardPayment = memberCardPayment.add(amount);
    default -> log.warn("未知的支付类型: {}", paymentType);
}
```

**旧 summary 构建（替换）：**
```java
// 旧
.setAlipayPayment(alipayPayment)
.setBankCardPayment(bankCardPayment)
.setCashPayment(cashPayment)
.setElectronicCouponPayment(electronicCouponPayment)
.setMembershipCardPayment(membershipCardPayment)
.setOtherPayment(otherPayment)
.setWechatPayment(wechatPayment)
```

**新 summary 构建：**
```java
.setQrPayment(qrPayment)
.setCashPayment(cashPayment)
.setPosPayment(posPayment)
.setDouyinPayment(douyinPayment)
.setMeituanPayment(meituanPayment)
.setMemberCardPayment(memberCardPayment)
```

- [ ] **Step 2: 重写 calculateTotal() 方法**

替换 `calculateTotal()` 方法中所有旧字段引用为新的6个支付字段。将：
- `alipayPayment` → `qrPayment`（注意：alipay 合并进 qr）
- `bankCardPayment` → 删除
- `electronicCouponPayment` → 删除
- `otherPayment` → 删除
- `wechatPayment` → 删除
- `membershipCardPayment` → `memberCardPayment`

新的初始化和累加：

```java
private OrderSummaryVO calculateTotal(List<OrderSummaryVO> summaries) {
    OrderSummaryVO totalSummary = new OrderSummaryVO();

    totalSummary.setTotalTurnover(BigDecimal.ZERO);
    totalSummary.setTotalActualReceipt(BigDecimal.ZERO);
    totalSummary.setTotalSingleTime(0);
    totalSummary.setTotalPeopleTime(0);
    totalSummary.setTotalProjectCount(0);
    totalSummary.setQrPayment(BigDecimal.ZERO);
    totalSummary.setCashPayment(BigDecimal.ZERO);
    totalSummary.setPosPayment(BigDecimal.ZERO);
    totalSummary.setDouyinPayment(BigDecimal.ZERO);
    totalSummary.setMeituanPayment(BigDecimal.ZERO);
    totalSummary.setMemberCardPayment(BigDecimal.ZERO);
    totalSummary.setCashRecharge(BigDecimal.ZERO);
    totalSummary.setWechatRecharge(BigDecimal.ZERO);
    totalSummary.setOtherRecharge(BigDecimal.ZERO);

    for (OrderSummaryVO summary : summaries) {
        if (summary.getTotalTurnover() != null) {
            totalSummary.setTotalTurnover(totalSummary.getTotalTurnover().add(summary.getTotalTurnover()));
        }
        if (summary.getTotalActualReceipt() != null) {
            totalSummary.setTotalActualReceipt(totalSummary.getTotalActualReceipt().add(summary.getTotalActualReceipt()));
        }
        if (summary.getQrPayment() != null) {
            totalSummary.setQrPayment(totalSummary.getQrPayment().add(summary.getQrPayment()));
        }
        if (summary.getCashPayment() != null) {
            totalSummary.setCashPayment(totalSummary.getCashPayment().add(summary.getCashPayment()));
        }
        if (summary.getPosPayment() != null) {
            totalSummary.setPosPayment(totalSummary.getPosPayment().add(summary.getPosPayment()));
        }
        if (summary.getDouyinPayment() != null) {
            totalSummary.setDouyinPayment(totalSummary.getDouyinPayment().add(summary.getDouyinPayment()));
        }
        if (summary.getMeituanPayment() != null) {
            totalSummary.setMeituanPayment(totalSummary.getMeituanPayment().add(summary.getMeituanPayment()));
        }
        if (summary.getMemberCardPayment() != null) {
            totalSummary.setMemberCardPayment(totalSummary.getMemberCardPayment().add(summary.getMemberCardPayment()));
        }
        if (summary.getCashRecharge() != null) {
            totalSummary.setCashRecharge(totalSummary.getCashRecharge().add(summary.getCashRecharge()));
        }
        if (summary.getWechatRecharge() != null) {
            totalSummary.setWechatRecharge(totalSummary.getWechatRecharge().add(summary.getWechatRecharge()));
        }
        if (summary.getOtherRecharge() != null) {
            totalSummary.setOtherRecharge(totalSummary.getOtherRecharge().add(summary.getOtherRecharge()));
        }
        if (summary.getTotalSingleTime() != null) {
            totalSummary.setTotalSingleTime(totalSummary.getTotalSingleTime() + summary.getTotalSingleTime());
        }
        if (summary.getTotalPeopleTime() != null) {
            totalSummary.setTotalPeopleTime(totalSummary.getTotalPeopleTime() + summary.getTotalPeopleTime());
        }
        if (summary.getTotalProjectCount() != null) {
            totalSummary.setTotalProjectCount(totalSummary.getTotalProjectCount() + summary.getTotalProjectCount());
        }
    }

    return totalSummary;
}
```

- [ ] **Step 3: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java
git commit -m "feat(payment): 重构销售汇总统计逻辑适配新支付类型"
```

---

### Task 8: 修复 OrderInfoServiceImpl 中的枚举引用

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java:619`

- [ ] **Step 1: 将 PaymentTypeEnum.ASSET 替换为 MEMBER_CARD**

在 `rollBackOrder` 方法中，第619行：

```java
// 旧
.eq(PaymentDetail::getPaymentType, Integer.parseInt(PaymentTypeEnum.ASSET.getCode()))
```

改为：

```java
.eq(PaymentDetail::getPaymentType, Integer.parseInt(PaymentTypeEnum.MEMBER_CARD.getCode()))
```

- [ ] **Step 2: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java
git commit -m "feat(payment): 更新OrderInfoServiceImpl中ASSET为MEMBER_CARD"
```

---

### Task 9: 修复 VipAssetServiceImpl 中的枚举引用

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/vip/service/impl/VipAssetServiceImpl.java:176`

- [ ] **Step 1: 将 PaymentTypeEnum.ASSET 替换为 MEMBER_CARD**

在 `handelOrder` 方法中，第176行：

```java
// 旧
.filter(p -> p.getPaymentType().toString().equals(PaymentTypeEnum.ASSET.getCode()))
```

改为：

```java
.filter(p -> p.getPaymentType().toString().equals(PaymentTypeEnum.MEMBER_CARD.getCode()))
```

- [ ] **Step 2: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/vip/service/impl/VipAssetServiceImpl.java
git commit -m "feat(payment): 更新VipAssetServiceImpl中ASSET为MEMBER_CARD"
```

---

### Task 10: 验证构建

- [ ] **Step 1: 编译验证**

```bash
mvn clean compile -DskipTests
```

Expected: BUILD SUCCESS，无编译错误。

- [ ] **Step 2: 修复编译错误（如有）**

如果 MapStruct 转换器报错（因为 OrderSalesSummary 字段变更），检查 `OrderSalesSummaryConvert` 接口是否能正确映射。由于使用的是 MapStruct 默认按字段名映射，字段名已统一，无需额外配置。

- [ ] **Step 3: 最终 Commit（如有修复）**
