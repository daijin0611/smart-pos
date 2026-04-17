-- 老系统次卡数据迁移快照表
CREATE TABLE IF NOT EXISTS vip_migrate_card_snapshot (
    id                BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    old_card_id       BIGINT              NOT NULL COMMENT '老系统次卡记录ID',
    old_member_id     BIGINT                       COMMENT '老系统会员ID',
    new_vip_id        BIGINT                       COMMENT '新系统会员ID（未匹配时为NULL）',
    item_id           VARCHAR(50)                  COMMENT '老系统项目ID',
    item_name         VARCHAR(255)                 COMMENT '项目名称',
    sum_times         INT                          COMMENT '购买总次数',
    leave_times       INT                          COMMENT '剩余次数',
    sum_money         DECIMAL(10, 2)               COMMENT '总金额',
    leave_money       DECIMAL(10, 2)               COMMENT '剩余金额',
    once_money        DECIMAL(10, 2)               COMMENT '单次金额',
    buy_date          DATETIME                     COMMENT '购买日期',
    last_consume_time DATETIME                     COMMENT '最后消费时间',
    emp_saler_names   VARCHAR(255)                 COMMENT '销售顾问',
    emp_saler_ids     VARCHAR(255)                 COMMENT '销售顾问ID',
    shop_name         VARCHAR(255)                 COMMENT '门店名称',
    sex               VARCHAR(10)                  COMMENT '性别',
    mobile            VARCHAR(20)                  COMMENT '手机号',
    new_vip_ticket_id BIGINT                       COMMENT '新系统优惠券模板ID',
    migrate_time      DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '迁移时间',
    org_id            BIGINT                       COMMENT '门店ID'
) COMMENT '老系统次卡迁移快照表';
-- 已在测试环境执行：2026-04-07
-- 已在生产环境执行：2026-04-07