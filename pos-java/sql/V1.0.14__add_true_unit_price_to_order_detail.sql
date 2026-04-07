-- 订单明细表增加实收单价字段， truePrice 语义变更为实收总价
ALTER TABLE order_detail ADD COLUMN true_unit_price DECIMAL(10, 2) DEFAULT NULL COMMENT '实收单价' AFTER true_price;

-- 修改 true_price 字段注释
ALTER TABLE order_detail MODIFY COLUMN true_price DECIMAL(10, 2) DEFAULT NULL COMMENT '实收总价';
