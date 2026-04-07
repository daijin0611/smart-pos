-- 订单明细表增加实收单价字段， truePrice 语义变更为实收总价
ALTER TABLE order_detail ADD COLUMN true_unit_price DECIMAL(10, 2) DEFAULT NULL COMMENT '实收单价' AFTER true_price;

-- 修改 true_price 字段注释
ALTER TABLE order_detail MODIFY COLUMN true_price DECIMAL(10, 2) DEFAULT NULL COMMENT '实收总价';

-- 增加是否已计算折扣字段
ALTER TABLE order_detail ADD COLUMN is_discount TINYINT DEFAULT 0 NOT NULL COMMENT '是否已计算折扣（0 未计算，1 已计算）' AFTER quantity;

-- 订单明细技师关联表增加员工编号字段
ALTER TABLE order_detail_technician ADD COLUMN user_code VARCHAR(50) DEFAULT NULL COMMENT '员工编号' AFTER user_name;
