-- =============================================================
-- Smart POS 大数据平台 - ODS 层建表语句
-- 数据库：pos_ods
-- 说明：原始数据层，与 MySQL 业务表 1:1 映射，按日期分区
-- =============================================================

CREATE DATABASE IF NOT EXISTS pos_ods
  COMMENT 'Smart POS ODS 原始数据层'
  LOCATION '/user/hive/warehouse/pos_ods.db';

USE pos_ods;

-- -----------------------------------------------------------
-- ods_order_info：订单主表
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ods_order_info (
    id                BIGINT    COMMENT '主键',
    create_time       STRING    COMMENT '创建时间',
    update_time       STRING    COMMENT '更新时间',
    is_delete         TINYINT   COMMENT '删除状态(0存在,1删除)',
    remark            STRING    COMMENT '备注',
    order_no          STRING    COMMENT '销售单号',
    order_time        STRING    COMMENT '开单时间',
    order_status      TINYINT   COMMENT '订单状态',
    vip_id            BIGINT    COMMENT '会员id',
    vip_name          STRING    COMMENT '顾客名称',
    vip_card_number   STRING    COMMENT '会员卡号',
    vip_phone_number  STRING    COMMENT '会员电话号',
    vip_balance       DECIMAL(10,2) COMMENT '会员余额',
    settle_time       STRING    COMMENT '结算时间',
    total_amount      DECIMAL(10,2) COMMENT '应收金额',
    actual_amount     DECIMAL(10,2) COMMENT '实收金额',
    discount_amount   DECIMAL(10,2) COMMENT '优惠金额',
    bed_id            BIGINT    COMMENT '床位id',
    user_id           BIGINT    COMMENT '收银人id',
    customer_type     TINYINT   COMMENT '顾客类型(0会员,1散客)',
    user_name         STRING    COMMENT '收银人名称',
    bed_name          STRING    COMMENT '床位名称',
    org_id            BIGINT    COMMENT '门店id'
)
COMMENT '订单主表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ods_order_detail：订单明细表
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ods_order_detail (
    id            BIGINT    COMMENT '主键',
    create_time   STRING    COMMENT '创建时间',
    update_time   STRING    COMMENT '更新时间',
    is_delete     TINYINT   COMMENT '删除状态(0存在,1删除)',
    remark        STRING    COMMENT '备注',
    order_id      BIGINT    COMMENT '订单id',
    user_id       BIGINT    COMMENT '员工id',
    detail_type   TINYINT   COMMENT '业务类型(0产品,1服务,2套餐)',
    server_id     BIGINT    COMMENT '订单业务id',
    std_price     DECIMAL(10,2) COMMENT '标准价',
    true_price    DECIMAL(10,2) COMMENT '实际单价',
    quantity      INT       COMMENT '销售数量',
    server_type   TINYINT   COMMENT '上钟类型(0点钟,1加钟,2轮牌)',
    vip_price     DECIMAL(10,2) COMMENT '会员价',
    true_unit_price DECIMAL(10,2) COMMENT '实际单价（单项）',
    timer_start   STRING    COMMENT '计时开始时间',
    timer_end     STRING    COMMENT '计时结束时间',
    timer_minutes INT       COMMENT '计时分钟数',
    org_id        BIGINT    COMMENT '门店id'
)
COMMENT '订单明细表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ods_payment_detail：支付明细表
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ods_payment_detail (
    id              BIGINT    COMMENT '主键',
    create_time     STRING    COMMENT '创建时间',
    update_time     STRING    COMMENT '更新时间',
    is_delete       TINYINT   COMMENT '删除状态(0存在,1删除)',
    remark          STRING    COMMENT '备注',
    active_type     TINYINT   COMMENT '业务类型',
    active_code     STRING    COMMENT '业务编号',
    active_name     STRING    COMMENT '业务名称',
    payment_type    TINYINT   COMMENT '支付方式',
    payment_name    STRING    COMMENT '支付方式名称',
    total_amount    DECIMAL(10,2) COMMENT '支付金额',
    payment_status  STRING    COMMENT '结算状态',
    org_id          BIGINT    COMMENT '门店id'
)
COMMENT '支付明细表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ods_kpi_detail：绩效明细表
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ods_kpi_detail (
    id            BIGINT    COMMENT '主键',
    create_time   STRING    COMMENT '创建时间',
    update_time   STRING    COMMENT '更新时间',
    is_delete     TINYINT   COMMENT '删除状态(0存在,1删除)',
    remark        STRING    COMMENT '备注',
    service_code  STRING    COMMENT '业务编号',
    service_name  STRING    COMMENT '业务名称',
    service_type  TINYINT   COMMENT '业务类型',
    item_type     TINYINT   COMMENT '上钟类型',
    user_id       BIGINT    COMMENT '技师id',
    user_name     STRING    COMMENT '提成技师',
    performance   DECIMAL(10,2) COMMENT '业绩金额',
    commission    DECIMAL(10,2) COMMENT '提成金额',
    org_id        BIGINT    COMMENT '门店id'
)
COMMENT '绩效明细表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ods_vip_info：会员信息表
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ods_vip_info (
    id                      BIGINT    COMMENT '主键',
    create_time             STRING    COMMENT '创建时间',
    update_time             STRING    COMMENT '更新时间',
    is_delete               TINYINT   COMMENT '删除状态(0存在,1删除)',
    name                    STRING    COMMENT '会员姓名',
    gender                  TINYINT   COMMENT '性别(0男,1女)',
    card_number             STRING    COMMENT '会员卡号',
    phone_number            STRING    COMMENT '手机号',
    balance                 DECIMAL(10,2) COMMENT '账户余额',
    last_consumption_time   STRING    COMMENT '最后消费时间',
    org_id                  BIGINT    COMMENT '所属门店id',
    remark                  STRING    COMMENT '备注'
)
COMMENT '会员信息表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ods_vip_asset：会员资产表
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ods_vip_asset (
    id                      BIGINT    COMMENT '主键',
    create_time             STRING    COMMENT '创建时间',
    update_time             STRING    COMMENT '更新时间',
    is_delete               TINYINT   COMMENT '删除状态(0存在,1删除)',
    asset_num               STRING    COMMENT '资产编号',
    asset_name              STRING    COMMENT '资产名称',
    asset_balance           DECIMAL(10,2) COMMENT '资产余额',
    asset_type              TINYINT   COMMENT '资产类型(0充值金,1赠送金)',
    asset_discount_base     DECIMAL(10,2) COMMENT '打折起始金额',
    asset_discount_rate     DECIMAL(5,2) COMMENT '折扣率',
    asset_is_cross_store    TINYINT   COMMENT '是否跨店(0否,1是)',
    vip_card_number         STRING    COMMENT '会员卡号',
    org_id                  BIGINT    COMMENT '门店id',
    vip_id                  BIGINT    COMMENT '会员id'
)
COMMENT '会员资产表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ods_vip_recharge_history：会员充值记录表
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ods_vip_recharge_history (
    id              BIGINT    COMMENT '主键',
    create_time     STRING    COMMENT '创建时间',
    update_time     STRING    COMMENT '更新时间',
    is_delete       TINYINT   COMMENT '删除状态(0存在,1删除)',
    vip_id          BIGINT    COMMENT '会员id',
    recharge_amount DECIMAL(10,2) COMMENT '充值金额',
    gift_amount     DECIMAL(10,2) COMMENT '赠送金额',
    recharge_type   TINYINT   COMMENT '充值类型',
    operator_id     BIGINT    COMMENT '操作员id',
    operator_name   STRING    COMMENT '操作员姓名',
    org_id          BIGINT    COMMENT '门店id',
    remark          STRING    COMMENT '备注'
)
COMMENT '会员充值记录表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ods_sys_user：员工信息表（全量，无日期分区）
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ods_sys_user (
    id              BIGINT    COMMENT '主键',
    create_time     STRING    COMMENT '创建时间',
    update_time     STRING    COMMENT '更新时间',
    is_delete       TINYINT   COMMENT '删除状态(0存在,1删除)',
    user_code       STRING    COMMENT '员工编号',
    user_name       STRING    COMMENT '员工姓名',
    user_number     STRING    COMMENT '手机号',
    user_position   STRING    COMMENT '职位',
    user_sex        TINYINT   COMMENT '性别(0男,1女)',
    org_id          BIGINT    COMMENT '主门店id'
)
COMMENT '员工信息表'
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ods_sys_org：门店信息表（全量，无日期分区）
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ods_sys_org (
    id              BIGINT    COMMENT '主键',
    create_time     STRING    COMMENT '创建时间',
    update_time     STRING    COMMENT '更新时间',
    is_delete       TINYINT   COMMENT '删除状态(0存在,1删除)',
    org_name        STRING    COMMENT '门店名称',
    org_code        STRING    COMMENT '门店编号',
    org_address     STRING    COMMENT '门店地址',
    org_number      STRING    COMMENT '联系电话',
    parent_id       BIGINT    COMMENT '上级门店id'
)
COMMENT '门店信息表'
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');
