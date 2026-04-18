-- =============================================================
-- Smart POS 大数据平台 - DWD 层建表语句
-- 数据库：pos_dwd
-- 说明：明细数据层，对 ODS 数据进行清洗、补全维度信息
-- =============================================================

CREATE DATABASE IF NOT EXISTS pos_dwd
  COMMENT 'Smart POS DWD 明细数据层'
  LOCATION '/user/hive/warehouse/pos_dwd.db';

USE pos_dwd;

-- -----------------------------------------------------------
-- dwd_order_detail：订单明细宽表
-- 关联：order_info + order_detail + sys_org + sys_user
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS dwd_order_detail (
    order_id            BIGINT        COMMENT '订单id',
    order_no            STRING        COMMENT '销售单号',
    order_time          STRING        COMMENT '开单时间',
    settle_time         STRING        COMMENT '结算时间',
    order_status        TINYINT       COMMENT '订单状态',
    order_status_name   STRING        COMMENT '订单状态名称',
    customer_type       TINYINT       COMMENT '顾客类型(0会员,1散客)',
    customer_type_name  STRING        COMMENT '顾客类型名称',
    total_amount        DECIMAL(10,2) COMMENT '应收金额',
    actual_amount       DECIMAL(10,2) COMMENT '实收金额',
    discount_amount     DECIMAL(10,2) COMMENT '优惠金额',
    vip_id              BIGINT        COMMENT '会员id',
    vip_name            STRING        COMMENT '会员姓名',
    vip_card_number     STRING        COMMENT '会员卡号',
    cashier_id          BIGINT        COMMENT '收银员id',
    cashier_name        STRING        COMMENT '收银员姓名',
    bed_id              BIGINT        COMMENT '床位id',
    bed_name            STRING        COMMENT '床位名称',
    org_id              BIGINT        COMMENT '门店id',
    org_name            STRING        COMMENT '门店名称',
    detail_id           BIGINT        COMMENT '明细id',
    detail_type         TINYINT       COMMENT '业务类型(0产品,1服务,2套餐)',
    detail_type_name    STRING        COMMENT '业务类型名称',
    server_id           BIGINT        COMMENT '服务/产品id',
    server_type         TINYINT       COMMENT '上钟类型(0点钟,1加钟,2轮牌)',
    server_type_name    STRING        COMMENT '上钟类型名称',
    technician_id       BIGINT        COMMENT '技师id',
    technician_name     STRING        COMMENT '技师姓名',
    std_price           DECIMAL(10,2) COMMENT '标准价',
    vip_price           DECIMAL(10,2) COMMENT '会员价',
    true_price          DECIMAL(10,2) COMMENT '实际单价',
    quantity            INT           COMMENT '销售数量',
    line_total          DECIMAL(10,2) COMMENT '行小计(true_price * quantity)',
    timer_minutes       INT           COMMENT '计时分钟数'
)
COMMENT '订单明细宽表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- dwd_payment_detail：支付明细宽表
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS dwd_payment_detail (
    id              BIGINT        COMMENT '支付记录id',
    create_time     STRING        COMMENT '创建时间',
    active_type     TINYINT       COMMENT '业务类型',
    active_type_name STRING       COMMENT '业务类型名称',
    active_code     STRING        COMMENT '业务编号',
    active_name     STRING        COMMENT '业务名称',
    payment_type    TINYINT       COMMENT '支付方式',
    payment_name    STRING        COMMENT '支付方式名称',
    total_amount    DECIMAL(10,2) COMMENT '支付金额',
    payment_status  STRING        COMMENT '结算状态',
    org_id          BIGINT        COMMENT '门店id',
    org_name        STRING        COMMENT '门店名称'
)
COMMENT '支付明细宽表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- dwd_kpi_detail：绩效明细宽表
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS dwd_kpi_detail (
    id              BIGINT        COMMENT '绩效明细id',
    create_time     STRING        COMMENT '创建时间',
    service_code    STRING        COMMENT '业务编号',
    service_name    STRING        COMMENT '业务名称',
    service_type    TINYINT       COMMENT '业务类型',
    service_type_name STRING      COMMENT '业务类型名称',
    item_type       TINYINT       COMMENT '上钟类型',
    item_type_name  STRING        COMMENT '上钟类型名称',
    user_id         BIGINT        COMMENT '技师id',
    user_name       STRING        COMMENT '技师姓名',
    user_position   STRING        COMMENT '技师职位',
    performance     DECIMAL(10,2) COMMENT '业绩金额',
    commission      DECIMAL(10,2) COMMENT '提成金额',
    org_id          BIGINT        COMMENT '门店id',
    org_name        STRING        COMMENT '门店名称'
)
COMMENT '绩效明细宽表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- -----------------------------------------------------------
-- dwd_vip_order：会员消费明细（关联会员信息与订单）
-- -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS dwd_vip_order (
    order_id            BIGINT        COMMENT '订单id',
    order_no            STRING        COMMENT '销售单号',
    order_time          STRING        COMMENT '开单时间',
    settle_time         STRING        COMMENT '结算时间',
    actual_amount       DECIMAL(10,2) COMMENT '实收金额',
    vip_id              BIGINT        COMMENT '会员id',
    vip_name            STRING        COMMENT '会员姓名',
    vip_card_number     STRING        COMMENT '会员卡号',
    vip_phone_number    STRING        COMMENT '会员手机号',
    vip_register_time   STRING        COMMENT '会员注册时间',
    vip_balance         DECIMAL(10,2) COMMENT '会员当前余额',
    org_id              BIGINT        COMMENT '门店id',
    org_name            STRING        COMMENT '门店名称'
)
COMMENT '会员消费明细宽表'
PARTITIONED BY (dt STRING COMMENT '数据日期，格式 YYYY-MM-DD')
STORED AS ORC
TBLPROPERTIES ('orc.compress' = 'SNAPPY');
