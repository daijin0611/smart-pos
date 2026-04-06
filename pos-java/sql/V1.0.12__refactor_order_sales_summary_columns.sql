-- V1.0.12: 重构 order_sales_summary 支付方式字段，对齐新 PaymentTypeEnum

-- 1. 新增4个支付方式列
ALTER TABLE order_sales_summary
    ADD COLUMN qr_payment            DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT '扫码支付金额' AFTER total_project_count,
    ADD COLUMN pos_payment           DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT 'POS支付金额' AFTER cash_payment,
    ADD COLUMN douyin_payment        DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT '抖音支付金额' AFTER pos_payment,
    ADD COLUMN meituan_payment       DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT '美团支付金额' AFTER douyin_payment;

-- 2. 迁移数据：旧字段 → 新字段
-- 扫码 = 原微信 + 原支付宝 + 原电子券 + 原其他
UPDATE order_sales_summary
SET qr_payment = COALESCE(wechat_payment, 0) + COALESCE(alipay_payment, 0) + COALESCE(electronic_coupon_payment, 0) + COALESCE(other_payment, 0);

-- 会员卡保持不变（membership_card_payment 列名后续重命名）
-- 现金保持不变（cash_payment 列名不变）
-- 抖音/美团/POS 历史数据无记录，默认0

-- 3. 删除旧列
ALTER TABLE order_sales_summary
    DROP COLUMN wechat_payment,
    DROP COLUMN alipay_payment,
    DROP COLUMN bank_card_payment,
    DROP COLUMN electronic_coupon_payment,
    DROP COLUMN other_payment;

-- 4. 重命名 membership_card_payment → member_card_payment（对齐枚举命名）
ALTER TABLE order_sales_summary
    CHANGE COLUMN membership_card_payment member_card_payment DECIMAL(18, 2) DEFAULT 0.00 NULL COMMENT '会员卡支付金额';
