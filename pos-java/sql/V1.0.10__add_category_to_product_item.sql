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

-- 已在测试环境执行：2026-04-02
-- 已在生产环境执行：2026-04-02