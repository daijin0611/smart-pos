# 设定与门店多对多关联改造设计

## 背景

当前项目中各设定（服务项、服务产品、疗程券、优惠券、充值活动）通过 `org_id` 字段与门店做一对一绑定，查询时自动从 `AuthInfoDTO.orgId` 获取当前用户所属门店来过滤。需要改造为多对多关系，支持管理员批量统一设置各个门店的设定。

## 改造范围

仅以下 5 个设定模块：

| 模块 | Entity | 现有 orgId 行号 |
|------|--------|----------------|
| 服务项 | `ServerItem` | 第109行 |
| 服务产品 | `ServerProduct` | 第116行 |
| 疗程券 | `ServerCureTicket` | 第82行 |
| 优惠券 | `VipTicket` | 第79行 |
| 充值活动 | `VipRechargeActive` | 第158行 |

其余模块（订单、库存、房间等）不做改造。

## 方案：通用关联表 + 各模块 Service 层统一改造

### 关联表结构

```sql
CREATE TABLE sys_org_relation (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    item_type   TINYINT      NOT NULL COMMENT '设定类型：1-服务项 2-服务产品 3-疗程券 4-优惠券 5-充值活动',
    item_id     BIGINT       NOT NULL COMMENT '设定项目ID',
    org_id      BIGINT       NOT NULL COMMENT '门店ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_type_item_org (item_type, item_id, org_id),
    KEY idx_item_type_org (item_type, org_id)
);
```

### 枚举定义

`OrgRelationTypeEnum`（TINYINT）：

| 值 | 枚举名 | 说明 |
|----|--------|------|
| 1 | SERVER_ITEM | 服务项 |
| 2 | SERVER_PRODUCT | 服务产品 |
| 3 | CURE_TICKET | 疗程券 |
| 4 | VIP_TICKET | 优惠券 |
| 5 | RECHARGE_ACTIVE | 充值活动 |

### 查询逻辑

- 各模块列表查询接口增加可选参数 `Long orgId`
- `orgId != null` → 通过关联表联查，只返回该门店关联的设定
- `orgId == null` → 查全部设定

### 新增/更新逻辑

- 新增设定时，前端传 `List<Long> orgIds`
- 设定保存后，批量写入 `sys_org_relation` 关联记录
- 更新设定时：先删除旧关联，再批量写入新关联

### 通用关联服务

`OrgRelationService` 提供以下方法：

- `bindOrgs(itemType, itemId, orgIds)` — 批量绑定
- `unbindOrgs(itemType, itemId)` — 解除全部绑定
- `getItemIdsByOrg(itemType, orgId)` — 查某门店关联的设定ID列表
- `getOrgIdsByItem(itemType, itemId)` — 查某设定关联的门店ID列表

## 数据迁移

```sql
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
```

迁移完成后，各表移除 `org_id` 字段。

## 涉及文件

### 新增文件

- `pos-common`: `OrgRelationTypeEnum` 枚举
- `pos-server`: `OrgRelationEntity`、`OrgRelationMapper`、`OrgRelationService`、`OrgRelationServiceImpl`
- `sql`: 迁移脚本（建表 + 迁移数据 + 移除 org_id）

### 修改文件（5 个模块各一套）

- Entity — 移除 orgId 字段
- DTO/VO — 查询参数加 orgId，新增/更新参数加 orgIds
- ServiceImpl — 查询改用关联表联查，新增/更新改用 OrgRelationService
- Controller — 接口参数调整
- Mapper XML — 查询 SQL 改为联表
