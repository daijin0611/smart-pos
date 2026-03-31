# 设定与门店多对多关联改造 实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将 5 个设定模块（服务项、服务产品、疗程券、优惠券、充值活动）与门店的关系从一对一改为多对多，通过通用关联表 `sys_org_relation` 管理。

**Architecture:** 新建一张通用关联表 `sys_org_relation`，用 `item_type`（TINYINT）区分设定类型，提供统一的 `OrgRelationService` 管理关联操作。各模块的查询接口增加可选 `orgId` 参数，新增/更新接口增加 `orgIds` 参数。现有 `org_id` 字段的数据迁移至关联表后移除。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus 3.5.11, MySQL 8.2.0

---

### Task 1: 创建 SQL 迁移脚本

**Files:**
- Create: `sql/V1.0.7__create_sys_org_relation.sql`

- [ ] **Step 1: 编写建表 + 数据迁移 + 移除 org_id 的 SQL 脚本**

```sql
-- 1. 创建设定与门店关联表
CREATE TABLE sys_org_relation (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    item_type   TINYINT      NOT NULL COMMENT '设定类型：1-服务项 2-服务产品 3-疗程券 4-优惠券 5-充值活动',
    item_id     BIGINT       NOT NULL COMMENT '设定项目ID',
    org_id      BIGINT       NOT NULL COMMENT '门店ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    UNIQUE KEY uk_type_item_org (item_type, item_id, org_id),
    KEY idx_item_type_org (item_type, org_id)
) COMMENT '设定与门店关联表';

-- 2. 迁移现有 org_id 数据到关联表
INSERT INTO sys_org_relation (item_type, item_id, org_id)
SELECT 1, id, org_id FROM server_item WHERE org_id IS NOT NULL AND is_delete = 0
UNION ALL
SELECT 2, id, org_id FROM server_product WHERE org_id IS NOT NULL AND is_delete = 0
UNION ALL
SELECT 3, id, org_id FROM server_cure_ticket WHERE org_id IS NOT NULL AND is_delete = 0
UNION ALL
SELECT 4, id, org_id FROM vip_ticket WHERE org_id IS NOT NULL AND is_delete = 0
UNION ALL
SELECT 5, id, org_id FROM vip_recharge_active WHERE org_id IS NOT NULL AND is_delete = 0;

-- 3. 移除各设定表的 org_id 字段
ALTER TABLE server_item DROP COLUMN org_id;
ALTER TABLE server_product DROP COLUMN org_id;
ALTER TABLE server_cure_ticket DROP COLUMN org_id;
ALTER TABLE vip_ticket DROP COLUMN org_id;
ALTER TABLE vip_recharge_active DROP COLUMN org_id;
```

- [ ] **Step 2: 提交**

```bash
git add sql/V1.0.7__create_sys_org_relation.sql
git commit -m "feat(relation): 添加设定与门店关联表及数据迁移SQL"
```

---

### Task 2: 创建 OrgRelationTypeEnum 枚举

**Files:**
- Create: `pos-common/src/main/java/org/haut/common/enums/OrgRelationTypeEnum.java`

- [ ] **Step 1: 创建枚举类**

```java
package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 设定与门店关联类型枚举
 */
@Getter
@AllArgsConstructor
public enum OrgRelationTypeEnum {
    SERVER_ITEM(1, "服务项"),
    SERVER_PRODUCT(2, "服务产品"),
    CURE_TICKET(3, "疗程券"),
    VIP_TICKET(4, "优惠券"),
    RECHARGE_ACTIVE(5, "充值活动");

    private final Integer value;
    private final String name;

    public static OrgRelationTypeEnum getByValue(Integer value) {
        for (OrgRelationTypeEnum typeEnum : values()) {
            if (typeEnum.value.equals(value)) {
                return typeEnum;
            }
        }
        return null;
    }
}
```

- [ ] **Step 2: 提交**

```bash
git add pos-common/src/main/java/org/haut/common/enums/OrgRelationTypeEnum.java
git commit -m "feat(relation): 添加关联类型枚举OrgRelationTypeEnum"
```

---

### Task 3: 创建 OrgRelationEntity

**Files:**
- Create: `pos-server/src/main/java/org/haut/server/system/entity/OrgRelationEntity.java`

- [ ] **Step 1: 创建关联表实体**

```java
package org.haut.server.system.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * 设定与门店关联表
 * @TableName sys_org_relation
 */
@TableName(value = "sys_org_relation")
@Data
@Accessors(chain = true)
public class OrgRelationEntity {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 设定类型：1-服务项 2-服务产品 3-疗程券 4-优惠券 5-充值活动
     */
    private Integer itemType;

    /**
     * 设定项目ID
     */
    private Long itemId;

    /**
     * 门店ID
     */
    private Long orgId;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
}
```

- [ ] **Step 2: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/system/entity/OrgRelationEntity.java
git commit -m "feat(relation): 添加关联表实体OrgRelationEntity"
```

---

### Task 4: 创建 OrgRelationMapper

**Files:**
- Create: `pos-server/src/main/java/org/haut/server/system/mapper/OrgRelationMapper.java`
- Create: `pos-server/src/main/resources/mapper/system/OrgRelationMapper.xml`

- [ ] **Step 1: 创建 Mapper 接口**

```java
package org.haut.server.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.haut.server.system.entity.OrgRelationEntity;

/**
 * 设定与门店关联 Mapper
 */
public interface OrgRelationMapper extends BaseMapper<OrgRelationEntity> {
}
```

- [ ] **Step 2: 创建 Mapper XML**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="org.haut.server.system.mapper.OrgRelationMapper">
    <resultMap id="BaseResultMap" type="org.haut.server.system.entity.OrgRelationEntity">
        <id property="id" column="id" jdbcType="BIGINT"/>
        <result property="itemType" column="item_type" jdbcType="TINYINT"/>
        <result property="itemId" column="item_id" jdbcType="BIGINT"/>
        <result property="orgId" column="org_id" jdbcType="BIGINT"/>
        <result property="createTime" column="create_time" jdbcType="TIMESTAMP"/>
    </resultMap>
</mapper>
```

- [ ] **Step 3: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/system/mapper/OrgRelationMapper.java pos-server/src/main/resources/mapper/system/OrgRelationMapper.xml
git commit -m "feat(relation): 添加关联表Mapper接口及XML"
```

---

### Task 5: 创建 OrgRelationService 及 ServiceImpl

**Files:**
- Create: `pos-server/src/main/java/org/haut/server/system/service/OrgRelationService.java`
- Create: `pos-server/src/main/java/org/haut/server/system/service/impl/OrgRelationServiceImpl.java`

- [ ] **Step 1: 创建 Service 接口**

```java
package org.haut.server.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.server.system.entity.OrgRelationEntity;

import java.util.List;

/**
 * 设定与门店关联 Service
 */
public interface OrgRelationService extends IService<OrgRelationEntity> {

    /**
     * 批量绑定门店关联
     * @param itemType 设定类型
     * @param itemId 设定项目ID
     * @param orgIds 门店ID列表
     */
    void bindOrgs(Integer itemType, Long itemId, List<Long> orgIds);

    /**
     * 解除某设定项目的全部门店关联
     * @param itemType 设定类型
     * @param itemId 设定项目ID
     */
    void unbindOrgs(Integer itemType, Long itemId);

    /**
     * 查询某门店关联的设定项目ID列表
     * @param itemType 设定类型
     * @param orgId 门店ID
     * @return 设定项目ID列表
     */
    List<Long> getItemIdsByOrg(Integer itemType, Long orgId);

    /**
     * 查询某设定项目关联的门店ID列表
     * @param itemType 设定类型
     * @param itemId 设定项目ID
     * @return 门店ID列表
     */
    List<Long> getOrgIdsByItem(Integer itemType, Long itemId);
}
```

- [ ] **Step 2: 创建 ServiceImpl**

```java
package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.system.entity.OrgRelationEntity;
import org.haut.server.system.mapper.OrgRelationMapper;
import org.haut.server.system.service.OrgRelationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 设定与门店关联 ServiceImpl
 */
@Service
public class OrgRelationServiceImpl extends ServiceImpl<OrgRelationMapper, OrgRelationEntity>
        implements OrgRelationService {

    @Override
    @Transactional
    public void bindOrgs(Integer itemType, Long itemId, List<Long> orgIds) {
        if (orgIds == null || orgIds.isEmpty()) {
            return;
        }
        List<OrgRelationEntity> entities = orgIds.stream().map(orgId -> {
            OrgRelationEntity entity = new OrgRelationEntity();
            entity.setItemType(itemType);
            entity.setItemId(itemId);
            entity.setOrgId(orgId);
            return entity;
        }).collect(Collectors.toList());
        this.saveBatch(entities);
    }

    @Override
    @Transactional
    public void unbindOrgs(Integer itemType, Long itemId) {
        LambdaQueryWrapper<OrgRelationEntity> wrapper = new LambdaQueryWrapper<OrgRelationEntity>()
                .eq(OrgRelationEntity::getItemType, itemType)
                .eq(OrgRelationEntity::getItemId, itemId);
        this.remove(wrapper);
    }

    @Override
    public List<Long> getItemIdsByOrg(Integer itemType, Long orgId) {
        LambdaQueryWrapper<OrgRelationEntity> wrapper = new LambdaQueryWrapper<OrgRelationEntity>()
                .eq(OrgRelationEntity::getItemType, itemType)
                .eq(OrgRelationEntity::getOrgId, orgId);
        List<OrgRelationEntity> list = this.list(wrapper);
        return list.stream().map(OrgRelationEntity::getItemId).collect(Collectors.toList());
    }

    @Override
    public List<Long> getOrgIdsByItem(Integer itemType, Long itemId) {
        LambdaQueryWrapper<OrgRelationEntity> wrapper = new LambdaQueryWrapper<OrgRelationEntity>()
                .eq(OrgRelationEntity::getItemType, itemType)
                .eq(OrgRelationEntity::getItemId, itemId);
        List<OrgRelationEntity> list = this.list(wrapper);
        return list.stream().map(OrgRelationEntity::getOrgId).collect(Collectors.toList());
    }
}
```

- [ ] **Step 3: 提交**

```bash
git add pos-server/src/main/java/org/haut/server/system/service/OrgRelationService.java pos-server/src/main/java/org/haut/server/system/service/impl/OrgRelationServiceImpl.java
git commit -m "feat(relation): 添加关联管理OrgRelationService及实现"
```

---

### Task 6: 改造服务项 (ServerItem) 模块

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/server/entity/ServerItem.java` — 移除 orgId 字段
- Modify: 查询参数 DTO — 增加 orgId
- Modify: 新增/更新 DTO — 增加 orgIds
- Modify: VO — 增加关联门店信息
- Modify: ServiceImpl — 改用关联表
- Modify: Mapper XML — 改为联表查询

- [ ] **Step 1: 移除 ServerItem Entity 的 orgId 字段**

在 `ServerItem.java` 中删除：
```java
    /**
     * 机构id
     */
    private Long orgId;
```

- [ ] **Step 2: 修改查询参数 DTO，增加 orgId 可选参数**

在 ServerItem 的查询 DTO（如 `ServerItemQuery`）中增加：
```java
    /**
     * 门店ID（可选，不传则查全部）
     */
    private Long orgId;
```

- [ ] **Step 3: 修改新增/更新 DTO，增加 orgIds**

在 ServerItem 的创建/更新 DTO 中增加：
```java
    /**
     * 关联门店ID列表
     */
    private List<Long> orgIds;
```

- [ ] **Step 4: 修改 ServiceImpl 查询方法**

查询方法改为：当 `orgId != null` 时，先从关联表获取该门店关联的 itemId 列表，再过滤查询；当 `orgId == null` 时查全部。

```java
@Override
public List<ServerItemVO> getList(ServerItemQuery query) {
    LambdaQueryWrapper<ServerItem> queryWrapper = Wrappers.lambdaQuery(ServerItem.class)
            .and(StringUtils.isNotBlank(query.getKeyWord()),
                    w -> w.like(ServerItem::getItemName, query.getKeyWord())
                            .or()
                            .like(ServerItem::getItemEncode, query.getKeyWord()))
            .eq(query.getItemStatus() != null, ServerItem::getItemStatus, query.getItemStatus());
    if (query.getOrgId() != null) {
        List<Long> itemIds = orgRelationService.getItemIdsByOrg(
                OrgRelationTypeEnum.SERVER_ITEM.getValue(), query.getOrgId());
        if (itemIds.isEmpty()) {
            return Collections.emptyList();
        }
        queryWrapper.in(ServerItem::getId, itemIds);
    }
    return serverItemConvert.toVOList(this.list(queryWrapper));
}
```

- [ ] **Step 5: 修改 ServiceImpl 新增方法**

新增时不再设置 orgId，改为调用关联服务绑定门店：

```java
// 替换 entity.setOrgId(auth.getOrgId()) 为：
// 保存后绑定门店
this.save(entity);
if (dto.getOrgIds() != null && !dto.getOrgIds().isEmpty()) {
    orgRelationService.bindOrgs(OrgRelationTypeEnum.SERVER_ITEM.getValue(), entity.getId(), dto.getOrgIds());
}
```

- [ ] **Step 6: 修改 ServiceImpl 更新方法**

更新时先解除旧关联，再绑定新关联：

```java
// 先更新基本信息
this.updateById(entity);
// 更新门店关联
if (dto.getOrgIds() != null) {
    orgRelationService.unbindOrgs(OrgRelationTypeEnum.SERVER_ITEM.getValue(), dto.getId());
    orgRelationService.bindOrgs(OrgRelationTypeEnum.SERVER_ITEM.getValue(), dto.getId(), dto.getOrgIds());
}
```

- [ ] **Step 7: 提交**

```bash
git add -u
git commit -m "feat(server-item): 改造服务项模块使用关联表管理门店"
```

---

### Task 7: 改造服务产品 (ServerProduct) 模块

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/server/entity/ServerProduct.java` — 移除 orgId
- Modify: 查询/新增/更新 DTO
- Modify: ServiceImpl
- Modify: Mapper XML（如有）

- [ ] **Step 1: 移除 ServerProduct Entity 的 orgId 字段**

删除 `ServerProduct.java` 第116行附近的 `private Long orgId;`

- [ ] **Step 2: 修改 DTO — 查询增加 orgId，新增/更新增加 orgIds**

同 Task 6 的模式。

- [ ] **Step 3: 修改 ServiceImpl 查询方法**

查询逻辑同 Task 6 Step 4，使用 `OrgRelationTypeEnum.SERVER_PRODUCT`。

- [ ] **Step 4: 修改 ServiceImpl 新增/更新方法**

新增/更新逻辑同 Task 6 Step 5/6。

- [ ] **Step 5: 提交**

```bash
git add -u
git commit -m "feat(server-product): 改造服务产品模块使用关联表管理门店"
```

---

### Task 8: 改造疗程券 (ServerCureTicket) 模块

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/server/entity/ServerCureTicket.java` — 移除 orgId
- Modify: 查询/新增/更新 DTO
- Modify: ServiceImpl
- Modify: `pos-server/src/main/resources/mapper/server/ServerCureTicketMapper.xml` — 移除 orgId 过滤，改用关联表

- [ ] **Step 1: 移除 ServerCureTicket Entity 的 orgId 字段**

删除 `ServerCureTicket.java` 第82行附近的 `private Long orgId;`

- [ ] **Step 2: 修改 DTO — 查询增加 orgId，新增/更新增加 orgIds**

同 Task 6 的模式。

- [ ] **Step 3: 修改 ServiceImpl 查询方法**

查询逻辑同 Task 6 Step 4，使用 `OrgRelationTypeEnum.CURE_TICKET`。

注意：疗程券的查询使用了自定义 Mapper XML（`getList` 方法），需要在 ServiceImpl 中改为先用关联表过滤 itemIds，再传入 XML 查询，或修改 XML 中的 orgId 条件为 itemIds IN 条件。

- [ ] **Step 4: 修改 Mapper XML**

在 `ServerCureTicketMapper.xml` 中，将 `orgId` 条件替换为 `itemIds` 的 IN 查询。Mapper 方法签名需同步修改。

- [ ] **Step 5: 修改 ServiceImpl 新增/更新方法**

同 Task 6 Step 5/6。

- [ ] **Step 6: 提交**

```bash
git add -u
git commit -m "feat(cure-ticket): 改造疗程券模块使用关联表管理门店"
```

---

### Task 9: 改造优惠券 (VipTicket) 模块

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/vip/entity/VipTicket.java` — 移除 orgId
- Modify: 查询/新增/更新 DTO
- Modify: ServiceImpl
- Modify: `pos-server/src/main/resources/mapper/vip/VipTicketMapper.xml` — 移除 orgId 过滤

- [ ] **Step 1: 移除 VipTicket Entity 的 orgId 字段**

删除 `VipTicket.java` 第79行附近的 `private Long orgId;`

- [ ] **Step 2: 修改 DTO — 查询增加 orgId，新增/更新增加 orgIds**

同 Task 6 的模式。

- [ ] **Step 3: 修改 ServiceImpl 查询方法**

查询逻辑同 Task 6 Step 4，使用 `OrgRelationTypeEnum.VIP_TICKET`。

注意：优惠券查询也使用了自定义 Mapper XML（`getList` 方法），需同步修改 XML 和 Mapper 接口。

- [ ] **Step 4: 修改 Mapper XML**

在 `VipTicketMapper.xml` 中，将 `orgId` 条件替换为 `itemIds` 的 IN 查询。

- [ ] **Step 5: 修改 ServiceImpl 新增/更新方法**

同 Task 6 Step 5/6。

- [ ] **Step 6: 提交**

```bash
git add -u
git commit -m "feat(vip-ticket): 改造优惠券模块使用关联表管理门店"
```

---

### Task 10: 改造充值活动 (VipRechargeActive) 模块

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/vip/entity/VipRechargeActive.java` — 移除 orgId
- Modify: 查询/新增/更新 DTO
- Modify: ServiceImpl
- Modify: `pos-server/src/main/resources/mapper/vip/VipRechargeActiveMapper.xml` — 移除 orgId 过滤

- [ ] **Step 1: 移除 VipRechargeActive Entity 的 orgId 字段**

删除 `VipRechargeActive.java` 第158行附近的 `private Long orgId;`

- [ ] **Step 2: 修改 DTO — 查询增加 orgId，新增/更新增加 orgIds**

同 Task 6 的模式。

- [ ] **Step 3: 修改 ServiceImpl 查询方法**

查询逻辑同 Task 6 Step 4，使用 `OrgRelationTypeEnum.RECHARGE_ACTIVE`。

注意：充值活动查询使用了自定义 Mapper XML（`queryList` 方法），需同步修改。

- [ ] **Step 4: 修改 Mapper XML**

在 `VipRechargeActiveMapper.xml` 中，将 `orgId` 条件替换为 `itemIds` 的 IN 查询。

- [ ] **Step 5: 修改 ServiceImpl 新增/更新方法**

同 Task 6 Step 5/6。

- [ ] **Step 6: 提交**

```bash
git add -u
git commit -m "feat(recharge-active): 改造充值活动模块使用关联表管理门店"
```

---

### Task 11: 编译验证

- [ ] **Step 1: 编译项目**

```bash
mvn clean compile -DskipTests
```

Expected: BUILD SUCCESS

- [ ] **Step 2: 检查是否有遗漏的 orgId 引用**

搜索整个项目中是否还有引用已移除的 orgId 字段的地方（排除未改造模块）：

```bash
grep -rn "ServerItem::getOrgId\|ServerProduct::getOrgId\|ServerCureTicket::getOrgId\|VipTicket::getOrgId\|VipRechargeActive::getOrgId" pos-server/ pos-web/
```

Expected: 无匹配结果

- [ ] **Step 3: 修复编译错误（如有）**

根据编译输出修复所有引用已移除 orgId 字段的代码。

- [ ] **Step 4: 最终提交**

```bash
git add -u
git commit -m "fix(relation): 修复编译错误及遗漏引用"
```
