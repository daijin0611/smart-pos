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

-- test ok