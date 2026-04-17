# 产品和服务项分类功能 实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 ServerProduct 和 ServerItem 添加基于字典表的分类字段，支持分类筛选。

**Architecture:** 复用现有 sys_dict_type / sys_dict_item 字典表，通过 dict_code 区分产品分类(product_category)和服务分类(item_category)。产品和服务项实体各新增 category varchar(100) 字段存储字典项 item_value。

**Tech Stack:** MySQL 8.2、MyBatis-Plus 3.5.11、MapStruct 1.6.3、Spring Boot 3.5.0

---

### Task 1: 数据库迁移脚本

**Files:**
- Create: `sql/V1.0.10__add_category_to_product_item.sql`

- [ ] **Step 1: 创建迁移脚本**

```sql
-- 为服务产品表添加分类字段
ALTER TABLE server_product ADD COLUMN category varchar(100) DEFAULT NULL COMMENT '分类(字典项item_value, dict_code=product_category)';

-- 为服务项目表添加分类字段
ALTER TABLE server_item ADD COLUMN category varchar(100) DEFAULT NULL COMMENT '分类(字典项item_value, dict_code=item_category)';

-- 新增字典类型：产品分类
INSERT INTO sys_dict_type (create_time, is_delete, dict_name, dict_code, sort)
VALUES (NOW(), 0, '产品分类', 'product_category', 0);

-- 新增字典类型：服务分类
INSERT INTO sys_dict_type (create_time, is_delete, dict_name, dict_code, sort)
VALUES (NOW(), 0, '服务分类', 'item_category', 0);
```

- [ ] **Step 2: 提交**

```bash
git add sql/V1.0.10__add_category_to_product_item.sql
git commit -m "feat(server): 添加产品和服务项分类字段及字典数据"
```

---

### Task 2: Entity 层添加 category 字段

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/server/entity/ServerProduct.java`
- Modify: `pos-server/src/main/java/org/haut/server/server/entity/ServerItem.java`

- [ ] **Step 1: 在 ServerProduct 实体中添加 category 字段**

在 `ServerProduct.java` 的 `quantity` 字段之后、`version` 字段之前添加：

```java
    /**
     * 分类
     */
    @Schema(description = "分类")
    private String category;
```

- [ ] **Step 2: 在 ServerItem 实体中添加 category 字段**

在 `ServerItem.java` 的 `itemStatus` 字段之后添加：

```java
    /**
     * 分类
     */
    private String category;
```

- [ ] **Step 3: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/server/entity/ServerProduct.java pos-server/src/main/java/org/haut/server/server/entity/ServerItem.java
git commit -m "feat(server): 实体层添加category字段"
```

---

### Task 3: DTO 层添加 category 字段

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/server/ServerProductCreateDTO.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/server/ServerProductUpdateDTO.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/server/ServerItemCreateDTO.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/dto/server/ServerItemUpdateDTO.java`

- [ ] **Step 1: ServerProductCreateDTO 添加 category 字段**

在 `orgIds` 字段之前添加：

```java
    @Schema(description = "分类")
    private String category;
```

- [ ] **Step 2: ServerProductUpdateDTO 添加 category 字段**

在 `orgIds` 字段之前添加：

```java
    @Schema(description = "分类")
    private String category;
```

- [ ] **Step 3: ServerItemCreateDTO 添加 category 字段**

在 `orgIds` 字段之前添加：

```java
    private String category;
```

- [ ] **Step 4: ServerItemUpdateDTO 添加 category 字段**

注意：ServerItemUpdateDTO extends ServerItemCreateDTO，所以 category 字段会自动继承，无需额外添加。确认该类确实继承自 ServerItemCreateDTO 后跳过此步骤。

- [ ] **Step 5: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/domain/dto/server/ServerProductCreateDTO.java pos-common/src/main/java/org/haut/common/domain/dto/server/ServerProductUpdateDTO.java pos-common/src/main/java/org/haut/common/domain/dto/server/ServerItemCreateDTO.java
git commit -m "feat(server): DTO层添加category字段"
```

---

### Task 4: VO 和 Query 层添加 category 字段

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/server/ServerProductInfoVO.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/server/ServerItemVO.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/query/server/ServerProductListQuery.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/query/server/ServerItemQuery.java`

- [ ] **Step 1: ServerProductInfoVO 添加 category 字段**

在 `unit` 字段之后添加：

```java
    @Schema(description = "分类")
    private String category;
```

- [ ] **Step 2: ServerItemVO 添加 category 字段**

在 `itemStatus` 字段之后、`orgs` 字段之前添加：

```java
    private String category;
```

- [ ] **Step 3: ServerProductListQuery 添加 category 查询条件**

在 `orgId` 字段之后添加：

```java
    @Schema(description = "分类(筛选条件)")
    private String category;
```

- [ ] **Step 4: ServerItemQuery 添加 category 查询条件**

在 `orgId` 字段之后添加：

```java
    @Schema(description = "分类(筛选条件)")
    private String category;
```

- [ ] **Step 5: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/domain/vo/server/ServerProductInfoVO.java pos-common/src/main/java/org/haut/common/domain/vo/server/ServerItemVO.java pos-common/src/main/java/org/haut/common/domain/query/server/ServerProductListQuery.java pos-common/src/main/java/org/haut/common/domain/query/server/ServerItemQuery.java
git commit -m "feat(server): VO和Query层添加category字段"
```

---

### Task 5: Service 层支持 category 查询和更新

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/server/service/impl/ServerProductServiceImpl.java`
- Modify: `pos-server/src/main/java/org/haut/server/server/service/impl/ServerItemServiceImpl.java`

- [ ] **Step 1: ServerProductServiceImpl.getList 添加分类过滤条件**

在 `getList` 方法的 `wrapper` 构建中，`.eq(query.getProductStatus() != null, ...)` 之后添加：

```java
                .eq(StringUtils.isNotBlank(query.getCategory()), ServerProduct::getCategory, query.getCategory())
```

注意：该文件使用 `org.apache.commons.lang3.StringUtils`。

- [ ] **Step 2: ServerProductServiceImpl.updateProduct 添加 category 更新**

在 `updateProduct` 方法的 `lambdaUpdate()` 链中，`.set(ServerProduct::getRemark, product.getRemark())` 之后、`.eq(ServerProduct::getId, product.getId())` 之前添加：

```java
                .set(ServerProduct::getCategory, product.getCategory())
```

- [ ] **Step 3: ServerItemServiceImpl.getList 添加分类过滤条件**

在 `getList` 方法的 `queryWrapper` 构建中，`.eq(query.getItemStatus() != null, ...)` 之后添加：

```java
                .eq(StringUtils.isNotBlank(query.getCategory()), ServerItem::getCategory, query.getCategory())
```

注意：该文件使用 `com.baomidou.mybatisplus.core.toolkit.StringUtils`，调用方式为 `StringUtils.isNotBlank`。

- [ ] **Step 4: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/server/service/impl/ServerProductServiceImpl.java pos-server/src/main/java/org/haut/server/server/service/impl/ServerItemServiceImpl.java
git commit -m "feat(server): 列表查询支持分类过滤，更新支持分类字段"
```

---

### Task 6: 构建验证

**Files:** 无新增/修改

- [ ] **Step 1: 编译项目确认无错误**

Run: `mvn clean compile -DskipTests -pl pos-common,pos-server,pos-web -am`
Expected: BUILD SUCCESS

- [ ] **Step 2: 修复编译错误（如有）**

根据编译输出修复问题，常见问题：
- MapStruct 映射不匹配（确认 Convert 接口中 category 字段名一致，同名字段会自动映射）
- import 缺失
