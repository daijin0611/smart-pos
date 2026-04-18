-- =============================================================
-- Smart POS 大数据平台 - DWS 层建表语句
-- 数据库：pos_dws
-- 说明：汇总数据层，按门店/员工/会员等维度聚合
-- =============================================================

CREATE DATABASE IF NOT EXISTS pos_dws
  COMMENT 'Smart POS DWS 汇总数据层'
  LOCATION '/user/hive/warehouse/pos_dws.db';

USE pos_dws;

-- -----------------------------------------------------------
-- dws_daily_sales_org：按门店+日期汇总的销售数据
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS dws_daily_sales_org (
    org_id                  BIGINT        COMMENT '门店id',
    org_name                STRING        COMMENT '门店名称',
    order_count             INT           COMMENT '订单总数',
    vip_order_count         INT           COMMENT '会员订单数',
    guest_order_count       INT           COMMENT '散客订单数',
    total_amount            DECIMAL(18,2) COMMENT '应收总金额',
    actual_amount           DECIMAL(18,2) COMMENT '实收总金额',
    discount_amount         DECIMAL(18,2) COMMENT '优惠总金额',
    product_sale_count      INT           COMMENT '产品销售项次',
    service_sale_count      INT           COMMENT '服务销售项次',
    package_sale_count      INT           COMMENT '套餐销售项次',
    new_vip_count           INT           COMMENT '新增会员数（当日注册）',
    recharge_amount         DECIMAL(18,2) COMMENT '会员充值总金额',
    recharge_gift_amount    DECIMAL(18,2) COMMENT '充值赠送总金额'
)
COMMENT '按门店+日期汇总销售数据'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- dws_daily_kpi_user：按员工+日期汇总的绩效数据
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS dws_daily_kpi_user (
    user_id         BIGINT        COMMENT '员工id',
    user_name       STRING        COMMENT '员工姓名',
    user_position   STRING        COMMENT '员工职位',
    org_id          BIGINT        COMMENT '门店id',
    org_name        STRING        COMMENT '门店名称',
    service_count   INT           COMMENT '服务项次',
    total_performance DECIMAL(18,2) COMMENT '总业绩金额',
    total_commission  DECIMAL(18,2) COMMENT '总提成金额'
)
COMMENT '按员工+日期汇总绩效数据'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- dws_monthly_vip_stat：按会员+月份汇总消费数据
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS dws_monthly_vip_stat (
    vip_id              BIGINT        COMMENT '会员id',
    vip_name            STRING        COMMENT '会员姓名',
    vip_card_number     STRING        COMMENT '会员卡号',
    org_id              BIGINT        COMMENT '主门店id',
    org_name            STRING        COMMENT '主门店名称',
    order_count         INT           COMMENT '消费订单数',
    total_consume_amount DECIMAL(18,2) COMMENT '累计消费金额',
    avg_order_amount    DECIMAL(18,2) COMMENT '平均订单金额',
    last_order_date     STRING        COMMENT '最后消费日期',
    recharge_count      INT           COMMENT '充值次数',
    recharge_amount     DECIMAL(18,2) COMMENT '充值总金额'
)
COMMENT '按会员+月份汇总消费数据'
PARTITIONED BY (month STRING COMMENT '数据月份，格式 YYYY-MM')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- dws_payment_type_stat：按支付方式+日期汇总
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS dws_payment_type_stat (
    org_id              BIGINT        COMMENT '门店id',
    org_name            STRING        COMMENT '门店名称',
    payment_type        TINYINT       COMMENT '支付方式',
    payment_name        STRING        COMMENT '支付方式名称',
    transaction_count   INT           COMMENT '支付笔数',
    total_amount        DECIMAL(18,2) COMMENT '支付总金额'
)
COMMENT '按支付方式+日期汇总'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');
