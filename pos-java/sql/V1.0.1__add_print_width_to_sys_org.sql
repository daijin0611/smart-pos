-- 为sys_org表添加打印宽度字段
-- Requirements: 1.1, 1.3

ALTER TABLE sys_org ADD COLUMN print_width INT DEFAULT 58 COMMENT '打印宽度（毫米）';
