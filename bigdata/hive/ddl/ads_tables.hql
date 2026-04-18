-- =============================================================
-- Smart POS 大数据平台 - ADS 层建表语句
-- 数据库：pos_ads
-- 说明：应用数据层，面向 BI 报表和业务分析
-- =============================================================

CREATE DATABASE IF NOT EXISTS pos_ads
  COMMENT 'Smart POS ADS 应用数据层'
  LOCATION '/user/hive/warehouse/pos_ads.db';

USE pos_ads;

-- -----------------------------------------------------------
-- ads_sales_daily_report：销售日报
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ads_sales_daily_report (
    org_id                  BIGINT        COMMENT '门店id',
    org_name                STRING        COMMENT '门店名称',
    order_count             INT           COMMENT '订单总数',
    vip_order_count         INT           COMMENT '会员订单数',
    vip_order_rate          DECIMAL(5,2)  COMMENT '会员订单占比(%)',
    total_amount            DECIMAL(18,2) COMMENT '应收总金额',
    actual_amount           DECIMAL(18,2) COMMENT '实收总金额',
    discount_amount         DECIMAL(18,2) COMMENT '优惠总金额',
    avg_order_amount        DECIMAL(18,2) COMMENT '客单价',
    recharge_amount         DECIMAL(18,2) COMMENT '会员充值总额',
    new_vip_count           INT           COMMENT '新增会员数',
    wechat_pay_amount       DECIMAL(18,2) COMMENT '微信支付金额',
    alipay_amount           DECIMAL(18,2) COMMENT '支付宝金额',
    cash_amount             DECIMAL(18,2) COMMENT '现金支付金额',
    member_card_amount      DECIMAL(18,2) COMMENT '会员卡支付金额',
    pos_pay_amount          DECIMAL(18,2) COMMENT 'POS机支付金额',
    top_service             STRING        COMMENT '当日最热服务项目',
    top_technician          STRING        COMMENT '当日业绩最高技师'
)
COMMENT '销售日报'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ads_top_technician_monthly：月度技师业绩排行
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ads_top_technician_monthly (
    rank_no             INT           COMMENT '排名',
    user_id             BIGINT        COMMENT '技师id',
    user_name           STRING        COMMENT '技师姓名',
    org_id              BIGINT        COMMENT '门店id',
    org_name            STRING        COMMENT '门店名称',
    service_count       INT           COMMENT '服务项次',
    total_performance   DECIMAL(18,2) COMMENT '总业绩金额',
    total_commission    DECIMAL(18,2) COMMENT '总提成金额',
    avg_per_service     DECIMAL(18,2) COMMENT '每次服务平均业绩'
)
COMMENT '月度技师业绩排行榜'
PARTITIONED BY (month STRING COMMENT '数据月份，格式 YYYY-MM')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ads_vip_rfm_analysis：会员 RFM 分析
-- R (Recency)：最近消费距今天数
-- F (Frequency)：消费频次（近90天）
-- M (Monetary)：消费金额（近90天）
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ads_vip_rfm_analysis (
    vip_id              BIGINT        COMMENT '会员id',
    vip_name            STRING        COMMENT '会员姓名',
    vip_card_number     STRING        COMMENT '会员卡号',
    vip_phone_number    STRING        COMMENT '手机号',
    org_id              BIGINT        COMMENT '主门店id',
    org_name            STRING        COMMENT '主门店名称',
    recency_days        INT           COMMENT 'R:最近消费距计算日天数',
    frequency           INT           COMMENT 'F:近90天消费频次',
    monetary            DECIMAL(18,2) COMMENT 'M:近90天消费金额',
    r_score             INT           COMMENT 'R得分(1-5，越小越好)',
    f_score             INT           COMMENT 'F得分(1-5，越大越好)',
    m_score             INT           COMMENT 'M得分(1-5，越大越好)',
    rfm_score           INT           COMMENT 'RFM综合得分',
    vip_segment         STRING        COMMENT '会员分层标签',
    current_balance     DECIMAL(18,2) COMMENT '当前余额',
    calc_date           STRING        COMMENT '计算日期'
)
COMMENT '会员RFM分析结果'
PARTITIONED BY (dt STRING COMMENT '计算日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- ads_service_popularity：服务/产品热度分析
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS ads_service_popularity (
    server_id           BIGINT        COMMENT '服务/产品id',
    server_name         STRING        COMMENT '服务/产品名称',
    detail_type         TINYINT       COMMENT '类型(0产品,1服务,2套餐)',
    detail_type_name    STRING        COMMENT '类型名称',
    org_id              BIGINT        COMMENT '门店id',
    org_name            STRING        COMMENT '门店名称',
    sale_count          INT           COMMENT '销售次数',
    sale_quantity       INT           COMMENT '销售数量合计',
    total_revenue       DECIMAL(18,2) COMMENT '总收入',
    avg_price           DECIMAL(18,2) COMMENT '平均实际单价',
    rank_in_org         INT           COMMENT '门店内排名',
    rank_overall        INT           COMMENT '全局排名'
)
COMMENT '服务/产品热度分析'
PARTITIONED BY (dt STRING COMMENT '统计截止日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');
