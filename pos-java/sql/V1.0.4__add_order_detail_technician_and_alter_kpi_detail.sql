-- 新建订单明细技师关联表
CREATE TABLE order_detail_technician (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    detail_id   BIGINT       NOT NULL COMMENT '订单明细ID',
    user_id     BIGINT       NOT NULL COMMENT '技师ID',
    user_name   VARCHAR(50)  NOT NULL COMMENT '技师姓名',
    create_time DATETIME              COMMENT '创建时间',
    update_time DATETIME              COMMENT '更新时间',
    is_delete   TINYINT DEFAULT 0     COMMENT '删除状态(0存在 1删除)',
    INDEX idx_detail_id (detail_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细技师关联表';

-- kpi_detail 新增订单明细关联字段
ALTER TABLE kpi_detail ADD COLUMN detail_id BIGINT NULL COMMENT '订单明细ID';
ALTER TABLE kpi_detail ADD COLUMN detail_code VARCHAR(50) NULL COMMENT '订单明细编号';
ALTER TABLE kpi_detail ADD INDEX idx_detail_id (detail_id);