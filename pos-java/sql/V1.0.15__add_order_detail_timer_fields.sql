-- V1.0.15__add_order_detail_timer_fields.sql
ALTER TABLE order_detail
    ADD COLUMN timer_status TINYINT DEFAULT 0 COMMENT '计时状态：0未开始,1进行中,2已暂停,3已结束',
    ADD COLUMN timer_start_time DATETIME DEFAULT NULL COMMENT '计时开始时间',
    ADD COLUMN timer_end_time DATETIME DEFAULT NULL COMMENT '预计结束时间',
    ADD COLUMN timer_paused_duration INT DEFAULT 0 COMMENT '累计暂停时长(秒)',
    ADD COLUMN timer_last_pause_time DATETIME DEFAULT NULL COMMENT '最近暂停开始时间',
    ADD COLUMN actual_duration INT DEFAULT NULL COMMENT '实际服务时长(秒)',
    ADD COLUMN timer_warned TINYINT DEFAULT 0 COMMENT '是否已发送到期提醒';
-- 已在测试环境执行：2026-04-11
-- 已在生产环境执行：2026-04-11