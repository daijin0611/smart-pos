ALTER TABLE vip_info ADD COLUMN old_vip_json JSON COMMENT '原系统会员信息JSON数据';

-- test ok
-- prod ok