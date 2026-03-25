ALTER TABLE vip_info_ticket MODIFY COLUMN status tinyint COMMENT '使用状态（0 未使用，1 已使用，2 已取消）';

-- test
-- prod