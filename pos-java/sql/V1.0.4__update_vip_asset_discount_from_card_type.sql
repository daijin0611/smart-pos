-- 根据card_type_id.json数据更新vip_asset表的折扣率和名称
-- 将JSON中的discount字段转换为asset_discount_rate（百分比整数形式）
-- 例如："discount"="6.9" → asset_discount_rate = 69
-- "discount"="0" → asset_discount_rate = 100
-- 折扣率基础均为标准价（asset_discount_base = 0）
-- 同时更新asset_name为cardtypename

-- 更新所有有折扣记录的asset_discount_base为0（标准价）
UPDATE vip_asset
SET asset_discount_base = 0,
    update_time = NOW()
WHERE card_type_id IS NOT NULL AND card_type_id != '' AND is_delete = 0;

-- 更新card_type_id为'126'的记录，折扣6.9折 → 69，名称：25年6.9折赠送400元
UPDATE vip_asset
SET asset_discount_rate = 69,
    asset_name = '25年6.9折赠送400元',
    update_time = NOW()
WHERE card_type_id = '126' AND is_delete = 0;

-- 更新card_type_id为'55'的记录，折扣0折 → 100，名称：舍艺套餐会员
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '舍艺套餐会员',
    update_time = NOW()
WHERE card_type_id = '55' AND is_delete = 0;

-- 更新card_type_id为'122'的记录，折扣0折 → 100，名称：399次卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '399次卡',
    update_time = NOW()
WHERE card_type_id = '122' AND is_delete = 0;

-- 更新card_type_id为'20151212'的记录，折扣0折 → 100，名称：美一客会员
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '美一客会员',
    update_time = NOW()
WHERE card_type_id = '20151212' AND is_delete = 0;

-- 更新card_type_id为'20161012'的记录，折扣0折 → 100，名称：青春版疗程卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '青春版疗程卡',
    update_time = NOW()
WHERE card_type_id = '20161012' AND is_delete = 0;

-- 更新card_type_id为'110'的记录，折扣0折 → 100，名称：体验卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '体验卡',
    update_time = NOW()
WHERE card_type_id = '110' AND is_delete = 0;

-- 更新card_type_id为'107'的记录，折扣0折 → 100，名称：3000修复卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '3000修复卡',
    update_time = NOW()
WHERE card_type_id = '107' AND is_delete = 0;

-- 更新card_type_id为'108'的记录，折扣0折 → 100，名称：1000修复卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '1000修复卡',
    update_time = NOW()
WHERE card_type_id = '108' AND is_delete = 0;

-- 更新card_type_id为'114'的记录，折扣0折 → 100，名称：疗程卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '疗程卡',
    update_time = NOW()
WHERE card_type_id = '114' AND is_delete = 0;

-- 更新card_type_id为'113'的记录，折扣0折 → 100，名称：普通卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '普通卡',
    update_time = NOW()
WHERE card_type_id = '113' AND is_delete = 0;

-- 更新card_type_id为'105'的记录，折扣0折 → 100，名称：5.9折卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '5.9折卡',
    update_time = NOW()
WHERE card_type_id = '105' AND is_delete = 0;

-- 更新card_type_id为'115'的记录，折扣0折 → 100，名称：6.9折卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '6.9折卡',
    update_time = NOW()
WHERE card_type_id = '115' AND is_delete = 0;

-- 更新card_type_id为'111'的记录，折扣0折 → 100，名称：1000元卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '1000元卡',
    update_time = NOW()
WHERE card_type_id = '111' AND is_delete = 0;

-- 更新card_type_id为'112'的记录，折扣0折 → 100，名称：会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '会员卡',
    update_time = NOW()
WHERE card_type_id = '112' AND is_delete = 0;

-- 更新card_type_id为'101'的记录，折扣0折 → 100，名称：1000元充送卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '1000元充送卡',
    update_time = NOW()
WHERE card_type_id = '101' AND is_delete = 0;

-- 更新card_type_id为'102'的记录，折扣6.9折 → 69，名称：2000元卡
UPDATE vip_asset
SET asset_discount_rate = 69,
    asset_name = '2000元卡',
    update_time = NOW()
WHERE card_type_id = '102' AND is_delete = 0;

-- 更新card_type_id为'103'的记录，折扣5.9折 → 59，名称：3000元卡
UPDATE vip_asset
SET asset_discount_rate = 59,
    asset_name = '3000元卡',
    update_time = NOW()
WHERE card_type_id = '103' AND is_delete = 0;

-- 更新card_type_id为'104'的记录，折扣5折 → 50，名称：五折卡
UPDATE vip_asset
SET asset_discount_rate = 50,
    asset_name = '五折卡',
    update_time = NOW()
WHERE card_type_id = '104' AND is_delete = 0;

-- 更新card_type_id为'207'的记录，折扣0折 → 100，名称：四厂现金7折卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '四厂现金7折卡',
    update_time = NOW()
WHERE card_type_id = '207' AND is_delete = 0;

-- 更新card_type_id为'212'的记录，折扣0折 → 100，名称：四厂8.9折会员储值卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '四厂8.9折会员储值卡',
    update_time = NOW()
WHERE card_type_id = '212' AND is_delete = 0;

-- 更新card_type_id为'213'的记录，折扣0折 → 100，名称：7.9折会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '7.9折会员卡',
    update_time = NOW()
WHERE card_type_id = '213' AND is_delete = 0;

-- 更新card_type_id为'214'的记录，折扣0折 → 100，名称：6.9折会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '6.9折会员卡',
    update_time = NOW()
WHERE card_type_id = '214' AND is_delete = 0;

-- 更新card_type_id为'215'的记录，折扣0折 → 100，名称：8.9折会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '8.9折会员卡',
    update_time = NOW()
WHERE card_type_id = '215' AND is_delete = 0;

-- 更新card_type_id为'200'的记录，折扣0折 → 100，名称：舍艺贵宾卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '舍艺贵宾卡',
    update_time = NOW()
WHERE card_type_id = '200' AND is_delete = 0;

-- 更新card_type_id为'201'的记录，折扣0折 → 100，名称：新7.9折会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '新7.9折会员卡',
    update_time = NOW()
WHERE card_type_id = '201' AND is_delete = 0;

-- 更新card_type_id为'202'的记录，折扣0折 → 100，名称：新8.9折会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '新8.9折会员卡',
    update_time = NOW()
WHERE card_type_id = '202' AND is_delete = 0;

-- 更新card_type_id为'203'的记录，折扣0折 → 100，名称：新5.9折会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '新5.9折会员卡',
    update_time = NOW()
WHERE card_type_id = '203' AND is_delete = 0;

-- 更新card_type_id为'204'的记录，折扣0折 → 100，名称：现金卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '现金卡',
    update_time = NOW()
WHERE card_type_id = '204' AND is_delete = 0;

-- 更新card_type_id为'205'的记录，折扣0折 → 100，名称：新6.9折会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '新6.9折会员卡',
    update_time = NOW()
WHERE card_type_id = '205' AND is_delete = 0;

-- 更新card_type_id为'206'的记录，折扣0折 → 100，名称：新5折会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '新5折会员卡',
    update_time = NOW()
WHERE card_type_id = '206' AND is_delete = 0;

-- 更新card_type_id为'208'的记录，折扣0折 → 100，名称：四厂现金6折卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '四厂现金6折卡',
    update_time = NOW()
WHERE card_type_id = '208' AND is_delete = 0;

-- 更新card_type_id为'209'的记录，折扣0折 → 100，名称：四厂贵宾会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '四厂贵宾会员卡',
    update_time = NOW()
WHERE card_type_id = '209' AND is_delete = 0;

-- 更新card_type_id为'210'的记录，折扣0折 → 100，名称：四厂现金5折卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '四厂现金5折卡',
    update_time = NOW()
WHERE card_type_id = '210' AND is_delete = 0;

-- 更新card_type_id为'211'的记录，折扣0折 → 100，名称：四厂7.9折会员储值卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '四厂7.9折会员储值卡',
    update_time = NOW()
WHERE card_type_id = '211' AND is_delete = 0;

-- 更新card_type_id为'216'的记录，折扣0折 → 100，名称：10次修脚卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '10次修脚卡',
    update_time = NOW()
WHERE card_type_id = '216' AND is_delete = 0;

-- 更新card_type_id为'117'的记录，折扣0折 → 100，名称：24年新8.9会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '24年新8.9会员卡',
    update_time = NOW()
WHERE card_type_id = '117' AND is_delete = 0;

-- 更新card_type_id为'118'的记录，折扣0折 → 100，名称：24年新7.9会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '24年新7.9会员卡',
    update_time = NOW()
WHERE card_type_id = '118' AND is_delete = 0;

-- 更新card_type_id为'121'的记录，折扣0折 → 100，名称：24年新5会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '24年新5会员卡',
    update_time = NOW()
WHERE card_type_id = '121' AND is_delete = 0;

-- 更新card_type_id为'116'的记录，折扣0折 → 100，名称：99元体验卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '99元体验卡',
    update_time = NOW()
WHERE card_type_id = '116' AND is_delete = 0;

-- 更新card_type_id为'119'的记录，折扣0折 → 100，名称：24年新6.9会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '24年新6.9会员卡',
    update_time = NOW()
WHERE card_type_id = '119' AND is_delete = 0;

-- 更新card_type_id为'120'的记录，折扣0折 → 100，名称：24年新5.9会员卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '24年新5.9会员卡',
    update_time = NOW()
WHERE card_type_id = '120' AND is_delete = 0;

-- 更新card_type_id为'127'的记录，折扣5.9折 → 59，名称：25年5.9折赠送600元
UPDATE vip_asset
SET asset_discount_rate = 59,
    asset_name = '25年5.9折赠送600元',
    update_time = NOW()
WHERE card_type_id = '127' AND is_delete = 0;

-- 更新card_type_id为'124'的记录，折扣8.9折 → 89，名称：25年8.9折赠送100元
UPDATE vip_asset
SET asset_discount_rate = 89,
    asset_name = '25年8.9折赠送100元',
    update_time = NOW()
WHERE card_type_id = '124' AND is_delete = 0;

-- 更新card_type_id为'125'的记录，折扣7.9折 → 79，名称：25年7.9折赠送200元
UPDATE vip_asset
SET asset_discount_rate = 79,
    asset_name = '25年7.9折赠送200元',
    update_time = NOW()
WHERE card_type_id = '125' AND is_delete = 0;

-- 更新card_type_id为'128'的记录，折扣6.9折 → 69，名称：25年6.9折赠送600元
UPDATE vip_asset
SET asset_discount_rate = 69,
    asset_name = '25年6.9折赠送600元',
    update_time = NOW()
WHERE card_type_id = '128' AND is_delete = 0;

-- 更新card_type_id为'123'的记录，折扣10折 → 100，名称：24年现金价卡
UPDATE vip_asset
SET asset_discount_rate = 100,
    asset_name = '24年现金价卡',
    update_time = NOW()
WHERE card_type_id = '123' AND is_delete = 0;

-- 验证更新结果
SELECT
    card_type_id,
    asset_name,
    asset_discount_base,
    asset_discount_rate,
    update_time
FROM vip_asset
WHERE card_type_id IS NOT NULL AND card_type_id != '' AND is_delete = 0
ORDER BY card_type_id;