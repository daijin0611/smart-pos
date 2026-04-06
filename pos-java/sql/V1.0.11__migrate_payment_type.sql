-- 迁移 payment_type 值到新编码
-- 注意：按从大到小顺序执行，避免值冲突

-- 99(未知) → 0(扫码) — 未知支付归入扫码
UPDATE payment_detail SET payment_type = 0 WHERE payment_type = 99;

-- 6(抖音) → 3
UPDATE payment_detail SET payment_type = 3 WHERE payment_type = 6;

-- 5(美团) → 4
UPDATE payment_detail SET payment_type = 4 WHERE payment_type = 5;

-- 4(优惠券) → 0(扫码) — 优惠券支付记录归入扫码
UPDATE payment_detail SET payment_type = 0 WHERE payment_type = 4;

-- 3(会员卡) → 5
UPDATE payment_detail SET payment_type = 5 WHERE payment_type = 3;

-- 2(现金) → 1
UPDATE payment_detail SET payment_type = 1 WHERE payment_type = 2;

-- 1(支付宝) → 0(扫码) — 合并到扫码
UPDATE payment_detail SET payment_type = 0 WHERE payment_type = 1;

-- 0(微信) 保持不变，已对应扫码
