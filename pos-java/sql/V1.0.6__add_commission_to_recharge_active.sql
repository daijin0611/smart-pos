ALTER TABLE vip_recharge_active ADD COLUMN commission_type TINYINT DEFAULT 1 COMMENT '提成类型（0固定金额，1比例）' AFTER present_is_cross_store;
ALTER TABLE vip_recharge_active ADD COLUMN commission_value DECIMAL(5,2) DEFAULT 0.00 COMMENT '提成值' AFTER commission_type;

-- test ok