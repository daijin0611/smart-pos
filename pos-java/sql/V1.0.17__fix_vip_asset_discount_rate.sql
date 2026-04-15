-- V1.0.17 修正储值卡折扣率
-- 24年开头的储值卡折扣率全部为100（未按卡类型设置），需要根据卡名称修正
-- 折扣规则：项目折扣 × 10 = asset_discount_rate（整数百分比）
-- 注意：25年开头的卡折扣率已正确，此脚本仅修正24年开头的卡

-- 24年新8.9会员卡 → 89
UPDATE vip_asset
SET asset_discount_rate = 89
WHERE asset_name = '24年新8.9会员卡'
  AND asset_discount_rate != 89;

-- 24年新7.9会员卡 → 79
UPDATE vip_asset
SET asset_discount_rate = 79
WHERE asset_name = '24年新7.9会员卡'
  AND asset_discount_rate != 79;

-- 24年新6.9会员卡 → 69
UPDATE vip_asset
SET asset_discount_rate = 69
WHERE asset_name = '24年新6.9会员卡'
  AND asset_discount_rate != 69;

-- 24年新5.9会员卡 → 59
UPDATE vip_asset
SET asset_discount_rate = 59
WHERE asset_name = '24年新5.9会员卡'
  AND asset_discount_rate != 59;

-- 24年新5会员卡 → 50
UPDATE vip_asset
SET asset_discount_rate = 50
WHERE asset_name = '24年新5会员卡'
  AND asset_discount_rate != 50;

-- 24年现金价卡 → 100（不打折，已是100则无需更新，保险起见确认）
UPDATE vip_asset
SET asset_discount_rate = 100
WHERE asset_name = '24年现金价卡'
  AND asset_discount_rate != 100;

-- 25年8.9折赠送100元 → 89
UPDATE vip_asset
SET asset_discount_rate = 89
WHERE asset_name = '25年8.9折赠送100元'
  AND asset_discount_rate != 89;

-- 25年7.9折赠送200元 → 79
UPDATE vip_asset
SET asset_discount_rate = 79
WHERE asset_name = '25年7.9折赠送200元'
  AND asset_discount_rate != 79;

-- 25年6.9折赠送400元 → 69
UPDATE vip_asset
SET asset_discount_rate = 69
WHERE asset_name = '25年6.9折赠送400元'
  AND asset_discount_rate != 69;

-- 25年6.9折赠送600元 → 69
UPDATE vip_asset
SET asset_discount_rate = 69
WHERE asset_name = '25年6.9折赠送600元'
  AND asset_discount_rate != 69;

-- 已在测试环境执行：2026-04-13
