# 手写单号功能实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在订单结算时增加手写单号字段，支持结算时必填输入、结算后可修改、订单列表和详情中展示。

**Architecture:** 在 order_info 表新增 manual_order_no 列，Entity/DTO/VO 层对应新增字段，结算逻辑写入，新增独立接口支持修改。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus 3.5.11, MapStruct 1.6.3

---

## 文件结构

| 操作 | 文件路径 | 职责 |
|------|---------|------|
| 新增 | `sql/V1.0.16__add_manual_order_no.sql` | 数据库迁移脚本 |
| 修改 | `pos-server/.../order/entity/OrderInfoEntity.java` | Entity 新增 manualOrderNo 字段 |
| 修改 | `pos-common/.../dto/order/OrderSettleDTO.java` | 结算 DTO 新增 manualOrderNo 字段 |
| 修改 | `pos-common/.../vo/order/OrderInfoVO.java` | 列表/详情 VO 新增 manualOrderNo 字段 |
| 修改 | `pos-server/.../service/OrderInfoService.java` | Service 接口新增 updateManualOrderNo 方法 |
| 修改 | `pos-server/.../service/impl/OrderInfoServiceImpl.java` | 结算逻辑写入 + 新增修改方法 |
| 修改 | `pos-web/.../controller/order/OrderController.java` | 新增修改手写单号接口 |
| 修改 | `pos-server/.../resources/mapper/order/OrderInfoMapper.xml` | 分页查询 SELECT 增加 manual_order_no |

---

### Task 1: 数据库迁移脚本

**Files:**
- Create: `sql/V1.0.16__add_manual_order_no.sql`

- [ ] **Step 1: 创建迁移脚本**

```sql
ALTER TABLE order_info ADD COLUMN manual_order_no VARCHAR(100) DEFAULT NULL COMMENT '手写单号';
```

- [ ] **Step 2: Commit**

```bash
git add sql/V1.0.16__add_manual_order_no.sql
git commit -m "feat: 添加手写单号字段迁移脚本"
```

---

### Task 2: Entity 层新增字段

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/entity/OrderInfoEntity.java:174`

- [ ] **Step 1: 在 OrderInfoEntity 末尾字段 `orgId` 之后新增 manualOrderNo**

在 `private Long orgId;` 的 `@Schema` 注解和字段声明之后，类的 `}` 之前，添加：

```java

    /**
     * 手写单号
     */
    @Schema(description = "手写单号")
    private String manualOrderNo;
```

- [ ] **Step 2: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/entity/OrderInfoEntity.java
git commit -m "feat: OrderInfoEntity 新增 manualOrderNo 字段"
```

---

### Task 3: DTO 层新增字段

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/order/OrderSettleDTO.java:116`

- [ ] **Step 1: 在 OrderSettleDTO 末尾字段 `paymentInfoList` 之后新增 manualOrderNo**

在 `private List<PaymentInfoDTO> paymentInfoList;` 之后，类的 `}` 之前，添加：

```java

    /**
     * 手写单号
     */
    @NotBlank(message = "手写单号不能为空")
    @Schema(description = "手写单号")
    private String manualOrderNo;
```

注意：文件已有 `import jakarta.validation.constraints.NotEmpty;`，需额外添加 `import jakarta.validation.constraints.NotBlank;`（如果尚未导入）。

- [ ] **Step 2: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/dto/order/OrderSettleDTO.java
git commit -m "feat: OrderSettleDTO 新增 manualOrderNo 必填字段"
```

---

### Task 4: VO 层新增字段

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderInfoVO.java:189`

- [ ] **Step 1: 在 OrderInfoVO 末尾字段 `payments` 之后新增 manualOrderNo**

在 `private List<PaymentVO> payments;` 之后，类的 `}` 之前，添加：

```java

    /**
     * 手写单号
     */
    @Schema(description = "手写单号")
    private String manualOrderNo;
```

- [ ] **Step 2: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/vo/order/OrderInfoVO.java
git commit -m "feat: OrderInfoVO 新增 manualOrderNo 字段"
```

---

### Task 5: Service 接口新增方法

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/OrderInfoService.java:106`

- [ ] **Step 1: 在 OrderInfoService 接口末尾方法 `rollBackOrder` 之后新增 updateManualOrderNo**

在 `void rollBackOrder(OrderRollBackDTO dto);` 之后，接口的 `}` 之前，添加：

```java

    /**
     * 修改手写单号
     * @param orderId 订单ID
     * @param manualOrderNo 新的手写单号
     */
    void updateManualOrderNo(Long orderId, String manualOrderNo);
```

- [ ] **Step 2: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/OrderInfoService.java
git commit -m "feat: OrderInfoService 新增 updateManualOrderNo 方法"
```

---

### Task 6: Service 实现 — 结算逻辑 + 修改方法

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java`

- [ ] **Step 1: 在 initOrderInfo 方法中写入 manualOrderNo**

在 `initOrderInfo()` 方法（第 727 行）的 return 链式调用末尾 `.setOrgId(auth.getOrgId())` 之后，追加：

```java
                .setManualOrderNo(dto.getManualOrderNo())
```

- [ ] **Step 2: 在 OrderInfoServiceImpl 类末尾新增 updateManualOrderNo 实现**

在 `buildReconciledRemark` 方法之后，类的 `}` 之前，添加：

```java

    /**
     * 修改手写单号
     * @param orderId 订单ID
     * @param manualOrderNo 新的手写单号
     */
    @Override
    public void updateManualOrderNo(Long orderId, String manualOrderNo) {
        OrderInfoEntity order = this.getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        // 仅允许已结算(2)和已对单(5)状态修改
        if (!OrderStatusEnum.SETTLED.getCode().equals(order.getOrderStatus())
                && !OrderStatusEnum.RECONCILED.getCode().equals(order.getOrderStatus())) {
            throw new BusinessException("仅已结算或已对单的订单可修改手写单号");
        }
        lambdaUpdate()
                .eq(OrderInfoEntity::getId, orderId)
                .set(OrderInfoEntity::getManualOrderNo, manualOrderNo)
                .update();
        log.info("订单手写单号修改成功，订单ID：{}，新手写单号：{}", orderId, manualOrderNo);
    }
```

- [ ] **Step 3: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java
git commit -m "feat: 结算写入 manualOrderNo，新增修改手写单号方法"
```

---

### Task 7: Controller 新增修改接口

**Files:**
- Modify: `pos-web/src/main/java/org/haut/controller/order/OrderController.java:168`

- [ ] **Step 1: 在 OrderController 末尾方法 `reconcileOrder` 之后新增 updateManualOrderNo 接口**

在 `reconcileOrder` 方法之后，类的 `}` 之前，添加：

```java

    /**
     * 修改手写单号
     * @param orderId 订单ID
     * @param manualOrderNo 新的手写单号
     * @return 处理结果
     */
    @PutMapping("/update-manual-order-no")
    @Operation(summary = "修改手写单号", description = "修改已结算或已对单订单的手写单号")
    @OperLog(module = OperLogModule.ORDER, description = "修改手写单号")
    public JsonVO<String> updateManualOrderNo(
            @RequestParam @NotNull Long orderId,
            @RequestParam @NotBlank String manualOrderNo) {
        log.info("修改手写单号请求：orderId={}, manualOrderNo={}", orderId, manualOrderNo);
        orderInfoService.updateManualOrderNo(orderId, manualOrderNo);
        return JsonVO.success("手写单号修改成功");
    }
```

注意：需确保导入 `import jakarta.validation.constraints.NotBlank;` 和 `import jakarta.validation.constraints.NotNull;`（`NotNull` 已在 DTO 中使用但 Controller 层可能未导入）。

- [ ] **Step 2: Commit**

```bash
git add pos-web/src/main/java/org/haut/controller/order/OrderController.java
git commit -m "feat: 新增修改手写单号接口 PUT /order/update-manual-order-no"
```

---

### Task 8: Mapper XML 更新分页查询

**Files:**
- Modify: `pos-server/src/main/resources/mapper/order/OrderInfoMapper.xml`

- [ ] **Step 1: 在 BaseResultMap 中增加 manual_order_no 映射**

在 `BaseResultMap`（第 6 行）的 `<result column="org_id" property="orgId" />` 之后，`</resultMap>` 之前，添加：

```xml
        <result column="manual_order_no" property="manualOrderNo" />
```

- [ ] **Step 2: 在 Base_Column_List 中增加 manual_order_no 列**

在 `Base_Column_List`（第 35 行）的 `bed_id, bed_name, user_id, user_name, org_id` 之后，添加：

```sql
, manual_order_no
```

- [ ] **Step 3: 在 orderInfoVO resultMap 中增加 manual_order_no 映射**

在 `orderInfoVO` resultMap（第 155 行）的 `<result column="org_id" property="orgId" />` 之后，`<collection` 标签之前，添加：

```xml
        
        <!-- 手写单号 -->
        <result column="manual_order_no" property="manualOrderNo" />
```

- [ ] **Step 4: 在 pageQuery 的 SELECT 中增加 manual_order_no**

在 `pageQuery` 查询（第 348 行）的 `oi.org_id` 之后，添加：

```sql
,
            oi.manual_order_no
```

- [ ] **Step 5: Commit**

```bash
git add pos-server/src/main/resources/mapper/order/OrderInfoMapper.xml
git commit -m "feat: Mapper XML 增加 manual_order_no 映射和查询"
```

---

### Task 9: 编译验证

- [ ] **Step 1: 执行编译**

```bash
cd /e/Codes/pos/pos-java && mvn clean compile -DskipTests
```

Expected: BUILD SUCCESS

- [ ] **Step 2: 修复编译错误（如有）**

如果出现 MapStruct 转换错误或其他问题，根据错误信息修复。MapStruct 的 `OrderConvert.toInfoVO()` 会自动映射同名字段 `manualOrderNo`，无需额外配置。

- [ ] **Step 3: 最终 Commit（如有修复）**

```bash
git add -A
git commit -m "fix: 修复手写单号功能编译问题"
```
