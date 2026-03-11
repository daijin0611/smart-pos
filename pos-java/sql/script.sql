create table kpi_detail
(
    id           bigint unsigned auto_increment comment '主键'
        primary key,
    create_time  datetime                     null comment '创建时间',
    update_time  datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete    tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark       varchar(255)                 null comment '备注',
    order_code   varchar(100)                 null comment '业务编号',
    service_code varchar(100)                 null comment '业务编码',
    service_name varchar(50)                  null comment '业务名称',
    quantity     int              default 1   null comment '数量',
    service_type tinyint                      null comment '业务类型',
    item_type    tinyint                      null comment '上钟类型',
    user_id      bigint                       null comment '技师id',
    user_name    varchar(50)                  null comment '提成技师',
    performance  decimal(10, 2)               null comment '业绩金额',
    commission   decimal(10, 2)               null comment '提成金额',
    org_id       bigint                       null comment '门店id'
)
    comment '业绩明细' row_format = DYNAMIC;

create table order_detail
(
    id            bigint unsigned auto_increment comment '主键'
        primary key,
    create_time   datetime                      null comment '创建时间',
    update_time   datetime                      null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete     tinyint unsigned default '0'  null comment '删除状态(0 存在，1 删除)',
    remark        varchar(255)                  null comment '备注',
    detail_code   varchar(255)                  null comment '订单明细编号',
    order_id      bigint                        null comment '订单id',
    order_code    varchar(255)                  null comment '订单编号',
    user_id       bigint                        null comment '员工id',
    user_name     varchar(255)                  null comment '技师名称',
    detail_type   tinyint                       null comment '业务类型（0 产品，1 服务，2 套餐）',
    bid           bigint                        null comment '订单业务id',
    business_code varchar(255)                  null comment '业务编码',
    business_name varchar(100)                  null comment '业务名称',
    std_price     decimal(10, 2)   default 0.00 null comment '标准价',
    true_price    decimal(10, 2)   default 0.00 null comment '实际单价',
    quantity      int                           null comment '销售数量',
    server_type   tinyint                       null comment '上钟类型（0 点钟，1 加钟，2 轮牌）',
    settled_time  datetime                      null comment '结算时间',
    order_status  tinyint                       null comment '订单状态',
    org_id        bigint                        null comment '机构id'
)
    comment '订单明细表' row_format = DYNAMIC;

create table order_info
(
    id               bigint unsigned auto_increment comment '主键'
        primary key,
    create_time      datetime                      null comment '创建时间',
    update_time      datetime                      null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete        tinyint unsigned default '0'  null comment '删除状态(0 存在，1 删除)',
    remark           varchar(255)                  null comment '备注',
    order_code       varchar(100)                  not null comment '销售单号',
    order_time       datetime                      not null comment '开单时间',
    order_status     tinyint                       null comment '订单状态',
    customer_name    varchar(100)                  null comment '顾客名称',
    customer_type    tinyint                       null comment '顾客类型（0 会员，1 散客）',
    vip_id           bigint                        null comment '会员id',
    vip_name         varchar(50)                   null comment '顾客名称',
    vip_card_number  varchar(255)                  null comment '会员卡号',
    vip_phone_number varchar(255)                  null comment '会员电话号',
    before_balance   decimal(10, 2)   default 0.00 null comment '消费前余额',
    after_balance    decimal(10, 2)   default 0.00 null comment '消费后余额',
    settle_time      datetime                      null comment '结算时间',
    total_amount     decimal(10, 2)   default 0.00 null comment '应收金额',
    actual_amount    decimal(10, 2)   default 0.00 null comment '实收金额',
    discount_amount  decimal(10, 2)   default 0.00 null comment '优惠金额',
    bed_id           bigint                        null comment '床位id',
    bed_name         varchar(255)                  null comment '床位名称',
    user_id          bigint                        null comment '收银人id',
    user_name        varchar(255)                  null comment '收银人名称',
    org_id           bigint                        null comment '门店id'
)
    comment '订单信息表' row_format = DYNAMIC;

create table order_sales_summary
(
    id                        bigint unsigned auto_increment comment '主键'
        primary key,
    create_time               datetime                    null comment '销售数据创建时间',
    stats_date                date                        null comment '销售日期',
    total_turnover            decimal(18, 2) default 0.00 null comment '总营业额',
    total_actual_receipt      decimal(18, 2) default 0.00 null comment '总实收金额',
    total_single_time         int            default 0    null comment '总单次数量',
    total_people_time         int            default 0    null comment '总人次',
    total_project_count       int            default 0    null comment '总项目数',
    alipay_payment            decimal(18, 2) default 0.00 null comment '支付宝支付金额',
    bank_card_payment         decimal(18, 2) default 0.00 null comment '银行卡支付金额',
    cash_payment              decimal(18, 2) default 0.00 null comment '现金支付金额',
    wechat_payment            decimal(18, 2) default 0.00 null comment '微信支付金额',
    electronic_coupon_payment decimal(18, 2) default 0.00 null comment '电子优惠券支付金额',
    membership_card_payment   decimal(18, 2) default 0.00 null comment '会员卡支付金额',
    other_payment             decimal(18, 2) default 0.00 null comment '其他方式支付金额',
    cash_recharge             decimal(18, 2) default 0.00 null comment '现金充值金额',
    wechat_recharge           decimal(18, 2) default 0.00 null comment '微信充值金额',
    other_recharge            decimal(18, 2) default 0.00 null comment '其他方式充值',
    org_id                    bigint                      null comment '门店id'
)
    comment '销售数据汇总表，整合销售、支付、充值相关数据' row_format = DYNAMIC;

create table payment_detail
(
    id             bigint unsigned auto_increment comment '主键'
        primary key,
    create_time    datetime                     null comment '创建时间',
    update_time    datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete      tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark         varchar(255)                 null comment '备注',
    active_type    tinyint                      null comment '业务类型',
    active_code    varchar(255)                 null comment '业务编号',
    active_name    varchar(255)                 null comment '业务名称',
    payment_type   tinyint                      null comment '支付方式',
    payment_name   varchar(255)                 null comment '支付方式名称',
    total_amount   decimal(10, 2)               null comment '支付金额',
    payment_status varchar(20)                  null comment '结算状态',
    asset_code     varchar(255)                 null comment '资产编号',
    org_id         bigint                       null comment '门店id'
)
    comment '支付明细表，记录各种业务的支付详情。' row_format = DYNAMIC;

create table room_bed
(
    id           bigint unsigned auto_increment comment '主键'
        primary key,
    create_time  datetime                     null comment '创建时间',
    update_time  datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete    tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark       varchar(255)                 null comment '备注',
    bed_name     varchar(20)                  null comment '床位名称',
    room_info_id bigint                       null comment '房间id',
    status       tinyint          default 0   null comment '床位状态（0 空闲中，1 服务中， 2 暂停使用）',
    org_id       bigint                       null
)
    comment '床位表' row_format = DYNAMIC;

create table room_info
(
    id          bigint unsigned auto_increment comment '主键'
        primary key,
    create_time datetime                     null comment '创建时间',
    update_time datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete   tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark      varchar(255)                 null comment '备注',
    room_name   varchar(20)                  null comment '房间名',
    org_id      bigint                       not null
)
    comment '房间表' row_format = DYNAMIC;

create table server_cure_ticket
(
    id               bigint unsigned auto_increment comment '主键'
        primary key,
    create_time      datetime                     null comment '创建时间',
    update_time      datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete        tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark           varchar(255)                 null comment '备注（其它描述）',
    name             varchar(50)                  not null comment '疗程卷名称',
    encode           varchar(200)                 not null comment '疗程编码',
    price            decimal(10, 2)               null comment '疗程价格',
    type             tinyint                      null comment '提成类型（0 固定金额，1 比例提成）',
    commission_value decimal(5, 2)                null comment '提成值（固定/比例）',
    commission_base  tinyint                      null comment '提成基准（0 标准价，1 实收价）',
    status           tinyint          default 0   null comment '状态（0 启用，1 禁用）',
    org_id           bigint                       null comment '门店id'
)
    comment '疗程券表' row_format = DYNAMIC;

create table server_cure_ticket_detail
(
    id              bigint unsigned auto_increment comment '主键'
        primary key,
    remark          varchar(255)    null comment '备注（其它描述）',
    cure_ticket_id  bigint unsigned null comment '疗程券id',
    vip_ticket_id   bigint          null comment '优惠券id',
    vip_ticket_name varchar(255)    null comment '优惠券名称',
    vip_ticket_num  int             null comment '优惠券数量'
)
    comment '疗程券内容表（关联server_cure_ticket, vip_ticket）' row_format = DYNAMIC;

create table server_item
(
    id                           bigint unsigned auto_increment comment '主键'
        primary key,
    create_time                  datetime                        null comment '创建时间',
    update_time                  datetime                        null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete                    tinyint unsigned default '0'    null comment '删除状态(0 存在，1 删除)',
    remark                       varchar(255)                    null comment '备注(其他描述)',
    item_name                    varchar(255)                    not null comment '服务项目名称',
    item_encode                  varchar(255)                    not null comment '服务项目编码',
    server_time                  int                             not null comment '服务时长',
    item_price                   decimal(10, 2)                  not null comment '标准价',
    vip_item_price               decimal(10, 2)                  not null comment '会员价',
    is_discounts                 tinyint          default 0      not null comment '是否参与打折（0 允许，1 禁止）',
    commission_type              tinyint          default 0      not null comment '提成类型（0 固定金额，1 比例提成）',
    commission_value_rotation    decimal(5, 2) unsigned zerofill not null comment '提成值（固定/比例）（轮牌）',
    commission_value_appointment decimal(5, 2) unsigned zerofill not null comment '提成值（固定/比例）（点钟）',
    commission_value_extend      decimal(5, 2) unsigned zerofill not null comment '提成值（固定/比例）（加钟）',
    commission_base              tinyint          default 0      not null comment '提成基准（0 标准价，1 实收价）',
    item_status                  tinyint          default 0      not null comment '项目状态（0 启用， 1 禁用）',
    org_id                       bigint           default 1      not null comment '机构id'
)
    comment '服务项目' row_format = DYNAMIC;

create table server_package
(
    id                bigint unsigned auto_increment comment '主键'
        primary key,
    create_time       datetime                     null comment '创建时间',
    update_time       datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete         tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark            varchar(255)                 null comment '备注（其他描述）',
    package_name      varchar(255)                 null comment '服务套餐名称
套餐名称',
    package_encode    varchar(255)                 null comment '套餐编码',
    package_price     decimal(10, 2)               null comment '散客价',
    package_price_vip decimal(10, 2)               null comment '会员价'
)
    comment '服务套餐表' row_format = DYNAMIC;

create table server_package_detail
(
    id                  bigint unsigned auto_increment comment '主键'
        primary key,
    create_time         datetime                     null comment '创建时间',
    update_time         datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete           tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark              varchar(255)                 null comment '备注',
    package_detail_name varchar(255)                 null comment '服务套餐明细名称',
    package_tool_number tinyint                      null comment '套餐明细使用物品数量',
    package_id          bigint                       null comment '套餐id'
)
    comment '服务套餐明细表' row_format = DYNAMIC;

create table server_product
(
    id                bigint unsigned auto_increment comment '主键'
        primary key,
    create_time       datetime                     null comment '创建时间',
    update_time       datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete         tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark            varchar(255)                 null comment '备注(其他描述)',
    product_name      varchar(255)                 not null comment '产品名称',
    product_encode    varchar(255)                 not null comment '产品编码',
    product_price     decimal(10, 2)               not null comment '标准价',
    vip_product_price decimal(10, 2)               not null comment '会员价',
    is_discount       tinyint                      not null comment '是否参与打折（0 是，1 否）',
    commission_type   tinyint                      not null comment '提成类型（0 固定提成， 1 比例提成）',
    commission_value  decimal(5, 2)                not null comment '提成值（固定/比例）根据提成类型而定',
    commission_base   tinyint          default 0   not null comment '提成价格（提成值计算基准 0：标准价 1：实收价）',
    status            tinyint          default 0   not null comment '产品状态（0 启用，1 禁用）',
    unit              varchar(10)                  null comment '服务产品单位',
    org_id            bigint           default 1   not null comment '机构id',
    quantity          int              default 0   not null comment '库存',
    version           int              default 1   not null comment '乐观锁版本号'
)
    comment '产品表' row_format = DYNAMIC;

create table server_recharge_role
(
    id                        bigint unsigned auto_increment comment '主键'
        primary key,
    create_time               datetime                     null comment '创建时间',
    update_time               datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete                 tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark                    varchar(255)                 null comment '备注（其他描述）',
    recharge_role_name        varchar(255)                 null comment '充值提成规则名称',
    recharge_price            decimal(10, 2)               null comment '充值金额',
    commission_type           tinyint                      null comment '提成类型',
    recharge_commission_value decimal(5, 2)                null comment '提成值（比例）',
    status                    tinyint          default 0   not null,
    org_id                    bigint                       not null comment '机构id',
    is_default                tinyint          default 0   null comment '是否默认规则（0 否，1 是）'
)
    comment '充值提成规则表' row_format = DYNAMIC;

create table stock_in_item
(
    id            bigint unsigned auto_increment comment '主键'
        primary key,
    create_time   datetime                     null comment '创建时间',
    update_time   datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete     tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark        varchar(255)                 null comment '备注(其他描述)',
    product_id    bigint                       not null comment '商品id',
    product_code  varchar(255)                 null comment '商品编码（冗余字段方便展示）',
    product_name  varchar(255)                 null comment '商品名称（冗余字段方便展示）',
    unit          varchar(10)                  not null comment '单位',
    quantity      int                          not null comment '入库数量',
    price         decimal(10, 2)               not null comment '入库单价',
    in_order_id   bigint                       not null comment '入库单id',
    in_order_code varchar(255)                 not null comment '入库单号',
    org_id        bigint                       not null comment '机构id'
)
    comment '入库明细表';

create table stock_in_order
(
    id          bigint unsigned auto_increment comment '主键'
        primary key,
    create_time datetime                     null comment '创建时间',
    update_time datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete   tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark      varchar(255)                 null comment '备注(其他描述)',
    total_price decimal(10, 2)               not null comment '总金额',
    operator    varchar(255)                 not null comment '操作人',
    order_code  varchar(255)                 not null comment '入库单编号',
    org_id      bigint           default 1   not null comment '机构id'
)
    comment '库存入库单' row_format = DYNAMIC;

create table stock_log
(
    id           bigint unsigned auto_increment comment '主键'
        primary key,
    create_time  datetime                     null comment '创建时间',
    update_time  datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete    tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark       varchar(255)                 null comment '备注(其他描述)',
    order_code   varchar(255)                 not null comment '单号',
    order_type   varchar(10)                  not null comment '单号类型',
    product_id   bigint                       null comment '产品id',
    product_name varchar(255)                 null comment '产品名称',
    product_code varchar(255)                 null comment '产品编码',
    operator     varchar(255)                 null comment '操作人',
    quantity     int                          null comment '数量',
    price        decimal(10, 2)               null comment '单价',
    total_price  decimal(10, 2)               null comment '总金额',
    org_id       bigint           default 1   not null
)
    comment '库存流水表';

create table stock_out_item
(
    id             bigint unsigned auto_increment comment '主键'
        primary key,
    create_time    datetime                     null comment '创建时间',
    update_time    datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete      tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark         varchar(255)                 null comment '备注(其他描述)',
    product_id     bigint                       not null comment '商品id',
    product_code   varchar(255)                 null comment '商品编码（冗余字段方便展示）',
    product_name   varchar(255)                 null comment '商品名称（冗余字段方便展示）',
    unit           varchar(10)                  not null comment '单位',
    quantity       int                          not null comment '出库数量',
    price          decimal(10, 2)               not null comment '出库单价',
    out_order_id   bigint                       not null comment '出库单id',
    out_order_code varchar(255)                 not null comment '出库单号',
    org_id         bigint                       not null comment '机构id'
)
    comment '出库明细表';

create table stock_out_order
(
    id          bigint unsigned auto_increment comment '主键'
        primary key,
    create_time datetime                     null comment '创建时间',
    update_time datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete   tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark      varchar(255)                 null comment '备注(其他描述)',
    operator    varchar(255)                 not null comment '操作人',
    order_code  varchar(255)                 not null comment '出库单号',
    total_price decimal(10, 2)               not null comment '出库总金额',
    org_id      bigint                       not null comment '机构id'
)
    comment '库存出库单' row_format = DYNAMIC;

create table sys_dict_item
(
    id          bigint unsigned auto_increment comment '主键'
        primary key,
    create_time datetime                     null comment '创建时间',
    update_time datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete   tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark      varchar(255)                 null comment '备注',
    dict_code   varchar(100)                 null comment '关联字典编码',
    item_value  varchar(100)                 null comment '字典项内容',
    item_label  varchar(100)                 not null comment '字典项标签',
    sort        int              default 0   null comment '排序权重'
)
    comment '系统字典内容表' row_format = DYNAMIC;

create table sys_dict_type
(
    id          bigint unsigned auto_increment comment '主键'
        primary key,
    create_time datetime                     null comment '创建时间',
    update_time datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete   tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark      varchar(255)                 null comment '备注',
    dict_name   varchar(100)                 null comment '字典名称',
    dict_code   varchar(100)                 null comment '字典编码',
    sort        int              default 0   null comment '排序权重'
)
    comment '系统字典类型表' row_format = DYNAMIC;

create table sys_org
(
    id                       bigint unsigned auto_increment comment '主键'
        primary key,
    create_time              datetime                     null comment '创建时间',
    update_time              datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete                tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    org_state                tinyint unsigned default '0' null comment '机构状态(0 正常，1 停用)',
    org_name                 varchar(100)                 not null comment '机构名称',
    org_short_name           varchar(50)                  null comment '机构简称',
    org_code                 varchar(20)                  not null comment '机构编号',
    org_parent               varchar(100)                 null comment '父级机构',
    org_property             varchar(50)                  null comment '机构性质',
    org_type                 varchar(50)                  null comment '机构类型',
    org_area                 varchar(50)                  null comment '行政区域',
    org_number               varchar(20)                  null comment '机构电话',
    org_leader               varchar(20)                  null comment '机构负责人',
    org_leader_num           varchar(11)                  null comment '负责人电话',
    org_address              varchar(255)                 null comment '详细地址',
    remark                   varchar(255)                 null comment '备注',
    recharge_discount_rate   int              default 100 null comment '充值折扣率',
    recharge_discount_base   int              default 0   null comment '充值折扣基础(0 标准价 1 会员价)',
    recharge_is_cross_store  int              default 0   null comment '充值是否允许跨店(0 否 1 是)',
    default_recharge_role_id bigint                       null comment '默认充值提成规则ID',
    default_discount_rate    int              default 100 not null comment '默认折扣率（百分比）',
    default_discount_base    tinyint          default 1   not null comment '默认折扣基准（0 标准价，1 会员价）',
    default_is_cross_store   tinyint          default 1   not null comment '默认跨店结算（0 不允许，1 允许）',
    print_width              int              default 58  null comment '打印宽度（毫米）'
)
    comment '机构信息表' row_format = DYNAMIC;

create table sys_permission
(
    id             bigint unsigned auto_increment comment '主键'
        primary key,
    create_time    datetime                     null comment '创建时间',
    update_time    datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete      tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    perm_name      varchar(20)                  not null comment '权限名称',
    perm_code      varchar(100)                 not null comment '权限标识',
    resource_path  varchar(200)                 not null comment '资源路径',
    component_name varchar(255)                 not null comment '组件名称',
    perm_status    int              default 0   not null comment '权限状态（0 正常， 1 停用）',
    parent_id      bigint unsigned  default '0' null comment '父权限ID',
    remark         varchar(255)                 null comment '备注'
)
    comment '系统权限表' row_format = DYNAMIC;

create table sys_role
(
    id          bigint unsigned auto_increment comment '主键'
        primary key,
    create_time datetime                     null comment '创建时间',
    update_time datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete   tinyint unsigned default '0' null comment '删除状态（0 存在，1 删除）',
    role_code   varchar(20)                  not null comment '角色标识',
    role_name   varchar(20)                  not null comment '角色名称',
    remark      varchar(255)                 null comment '备注',
    role_sort   int              default 1   null comment '显示顺序',
    role_status int              default 0   null comment '角色状态（0 启用，1 禁用）'
)
    comment '系统角色表' row_format = DYNAMIC;

create table sys_role_permission
(
    role_id       bigint unsigned not null comment '角色id',
    permission_id bigint unsigned not null comment '权限id',
    primary key (role_id, permission_id),
    constraint fk_sys_role_permission_sys_permission_1
        foreign key (permission_id) references sys_permission (id),
    constraint fk_sys_role_permission_sys_role_1
        foreign key (role_id) references sys_role (id)
)
    comment '角色权限关联表' row_format = DYNAMIC;

create table sys_user
(
    id              bigint unsigned auto_increment comment '主键'
        primary key,
    create_time     datetime                     null comment '创建时间',
    update_time     datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete       tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    user_code       varchar(20)                  not null comment '编号',
    user_password   varchar(20)                  null comment '登录密码',
    user_name       varchar(20)                  not null comment '真实姓名',
    user_number     varchar(11)                  not null comment '手机号',
    user_position   varchar(20)                  null comment '职位',
    user_sex        tinyint          default 0   not null comment '性别（0 男，1 女）',
    user_birthday   date                         null comment '生日',
    user_dept       varchar(20)                  null comment '部门',
    user_entry_date date                         null comment '入职时间',
    user_status     varchar(10)                  null comment '在职状态',
    user_id_card    varchar(18)                  null comment '身份证号',
    user_address    varchar(200)                 null comment '人员地址',
    user_marry      varchar(10)                  null comment '婚姻状况',
    user_edu        varchar(10)                  null comment '学历状况',
    user_health     datetime                     null comment '健康证到期',
    remark          varchar(255)                 null comment '备注',
    org_id          bigint unsigned              null comment '机构id',
    role_id         bigint unsigned              null comment '角色id'
)
    comment '系统用户表（员工表）' row_format = DYNAMIC;

create table sys_org_user
(
    org_id bigint unsigned not null comment '机构id',
    usr_id bigint unsigned not null comment '用户id',
    primary key (org_id, usr_id),
    constraint fk_sys_org_user_sys_org_1
        foreign key (org_id) references sys_org (id),
    constraint fk_sys_org_user_sys_user_1
        foreign key (usr_id) references sys_user (id)
)
    comment '门店用户关联表' row_format = DYNAMIC;

create table sys_user_role
(
    user_id bigint unsigned not null comment '用户id',
    role_id bigint unsigned not null comment '角色id',
    primary key (user_id, role_id),
    constraint fk_sys_user_role_sys_role_1
        foreign key (role_id) references sys_role (id),
    constraint fk_sys_user_role_sys_user_1
        foreign key (user_id) references sys_user (id)
)
    comment '用户角色关联表' row_format = DYNAMIC;

create table vip_asset
(
    id                   bigint unsigned auto_increment comment '主键'
        primary key,
    create_time          datetime                      null comment '创建时间',
    update_time          datetime                      null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete            tinyint unsigned default '0'  null comment '删除状态(0 存在，1 删除)',
    remark               varchar(255)                  null comment '备注',
    asset_num            varchar(255)                  null comment '资产编号',
    asset_name           varchar(255)                  null comment '会员卡名称',
    asset_balance        decimal(10, 2)   default 0.00 null comment '余额',
    asset_type           tinyint                       null comment '资产类型（0 充值，1 赠送）',
    asset_discount_base  tinyint                       null comment '折扣基础（0 标准价，1 会员价）',
    asset_discount_rate  int                           null comment '折扣率',
    asset_is_cross_store tinyint(1)                    null comment '跨店消费（0 不允许，1 允许）',
    asset_card_number    varchar(255)                  null comment '实体卡号',
    vip_id               bigint                        null comment '会员id',
    org_id               bigint                        null comment '门店id',
    version              int              default 1    not null comment '乐观锁',
    vip_card_number      varchar(50)                   null comment '会员卡号',
    card_type_id         varchar(50)                   null comment '兼容美管家会员卡类型分类ID'
)
    comment '会员资产表' row_format = DYNAMIC;

create index idx_vip_asset_card_type_id
    on vip_asset (card_type_id);

create index idx_vip_asset_vip_card_number
    on vip_asset (vip_card_number);

create table vip_info
(
    id                    bigint unsigned auto_increment comment '主键'
        primary key,
    create_time           datetime                      null comment '创建时间',
    update_time           datetime                      null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete             tinyint unsigned default '0'  null comment '删除状态(0 存在，1 删除)',
    remark                varchar(255)                  null comment '备注',
    name                  varchar(255)                  null comment '姓名',
    gender                tinyint                       null comment '性别（0 男，1 女）',
    card_number           varchar(255)                  null comment '会员卡号',
    identity              tinyint          default 0    not null comment '会员身份',
    phone_number          varchar(11)                   null comment '电话号码',
    last_consumption_time date                          null comment '末次消费日期',
    last_recharge_time    date                          null comment '末次充值时间',
    balance               decimal(10, 2)   default 0.00 null comment '店内总余额',
    birthday              date                          null comment '会员生日',
    address               varchar(255)                  null comment '会员地址',
    pwd                   varchar(255)                  null comment '会员密码',
    org_id                bigint           default 1    not null comment '注册门店id'
)
    comment '会员信息表';

create table vip_info_ticket
(
    id               bigint unsigned auto_increment comment '主键'
        primary key,
    create_time      datetime                     null comment '创建时间',
    update_time      datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete        tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark           varchar(255)                 null comment '备注',
    vip_info_id      bigint                       not null comment '会员id',
    vip_ticket_id    bigint                       null comment '优惠券id',
    ticket_name      varchar(255)                 null comment '代金券名称',
    ticket_type      tinyint                      null comment '优惠券类型',
    vip_name         varchar(255)                 null comment '领取人名称',
    vip_phone_number varchar(255)                 null comment '领取人手机号',
    status           varchar(20)                  null comment '使用状态',
    claim_time       date                         null comment '领取时间',
    expiry_date      date                         null comment '到期时间',
    ticket_code      varchar(255)                 null comment '优惠券码',
    vip_card_number  varchar(255)                 null comment '领取人卡号',
    org_id           bigint                       null comment '机构id',
    active_id        int                          null comment '活动id',
    source_type      tinyint                      null comment '来源类型',
    source_code      varchar(255)                 null comment '充值历史编号',
    used_order_code  varchar(255)                 null comment '用券订单编号'
)
    comment '会员信息与优惠券关联表（优惠券明细）' row_format = DYNAMIC;

create table vip_recharge_active
(
    id                       bigint unsigned auto_increment comment '主键'
        primary key,
    create_time              datetime                     null comment '创建时间',
    update_time              datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete                tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark                   varchar(255)                 null comment '备注',
    active_status            tinyint          default 0   null comment '充值活动状态（0 启用，1 禁用）',
    active_name              varchar(255)                 not null comment '活动名称',
    active_begin_time        date                         null comment '开始时间',
    active_final_time        date                         null comment '结束时间',
    active_type              tinyint                      not null comment '活动类型',
    active_capital           decimal(10, 2)               null comment '充值本金',
    active_discount          int                          null comment '消费折扣百分比',
    active_base              tinyint                      null comment '折扣基础（0 标准价，1 会员价）',
    is_cross_store           tinyint                      null comment '是否允许跨店结算（0 不允许，1 允许）',
    present_value            decimal(10, 2)               null comment '赠送金额',
    present_discount_is_same tinyint                      null comment '折扣是否同本金（0 不同，1 同）',
    present_discount         int                          null comment '赠送金-消费折扣百分比',
    present_base             tinyint                      null comment '赠送金-折扣基础（0 标准价，1 会员价）',
    present_is_cross_store   tinyint                      null comment '赠送金-允许跨店结算（0 不允许，1 允许）',
    org_id                   bigint                       null comment '门店id'
)
    comment '充值活动表' row_format = DYNAMIC;

create table vip_recharge_active_ticket
(
    id          bigint unsigned auto_increment comment '主键'
        primary key,
    create_time datetime                     null comment '创建时间',
    update_time datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete   tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark      varchar(255)                 null comment '备注',
    ticket_id   bigint                       null comment '优惠券id',
    ticket_name varchar(255)                 null comment '优惠券名称',
    active_id   bigint                       null comment '充值活动id',
    number      int                          null comment '优惠券数量'
)
    comment '充值活动与优惠券关联表
' row_format = DYNAMIC;

create table vip_recharge_history
(
    id                 bigint unsigned zerofill auto_increment comment '主键'
        primary key,
    create_time        datetime                     null comment '创建时间',
    update_time        datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete          tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark             varchar(255)                 null comment '备注',
    history_code       varchar(255)                 not null comment '充值单号',
    recharge_value     decimal(10, 2)               null comment '充值金额',
    recharge_status    tinyint                      null comment '充值状态（0 充值成功，1 已冲正）',
    recharge_type      varchar(255)                 null comment '充值类型（0 门店充值，1 手动赠送）',
    recharge_time      datetime                     not null comment '充值时间',
    vip_id             bigint                       null comment '关联充值会员id',
    vip_name           varchar(255)                 null comment '会员姓名',
    vip_phone_number   varchar(255)                 null comment '会员电话号',
    vip_card_number    varchar(255)                 null comment '会员卡号',
    activity_id        bigint                       null comment '关联充值活动id',
    active_name        varchar(255)                 null comment '充值活动名称',
    asset_code         varchar(255)                 null comment '本金资产编号',
    present_value      decimal(10, 2)               null comment '赠送金额',
    present_asset_code varchar(255)                 null comment '赠送资产编号',
    ticket_info        varchar(255)                 null comment '赠券信息',
    ticket_num         int                          null comment '优惠券数量',
    user_name          varchar(255)                 null comment '操作员名称',
    user_id            bigint                       null comment '操作员id',
    org_id             bigint                       null comment '门店id',
    is_renewal         tinyint          default 0   not null comment '是否续费充值（0 否，1 是）'
)
    comment '充值记录表' row_format = DYNAMIC;

create table vip_recharge_user
(
    id          bigint unsigned auto_increment comment '主键'
        primary key,
    create_time datetime                     null comment '创建时间',
    update_time datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete   tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark      varchar(255)                 null comment '备注',
    recharge_id bigint                       null comment '收入记录id',
    user_id     bigint                       null comment '操作员id',
    commission  decimal(10, 2)               null comment '充值业绩'
)
    comment '员工充值提成关联表' row_format = DYNAMIC;

create table vip_ticket
(
    id                    bigint unsigned auto_increment comment '主键'
        primary key,
    create_time           datetime                     null comment '创建时间',
    update_time           datetime                     null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete             tinyint unsigned default '0' null comment '删除状态(0 存在，1 删除)',
    remark                varchar(255)                 null comment '备注',
    ticket_status         tinyint          default 0   null comment '优惠券状态（0 启用，1 禁用）',
    ticket_name           varchar(255)                 null comment '优惠券名称',
    ticket_type           tinyint                      null comment '优惠券类型',
    ticket_effective_time int                          null comment '有效天数（-1 代表无限期）',
    ticket_full_payment   decimal(10, 2)               null comment '限额满多少元可用',
    ticket_value          decimal(10, 2)               null comment '优惠券面值',
    org_id                bigint                       null comment '门店id'
)
    comment '会员优惠券' row_format = DYNAMIC;

create table vip_ticket_detail
(
    ticket_id      bigint not null comment '优惠券id',
    server_item_id bigint not null comment '服务项目id',
    id             bigint auto_increment comment '主键id'
        primary key
)
    comment '体验券详情';


