# 订单明细多人业绩分配 实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为订单明细实现多人业绩分配，支持多个技师平分同一条明细的业绩和提成。

**Architecture:** 新建 `order_detail_technician` 关联表管理技师与明细的多对多关系。`order_detail.userId/userName` 语义调整为收银员。`kpi_detail` 新增 `detailId/detailCode` 字段关联订单明细。结算时按技师人数平分业绩和提成。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus 3.5.11, MySQL

---

## 文件结构

### 新建文件

| 文件 | 职责 |
|------|------|
| `sql/V1.0.4__add_order_detail_technician_and_alter_kpi_detail.sql` | 数据库迁移脚本 |
| `pos-common/src/main/java/org/haut/common/domain/dto/order/OrderDetailTechnicianDTO.java` | 技师信息 DTO |
| `pos-server/src/main/java/org/haut/server/order/entity/OrderDetailTechnicianEntity.java` | 技师关联实体 |
| `pos-server/src/main/java/org/haut/server/order/mapper/OrderDetailTechnicianMapper.java` | 技师关联 Mapper |
| `pos-server/src/main/java/org/haut/server/order/service/OrderDetailTechnicianService.java` | 技师关联 Service 接口 |
| `pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailTechnicianServiceImpl.java` | 技师关联 Service 实现 |

### 修改文件

| 文件 | 改动 |
|------|------|
| `pos-common/src/main/java/org/haut/common/domain/dto/order/OrderDetailCreateDTO.java` | 移除 userId/userName，新增 technicians 列表 |
| `pos-common/src/main/java/org/haut/common/domain/dto/order/OrderDetailSettleDTO.java` | 移除 userId/userName，新增 technicians 列表 |
| `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderDetailVO.java` | 新增 technicians 列表 |
| `pos-common/src/main/java/org/haut/common/domain/vo/order/ReceiptItemVO.java` | technicianName 改为 technicians 列表 |
| `pos-server/src/main/java/org/haut/server/kpi/entity/KpiDetail.java` | 新增 detailId、detailCode 字段 |
| `pos-server/src/main/java/org/haut/server/order/service/OrderDetailService.java` | 修改 updateServerEmployee 签名 |
| `pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailServiceImpl.java` | 核心改造 |
| `pos-server/src/main/java/org/haut/server/kpi/service/KpiDetailService.java` | handelOrder 签名变更 |
| `pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java` | 多人业绩计算改造 |
| `pos-web/src/main/java/org/haut/controller/order/OrderController.java` | update-server-employee 接口参数变更 |

---

### Task 1: 数据库迁移脚本

**Files:**
- Create: `sql/V1.0.4__add_order_detail_technician_and_alter_kpi_detail.sql`

- [ ] **Step 1: 编写迁移 SQL**

```sql
-- 新建订单明细技师关联表
CREATE TABLE order_detail_technician (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    detail_id   BIGINT       NOT NULL COMMENT '订单明细ID',
    user_id     BIGINT       NOT NULL COMMENT '技师ID',
    user_name   VARCHAR(50)  NOT NULL COMMENT '技师姓名',
    create_time DATETIME              COMMENT '创建时间',
    update_time DATETIME              COMMENT '更新时间',
    is_delete   TINYINT DEFAULT 0     COMMENT '删除状态(0存在 1删除)',
    INDEX idx_detail_id (detail_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细技师关联表';

-- kpi_detail 新增订单明细关联字段
ALTER TABLE kpi_detail ADD COLUMN detail_id BIGINT NULL COMMENT '订单明细ID';
ALTER TABLE kpi_detail ADD COLUMN detail_code VARCHAR(50) NULL COMMENT '订单明细编号';
ALTER TABLE kpi_detail ADD INDEX idx_detail_id (detail_id);
```

- [ ] **Step 2: 在数据库中执行迁移脚本验证**

执行上述 SQL，确认表创建成功，字段添加正确。

- [ ] **Step 3: 提交**

```bash
git add sql/V1.0.4__add_order_detail_technician_and_alter_kpi_detail.sql
git commit -m "feat(order): 添加订单明细技师关联表和kpi_detail关联字段"
```

---

### Task 2: 新增 OrderDetailTechnicianDTO

**Files:**
- Create: `pos-common/src/main/java/org/haut/common/domain/dto/order/OrderDetailTechnicianDTO.java`

- [ ] **Step 1: 创建 DTO 类**

```java
package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Schema(description = "订单明细技师DTO")
public class OrderDetailTechnicianDTO {

    @NotNull(message = "技师ID不能为空")
    @Schema(description = "技师ID")
    private Long userId;

    @Schema(description = "技师姓名")
    private String userName;
}
```

- [ ] **Step 2: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/domain/dto/order/OrderDetailTechnicianDTO.java
git commit -m "feat(order): 添加订单明细技师DTO"
```

---

### Task 3: 新增 Entity、Mapper、Service

**Files:**
- Create: `pos-server/src/main/java/org/haut/server/order/entity/OrderDetailTechnicianEntity.java`
- Create: `pos-server/src/main/java/org/haut/server/order/mapper/OrderDetailTechnicianMapper.java`
- Create: `pos-server/src/main/java/org/haut/server/order/service/OrderDetailTechnicianService.java`
- Create: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailTechnicianServiceImpl.java`

- [ ] **Step 1: 创建 Entity 类**

```java
package org.haut.server.order.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

@TableName(value = "order_detail_technician")
@Data
@Accessors(chain = true)
@Schema(description = "订单明细技师关联表")
public class OrderDetailTechnicianEntity {

    @TableId(type = IdType.AUTO)
    @Schema(description = "主键ID")
    private Long id;

    @TableField(fill = FieldFill.INSERT)
    @Schema(description = "创建时间")
    private Date createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    @Schema(description = "更新时间")
    private Date updateTime;

    @Schema(description = "删除状态(0存在 1删除)")
    private Integer isDelete;

    @Schema(description = "订单明细ID")
    private Long detailId;

    @Schema(description = "技师ID")
    private Long userId;

    @Schema(description = "技师姓名")
    private String userName;
}
```

- [ ] **Step 2: 创建 Mapper 接口**

```java
package org.haut.server.order.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.haut.server.order.entity.OrderDetailTechnicianEntity;

@Mapper
public interface OrderDetailTechnicianMapper extends BaseMapper<OrderDetailTechnicianEntity> {
}
```

- [ ] **Step 3: 创建 Service 接口**

```java
package org.haut.server.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import org.haut.server.order.entity.OrderDetailTechnicianEntity;

import java.util.List;

public interface OrderDetailTechnicianService extends IService<OrderDetailTechnicianEntity> {

    /**
     * 批量保存技师关联
     * @param detailId 订单明细ID
     * @param technicians 技师列表
     */
    void saveTechnicians(Long detailId, List<OrderDetailTechnicianDTO> technicians);

    /**
     * 根据订单明细ID查询技师列表
     * @param detailId 订单明细ID
     * @return 技师列表
     */
    List<OrderDetailTechnicianDTO> listByDetailId(Long detailId);

    /**
     * 根据多个订单明细ID批量查询技师列表
     * @param detailIds 订单明细ID列表
     * @return 技师列表（含 detailId）
     */
    List<OrderDetailTechnicianEntity> listByDetailIds(List<Long> detailIds);

    /**
     * 更新技师关联（先删后增）
     * @param detailId 订单明细ID
     * @param technicians 新的技师列表
     */
    void updateTechnicians(Long detailId, List<OrderDetailTechnicianDTO> technicians);

    /**
     * 根据订单明细ID删除技师关联
     * @param detailId 订单明细ID
     */
    void removeByDetailId(Long detailId);
}
```

- [ ] **Step 4: 创建 Service 实现类**

```java
package org.haut.server.order.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import org.haut.server.order.entity.OrderDetailTechnicianEntity;
import org.haut.server.order.mapper.OrderDetailTechnicianMapper;
import org.haut.server.order.service.OrderDetailTechnicianService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderDetailTechnicianServiceImpl
        extends ServiceImpl<OrderDetailTechnicianMapper, OrderDetailTechnicianEntity>
        implements OrderDetailTechnicianService {

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveTechnicians(Long detailId, List<OrderDetailTechnicianDTO> technicians) {
        if (technicians == null || technicians.isEmpty()) {
            return;
        }
        List<OrderDetailTechnicianEntity> entities = technicians.stream()
                .map(t -> new OrderDetailTechnicianEntity()
                        .setDetailId(detailId)
                        .setUserId(t.getUserId())
                        .setUserName(t.getUserName()))
                .toList();
        saveBatch(entities);
    }

    @Override
    public List<OrderDetailTechnicianDTO> listByDetailId(Long detailId) {
        if (detailId == null) {
            return Collections.emptyList();
        }
        List<OrderDetailTechnicianEntity> entities = lambdaQuery()
                .eq(OrderDetailTechnicianEntity::getDetailId, detailId)
                .list();
        return entities.stream()
                .map(e -> new OrderDetailTechnicianDTO()
                        .setUserId(e.getUserId())
                        .setUserName(e.getUserName()))
                .toList();
    }

    @Override
    public List<OrderDetailTechnicianEntity> listByDetailIds(List<Long> detailIds) {
        if (detailIds == null || detailIds.isEmpty()) {
            return Collections.emptyList();
        }
        return lambdaQuery()
                .in(OrderDetailTechnicianEntity::getDetailId, detailIds)
                .list();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateTechnicians(Long detailId, List<OrderDetailTechnicianDTO> technicians) {
        removeByDetailId(detailId);
        saveTechnicians(detailId, technicians);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void removeByDetailId(Long detailId) {
        lambdaUpdate()
                .eq(OrderDetailTechnicianEntity::getDetailId, detailId)
                .remove();
    }
}
```

- [ ] **Step 5: 编译验证**

```bash
cd E:/Codes/pos/pos-java && mvn compile -pl pos-server -am -DskipTests -q
```

预期：编译成功，无错误。

- [ ] **Step 6: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/order/entity/OrderDetailTechnicianEntity.java pos-server/src/main/java/org/haut/server/order/mapper/OrderDetailTechnicianMapper.java pos-server/src/main/java/org/haut/server/order/service/OrderDetailTechnicianService.java pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailTechnicianServiceImpl.java
git commit -m "feat(order): 添加订单明细技师关联的Entity/Mapper/Service"
```

---

### Task 4: 修改 DTO — OrderDetailCreateDTO 和 OrderDetailSettleDTO

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/order/OrderDetailCreateDTO.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/order/OrderDetailSettleDTO.java`

- [ ] **Step 1: 修改 OrderDetailCreateDTO**

移除 `userId` 和 `userName` 字段，新增 `technicians` 字段：

```java
package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

@Data
@Accessors(chain = true)
@Schema(description = "订单明细DTO")
public class OrderDetailCreateDTO {

    @NotNull(message = "业务类型不能为空")
    @Schema(description = "业务类型（0 产品，1 服务，2 疗程券）")
    private Integer detailType;

    @NotNull(message = "业务ID不能为空")
    @Schema(description = "订单业务ID（产品ID、服务ID或疗程券ID）")
    private Long bid;

    @Schema(description = "标准单价", example = "100.00")
    private BigDecimal stdPrice;

    @Schema(description = "实际单价(结算前和实收价保持一致；结算时更新实际单价)", example = "100.00")
    private BigDecimal truePrice;

    @NotNull(message = "销售数量不能为空")
    @Schema(description = "销售数量")
    private Integer quantity;

    @Schema(description = "上钟类型（0 点钟，1 加钟，2 轮牌）")
    private Integer serverType;

    @Schema(description = "备注信息")
    private String remark;

    @Schema(description = "技师列表")
    private List<OrderDetailTechnicianDTO> technicians;
}
```

- [ ] **Step 2: 修改 OrderDetailSettleDTO**

移除 `userId` 和 `userName` 字段及其 `@NotNull` 注解，新增 `technicians` 字段：

```java
package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

@Data
@Schema(description = "结算订单明细请求DTO")
@Accessors(chain = true)
public class OrderDetailSettleDTO {

    @Schema(description = "订单明细ID")
    private Long id;

    @Schema(description = "订单明细编号")
    private String detailCode;

    @NotNull(message = "业务类型不能为空")
    @Schema(description = "业务类型（0 产品，1 服务，2 疗程券）")
    private Integer detailType;

    @NotNull(message = "业务ID不能为空")
    @Schema(description = "订单业务ID（产品ID、服务ID或疗程券ID）")
    private Long bid;

    @Schema(description = "业务名称")
    private String businessName;

    @Schema(description = "业务编码")
    private String businessCode;

    @Schema(description = "标准单价", example = "100.00")
    private BigDecimal stdPrice;

    @Schema(description = "实际单价(结算前和实收价保持一致；结算时更新实际单价)", example = "100.00")
    private BigDecimal truePrice;

    @NotNull(message = "销售数量不能为空")
    @Schema(description = "销售数量")
    private Integer quantity;

    @Schema(description = "上钟类型（0 点钟，1 加钟，2 轮牌）")
    private Integer serverType;

    @Schema(description = "备注信息")
    private String remark;

    @Schema(description = "技师列表")
    private List<OrderDetailTechnicianDTO> technicians;
}
```

- [ ] **Step 3: 编译验证**

```bash
cd E:/Codes/pos/pos-java && mvn compile -DskipTests -q
```

预期：可能有编译错误，因为 `OrderDetailServiceImpl` 和 `KpiDetailServiceImpl` 引用了被移除的字段。这些将在后续 Task 中修复。

- [ ] **Step 4: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/domain/dto/order/OrderDetailCreateDTO.java pos-common/src/main/java/org/haut/common/domain/dto/order/OrderDetailSettleDTO.java
git commit -m "feat(order): DTO移除userId/userName，新增technicians技师列表"
```

---

### Task 5: 修改 VO — OrderDetailVO 和 ReceiptItemVO

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderDetailVO.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/ReceiptItemVO.java`

- [ ] **Step 1: 修改 OrderDetailVO**

在文件末尾 `orderStatus` 字段之后添加 `technicians` 字段：

```java
// 在 orderStatus 字段之后添加：

/**
 * 技师列表
 */
@Schema(description = "技师列表")
private List<OrderDetailTechnicianDTO> technicians;
```

同时添加 import：
```java
import java.util.List;
```

- [ ] **Step 2: 修改 ReceiptItemVO**

将 `technicianName` 单一字段改为 `technicians` 列表以支持多人展示：

```java
package org.haut.common.domain.vo.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

@Data
@Accessors(chain = true)
@Schema(description = "小票-订单明细项信息")
public class ReceiptItemVO {

    @Schema(description = "项目/商品名称")
    private String itemName;

    @Schema(description = "技师名称列表")
    private List<String> technicianNames;

    @Schema(description = "数量")
    private Integer quantity;

    @Schema(description = "标准价")
    private BigDecimal stdPrice;

    @Schema(description = "实际单价")
    private BigDecimal truePrice;

    @Schema(description = "行金额（实际单价 * 数量）")
    private BigDecimal amount;

    @Schema(description = "上钟类型名称（点钟/加钟/轮牌）")
    private String serverTypeName;
}
```

- [ ] **Step 3: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/domain/vo/order/OrderDetailVO.java pos-common/src/main/java/org/haut/common/domain/vo/order/ReceiptItemVO.java
git commit -m "feat(order): VO添加technicians技师列表字段"
```

---

### Task 6: 修改 KpiDetail Entity

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/kpi/entity/KpiDetail.java`

- [ ] **Step 1: 添加 detailId 和 detailCode 字段**

在 `orgId` 字段之前添加：

```java
/**
 * 订单明细ID
 */
@Schema(description = "订单明细ID")
private Long detailId;

/**
 * 订单明细编号
 */
@Schema(description = "订单明细编号")
private String detailCode;
```

- [ ] **Step 2: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/kpi/entity/KpiDetail.java
git commit -m "feat(kpi): KpiDetail添加detailId和detailCode关联字段"
```

---

### Task 7: 改造 KpiDetailService — 多人业绩计算

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/kpi/service/KpiDetailService.java`
- Modify: `pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java`

- [ ] **Step 1: KpiDetailService 接口无需改动**

`handelOrder(OrderInfoEntity order, List<OrderDetailSettleDTO> orderDetails)` 签名不变，因为 `OrderDetailSettleDTO` 已经包含 `technicians` 字段。

- [ ] **Step 2: 改造 KpiDetailServiceImpl.handelOrder 方法**

将原来的 1:1 映射改为 1:N 映射（一条明细对应多个技师的 KPI 记录）：

```java
@Override
@Transactional(rollbackFor = Exception.class)
public void handelOrder(OrderInfoEntity order, List<OrderDetailSettleDTO> orderDetails) {
    List<KpiDetail> kpis = orderDetails.stream()
            .flatMap(detail -> {
                List<OrderDetailTechnicianDTO> technicians = detail.getTechnicians();
                // 如果没有技师列表，跳过该明细
                if (technicians == null || technicians.isEmpty()) {
                    return java.util.stream.Stream.empty();
                }
                int count = technicians.size();
                // 计算总提成金额（按明细的 serverType 计算）
                BigDecimal totalCommission = handelCommission(detail);
                // 提成按人数平分
                BigDecimal perCommission = totalCommission.divide(
                        BigDecimal.valueOf(count), 2, java.math.RoundingMode.HALF_UP);
                // 业绩也平分：performance 字段原来存的是 truePrice（单价），这里改为按人数平分后的金额
                BigDecimal performance = detail.getTruePrice().divide(
                        BigDecimal.valueOf(count), 2, java.math.RoundingMode.HALF_UP);
                return technicians.stream()
                        .map(t -> new KpiDetail()
                                .setOrderCode(order.getOrderCode())
                                .setServiceCode(detail.getBusinessCode())
                                .setServiceName(detail.getBusinessName())
                                .setServiceType(detail.getDetailType())
                                .setItemType(detail.getServerType())
                                .setUserId(t.getUserId())
                                .setUserName(t.getUserName())
                                .setPerformance(performance)
                                .setCommission(perCommission)
                                .setDetailId(detail.getId())
                                .setDetailCode(detail.getDetailCode())
                                .setOrgId(order.getOrgId()));
            })
            .toList();
    saveBatch(kpis);
}
```

需要添加 import：
```java
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import java.util.stream.Stream;
```

- [ ] **Step 3: 编译验证**

```bash
cd E:/Codes/pos/pos-java && mvn compile -pl pos-server -am -DskipTests -q
```

预期：编译成功。

- [ ] **Step 4: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java
git commit -m "feat(kpi): 改造业绩计算支持多人平分模式"
```

---

### Task 8: 改造 OrderDetailService 接口

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/OrderDetailService.java`

- [ ] **Step 1: 修改 updateServerEmployee 方法签名**

将原来的单技师参数改为技师列表：

```java
/**
 * 更新订单明细的服务技师（多人模式）
 * @param detailId 订单明细ID
 * @param technicians 技师列表
 */
void updateServerEmployee(Long detailId, List<OrderDetailTechnicianDTO> technicians);
```

添加 import：
```java
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import java.util.List;  // 已有则不需添加
```

- [ ] **Step 2: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/OrderDetailService.java
git commit -m "feat(order): OrderDetailService接口updateServerEmployee支持多人模式"
```

---

### Task 9: 改造 OrderDetailServiceImpl — 核心业务逻辑

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailServiceImpl.java`

- [ ] **Step 1: 注入 OrderDetailTechnicianService**

在类成员变量区域添加：

```java
private final OrderDetailTechnicianService orderDetailTechnicianService;
```

由于使用 `@RequiredArgsConstructor`，构造器注入会自动包含此依赖。

添加 import：
```java
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import org.haut.server.order.service.OrderDetailTechnicianService;
```

- [ ] **Step 2: 改造 addDetails 方法**

在保存明细实体之后，保存技师关联：

```java
@Override
@Transactional(rollbackFor = Exception.class)
public String addDetails(OrderDetailCreateDTO dto, Long orderId) {
    log.info("添加订单明细，订单ID：{}，明细信息：{}", orderId, dto);

    if (orderId == null) {
        throw new BusinessException("订单ID不能为空");
    }
    if (dto == null) {
        throw new BusinessException("订单明细信息不能为空");
    }

    AuthInfoDTO auth = AuthContextHolder.getAuth();

    OrderInfoEntity orderInfo = orderInfoMapper.selectById(orderId);
    if (orderInfo == null) {
        throw new BusinessException("订单不存在");
    }

    if (!OrderStatusEnum.UNSETTLED.getCode().equals(orderInfo.getOrderStatus())) {
        throw new BusinessException("订单已结算，无法添加明细");
    }

    OrderDetailEntity detailEntity = handelDetail(dto)
            .setDetailCode(CodeUtils.generateByTime(PrefixConst.ORDER_DETAIL))
            .setOrderId(orderId)
            .setOrderCode(orderInfo.getOrderCode())
            .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode())
            .setOrgId(auth.getOrgId());

    detailEntity.setTruePrice(BigDecimal.ZERO);

    boolean saved = this.save(detailEntity);
    if (!saved) {
        throw new BusinessException("添加订单明细失败");
    }

    // 保存技师关联
    orderDetailTechnicianService.saveTechnicians(detailEntity.getId(), dto.getTechnicians());

    log.info("订单明细添加成功，明细编号：{}", detailEntity.getDetailCode());
    return "订单明细添加成功";
}
```

- [ ] **Step 3: 改造 createOrderDetails 方法**

在 `saveOrUpdateBatch` 之后保存技师关联：

```java
@Override
@Transactional
public List<OrderDetailVO> createOrderDetails(List<OrderDetailCreateDTO> orderDetails, Long orderId) {
    AuthInfoDTO auth = AuthContextHolder.getAuth();
    if (orderId == null)
        throw new BusinessException(ResultStatus.PARAMS_INVALID.getMessage());
    OrderInfoEntity orderInfo = orderInfoMapper.selectById(orderId);
    if (orderInfo == null)
        throw new BusinessException("订单不存在");

    List<OrderDetailEntity> list = orderDetails.stream()
            .map(e -> this.handelDetail(e)
                    .setDetailCode(CodeUtils.generateByTime(PrefixConst.ORDER_DETAIL))
                    .setOrderId(orderId)
                    .setOrderCode(orderInfo.getOrderCode())
                    .setOrderStatus(OrderStatusEnum.UNSETTLED.getCode())
                    .setOrgId(auth.getOrgId()))
            .toList();
    this.saveOrUpdateBatch(list);

    // 保存技师关联
    for (int i = 0; i < list.size(); i++) {
        OrderDetailEntity entity = list.get(i);
        List<OrderDetailTechnicianDTO> technicians = orderDetails.get(i).getTechnicians();
        orderDetailTechnicianService.saveTechnicians(entity.getId(), technicians);
    }

    return orderDetailConvert.toVo(list);
}
```

- [ ] **Step 4: 改造 settleOrderDetailAndReturn 方法**

保存明细后同步保存技师关联：

```java
@Override
@Transactional(rollbackFor = Exception.class)
public List<OrderDetailEntity> settleOrderDetailAndReturn(OrderInfoEntity order, List<OrderDetailSettleDTO> orderDetails) {
    log.info("orderCode:{} 开始结算订单明细", order.getOrderCode());
    stockOutOrderService.handelOrder(orderDetails);
    log.info("orderCode:{} 处理库存成功订单号", order.getOrderCode());
    serverCureTicketService.handelOrder(orderDetails, order);
    log.info("orderCode:{} 处理疗程券成功", order.getOrderCode());
    kpiDetailService.handelOrder(order, orderDetails);
    log.info("orderCode:{} 处理疗业绩提成成功", order.getOrderCode());

    List<OrderDetailEntity> details = orderDetails.stream()
            .map(e -> orderDetailConvert.toEntity(e)
                    .setOrderCode(order.getOrderCode())
                    .setDetailCode(StringUtils.isBlank(e.getDetailCode()) ?
                            CodeUtils.generateByTime(PrefixConst.ORDER_DETAIL) : e.getDetailCode())
                    .setOrderId(order.getId())
                    .setSettledTime(order.getSettleTime())
                    .setOrderStatus(order.getOrderStatus())
                    .setOrgId(order.getOrgId()))
            .toList();

    saveOrUpdateBatch(details);
    log.info("orderCode:{} 订单明细处理成功", order.getOrderCode());

    // 保存/更新技师关联
    for (int i = 0; i < details.size(); i++) {
        OrderDetailEntity entity = details.get(i);
        List<OrderDetailTechnicianDTO> technicians = orderDetails.get(i).getTechnicians();
        if (technicians != null && !technicians.isEmpty()) {
            orderDetailTechnicianService.updateTechnicians(entity.getId(), technicians);
        }
    }

    return details;
}
```

- [ ] **Step 5: 改造 updateServerEmployee 方法**

```java
@Override
@Transactional(rollbackFor = Exception.class)
public void updateServerEmployee(Long detailId, List<OrderDetailTechnicianDTO> technicians) {
    if (detailId == null || technicians == null || technicians.isEmpty()) {
        throw new BusinessException(ResultStatus.PARAMS_INVALID.getMessage());
    }

    OrderDetailEntity detail = this.getById(detailId);
    if (detail == null) {
        throw new BusinessException("订单明细不存在");
    }

    if (!OrderStatusEnum.UNSETTLED.getCode().equals(detail.getOrderStatus())) {
        throw new BusinessException("订单已结算，无法修改服务技师");
    }

    orderDetailTechnicianService.updateTechnicians(detailId, technicians);

    log.info("修改订单明细服务技师成功，明细ID：{}，技师数量：{}", detailId, technicians.size());
}
```

- [ ] **Step 6: 改造 queryByOrderId 方法**

查询时填充技师列表：

```java
@Override
public List<OrderDetailVO> queryByOrderId(Long orderId) {
    log.info("查询订单明细列表，订单ID：{}", orderId);

    if (orderId == null) {
        throw new BusinessException("订单ID不能为空");
    }

    List<OrderDetailEntity> detailEntities = this.lambdaQuery()
            .eq(OrderDetailEntity::getOrderId, orderId)
            .list();

    List<OrderDetailVO> detailVOs = orderDetailConvert.toVo(detailEntities);

    // 填充技师列表
    List<Long> detailIds = detailEntities.stream()
            .map(OrderDetailEntity::getId)
            .toList();
    if (!detailIds.isEmpty()) {
        List<OrderDetailTechnicianEntity> allTechnicians =
                orderDetailTechnicianService.listByDetailIds(detailIds);
        // 按 detailId 分组
        java.util.Map<Long, List<OrderDetailTechnicianDTO>> techMap = allTechnicians.stream()
                .collect(java.util.stream.Collectors.groupingBy(
                        OrderDetailTechnicianEntity::getDetailId,
                        java.util.stream.Collectors.mapping(
                                e -> new OrderDetailTechnicianDTO()
                                        .setUserId(e.getUserId())
                                        .setUserName(e.getUserName()),
                                java.util.stream.Collectors.toList()
                        )
                ));
        // 填充到 VO
        for (int i = 0; i < detailVOs.size(); i++) {
            Long detailId = detailEntities.get(i).getId();
            detailVOs.get(i).setTechnicians(techMap.getOrDefault(detailId, List.of()));
        }
    }

    log.info("查询到订单明细数量：{}", detailVOs.size());
    return detailVOs;
}
```

需要额外 import：
```java
import org.haut.server.order.entity.OrderDetailTechnicianEntity;
import java.util.Map;
```

- [ ] **Step 7: 编译验证**

```bash
cd E:/Codes/pos/pos-java && mvn compile -DskipTests -q
```

预期：编译成功（注意 Controller 层可能有参数不匹配的问题，将在 Task 10 修复）。

- [ ] **Step 8: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailServiceImpl.java pos-server/src/main/java/org/haut/server/order/service/OrderDetailService.java
git commit -m "feat(order): OrderDetailServiceImpl改造支持多人技师模式"
```

---

### Task 10: 改造 OrderController

**Files:**
- Modify: `pos-web/src/main/java/org/haut/controller/order/OrderController.java`

- [ ] **Step 1: 修改 update-server-employee 接口**

将 `@RequestParam` 单参数改为 `@RequestBody` 接收技师列表：

```java
@PutMapping("/update-server-employee/{detailId}")
@Operation(summary = "修改服务技师", description = "修改订单明细的服务技师（支持多人）")
public JsonVO<String> updateServerEmployee(
        @PathVariable Long detailId,
        @RequestBody List<OrderDetailTechnicianDTO> technicians) {
    log.info("修改订单明细服务技师请求：detailId={}, 技师数量={}", detailId,
            technicians != null ? technicians.size() : 0);
    orderDetailService.updateServerEmployee(detailId, technicians);
    return JsonVO.success("服务技师修改成功");
}
```

添加 import（如果不存在）：
```java
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import java.util.List;
```

- [ ] **Step 2: 编译验证**

```bash
cd E:/Codes/pos/pos-java && mvn compile -DskipTests -q
```

预期：编译成功。

- [ ] **Step 3: 提交**

```bash
git add pos-web/src/main/java/org/haut/controller/order/OrderController.java
git commit -m "feat(order): Controller接口支持多人技师模式"
```

---

### Task 11: 修复 OrderDetailConvert MapStruct 映射

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailServiceImpl.java`（Convert 接口定义在同一个文件中）

- [ ] **Step 1: 检查 Convert 映射**

`OrderDetailConvert` 位于 `OrderDetailServiceImpl.java` 第 48-53 行：

```java
@Mapper(componentModel = "spring")
interface OrderDetailConvert {
    OrderDetailEntity toEntity(OrderDetailCreateDTO dto);
    OrderDetailEntity toEntity(OrderDetailSettleDTO dto);
    List<OrderDetailVO> toVo(List<OrderDetailEntity> entityList);
}
```

由于 `OrderDetailCreateDTO` 和 `OrderDetailSettleDTO` 已移除 `userId/userName`，MapStruct 不会再自动映射这两个字段到 Entity 和 VO，这正是我们需要的行为。

`OrderDetailVO` 中新增的 `technicians` 字段不会被 MapStruct 自动填充（Entity 中无此字段），需要手动填充，已在 Task 9 的 `queryByOrderId` 中处理。

无需修改 Convert 接口。

- [ ] **Step 2: 提交**

此步骤无代码变更，跳过提交。

---

### Task 12: 全量编译和启动验证

- [ ] **Step 1: 全量编译**

```bash
cd E:/Codes/pos/pos-java && mvn clean compile -DskipTests
```

预期：BUILD SUCCESS。

- [ ] **Step 2: 启动应用验证**

```bash
cd E:/Codes/pos/pos-java && mvn install -DskipTests && mvn spring-boot:run -pl pos-web -Dspring-boot.run.profiles=dev
```

预期：应用成功启动，无 Bean 注入失败等错误。

- [ ] **Step 3: 验证 Swagger 文档可访问**

访问 `http://localhost:8080/api/swagger-ui.html`，确认订单相关接口文档正常加载，新增的 `technicians` 字段在 DTO 中可见。

- [ ] **Step 4: 最终提交（如有遗漏修复）**

如果编译或启动过程中有需要额外修复的问题，修复后提交。
