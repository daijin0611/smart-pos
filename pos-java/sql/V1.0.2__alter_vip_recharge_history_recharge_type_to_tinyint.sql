-- 将充值类型从字符串统一为数值：0-门店充值，1-手动赠送
-- 兼容历史值：门店充值/手动赠送/0/1/2

UPDATE vip_recharge_history
SET recharge_type = CASE
    WHEN recharge_type IN ('门店充值', '0', 0) THEN '0'
    WHEN recharge_type IN ('手动赠送', '1', 1, '2', 2) THEN '1'
    ELSE recharge_type
END
WHERE recharge_type IS NOT NULL;

ALTER TABLE vip_recharge_history
    MODIFY COLUMN recharge_type TINYINT NULL COMMENT '充值类型（0 门店充值，1 手动赠送）';

-- test ok
-- prod ok