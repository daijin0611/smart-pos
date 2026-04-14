-- 美管家系统次卡数据导入 SQL
-- 生成时间: 2026-04-14 01:12:07
-- 源文件: ticket.json
-- 门店 org_id: 7
-- 原始次卡数: 1417
-- 唯一会员数: 1148
-- 生成券实例数: 1590
-- 跳过(剩余次数=0): 901
-- 快照记录数: 1417

START TRANSACTION;

-- ============================================
-- 通用次卡模板优惠券 (vip_ticket)
-- ============================================

INSERT INTO vip_ticket (create_time, update_time, is_delete, ticket_status, ticket_name, ticket_type, ticket_effective_time, ticket_value)
SELECT NOW(), NOW(), 0, 1, '美管家次卡迁移模板', 1, -1, 0
WHERE NOT EXISTS (SELECT 1 FROM vip_ticket WHERE ticket_name = '美管家次卡迁移模板' AND is_delete = 0);

-- 门店关联 (item_type=4 优惠券)
INSERT IGNORE INTO sys_org_relation (item_type, item_id, org_id)
SELECT 4, id, 7 FROM vip_ticket WHERE ticket_name = '美管家次卡迁移模板' AND is_delete = 0;

-- 项目券关联所有门店服务项目 (vip_ticket_detail)
INSERT IGNORE INTO vip_ticket_detail (ticket_id, server_item_id)
SELECT vt.id, sor.item_id
FROM vip_ticket vt
CROSS JOIN sys_org_relation sor
WHERE vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0
  AND sor.item_type = 1 AND sor.org_id = 7;

-- ============================================
-- 补创建缺失会员 (vip_info)
-- ============================================

INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邢喜莲', 1, '181527865', '15093352210', 0.00, 7, 0, '美管家次卡迁移导入', '2026-04-05 17:58:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527865' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '韩照睿', 1, '181527852', '15517121203', 0.00, 7, 0, '美管家次卡迁移导入', '2026-04-04 21:00:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527852' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张旭', 0, '214950901', '15136129595', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-22 22:06:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '214950901' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王霞', 1, '214828655', '18037867988', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-20 16:43:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '214828655' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '韩先生', 0, '201668501', '18838136333', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-19 22:24:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201668501' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 1, '184809099', '15617679900', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-16 22:22:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809099' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨先生', 1, '184808968', '17337109636', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-16 22:16:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808968' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周女士', 1, '214530133', '18736068837', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-13 10:53:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '214530133' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王先生', 0, '201410755', '18569972777', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-12 21:40:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201410755' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '212611738', '13937190986', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-12 21:37:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '212611738' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵静', 1, '197182821', '18537285668', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-12 19:30:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '197182821' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王晨阳', 0, '173772684', '18638640217', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-10 16:54:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173772684' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马女士', 1, '214213374', '15515806010', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-04 18:08:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '214213374' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '薛芳芳', 1, '210691886', '13937118217', 0.00, 7, 0, '美管家次卡迁移导入', '2026-03-02 21:02:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '210691886' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '蔡琛', 1, '214078468', '13607661849', 0.00, 7, 0, '美管家次卡迁移导入', '2026-02-28 21:48:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '214078468' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李倩', 1, '213444311', '13938535595', 0.00, 7, 0, '美管家次卡迁移导入', '2026-02-10 13:04:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '213444311' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周德海', 1, '181527822', '18637122576', 0.00, 7, 0, '美管家次卡迁移导入', '2026-02-08 22:26:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527822' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '崔艳玲', 1, '185175861', '15838359663', 0.00, 7, 0, '美管家次卡迁移导入', '2026-01-28 22:13:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185175861' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李学良', 1, '169958567', '13838002046', 0.00, 7, 0, '美管家次卡迁移导入', '2026-01-28 13:20:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169958567' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '虞瑾', 1, '212675771', '18625527120', 0.00, 7, 0, '美管家次卡迁移导入', '2026-01-28 10:47:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '212675771' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张斌', 1, '211132271', '15093382528', 0.00, 7, 0, '美管家次卡迁移导入', '2026-01-27 16:16:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '211132271' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李美女', 1, '185988191', '13213177025', 0.00, 7, 0, '美管家次卡迁移导入', '2026-01-25 22:00:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185988191' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵爱菊', 1, '183989461', '15286807939', 0.00, 7, 0, '美管家次卡迁移导入', '2026-01-24 15:22:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183989461' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李晓琳', 1, '211130995', '13503846600', 0.00, 7, 0, '美管家次卡迁移导入', '2026-01-10 10:58:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '211130995' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵枝', 1, '211486017', '15093564769', 0.00, 7, 0, '美管家次卡迁移导入', '2025-12-31 17:41:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '211486017' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡胡', 0, '211257540', '13837123310', 0.00, 7, 0, '美管家次卡迁移导入', '2025-12-27 17:44:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '211257540' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王芳', 1, '199588920', '13503991279', 0.00, 7, 0, '美管家次卡迁移导入', '2025-12-25 19:59:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '199588920' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王淑辉', 1, '181527318', '18537172727', 0.00, 7, 0, '美管家次卡迁移导入', '2025-12-24 20:32:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527318' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 1, '190022202', '15093489056', 0.00, 7, 0, '美管家次卡迁移导入', '2025-12-20 21:47:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '190022202' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '柏延青', 1, '192652443', '18203636121', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-30 23:00:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '192652443' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女士', 1, '210179954', '15038662102', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-30 22:56:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '210179954' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴丽华', 1, '181527526', '17398985656', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-29 19:48:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527526' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '史婷伟', 1, '197351426', '18338723192', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-29 11:25:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '197351426' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘姐', 1, '182938465', '13783502817', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-28 15:22:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '182938465' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张三', 0, '209934835', '17537171531', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-25 18:38:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '209934835' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张志远', 0, '198527591', '18173905611', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-25 16:46:18', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '198527591' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭婉若', 1, '184808975', '15290826594', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-21 23:05:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808975' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吕孟宁', 1, '181527395', '18537115199', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-18 20:53:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527395' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吕方', 1, '181527460', '13083715585', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-17 21:11:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527460' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马先生', 0, '209562239', '15238826761', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-16 17:39:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '209562239' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '169865953', '13673377360', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-15 18:30:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169865953' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '符湘萍', 1, '181527399', '18625581116', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-15 11:43:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527399' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐广', 0, '184345168', '13838187047', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-14 19:11:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184345168' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '魏鑫然', 1, '190884631', '13733876320', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-14 12:20:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '190884631' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '姜女士', 1, '209445087', '15637122839', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-13 21:29:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '209445087' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘先生', 1, '181527336', '18039666700', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-12 17:45:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527336' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李阳', 1, '209313652', '19337852565', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-09 23:59:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '209313652' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '姜秀玲', 1, '207968686', '18539280565', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-09 20:41:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '207968686' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王栋', 0, '169968228', '17760770952', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-08 22:43:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169968228' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭伟', 1, '181527419', '13343859556', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-08 13:42:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527419' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张伟', 1, '201386463', '18037465161', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-08 13:41:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201386463' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '裴斐斐', 1, '181527587', '18736022332', 0.00, 7, 0, '美管家次卡迁移导入', '2025-11-08 13:39:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527587' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李艳荣', 1, '208880585', '13103829009', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-31 13:41:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '208880585' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '208874721', '13526764967', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-31 11:10:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '208874721' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张琳琳', 1, '181527290', '15838182696', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-29 10:27:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527290' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 0, '208806085', '13949015776', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-29 10:24:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '208806085' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '谭凤', 1, '206549789', '13523518834', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-23 22:47:46', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '206549789' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭伟', 1, '181527977', '13343859556', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-23 18:06:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527977' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王振民', 1, '196806542', '13733169451', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-19 13:25:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '196806542' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '崔先生', 0, '208382859', '13849057021', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-18 16:43:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '208382859' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张新丽', 1, '206790510', '15903692186', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-17 21:23:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '206790510' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李淑萍', 1, '201672593', '15036765572', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-16 11:12:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201672593' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贾女士', 1, '190156327', '15039378301', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-14 16:10:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '190156327' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙小景', 1, '207846000', '18937128280', 0.00, 7, 0, '美管家次卡迁移导入', '2025-10-06 13:03:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '207846000' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李灵君', 1, '184808983', '18937171522', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-29 22:44:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808983' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '谢爱荣', 1, '184808997', '13213223283', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-29 18:31:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808997' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '董女士', 1, '207312065', '13939016471', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-25 20:25:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '207312065' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐先生', 0, '186019806', '15638107123', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-24 20:48:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '186019806' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马星', 0, '195217020', '18768863125', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-23 16:34:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '195217020' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '肖', 0, '189511239', '15824855315', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-21 15:28:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '189511239' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常璐', 1, '196740554', '16603868937', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-15 19:04:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '196740554' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '闫学森', 0, '206824887', '18595855799', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-14 18:05:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '206824887' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '风玉琴', 1, '206639725', '13014503658', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-10 13:20:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '206639725' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡肆糖', 1, '206588797', '15136452219', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-09 12:28:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '206588797' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '魏巍', 1, '184808982', '15838254589', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-06 16:52:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808982' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐红', 1, '206490576', '15939041312', 0.00, 7, 0, '美管家次卡迁移导入', '2025-09-06 16:49:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '206490576' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高新', 1, '184808976', '13653836542', 0.00, 7, 0, '美管家次卡迁移导入', '2025-08-26 16:01:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808976' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王淑婷', 1, '205617524', '13782229706', 0.00, 7, 0, '美管家次卡迁移导入', '2025-08-25 18:55:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '205617524' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '巴建设', 0, '205576479', '13838288043', 0.00, 7, 0, '美管家次卡迁移导入', '2025-08-24 17:39:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '205576479' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱家惠', 1, '205540727', '15093678707', 0.00, 7, 0, '美管家次卡迁移导入', '2025-08-23 19:25:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '205540727' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈全慧', 1, '205381015', '13613806988', 0.00, 7, 0, '美管家次卡迁移导入', '2025-08-19 12:57:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '205381015' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马桂玲', 1, '184808969', '13526751061', 0.00, 7, 0, '美管家次卡迁移导入', '2025-07-28 11:17:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808969' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李新英', 1, '204118888', '13676951817', 0.00, 7, 0, '美管家次卡迁移导入', '2025-07-17 21:54:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '204118888' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '翟英', 1, '201089053', '13384006652', 0.00, 7, 0, '美管家次卡迁移导入', '2025-06-16 14:43:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201089053' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵鹏辉', 1, '184808992', '15093124152', 0.00, 7, 0, '美管家次卡迁移导入', '2025-06-15 21:28:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808992' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '桂珍', 1, '181527382', '15981878251', 0.00, 7, 0, '美管家次卡迁移导入', '2025-06-15 18:36:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527382' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '弓晶', 1, '201461074', '19139918092', 0.00, 7, 0, '美管家次卡迁移导入', '2025-06-15 18:00:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201461074' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐红霞', 1, '201122423', '15516988198', 0.00, 7, 0, '美管家次卡迁移导入', '2025-06-14 12:36:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201122423' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '姬素珍', 1, '201623282', '13523036766', 0.00, 7, 0, '美管家次卡迁移导入', '2025-06-07 19:06:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201623282' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李承骏', 1, '191710595', '13526704552', 0.00, 7, 0, '美管家次卡迁移导入', '2025-06-07 18:04:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '191710595' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈霞', 1, '194055722', '13703864980', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-30 21:20:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '194055722' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵雅楠', 1, '201697676', '18337186786', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-28 23:09:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201697676' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙小景', 1, '201672560', '18937128280', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-28 11:43:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201672560' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李晶', 1, '201583052', '18695887755', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-26 12:57:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201583052' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '董怡涵', 1, '201583023', '15981815113', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-26 12:56:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201583023' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵杰', 1, '201578298', '18703609975', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-26 09:20:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201578298' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 1, '201543917', '15039051992', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-25 12:05:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201543917' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋女士', 1, '201543861', '15517368185', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-25 12:04:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201543861' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张美女', 1, '201490052', '18638112055', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-24 11:59:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201490052' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王先生', 0, '201489354', '13513890310', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-24 11:57:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201489354' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '明女士', 1, '201489305', '13333858535', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-24 11:56:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201489305' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女士', 1, '201489253', '13903834599', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-24 11:54:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201489253' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陶先生', 1, '189869820', '13203883414', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-23 23:01:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '189869820' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '韩女士', 1, '201461107', '13598652006', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-23 14:12:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201461107' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '康女士', 1, '201461014', '15294631677', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-23 14:10:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201461014' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙先生', 0, '201460893', '19059621357', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-23 14:07:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201460893' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张坤', 1, '201460853', '15903656306', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-23 14:06:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201460853' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周女士', 1, '201424879', '18939625636', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-22 11:47:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201424879' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '201424844', '16696686567', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-22 11:46:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201424844' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹女士', 1, '201424799', '15938710765', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-22 11:45:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201424799' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '路蒙伟', 1, '201424766', '18137270778', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-22 11:44:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201424766' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女士', 1, '201424720', '19871482868', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-22 11:42:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201424720' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贾先生', 0, '201386510', '18037469008', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-21 12:02:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201386510' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '许女士', 1, '201386371', '15939039930', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-21 11:59:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201386371' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '史国有', 0, '201366651', '13608499428', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-20 17:31:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201366651' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '肖先生', 0, '201366586', '13653800760', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-20 17:30:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201366586' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '裴老师', 1, '194843199', '19303971737', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-19 22:12:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '194843199' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张与白', 1, '201296557', '17803820690', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-19 11:25:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201296557' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '卢应珍', 1, '201296512', '15188266891', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-19 11:23:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201296512' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孟先生', 0, '201255527', '15617863719', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-18 12:40:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201255527' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 0, '201255464', '15515990371', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-18 12:39:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201255464' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女士', 1, '201254182', '15637181886', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-18 12:13:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201254182' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈素梅', 1, '201254110', '18537167283', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-18 12:11:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201254110' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 1, '201248731', '13027730072', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-18 12:10:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201248731' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王玉果', 1, '201190638', '18530065305', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-17 10:32:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201190638' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张爱芹', 1, '201122484', '13523400110', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-15 11:23:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201122484' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孟弈晨', 1, '201122455', '15515879305', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-15 11:23:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201122455' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱金凤', 1, '201122397', '13838562918', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-15 11:20:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201122397' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '井女士', 1, '201122367', '15803829932', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-15 11:19:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201122367' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王丽', 1, '201122312', '18339980330', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-15 11:17:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201122312' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '顾女士', 1, '201089185', '15038129211', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-14 12:03:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201089185' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张利民', 0, '201089152', '13837096618', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-14 12:02:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201089152' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙亚平', 1, '201088996', '15515729030', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-14 11:57:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201088996' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '侯海霞', 1, '201088933', '15515889598', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-14 11:56:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201088933' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '99卡谢女士', 1, '184809076', '13592679350', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-14 11:54:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809076' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '崔静', 1, '201088839', '18703995827', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-14 11:52:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201088839' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冯先生', 0, '201088776', '13526851515', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-14 11:50:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201088776' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '苗女士', 1, '201088705', '18768391194', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-14 11:47:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201088705' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '201056136', '13526815156', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-13 12:17:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201056136' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 0, '201056081', '13015527755', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-13 12:15:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201056081' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑女士', 1, '201056031', '18568875113', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-13 12:14:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201056031' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '171201242', '15738316199', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-13 12:13:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171201242' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '田女士', 1, '201055922', '13633862151', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-13 12:11:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201055922' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨女士', 1, '201055799', '15688889321', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-13 12:06:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201055799' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冯先生', 1, '201055766', '15837103169', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-13 12:05:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201055766' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 0, '201055578', '13526722682', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-13 11:59:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201055578' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '201020539', '13903859630', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-13 11:58:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '201020539' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李云云', 1, '184809096', '18336375860', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-10 22:08:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809096' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李亚平', 0, '200752308', '13303837690', 0.00, 7, 0, '美管家次卡迁移导入', '2025-05-06 21:21:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '200752308' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘金山', 0, '200337501', '15333835007', 0.00, 7, 0, '美管家次卡迁移导入', '2025-04-28 22:23:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '200337501' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘顺利', 0, '200173211', '18625557336', 0.00, 7, 0, '美管家次卡迁移导入', '2025-04-25 12:07:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '200173211' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '董汉云', 1, '200117168', '13027784302', 0.00, 7, 0, '美管家次卡迁移导入', '2025-04-23 17:53:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '200117168' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 0, '199686621', '13323657678', 0.00, 7, 0, '美管家次卡迁移导入', '2025-04-13 22:43:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '199686621' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '惠女士', 1, '199586361', '18739938993', 0.00, 7, 0, '美管家次卡迁移导入', '2025-04-11 17:00:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '199586361' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄红萍', 1, '198804930', '13838569290', 0.00, 7, 0, '美管家次卡迁移导入', '2025-03-25 12:18:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '198804930' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙丽', 1, '183486483', '13526887094', 0.00, 7, 0, '美管家次卡迁移导入', '2025-03-15 12:39:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183486483' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '谷奇', 1, '184809048', '13525532853', 0.00, 7, 0, '美管家次卡迁移导入', '2025-03-06 19:39:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809048' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '顾依霏', 1, '197936285', '15515778810', 0.00, 7, 0, '美管家次卡迁移导入', '2025-03-05 23:42:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '197936285' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '位朋真', 1, '197317127', '18530057588', 0.00, 7, 0, '美管家次卡迁移导入', '2025-02-22 21:10:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '197317127' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈燕', 1, '197319194', '13607681723', 0.00, 7, 0, '美管家次卡迁移导入', '2025-02-22 21:07:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '197319194' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周莘源', 1, '197049400', '13837199948', 0.00, 7, 0, '美管家次卡迁移导入', '2025-02-15 14:56:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '197049400' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '庞红红', 1, '196869583', '13838255533', 0.00, 7, 0, '美管家次卡迁移导入', '2025-02-10 17:58:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '196869583' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李杰', 1, '184808985', '13703849111', 0.00, 7, 0, '美管家次卡迁移导入', '2025-02-08 20:23:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808985' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '小蕊', 1, '196737978', '15036186996', 0.00, 7, 0, '美管家次卡迁移导入', '2025-02-05 20:36:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '196737978' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱鹏', 0, '196497125', '18903830195', 0.00, 7, 0, '美管家次卡迁移导入', '2025-01-23 17:51:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '196497125' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈月红', 1, '196366556', '15138919045', 0.00, 7, 0, '美管家次卡迁移导入', '2025-01-21 12:16:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '196366556' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王永强', 1, '181527275', '13903843219', 0.00, 7, 0, '美管家次卡迁移导入', '2025-01-13 18:27:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527275' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '蔡勇梁', 0, '195906640', '17837196978', 0.00, 7, 0, '美管家次卡迁移导入', '2025-01-12 19:52:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '195906640' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈元科', 1, '181527845', '13674960098', 0.00, 7, 0, '美管家次卡迁移导入', '2025-01-11 20:53:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527845' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '乔兰', 1, '181527660', '15600460067', 0.00, 7, 0, '美管家次卡迁移导入', '2025-01-07 14:01:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527660' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李香兰', 1, '195238654', '15126177203', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-30 15:19:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '195238654' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贾秀梅', 1, '181527302', '15039378301', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-30 11:17:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527302' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王翠萍', 1, '195090892', '15837150126', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-26 19:40:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '195090892' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵艳玲', 1, '195032328', '15803849392', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-25 17:19:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '195032328' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '栾政义', 0, '195022645', '18737190517', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-25 14:10:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '195022645' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘世豪', 0, '194981198', '15639298280', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-24 12:06:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '194981198' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '金川', 0, '194975756', '13803892953', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-23 22:04:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '194975756' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宴阿姨', 1, '170418418', '15937121813', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-22 23:18:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170418418' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李美佳', 1, '194747463', '15515537612', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-18 14:43:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '194747463' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '园园', 1, '194732488', '13148227907', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-17 20:31:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '194732488' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '魏爱波', 1, '184644041', '13676921165', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-15 18:50:46', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184644041' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵丽', 1, '184809097', '13523048596', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-14 21:55:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809097' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '音女士', 1, '184534920', '15038216160', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-08 13:53:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184534920' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马英群', 1, '194385294', '13503844988', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-08 13:49:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '194385294' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王有才', 1, '184809095', '18595750693', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-05 11:50:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809095' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '桑嘉丽', 1, '194239013', '15738315363', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-04 21:47:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '194239013' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨洋', 1, '194149882', '13838251685', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-02 21:04:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '194149882' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常娟', 1, '181527270', '15537251018', 0.00, 7, 0, '美管家次卡迁移导入', '2024-12-01 16:55:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527270' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵海菲', 1, '184708403', '18736099998', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-28 13:20:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184708403' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵静心', 1, '193720960', '15981867936', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-24 14:45:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '193720960' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵爱菊', 1, '183989675', '15286807939', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-20 12:33:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183989675' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈嘉敏', 1, '193454132', '18737325787', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-16 22:21:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '193454132' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张保林', 1, '190674384', '13949131618', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-14 20:49:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '190674384' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吕女士', 1, '184809114', '17596574484', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-11 16:41:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809114' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马鸣戈', 1, '185720369', '13937181055', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-11 14:18:46', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185720369' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宗庆华', 1, '193194044', '13598017542', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-10 22:03:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '193194044' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '樊建宇', 1, '193073637', '13525568751', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-08 19:24:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '193073637' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨萌萌', 1, '193086413', '15225465242', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-08 19:05:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '193086413' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李松杰', 0, '193074295', '13937102369', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-08 16:04:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '193074295' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李静', 1, '192975154', '15803849391', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-07 15:27:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '192975154' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马晓慧', 1, '181527293', '17639298811', 0.00, 7, 0, '美管家次卡迁移导入', '2024-11-01 22:32:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527293' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹瑞春', 1, '184809081', '13526678852', 0.00, 7, 0, '美管家次卡迁移导入', '2024-10-25 21:18:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809081' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李忠福', 0, '192043626', '13014583123', 0.00, 7, 0, '美管家次卡迁移导入', '2024-10-22 22:52:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '192043626' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张兆杏', 0, '192012377', '18629945512', 0.00, 7, 0, '美管家次卡迁移导入', '2024-10-22 10:11:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '192012377' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴昱霖', 1, '182791335', '17303717019', 0.00, 7, 0, '美管家次卡迁移导入', '2024-10-20 15:41:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '182791335' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '潘先生', 0, '191710919', '15617950975', 0.00, 7, 0, '美管家次卡迁移导入', '2024-10-13 23:17:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '191710919' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡女士', 1, '191664158', '15038281545', 0.00, 7, 0, '美管家次卡迁移导入', '2024-10-13 12:07:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '191664158' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘瑞丽', 1, '191609876', '13526503842', 0.00, 7, 0, '美管家次卡迁移导入', '2024-10-11 18:44:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '191609876' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐进', 0, '191601369', '13837673222', 0.00, 7, 0, '美管家次卡迁移导入', '2024-10-11 16:56:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '191601369' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '党女士', 1, '181527306', '18037160069', 0.00, 7, 0, '美管家次卡迁移导入', '2024-10-06 17:59:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527306' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨文乐', 1, '190840964', '15137139580', 0.00, 7, 0, '美管家次卡迁移导入', '2024-09-25 22:35:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '190840964' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 1, '190302099', '13247195362', 0.00, 7, 0, '美管家次卡迁移导入', '2024-09-14 11:03:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '190302099' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '190143177', '13071091113', 0.00, 7, 0, '美管家次卡迁移导入', '2024-09-10 19:21:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '190143177' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李洁', 1, '190097265', '15803888795', 0.00, 7, 0, '美管家次卡迁移导入', '2024-09-09 15:40:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '190097265' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘雯', 1, '190096588', '13071070773', 0.00, 7, 0, '美管家次卡迁移导入', '2024-09-09 15:29:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '190096588' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高原', 1, '184809023', '13838121054', 0.00, 7, 0, '美管家次卡迁移导入', '2024-09-08 17:53:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809023' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '丁先生', 0, '184265868', '15890096270', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-28 19:46:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184265868' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女士', 1, '184809052', '13333818588', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-24 21:55:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809052' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贺女士', 1, '187211409', '18638527031', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-23 21:47:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '187211409' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '谢', 0, '169745412', '15837177337', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-20 10:48:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169745412' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '龚建秀', 1, '181527558', '15515659756', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-19 12:44:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527558' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李灵君', 1, '181527265', '18937171522', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-17 19:00:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527265' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李松香', 1, '181528121', '13903862303', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-17 11:30:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181528121' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陶先生', 1, '181527603', '13203883414', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-17 11:08:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527603' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡丽英', 1, '184808944', '13949033282', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-16 15:21:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808944' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '范女士', 1, '182967030', '13838394928', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-15 21:20:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '182967030' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈玲', 1, '181784938', '13223713056', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-15 16:51:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181784938' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张秘景', 1, '188686096', '13938440466', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-10 10:54:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '188686096' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '魏阿姨', 1, '188462257', '13733185802', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-06 11:12:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '188462257' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马先生', 1, '188454121', '13937173050', 0.00, 7, 0, '美管家次卡迁移导入', '2024-08-05 20:22:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '188454121' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女士', 1, '188051404', '18239268213', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-28 16:22:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '188051404' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '彭阳春', 1, '184809007', '18530080362', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-28 15:40:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809007' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张兰', 0, '188030235', '18910888617', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-27 22:10:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '188030235' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '矩矩', 1, '185067650', '15736758089', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-26 20:02:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185067650' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李莹', 1, '187919235', '15136105861', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-24 19:10:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '187919235' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '187789321', '13938505661', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-21 17:20:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '187789321' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陆小哥', 0, '185097667', '17638106615', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-21 11:04:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185097667' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '187611384', '13938505661', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-17 12:30:18', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '187611384' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '付晓琳', 1, '187447879', '15093447811', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-12 22:03:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '187447879' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '军强', 0, '187187254', '18539987100', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-06 15:16:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '187187254' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '蒋先生', 1, '187007048', '17337141889', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-01 21:48:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '187007048' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱女士', 1, '186986802', '15939027808', 0.00, 7, 0, '美管家次卡迁移导入', '2024-07-01 16:51:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '186986802' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄小雨', 0, '183599374', '15803880972', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-30 22:46:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183599374' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '范', 1, '186602969', '13838394928', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-24 21:12:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '186602969' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱先生', 0, '186559227', '13838005175', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-23 22:31:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '186559227' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱爱莲', 1, '186449677', '13803862503', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-21 17:14:46', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '186449677' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘晓辉', 0, '186282590', '17329315555', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-16 23:02:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '186282590' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨玉林', 0, '186282477', '15838351859', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-16 22:55:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '186282477' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭赵峰', 1, '186122742', '18037797511', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-13 12:16:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '186122742' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘锋', 1, '183984678', '18768890235', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-12 20:17:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183984678' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '卓玛秀', 1, '185992160', '19939711166', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-10 11:04:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185992160' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李岚', 1, '185976253', '13673696660', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-09 18:57:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185976253' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '185905310', '13071091113', 0.00, 7, 0, '美管家次卡迁移导入', '2024-06-07 22:40:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185905310' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白璐', 1, '185146952', '18137157779', 0.00, 7, 0, '美管家次卡迁移导入', '2024-05-22 22:29:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185146952' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女士', 1, '183599835', '15238651859', 0.00, 7, 0, '美管家次卡迁移导入', '2024-05-22 14:31:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183599835' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈艺茹', 1, '185097705', '15038307973', 0.00, 7, 0, '美管家次卡迁移导入', '2024-05-21 23:12:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '185097705' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈芬哒', 1, '184962186', '13298158833', 0.00, 7, 0, '美管家次卡迁移导入', '2024-05-18 22:26:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184962186' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女士', 1, '176297481', '15838013119', 0.00, 7, 0, '美管家次卡迁移导入', '2024-05-16 23:11:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '176297481' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王彦', 1, '184833158', '15937113767', 0.00, 7, 0, '美管家次卡迁移导入', '2024-05-16 15:30:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184833158' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '何', 1, '184643729', '18037276585', 0.00, 7, 0, '美管家次卡迁移导入', '2024-05-11 22:32:18', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184643729' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘鹏飞', 0, '184520498', '15038193202', 0.00, 7, 0, '美管家次卡迁移导入', '2024-05-08 17:44:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184520498' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高鹏飞', 0, '184460807', '17398960789', 0.00, 7, 0, '美管家次卡迁移导入', '2024-05-06 18:28:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184460807' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高先生', 0, '184221131', '15515550528', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-30 22:15:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184221131' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马京飞', 0, '184198372', '17737709209', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-30 17:22:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184198372' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭阿姨', 1, '183965232', '15639297787', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-25 16:12:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183965232' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邓女士', 1, '183731526', '13838174939', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-23 11:51:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183731526' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王慧玲', 1, '183509594', '18137843702', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-20 17:58:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183509594' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169746124', '15093107218', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-16 20:38:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169746124' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙秀英', 1, '183333275', '13733087797', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-16 16:47:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '183333275' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张姨', 1, '181844124', '15036387394', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-07 22:24:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181844124' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贾玉琼', 1, '182842027', '13523055717', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-05 22:15:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '182842027' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '董雅娟', 1, '182626281', '17698002233', 0.00, 7, 0, '美管家次卡迁移导入', '2024-04-01 15:43:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '182626281' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李淑琴阿姨', 1, '174281794', '18736066183', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-31 17:15:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174281794' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '袁女士', 1, '181844195', '13552344448', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-28 14:31:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181844195' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张静', 1, '181905174', '15378724406', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-28 13:59:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181905174' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张云', 1, '181905137', '13201153999', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-28 13:58:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181905137' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王倩', 1, '181868767', '15638906813', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-27 12:48:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181868767' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '田小兰', 1, '181527462', '15903626612', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-24 16:54:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181527462' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王有才', 1, '181753690', '18595750693', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-24 14:57:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181753690' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白杨', 1, '181716162', '13014560701', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-23 21:47:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181716162' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 0, '181687244', '18737198699', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-23 11:30:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181687244' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '管可可', 1, '181679854', '18825989852', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-22 23:11:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181679854' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄女士', 1, '181663383', '15893546728', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-22 17:21:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181663383' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '许阿姨', 1, '181645317', '13203827085', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 22:21:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181645317' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张永强', 1, '181645304', '13103939126', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 22:21:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181645304' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡鹏飞', 1, '181645292', '15638529091', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 22:20:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181645292' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈丽霞', 1, '181645272', '18614984134', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 22:19:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181645272' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙亚平', 1, '181645251', '15514383625', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 22:18:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181645251' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡女士', 1, '181645201', '15290409020', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 22:16:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181645201' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡秋霞', 1, '181645163', '15093204171', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 22:14:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181645163' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨月萍', 1, '181645144', '13838962965', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 22:13:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181645144' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘全凤', 1, '181599391', '13598886853', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 22:10:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181599391' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周全', 0, '181629171', '17796650311', 0.00, 7, 0, '美管家次卡迁移导入', '2024-03-21 17:15:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '181629171' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋女士', 1, '173809341', '18538086996', 0.00, 7, 0, '美管家次卡迁移导入', '2023-12-30 18:33:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173809341' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '171125949', '13937051998', 0.00, 7, 0, '美管家次卡迁移导入', '2023-12-05 22:10:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171125949' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '付', 1, '177437048', '13700855983', 0.00, 7, 0, '美管家次卡迁移导入', '2023-12-03 18:18:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '177437048' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 0, '177042527', '13526800103', 0.00, 7, 0, '美管家次卡迁移导入', '2023-11-24 17:29:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '177042527' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈先生', 0, '170193805', '13592585501', 0.00, 7, 0, '美管家次卡迁移导入', '2023-11-19 17:04:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170193805' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '迟女士', 1, '176241701', '15522426728', 0.00, 7, 0, '美管家次卡迁移导入', '2023-11-05 21:15:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '176241701' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '管', 1, '176077200', '13837113645', 0.00, 7, 0, '美管家次卡迁移导入', '2023-11-02 11:37:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '176077200' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '176051638', '15225074834', 0.00, 7, 0, '美管家次卡迁移导入', '2023-11-01 16:42:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '176051638' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘玉华', 1, '176051577', '13523582760', 0.00, 7, 0, '美管家次卡迁移导入', '2023-11-01 16:41:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '176051577' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '姚女生', 1, '169708661', '15324885591', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-31 11:37:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169708661' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '韩先生', 0, '175929176', '13623826180', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-30 11:07:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175929176' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋女士', 1, '175908539', '15137199295', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-29 17:06:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175908539' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169756310', '15039090826', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-29 16:21:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169756310' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '苏女士', 1, '175884800', '17562615447', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-28 23:16:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175884800' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '175881218', '18638010326', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-28 21:18:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175881218' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '段女士', 0, '175856963', '15903616130', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-28 15:10:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175856963' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵女士', 1, '175794001', '15093210767', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-26 20:46:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175794001' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女士', 1, '175698251', '17744612190', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-23 20:15:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175698251' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋', 1, '175670247', '13838108196', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-23 14:27:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175670247' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '解', 1, '175607060', '15515512321', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-21 19:02:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175607060' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白', 1, '175595578', '13838028116', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-21 16:05:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175595578' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '材女士', 0, '175495047', '18336330197', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-18 15:53:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175495047' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '175450172', '18137657592', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-16 23:08:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175450172' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '175448811', '15838223689', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-16 21:53:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175448811' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘思雨', 1, '171269072', '15003886836', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-16 21:48:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171269072' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '169931394', '13938259535', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-14 19:46:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169931394' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '华', 1, '170116117', '13623860750', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-14 18:11:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170116117' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '肖', 1, '171682128', '18937179062', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-09 17:58:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171682128' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吉先生', 0, '175050916', '15838236525', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-08 20:23:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '175050916' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '蒋', 1, '174994727', '18903814477', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-07 15:35:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174994727' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '174975801', '13838338265', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-06 21:33:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174975801' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭先生', 0, '171599671', '13526626257', 0.00, 7, 0, '美管家次卡迁移导入', '2023-10-03 13:04:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171599671' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贺女士', 1, '170194035', '13938528421', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-28 22:35:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170194035' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '范先生', 0, '174639816', '13343831360', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-28 15:05:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174639816' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '174596413', '15617679900', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-27 21:23:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174596413' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马先生', 0, '170367148', '18538020014', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-26 22:51:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170367148' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马', 1, '174491563', '13673373646', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-26 12:11:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174491563' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 1, '169790453', '15136227238', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-24 20:48:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169790453' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 1, '174399399', '18503800495', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-24 13:27:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174399399' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170266168', '15890107203', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-23 18:38:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170266168' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169896352', '13027730072', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-23 16:11:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169896352' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170744033', '13014559768', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-23 16:08:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170744033' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '程', 1, '170033203', '15138489677', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-22 21:01:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170033203' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '174319257', '15639007267', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-22 15:13:46', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174319257' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨先生', 0, '174294401', '13383713881', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-21 21:00:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174294401' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋', 1, '174289314', '13937199249', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-21 19:16:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174289314' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐', 1, '174270376', '18539902848', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-21 11:59:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174270376' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '174270317', '18937621981', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-21 11:57:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174270317' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马女士', 1, '174254988', '13837171114', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-20 23:04:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174254988' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '田', 0, '174249731', '15890697161', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-20 20:30:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174249731' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孟', 1, '174239520', '15838309106', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-20 17:23:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174239520' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '田', 0, '174237532', '13676955503', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-20 16:54:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174237532' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '174078434', '13803830865', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-19 13:46:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '174078434' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '江女士', 1, '169739011', '15638501071', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-18 17:12:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169739011' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王宁', 1, '169796373', '18937137737', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-18 10:19:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169796373' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马女士', 1, '173978845', '17639298811', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-17 18:19:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173978845' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邱', 1, '173931956', '13938500220', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-16 18:35:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173931956' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 0, '169929675', '18695888500', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-16 18:31:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169929675' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '党女士', 1, '172577378', '18037160069', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-16 16:39:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172577378' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女士', 1, '173894132', '18037889899', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-15 20:22:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173894132' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马女士', 1, '173892930', '17639343413', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-15 19:59:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173892930' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '173864074', '18530037912', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-14 22:38:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173864074' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐', 1, '169941452', '13503998687', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-14 21:02:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169941452' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 0, '170040209', '18638677998', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-14 20:27:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170040209' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙女士', 1, '173835339', '18638563337', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-14 00:00:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173835339' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '罗淑梅', 1, '173812009', '13643712837', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-13 19:40:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173812009' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐先生', 0, '173809886', '13723053190', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-13 18:49:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173809886' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 0, '173784768', '13592591892', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-13 13:35:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173784768' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵丽', 1, '173775611', '13523048596', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-12 22:16:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173775611' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周', 1, '173743981', '13803863867', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-12 10:30:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173743981' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张伟', 0, '169812040', '18037465161', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-11 23:59:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169812040' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '荆', 1, '169721230', '13526682861', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-11 23:02:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169721230' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王君', 1, '170071542', '15238031915', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-11 20:08:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170071542' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑', 0, '173723491', '19903711590', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-11 16:59:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173723491' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '关', 1, '173722848', '13508661096', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-11 16:44:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173722848' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '170228429', '13703863224', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-10 18:41:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170228429' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '凌嘉翔', 0, '171289903', '18603853023', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-10 11:31:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171289903' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孟', 0, '173648565', '18539970953', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-09 22:26:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173648565' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169939369', '13938251558', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-09 19:26:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169939369' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑', 0, '173639113', '13938243376', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-09 19:25:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173639113' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女士', 1, '173599161', '15713899953', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-08 22:10:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173599161' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '余先生', 0, '173596396', '13526715150', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-08 21:01:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173596396' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '雷女士', 1, '173596176', '13523422468', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-08 20:59:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173596176' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '隔壁房产', 0, '173587454', '13837108773', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-08 18:50:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173587454' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '170277287', '18937626566', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-08 17:20:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170277287' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '美女', 1, '173583508', '18703676987', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-08 17:18:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173583508' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '经先生', 0, '173583357', '15937160888', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-08 17:14:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173583357' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 0, '173551219', '15638400452', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-07 16:58:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173551219' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '172713062', '18950151312', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-07 10:56:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172713062' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '兰', 1, '173515481', '15093118704', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-06 18:39:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173515481' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭女士', 1, '173465821', '13803815770', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-06 10:20:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173465821' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女士', 1, '173445323', '15938758868', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-05 16:06:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173445323' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '173444045', '13937128142', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-05 15:33:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173444045' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邢', 0, '171350531', '13603415335', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-05 00:00:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171350531' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '魏', 1, '173424406', '18137181005', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-04 19:00:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173424406' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '173389637', '17737712003', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-03 21:04:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173389637' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '169838985', '15038353355', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-03 20:15:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169838985' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周', 0, '173380277', '15515920890', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-03 18:34:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173380277' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '173376072', '15290889610', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-03 17:32:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173376072' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '何女士', 1, '173354095', '13073739125', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-03 14:17:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173354095' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '韦', 1, '173339927', '18503860110', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-02 23:07:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173339927' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杜', 1, '173334657', '13598892166', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-02 20:49:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173334657' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋', 1, '173334545', '13523530936', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-02 20:48:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173334545' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '173245089', '13603848587', 0.00, 7, 0, '美管家次卡迁移导入', '2023-09-01 13:55:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173245089' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '何', 0, '170043644', '13523078550', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-30 12:05:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170043644' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '173105758', '18937623045', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-29 21:41:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173105758' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '173065605', '15981892167', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-29 13:49:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '173065605' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 1, '172996579', '18237857887', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-27 23:51:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172996579' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '172992736', '15836989295', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-27 21:20:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172992736' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '兰', 0, '172992654', '15837516256', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-27 21:18:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172992654' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '沈先生', 0, '172973156', '13525570085', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-27 16:06:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172973156' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋', 1, '172971001', '17638765835', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-27 15:29:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172971001' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '隔壁房产', 0, '172937994', '18538723082', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-26 17:17:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172937994' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '董', 1, '172937865', '13014232688', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-26 17:15:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172937865' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '172907041', '18737164806', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-25 21:51:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172907041' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '林', 0, '172900786', '13253587888', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-25 19:45:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172900786' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '华', 1, '170363201', '13837192526', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-24 22:25:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170363201' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '172820312', '18037155515', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-24 18:15:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172820312' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女士', 1, '172811737', '15937191339', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-24 15:50:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172811737' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹美女', 1, '172795405', '18622637317', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-23 23:04:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172795405' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '172791943', '16799973999', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-23 21:10:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172791943' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '罗', 1, '172789495', '17337199905', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-23 20:20:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172789495' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘先生', 0, '172788525', '18339806011', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-23 20:00:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172788525' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '申', 1, '172738677', '17724828835', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-22 21:27:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172738677' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '172704310', '18660839493', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-21 23:59:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172704310' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '任', 1, '172702233', '15617859948', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-21 21:54:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172702233' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 0, '172702153', '13938555601', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-21 21:52:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172702153' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '172702001', '13938515127', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-21 21:47:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172702001' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 0, '172701854', '13838565595', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-21 21:44:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172701854' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '171107962', '17630009878', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-21 00:00:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171107962' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贾', 1, '172654859', '18638941985', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-20 17:17:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172654859' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '172649128', '13526775589', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-20 15:44:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172649128' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '172648409', '13775493313', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-20 15:31:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172648409' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杭', 0, '172630917', '18037173768', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-19 23:23:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172630917' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭女士', 1, '172629546', '15237111105', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-19 22:12:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172629546' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '楚', 0, '169740994', '15617710915', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-19 21:53:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169740994' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘先生', 0, '172627789', '15303718330', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-19 21:31:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172627789' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '172612131', '15324839298', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-19 16:52:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172612131' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '程女士', 1, '172600174', '18237118488', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-19 13:02:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172600174' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '172587814', '13838072163', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-18 21:28:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172587814' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白', 1, '172585059', '17365984118', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-18 20:35:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172585059' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白', 1, '172584964', '17760735556', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-18 20:34:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172584964' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 1, '172575223', '13598428703', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-18 17:11:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172575223' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169853529', '13663861836', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-18 16:24:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169853529' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '乔先生', 0, '172222487', '15903660077', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-10 20:43:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172222487' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '连女士', 1, '172214923', '13393731556', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-10 17:54:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172214923' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '172212648', '13027511413', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-10 16:59:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172212648' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '景', 0, '172209472', '13938352230', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-10 15:41:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172209472' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白', 1, '172184385', '17611712900', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-09 18:15:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172184385' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '172116254', '15639715400', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-08 21:40:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172116254' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '172088623', '13683808702', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-08 15:48:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172088623' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '172071149', '15517569802', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-07 19:55:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172071149' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孟', 1, '172070337', '15136282018', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-07 19:36:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172070337' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '体验卡男', 0, '172042757', '13681194337', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-06 21:27:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172042757' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '172041861', '13633825797', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-06 21:07:46', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172041861' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冯', 1, '172020436', '13503713343', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-06 14:43:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172020436' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '172020338', '17760745535', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-06 14:41:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172020338' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '乔', 1, '172010817', '13663016752', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-06 10:27:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '172010817' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄', 1, '169871986', '13838232228', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-05 13:54:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169871986' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '171975241', '13271550296', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-05 10:58:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171975241' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '岳', 0, '171938411', '15736796800', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-03 21:39:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171938411' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吕', 0, '171936241', '18503926982', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-03 20:51:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171936241' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吕', 0, '171936179', '13007617927', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-03 20:50:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171936179' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '欧文', 0, '171904696', '15670603112', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-02 22:56:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171904696' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李兆慧', 1, '171896776', '13673620902', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-02 19:39:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171896776' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '美女', 1, '171892571', '13703909120', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-02 18:05:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171892571' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '171888574', '13461572199', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-02 16:32:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171888574' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄', 1, '171874297', '13643867722', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-02 11:48:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171874297' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '171865354', '13783685558', 0.00, 7, 0, '美管家次卡迁移导入', '2023-08-01 20:42:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171865354' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '171815541', '16639795158', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-31 22:35:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171815541' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '程', 1, '170416241', '18603827000', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-30 16:30:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170416241' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '史桂梅', 1, '171733532', '15993716868', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-30 11:19:18', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171733532' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '171721910', '15515962501', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-29 19:41:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171721910' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '171685532', '15093452995', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-28 21:01:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171685532' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '美女', 1, '171685147', '18530086787', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-28 20:52:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171685147' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '秦', 0, '171679683', '13607693890', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-28 18:41:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171679683' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马可', 1, '171679629', '13598863626', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-28 18:40:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171679629' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '171661612', '19913836699', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-27 22:32:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171661612' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '夏', 1, '171657799', '13140100030', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-27 20:40:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171657799' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '袁', 1, '171639903', '18837198331', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-27 15:53:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171639903' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '时', 1, '171618857', '15538016830', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-26 21:55:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171618857' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '171579697', '15225117504', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-25 23:18:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171579697' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '171579685', '13673621322', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-25 23:16:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171579685' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邓', 1, '171576000', '13525530846', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-25 21:01:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171576000' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '房东', 0, '171575799', '15890672392', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-25 20:57:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171575799' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '任女士', 1, '171575185', '18703657303', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-25 20:44:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171575185' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '171544730', '13938505661', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-24 20:46:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171544730' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '171511096', '18237196281', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-23 21:00:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171511096' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '171509204', '18036191608', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-23 20:28:18', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171509204' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '171506260', '15936267153', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-23 19:36:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171506260' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 1, '171470433', '13603868296', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-23 11:46:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171470433' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '171468283', '15136188269', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-23 10:48:18', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171468283' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '程', 1, '171460698', '13663806890', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-22 20:48:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171460698' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '樊', 1, '171453268', '15637268278', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-22 18:51:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171453268' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女生', 1, '171406942', '15515883701', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-21 18:56:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171406942' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '美女', 1, '170594725', '13343859556', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-21 18:22:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170594725' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '171401108', '15353505170', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-21 16:40:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171401108' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '171373894', '18603839814', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-20 18:57:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171373894' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '171372248', '15038327323', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-20 18:18:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171372248' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '171357354', '13838063160', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-20 11:26:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171357354' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱', 0, '171348369', '18539578990', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-19 20:36:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171348369' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 0, '171339613', '15837323235', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-19 17:18:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171339613' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邱', 1, '171339298', '13783655582', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-19 17:10:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171339298' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 0, '171328682', '16650255673', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-19 15:46:46', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171328682' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐', 1, '171328618', '15515577377', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-19 15:45:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171328618' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '崔', 1, '171320945', '15837186268', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-19 12:26:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171320945' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '职', 1, '171315409', '13592505722', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-18 22:51:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171315409' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '文', 1, '171312095', '13333833558', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-18 21:11:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171312095' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '171289954', '13526852933', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-18 12:35:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171289954' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张华', 0, '171288627', '13903943867', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-18 12:06:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171288627' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '171288547', '15539121945', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-18 12:04:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171288547' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '171269235', '13783456928', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-17 22:09:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171269235' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '闫', 1, '171266109', '13140099722', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-17 20:49:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171266109' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 1, '170000197', '18539288975', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-17 20:47:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170000197' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '170000308', '13526654373', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-17 20:45:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170000308' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张勇', 0, '171265270', '13633933363', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-17 20:30:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171265270' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹水林', 0, '171306277', '18037103871', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-17 00:00:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171306277' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '171232580', '15981910519', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-16 21:34:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171232580' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '侯', 0, '171232208', '15036036462', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-16 21:26:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171232208' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '先生', 0, '171227754', '13603862602', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-16 20:09:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171227754' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '171170685', '13772343038', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-15 21:31:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171170685' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐', 1, '171162363', '13513800990', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-15 19:07:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171162363' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '171134151', '18637163920', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-14 22:35:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171134151' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '索', 1, '171116216', '13083662213', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-14 18:34:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171116216' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨先生', 0, '169709083', '18638637160', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-14 18:32:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169709083' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马女士', 1, '171114344', '18203664009', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-14 17:52:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171114344' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '171093488', '18539277201', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 21:35:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171093488' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '姚', 1, '171093436', '15225125422', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 21:34:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171093436' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '171093282', '13643808248', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 21:30:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171093282' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '沈', 0, '171093177', '18937654083', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 21:28:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171093177' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '龚', 1, '171089212', '13253570267', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 20:04:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171089212' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '171086520', '13838002395', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 19:06:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171086520' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '171079294', '15824865868', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 16:33:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171079294' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '魏', 0, '171079236', '15517153259', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 16:31:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171079236' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '171077315', '16637125308', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 15:49:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171077315' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '沈', 1, '171076965', '15981889768', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 15:39:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171076965' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '栗', 1, '171063177', '15515715806', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-13 11:04:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171063177' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李芳', 1, '171060546', '18638153717', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-12 23:02:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171060546' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '芦', 1, '169850121', '13213012009', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-12 20:21:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169850121' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '姚', 0, '171044629', '13353808191', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-12 16:26:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171044629' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 0, '171032441', '19937131213', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-11 23:18:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171032441' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '171026257', '13608691017', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-11 20:54:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171026257' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '171017795', '13949403046', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-11 17:41:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171017795' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '170042724', '15038059020', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-11 11:07:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170042724' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡', 0, '170979831', '15003805885', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-10 22:19:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170979831' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '范', 1, '170925527', '15890157197', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-09 21:53:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170925527' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '170925140', '13530321950', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-09 21:45:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170925140' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '169875331', '13703701703', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-09 14:58:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169875331' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '闫', 0, '170887830', '13613714099', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-08 22:30:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170887830' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '丁女士', 1, '170850204', '13783495827', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-08 13:23:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170850204' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 0, '171013930', '17729751886', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-08 00:00:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '171013930' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '170833629', '15343828444', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-07 22:27:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170833629' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙琳', 1, '170818392', '18638282611', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-07 16:56:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170818392' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋', 1, '170805825', '13849196833', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-07 15:01:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170805825' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '170805174', '17335767831', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-07 14:45:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170805174' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '170798629', '13343859557', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-07 11:28:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170798629' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170793413', '18003819008', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-06 22:37:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170793413' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '170792813', '18736025522', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-06 22:12:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170792813' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵一红', 0, '170787328', '15515701618', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-06 20:14:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170787328' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '170784557', '13213142236', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-06 19:16:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170784557' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '余', 1, '170777057', '13838011444', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-06 16:31:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170777057' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '秦', 1, '170745336', '13849191198', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-05 21:39:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170745336' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '龚姐', 1, '169933539', '13633855731', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-05 18:26:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169933539' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '170733719', '13526672010', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-05 17:43:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170733719' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '耿', 0, '170731708', '13073779887', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-05 16:56:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170731708' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 0, '170730016', '15617851996', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-05 16:13:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170730016' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '170698680', '13569922811', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-04 20:51:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170698680' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋女士', 1, '170676501', '18037099590', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-04 17:21:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170676501' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '170658132', '15003999061', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-03 23:33:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170658132' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 0, '170658116', '15538358388', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-03 23:31:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170658116' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 1, '170277967', '13083712996', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-03 22:59:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170277967' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周', 1, '170656692', '15617565956', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-03 22:12:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170656692' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170656651', '13017679389', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-03 22:10:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170656651' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '170655232', '13503814589', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-03 21:28:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170655232' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡', 1, '169934089', '15514568766', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-03 15:59:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169934089' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '于先生', 0, '170633051', '13253462886', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-03 15:49:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170633051' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贾女士', 1, '170630093', '15039378301', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-03 14:30:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170630093' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '170606089', '13838109899', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 21:34:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170606089' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '170605013', '18939262988', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 21:10:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170605013' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '170604901', '13838075998', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 21:08:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170604901' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170598756', '15286847700', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 19:21:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170598756' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '甜橙', 1, '170597199', '13071080123', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 18:52:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170597199' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '岳', 1, '170596284', '13213105886', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 18:35:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170596284' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄', 1, '170594504', '18039234300', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 18:04:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170594504' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '段', 1, '170594378', '13598805244', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 18:02:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170594378' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '170578664', '13073751704', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 13:40:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170578664' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 0, '170574219', '15537107796', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 11:42:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170574219' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '薛', 1, '170574145', '15515630591', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-02 11:40:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170574145' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 0, '170568564', '15136268561', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-01 22:37:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170568564' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 0, '170567979', '13837193186', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-01 22:15:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170567979' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170567876', '18920820923', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-01 22:13:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170567876' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '169958304', '15538183532', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-01 21:38:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169958304' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 0, '170561557', '13303812653', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-01 20:10:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170561557' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '史', 1, '170530390', '13633809591', 0.00, 7, 0, '美管家次卡迁移导入', '2023-07-01 12:04:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170530390' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冯', 1, '170503227', '15603711780', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-30 21:56:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170503227' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170501917', '13303828290', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-30 21:28:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170501917' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋', 1, '169858344', '15803880972', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-30 15:29:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169858344' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '梧桐雨', 1, '170450622', '13937181105', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-30 14:20:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170450622' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170450548', '15938754599', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-30 14:18:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170450548' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170405448', '13213070219', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-29 20:38:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170405448' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170429867', '13607664032', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-29 20:06:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170429867' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '樊', 0, '170422689', '13629847598', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-29 17:56:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170422689' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 0, '170421636', '15333866619', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-29 17:40:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170421636' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邱', 1, '170418912', '13837129663', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-29 17:11:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170418912' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170418830', '15037192101', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-29 17:09:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170418830' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘先生', 0, '170418713', '18039970826', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-29 17:08:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170418713' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '170416676', '18736018051', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-29 16:19:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170416676' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '季', 0, '170416603', '18736033570', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-29 16:17:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170416603' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 0, '170400009', '13508062550', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-28 22:13:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170400009' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '170399822', '18638911285', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-28 22:07:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170399822' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '安', 1, '170390507', '13027783399', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-28 18:40:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170390507' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑', 1, '170390394', '18538703111', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-28 18:38:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170390394' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杜', 0, '170385235', '13733836183', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-28 16:36:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170385235' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 0, '170382814', '17719815562', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-28 15:38:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170382814' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170378898', '15514371965', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-28 13:47:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170378898' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孟', 1, '169945376', '17630036840', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-27 22:55:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169945376' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '佟', 0, '170366168', '19397945912', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-27 22:30:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170366168' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '佟', 0, '170366089', '18345010105', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-27 22:25:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170366089' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冯', 1, '170366037', '13783466100', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-27 22:23:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170366037' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周', 0, '170364876', '15538136653', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-27 21:45:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170364876' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '170362254', '13733858396', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-27 20:47:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170362254' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170326203', '13403713293', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-27 11:04:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170326203' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常', 0, '170323726', '13460338911', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 23:13:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170323726' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曲', 1, '170322994', '15238007770', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 22:29:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170322994' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贺', 1, '170322353', '15890624713', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 22:05:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170322353' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170317474', '15515577897', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 20:11:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170317474' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '董', 0, '170316434', '13603828109', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 19:48:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170316434' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙-彭世', 0, '170316266', '15839201788', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 19:45:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170316266' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '化丽芳', 1, '170309279', '13837117281', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 18:33:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170309279' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170309219', '15996776037', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 18:31:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170309219' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱', 0, '170305659', '13523416345', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 17:02:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170305659' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 0, '170305591', '13592495909', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 17:00:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170305591' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170305420', '15617895677', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 16:56:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170305420' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常', 1, '170305333', '18503816166', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 16:54:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170305333' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贾', 1, '170305221', '15238798625', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-26 16:52:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170305221' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冯', 0, '170277347', '18838155708', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 22:12:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170277347' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '170270081', '13838161658', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 20:29:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170270081' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '170269943', '13523049592', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 20:27:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170269943' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '井', 0, '170269309', '15136121393', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 20:13:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170269309' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '170265979', '19937804689', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 19:03:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170265979' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '索', 1, '170265899', '13526693449', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 19:02:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170265899' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '秦', 1, '170265287', '15603715081', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 18:48:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170265287' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 0, '170264989', '15290803406', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 18:41:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170264989' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '170262617', '18137274993', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 17:57:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170262617' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169833452', '13803716131', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 17:39:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169833452' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常', 0, '170261734', '18937655539', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 17:37:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170261734' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '蕾', 1, '170243319', '13643807007', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 15:32:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170243319' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170239296', '15286822801', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 13:46:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170239296' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170238390', '15038245655', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 13:22:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170238390' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 0, '170238298', '13523008039', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 13:20:18', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170238298' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '樊女士', 1, '170236246', '13613813562', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 12:11:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170236246' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '170235473', '18137866068', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 11:44:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170235473' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '蒋', 0, '170235433', '18539918111', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-25 11:42:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170235433' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴', 0, '170230919', '13849466111', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 22:23:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170230919' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴', 1, '170230881', '13663859199', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 22:22:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170230881' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '170230841', '18390759636', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 22:20:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170230841' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '唐', 1, '170230778', '17374375912', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 22:18:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170230778' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '粱', 1, '170228511', '13783623086', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 21:17:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170228511' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑', 1, '170222077', '13203809086', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 19:10:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170222077' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '卢', 0, '170221986', '18839779276', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 19:08:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170221986' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李姐', 1, '170219879', '13673683531', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 18:27:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170219879' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '170219776', '13043022922', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 18:25:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170219776' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170215907', '13525536084', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 17:25:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170215907' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '连女士', 1, '170211012', '13027721220', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 15:48:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170211012' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高先生', 0, '170210862', '13838047047', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 15:45:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170210862' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱', 1, '170204518', '13683713500', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 13:22:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170204518' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱', 1, '170204452', '13937123992', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 13:20:57', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170204452' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '龚', 0, '170204395', '18239955689', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 13:19:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170204395' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱', 1, '170204346', '13783405600', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 13:17:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170204346' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '沙', 0, '170202073', '13838523615', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-24 12:14:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170202073' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170195955', '18838999402', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 22:27:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170195955' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '余', 1, '170194736', '18239953667', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 21:47:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170194736' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹', 1, '170194683', '17343000065', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 21:45:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170194683' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨先生', 0, '170193910', '13949313878', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 21:28:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170193910' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170191385', '13674955817', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 20:35:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170191385' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170187883', '15538360633', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 19:21:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170187883' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '170187735', '17622671071', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 19:18:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170187735' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '170187652', '13820696461', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 19:16:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170187652' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '尚', 0, '170184339', '15093051977', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 18:10:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170184339' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170182469', '13526794850', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 17:35:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170182469' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170181423', '13783596996', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 17:15:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170181423' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '170178107', '18039218787', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 16:11:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170178107' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '程', 0, '170166229', '13298322296', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 15:38:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170166229' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '齐', 1, '170166086', '18703807178', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-23 15:35:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170166086' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170151373', '13607662740', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 23:02:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170151373' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马', 1, '170151044', '15890162806', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 22:37:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170151044' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马', 1, '170151023', '13937196087', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 22:36:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170151023' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '170150603', '13733822127', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 22:14:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170150603' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '金', 1, '170150478', '13703713918', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 22:07:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170150478' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '170145432', '18037108196', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 19:35:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170145432' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '林', 0, '169812224', '13383822319', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 19:33:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169812224' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '170142181', '15517535002', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 18:11:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170142181' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '170131319', '13676926700', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 14:11:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170131319' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陶先生', 0, '170127320', '13203883414', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 12:15:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170127320' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '170127030', '15003855195', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 12:05:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170127030' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '170126943', '13007601900', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-22 12:03:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170126943' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '170121211', '15188317600', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-21 22:31:18', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170121211' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '170121013', '17796668052', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-21 22:27:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170121013' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '170120983', '15236116817', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-21 22:22:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170120983' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170118516', '18439887806', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-21 21:20:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170118516' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '170113070', '13253441395', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-21 19:29:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170113070' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '170112986', '18614951334', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-21 19:28:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170112986' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡', 1, '170105805', '13623807308', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-21 16:42:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170105805' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王双凤', 1, '170100761', '13393731132', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-21 14:53:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170100761' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '170081851', '18339723972', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 22:54:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170081851' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '170079929', '13460593381', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 21:44:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170079929' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '170079854', '13663806800', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 21:42:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170079854' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '170079782', '13643813106', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 21:41:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170079782' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '170079416', '13673638863', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 21:32:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170079416' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '170079286', '18037456441', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 21:30:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170079286' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '罗', 1, '170077955', '18803970533', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 21:00:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170077955' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '路', 0, '170077873', '13849177765', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 20:59:02', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170077873' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孟', 0, '170075578', '15136468837', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 20:12:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170075578' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '170075501', '13703821852', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 20:10:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170075501' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女士', 1, '170075381', '13837159903', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 20:09:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170075381' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170075278', '13683801486', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 20:06:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170075278' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '170071656', '13223023928', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 18:48:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170071656' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '170069934', '13903826828', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 18:09:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170069934' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '辛', 1, '170068764', '15890600200', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 17:51:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170068764' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '仲', 1, '170068696', '15038036188', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 17:49:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170068696' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 0, '170064543', '13503739886', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 16:28:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170064543' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170058170', '13015506267', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 14:25:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170058170' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '程', 1, '170057787', '13598879540', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 14:13:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170057787' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '程', 1, '170052326', '18530830877', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 13:18:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170052326' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '170041996', '15738375370', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-20 10:34:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170041996' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邵', 0, '170040219', '19031974235', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 23:37:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170040219' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '钟', 0, '170040185', '13592516153', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 23:34:02', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170040185' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '申', 1, '170039931', '15838306159', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 23:12:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170039931' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄', 0, '170039908', '18236961853', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 23:10:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170039908' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冯', 1, '170039892', '13653861123', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 23:08:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170039892' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴', 0, '170039226', '18638015769', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 22:29:14', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170039226' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '董', 1, '170036447', '17337192272', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 21:11:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170036447' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '粱', 1, '170033285', '18739909434', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 20:03:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170033285' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴', 1, '170033110', '15515812432', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 19:59:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170033110' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170033018', '18749231610', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 19:57:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170033018' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '170029656', '13513801071', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 18:41:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170029656' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '彭', 0, '170026232', '13937189966', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 17:40:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170026232' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 0, '170026085', '15837175717', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 17:37:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170026085' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马', 1, '170025145', '15639269686', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 17:14:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170025145' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '170024297', '13523077783', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 16:54:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170024297' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '闫', 1, '170019242', '15136215719', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 14:59:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170019242' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '170019124', '13700886620', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 14:57:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170019124' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '170007968', '18937153488', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 11:38:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170007968' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑', 0, '170007908', '13653977806', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 11:36:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170007908' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '任女士', 1, '170005190', '15286811864', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 10:39:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170005190' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨洋', 1, '170005127', '16696232119', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 10:36:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170005127' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马', 1, '170085141', '13183014181', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-19 00:00:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170085141' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '洪', 0, '170002848', '17737196369', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 23:01:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170002848' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '余', 0, '170002796', '13235302332', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 22:59:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170002796' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 0, '170001708', '13393718340', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 22:58:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170001708' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '170001601', '13838213805', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 22:12:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '170001601' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '崔女士', 1, '169995203', '13783687832', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 21:58:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169995203' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 1, '169996764', '13733167487', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 20:36:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169996764' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '169994419', '17729775567', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 19:56:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169994419' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '汪', 0, '169994217', '13629845679', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 19:53:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169994217' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡', 0, '169991616', '13803840268', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 19:08:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169991616' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王先生', 0, '169990941', '17837134397', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 18:56:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169990941' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '无名', 1, '169985360', '15003990583', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 18:31:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169985360' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169980641', '15837121596', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 17:34:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169980641' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169980506', '13526591258', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 17:32:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169980506' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169979666', '13838250857', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 17:18:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169979666' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '将', 1, '169979279', '18039667251', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 17:12:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169979279' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '鲍先生', 0, '169965423', '15188399986', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 14:47:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169965423' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女士', 1, '169965107', '13607673779', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 14:41:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169965107' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169963955', '13525525991', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 14:19:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169963955' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '侯', 0, '169963817', '15393707929', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 14:16:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169963817' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169963507', '13598317639', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 14:11:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169963507' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 0, '169958766', '13643856983', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 13:26:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169958766' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白宏勋', 0, '169954119', '13545970828', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 11:37:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169954119' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169953370', '16603993821', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 11:12:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169953370' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '169953207', '13700886778', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 11:09:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169953207' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '169951834', '13676968977', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-18 10:31:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169951834' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169949998', '18239950668', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 23:53:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169949998' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李先生', 0, '169949917', '13271580366', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 23:43:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169949917' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱', 0, '169946716', '13333338603', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 21:35:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169946716' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贺', 0, '169942891', '15036005220', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 20:25:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169942891' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '169941986', '13592588995', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 20:09:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169941986' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑', 0, '169939501', '18039291369', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 19:24:02', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169939501' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '魏', 0, '169938310', '15981911711', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 19:02:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169938310' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '韩', 1, '169936953', '13707627697', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 18:36:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169936953' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '苏', 0, '169936854', '15515730223', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 18:35:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169936854' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陶', 1, '169936748', '15978897703', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 18:33:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169936748' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169934656', '13592414162', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 17:55:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169934656' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 1, '169934238', '18538194344', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 17:47:46', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169934238' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169933968', '13140061731', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 17:43:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169933968' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '范', 1, '169933164', '13838073639', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 17:29:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169933164' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曲女士', 1, '169929419', '18638071593', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 16:25:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169929419' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '向', 0, '169929209', '15538273705', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 16:22:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169929209' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '169928961', '13569597689', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 16:16:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169928961' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '韩', 1, '169914005', '15238315120', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 14:56:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169914005' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '柠檬', 0, '169910867', '18695866808', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 13:50:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169910867' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '夏', 0, '169904750', '15538138320', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 11:25:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169904750' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169904556', '15938750156', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 11:23:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169904556' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '169904477', '13526833006', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-17 11:18:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169904477' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '付', 0, '169901004', '13733186803', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 23:42:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169901004' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '肖', 0, '169900365', '13598827989', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 22:50:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169900365' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '无', 0, '169899216', '13460228020', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 22:03:30', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169899216' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169899136', '18639550881', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 22:01:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169899136' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '169899085', '15936214021', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 21:59:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169899085' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '闫', 0, '169899018', '16696117739', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 21:57:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169899018' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '169898264', '15517151517', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 21:40:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169898264' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '景', 0, '169896543', '13673355935', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 21:01:46', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169896543' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 0, '169896482', '15003801943', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 21:00:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169896482' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '169893659', '17838306997', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 20:02:55', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169893659' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '169893578', '17788135598', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 20:01:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169893578' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邱', 0, '169889525', '13183003122', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 18:27:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169889525' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冯', 1, '169889440', '13525574610', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 18:26:08', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169889440' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '先生', 0, '169887451', '18657505833', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 17:41:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169887451' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169884264', '15090081515', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 16:28:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169884264' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '金', 0, '169883281', '15517555800', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 16:07:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169883281' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '金', 1, '169883208', '15517555900', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 16:05:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169883208' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '谷女士', 1, '169882136', '15639718386', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 15:40:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169882136' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169878700', '13803829713', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 14:22:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169878700' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169875427', '18503896970', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 13:46:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169875427' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169872080', '13653835673', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-16 12:11:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169872080' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常', 0, '169866091', '15038197191', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 22:38:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169866091' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常', 0, '169866049', '13603456821', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 22:36:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169866049' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169866007', '18703607805', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 22:35:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169866007' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邢', 1, '169865849', '13838221966', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 22:29:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169865849' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '169861308', '18211605381', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 20:46:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169861308' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '袁', 0, '169860556', '13203717055', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 20:33:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169860556' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '169859392', '15903605896', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 20:12:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169859392' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '169858817', '17638560759', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 20:02:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169858817' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169858666', '13277102462', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 20:00:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169858666' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '169858486', '15093487897', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 19:57:02', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169858486' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '169853354', '13526577916', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 18:06:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169853354' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169853254', '13523063472', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 18:04:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169853254' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169850361', '18539407920', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 16:52:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169850361' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169850261', '13592421892', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 16:49:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169850261' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '美羊羊', 1, '169840739', '18638197292', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 16:11:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169840739' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '英', 1, '169840627', '13949077648', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 16:09:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169840627' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常', 1, '169840502', '13598075161', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 16:06:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169840502' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '单', 1, '169839146', '13513806666', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 15:54:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169839146' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 0, '169833336', '18903715618', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 14:32:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169833336' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169827525', '13598869076', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 13:25:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169827525' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '樊', 1, '169827455', '15225683747', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 13:22:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169827455' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '169827339', '18530923938', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 13:19:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169827339' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 1, '169827292', '18137170567', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 13:17:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169827292' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱', 0, '169827227', '13503860607', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 13:15:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169827227' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169827167', '15837162887', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 13:14:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169827167' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王先生', 0, '169818914', '13073705126', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-15 12:19:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169818914' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陶', 0, '169814182', '18739919007', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 23:41:40', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169814182' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '169814170', '13140012336', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 23:39:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169814170' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169813954', '15515772600', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 23:15:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169813954' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169813895', '15939296250', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 23:10:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169813895' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '袁', 1, '169813878', '15890657879', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 23:08:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169813878' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169813850', '13526659391', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 23:07:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169813850' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '169813819', '15638198258', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 23:05:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169813819' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '169813801', '13503844152', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 23:04:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169813801' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 0, '169812324', '13938233064', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 21:58:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169812324' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈', 0, '169811981', '13383868377', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 21:47:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169811981' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169811831', '13937177310', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 21:44:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169811831' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169811722', '13523460617', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 21:42:02', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169811722' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 0, '169811614', '15303836111', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 21:38:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169811614' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '169811557', '13592167376', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 21:36:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169811557' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169809327', '13839538002', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 20:44:59', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169809327' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169809205', '13633830400', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 20:42:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169809205' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '169807868', '13526543770', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 20:12:35', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169807868' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169807752', '18638033100', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 20:10:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169807752' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '169806369', '15237507889', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 19:41:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169806369' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杜', 0, '169806305', '15838347110', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 19:39:19', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169806305' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '169806226', '13838517515', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 19:37:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169806226' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 0, '169805681', '15981863925', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 19:24:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169805681' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱', 1, '169805600', '15803834325', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 19:22:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169805600' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 0, '169798662', '14788888538', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 16:28:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169798662' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '桂', 1, '169798589', '15981878251', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 16:26:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169798589' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '万', 1, '169795641', '13526024009', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 15:07:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169795641' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '沈', 1, '169794744', '13383822796', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 14:43:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169794744' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '严', 1, '169793599', '13393902808', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 14:09:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169793599' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169793529', '13939088544', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 14:07:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169793529' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169790293', '13676992258', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 12:25:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169790293' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡', 1, '169790215', '18749452606', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 12:22:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169790215' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '祁', 1, '169790169', '13373950908', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-14 12:20:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169790169' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169785410', '13613867646', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 23:19:22', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169785410' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169784991', '13949485308', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 22:42:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169784991' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '许', 1, '169784701', '18039667281', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 22:25:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169784701' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '景', 1, '169784668', '18737165357', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 22:23:09', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169784668' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '乔', 1, '169783228', '18860365910', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 21:32:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169783228' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郎', 0, '169783039', '18737178605', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 21:27:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169783039' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '169782852', '18838940262', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 21:21:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169782852' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169782791', '13700887493', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 21:20:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169782791' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '左', 1, '169782720', '17539565802', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 21:18:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169782720' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白', 1, '169782649', '17739788812', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 21:16:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169782649' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '尚先生', 0, '169782579', '15649060116', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 21:14:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169782579' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169782508', '13607666539', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 21:13:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169782508' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169780863', '13598089676', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 20:34:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169780863' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169780758', '15639904746', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 20:32:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169780758' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169780678', '17719944162', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 20:30:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169780678' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169778768', '15138957805', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 19:46:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169778768' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '丁', 1, '169778696', '13526438815', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 19:45:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169778696' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169773115', '18737463321', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 17:50:42', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169773115' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨', 1, '169771921', '15738822093', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 17:21:18', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169771921' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孟', 0, '169770271', '13838290538', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 16:38:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169770271' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '梅', 1, '169770211', '15036237199', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 16:36:54', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169770211' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169770140', '13938984418', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 16:35:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169770140' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '粱', 1, '169769935', '18569931872', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 16:30:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169769935' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 0, '169765803', '15136170397', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 14:46:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169765803' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169765643', '13598091870', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 14:41:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169765643' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王先生', 0, '169765442', '13126790773', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 14:34:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169765442' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭女士', 1, '169765334', '13513807672', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 14:32:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169765334' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马', 1, '169758965', '18240718440', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 11:10:47', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169758965' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙', 1, '169758911', '15538213715', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 11:08:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169758911' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡', 1, '169758705', '17093783333', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-13 11:01:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169758705' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '万女士', 1, '169755766', '18937623043', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 22:55:25', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169755766' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '169755350', '13838070684', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 22:31:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169755350' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169754221', '19913850196', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:49:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169754221' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169754161', '13271582829', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:47:44', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169754161' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '169754082', '18037381669', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:45:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169754082' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169753705', '18738195814', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:37:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169753705' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 0, '169753586', '15803886816', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:33:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169753586' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张刚', 1, '169753449', '13838348187', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:30:13', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169753449' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '丁', 1, '169753307', '17630574101', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:26:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169753307' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169753137', '18538942050', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:22:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169753137' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169753013', '13623712371', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:19:28', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169753013' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡', 1, '169752833', '15515828111', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 21:15:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169752833' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '史', 1, '169749919', '15138953921', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 20:12:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169749919' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '169748973', '18625666883', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 19:53:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169748973' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘先生', 0, '169748347', '13721650601', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 19:38:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169748347' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169746255', '13140067857', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 18:49:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169746255' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169745731', '13406712309', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 18:35:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169745731' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王', 1, '169745659', '15003858463', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 18:33:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169745659' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '169745553', '15237195530', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 18:30:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169745553' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈先生', 0, '169743343', '13782763180', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 17:32:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169743343' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白先生', 0, '169743263', '13782627109', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 17:31:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169743263' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 0, '169743067', '18939515231', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 17:26:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169743067' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常', 1, '169742978', '15036092966', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 17:24:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169742978' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨女士', 1, '169742891', '17746964010', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 17:22:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169742891' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '顾', 0, '169742685', '15619358353', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 17:17:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169742685' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 1, '169741109', '17303711020', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 16:39:50', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169741109' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王芳', 1, '169740920', '15936261656', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 16:34:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169740920' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王涛', 0, '169740711', '15537151688', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 16:30:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169740711' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '和', 1, '169739811', '13633816270', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 16:07:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169739811' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘先生', 0, '169739669', '13938567656', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 16:04:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169739669' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '卢', 1, '169739615', '17637109601', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 16:03:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169739615' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '左国岭', 0, '169739440', '13939027727', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 15:58:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169739440' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨先生', 0, '169739325', '13594736599', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 15:54:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169739325' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '侯', 0, '169739243', '13403899880', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 15:52:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169739243' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '罗先生', 0, '169739128', '18323001380', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-12 15:50:31', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169739128' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋女士', 1, '169721266', '18337179972', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:59:58', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169721266' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋女士', 1, '169721196', '13700853543', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:55:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169721196' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 0, '169721145', '13598028780', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:53:45', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169721145' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '史女生', 1, '169721104', '18639167874', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:51:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169721104' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '田先生', 0, '169721057', '18639167974', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:49:34', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169721057' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白女士', 1, '169720732', '13674993938', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:36:33', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169720732' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵先生', 1, '169720683', '13592360116', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:34:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169720683' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169720635', '15188305277', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:32:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169720635' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '芦女生', 1, '169720582', '15188516899', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:30:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169720582' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙女生', 1, '169720522', '13253517613', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:28:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169720522' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙姐', 1, '169720453', '13783474113', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:25:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169720453' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵先生', 0, '169720331', '18272576518', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 22:20:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169720331' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张元', 1, '169718556', '18538281587', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 21:37:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169718556' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱华', 0, '169718454', '13939035287', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 21:35:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169718454' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '石先生', 0, '169718303', '13949088003', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 21:32:10', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169718303' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭先生', 0, '169717879', '13523492223', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 21:23:32', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169717879' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘女士', 1, '169717791', '13608433790', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 21:21:12', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169717791' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '仝', 0, '169717679', '17752505583', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 21:19:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169717679' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑先生', 0, '169715088', '15136231248', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 20:35:52', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169715088' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '袁女士', 1, '169714948', '13253673651', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 20:32:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169714948' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '岺威', 0, '169714551', '15225100857', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 20:25:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169714551' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '蓝女士', 1, '169714232', '15838227072', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 20:20:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169714232' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '赵', 1, '169714053', '13673715476', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 20:17:15', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169714053' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高', 0, '169713750', '13673711945', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 20:12:05', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169713750' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭', 1, '169708334', '13503813255', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 18:42:24', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169708334' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '连先生', 0, '169708171', '13393738483', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 18:39:20', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169708171' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白女生', 1, '169707944', '15138915728', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 18:35:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169707944' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋女生', 1, '169707789', '15043022879', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 18:33:36', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169707789' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '党女生', 1, '169707616', '15890139852', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 18:30:29', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169707616' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马先生', 1, '169707471', '15690886598', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 18:28:00', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169707471' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周先生', 0, '169705505', '00000000000', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 17:55:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169705505' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '耿天增', 0, '169704772', '15517156621', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 17:44:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169704772' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169704582', '13333986310', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 17:41:41', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169704582' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨女士', 1, '169704463', '13937169063', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 17:39:37', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169704463' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄女生', 1, '169704317', '16696102040', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 17:37:11', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169704317' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169704176', '13783479893', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 17:34:53', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169704176' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女生', 0, '169704046', '15638833397', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 17:32:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169704046' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王先生', 0, '169695483', '13643835056', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 15:39:23', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169695483' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '芳女生', 1, '169695248', '17739773206', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 15:36:51', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169695248' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 0, '169694721', '15038389105', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 15:26:06', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169694721' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹', 1, '169694505', '13253384998', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 15:23:21', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169694505' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王先生', 0, '169694344', '15039061918', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 15:19:43', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169694344' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘先生', 0, '169694082', '15003940281', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 15:15:48', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169694082' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙先生', 0, '169693130', '18137171588', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 14:58:01', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169693130' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邢女士', 0, '169692656', '13253618729', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 14:50:16', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169692656' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陆女生', 1, '169692230', '15517505061', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 14:41:17', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169692230' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张', 1, '169690148', '13653975573', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 13:59:56', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169690148' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陆先生', 0, '169687386', '15093353979', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 13:01:49', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169687386' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '时先生', 0, '169682268', '13849043827', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 12:32:38', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169682268' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐先生', 0, '169682162', '15003810317', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 12:29:27', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169682162' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡阿姨', 1, '169682039', '19139777789', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 12:26:07', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169682039' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 0, '169678823', '13619849095', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 11:28:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169678823' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李', 1, '169679125', '13721416619', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 11:16:39', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169679125' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '耿先生', 0, '169678516', '13598001350', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 11:01:04', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169678516' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王叔', 0, '169678002', '13598524766', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 10:56:26', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169678002' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李阿姨', 1, '169677771', '13849528107', 0.00, 7, 0, '美管家次卡迁移导入', '2023-06-11 10:42:03', NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '169677771' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '史利霞', 1, '184808941', '15138953921', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808941' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王玉玲', 1, '184808942', '13526601116', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808942' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王艳丽', 1, '184808943', '18530071994', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808943' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '符湘萍', 1, '184808945', '18625581116', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808945' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王玉', 1, '184808946', '13613802882', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808946' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘全玉', 1, '184808947', '15981902126', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808947' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑艳丽', 1, '184808948', '15738502374', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808948' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杜轶', 1, '184808949', '13603990607', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808949' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹红', 1, '184808950', '15238377329', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808950' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '常永斌', 1, '184808951', '13103710011', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808951' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贾萌萌', 1, '184808952', '13939055901', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808952' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '樊女士', 1, '184808953', '18638548661', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808953' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨合生', 1, '184808954', '13603863355', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808954' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹华清', 1, '184808955', '13203733815', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808955' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴小哈', 1, '184808956', '15188375269', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808956' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白冠一', 1, '184808957', '13608686660', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808957' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马家辉', 1, '184808958', '18703657744', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808958' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '石涛', 1, '184808959', '15238387637', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808959' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生', 1, '184808960', '15038395666', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808960' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张庆阳', 1, '184808961', '15138681290', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808961' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄津', 1, '184808962', '13783408979', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808962' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冯军涛', 1, '184808963', '13937173501', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808963' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '段宗超', 1, '184808964', '15515700088', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808964' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '何女士', 1, '184808965', '13700847106', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808965' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹璐', 1, '184808966', '13838572828', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808966' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '+郭桂敏', 1, '184808967', '18538741959', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808967' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张玉凤', 1, '184808970', '13673391012', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808970' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨永', 1, '184808971', '18337173660', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808971' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王合金', 1, '184808972', '13803911229', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808972' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈钇辛', 1, '184808973', '16603871777', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808973' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴新生', 1, '184808974', '18638015769', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808974' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李鹏飞', 1, '184808977', '18337101697', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808977' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '殷女士', 1, '184808978', '13803716292', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808978' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑现华', 1, '184808979', '13838134935', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808979' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王明霞', 1, '184808980', '15890107203', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808980' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '慕承霖', 1, '184808981', '15690886113', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808981' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '党春菊', 1, '184808984', '15890139852', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808984' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘景周', 1, '184808986', '15837138840', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808986' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '冀豫', 1, '184808987', '13526862887', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808987' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张金红', 1, '184808988', '13683805105', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808988' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '裴老师', 1, '184808989', '15237105162', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808989' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王新华', 1, '184808990', '15038010201', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808990' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭小清', 1, '184808991', '15136425200', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808991' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '翟华伟', 1, '184808993', '13938555456', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808993' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '崔莉婉', 1, '184808994', '15838323390', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808994' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '丁在忠', 1, '184808995', '13233869158', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808995' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '季女士', 1, '184808996', '13592665836', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808996' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周璐璐', 1, '184808998', '18937729707', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808998' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '白金贵', 1, '184808999', '13683839705', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184808999' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨想', 1, '184809000', '13569290223', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809000' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '翟玉', 1, '184809001', '15838310148', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809001' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郝双红', 1, '184809002', '15639070400', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809002' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '崔翔', 1, '184809003', '18003716999', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809003' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '连雪', 1, '184809004', '15803879989', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809004' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '范女士', 1, '184809005', '13674985677', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809005' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女士', 1, '184809006', '13643836430', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809006' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王莹', 1, '184809008', '17320116680', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809008' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张秋芬', 1, '184809009', '13592606016', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809009' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李艳梅', 1, '184809010', '13673623435', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809010' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郑敏', 1, '184809011', '13939319915', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809011' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '于先哲', 1, '184809012', '18203996209', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809012' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张福利', 1, '184809013', '13949027868', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809013' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王倩玲', 1, '184809014', '13838026204', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809014' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马可', 1, '184809015', '13607693890', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809015' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '蒋云', 1, '184809016', '15638178321', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809016' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '熊远成', 1, '184809017', '19138013208', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809017' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周瑞杰', 1, '184809018', '13959271761', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809018' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '姚汝明', 1, '184809019', '13526639626', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809019' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈爱华', 1, '184809020', '15237701434', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809020' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴宝花', 1, '184809021', '18638165984', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809021' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '彭辉', 1, '184809022', '15138969712', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809022' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '高慧兰', 1, '184809024', '13938615237', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809024' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张书琴', 1, '184809025', '19337161618', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809025' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李玉芝', 1, '184809026', '13592598058', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809026' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '99张西', 1, '184809027', '13007602038', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809027' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李女士', 1, '184809028', '13673001431', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809028' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吕先生', 1, '184809029', '18336010223', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809029' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '宋女士', 1, '184809030', '15738317775', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809030' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '062李女士', 1, '184809031', '13383822319', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809031' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李菊兰', 1, '184809032', '15291955292', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809032' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李志云', 1, '184809033', '13733835255', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809033' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周', 1, '184809034', '15515736009', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809034' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '朱虎成', 1, '184809035', '15225122281', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809035' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曹璐妈妈', 1, '184809036', '13938585035', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809036' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '欧阳霞', 1, '184809037', '15639797516', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809037' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张先生 胡姐', 1, '184809038', '13603865080', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809038' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈娟', 1, '184809039', '18503838901', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809039' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘先生', 1, '184809040', '13838189201', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809040' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张晓燕', 1, '184809041', '18037573590', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809041' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周德海', 1, '184809042', '18637122576', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809042' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王丽', 1, '184809043', '15737175668', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809043' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '贝贝', 1, '184809044', '13461421604', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809044' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吴英', 1, '184809045', '13703905592', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809045' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '石笑峰', 1, '184809046', '13937115799', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809046' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李彤彤', 1, '184809047', '13938569634', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809047' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张良华', 1, '184809049', '13721436225', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809049' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '郭伟', 1, '184809050', '13343859556', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809050' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '段卫峰', 1, '184809051', '18537180101', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809051' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘彬', 1, '184809053', '15286800109', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809053' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周凝芳', 1, '184809054', '15981865902', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809054' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '余君丽', 1, '184809055', '18595658404', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809055' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李志红', 1, '184809056', '13733865481', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809056' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘全凤', 1, '184809057', '13598886853', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809057' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '孙亚平', 1, '184809058', '15514383625', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809058' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '姚女士', 1, '184809059', '15324885591', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809059' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张霞', 1, '184809060', '15638109296', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809060' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李金环', 1, '184809061', '13333840337', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809061' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '祁雯', 1, '184809062', '1000121187', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809062' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张全友', 1, '184809063', '15810885205', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809063' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '娇娇', 1, '184809064', '13203710656', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809064' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '沈亮', 1, '184809065', '13526803537', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809065' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘先生', 1, '184809066', '17737176577', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809066' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈芊羽', 1, '184809067', '15638871833', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809067' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王巧云', 1, '184809068', '15515722886', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809068' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张彬彬', 1, '184809069', '16650237696', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809069' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '靳斌', 1, '184809070', '17752563920', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809070' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马女士', 1, '184809071', '15003871086', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809071' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨香粉', 1, '184809072', '15136196811', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809072' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '任', 1, '184809073', '18538700095', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809073' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '裴女士', 1, '184809074', '15936256897', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809074' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张女士', 1, '184809075', '13837114130', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809075' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '胡爱欣', 1, '184809077', '18567531486', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809077' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '184809078', '18595806743', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809078' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '梁女士', 1, '184809079', '13707581722', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809079' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '边女士', 1, '184809080', '13523577795', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809080' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '平平', 1, '184809082', '18737145558', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809082' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '黄伟', 1, '184809083', '13733748620', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809083' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '魏娜', 1, '184809084', '13598872479', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809084' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '杨静', 1, '184809085', '15378786744', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809085' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '崔女士', 1, '184809086', '18625522251', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809086' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '夏勇', 1, '184809087', '13653838152', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809087' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '申茹', 1, '184809088', '13598871135', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809088' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张艳', 1, '184809089', '13938525895', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809089' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张少杰', 1, '184809090', '15729391111', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809090' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '张莹', 1, '184809091', '18303658503', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809091' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李秀容', 1, '184809092', '15839837763', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809092' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '马倩', 1, '184809093', '15639269628', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809093' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '曲锋', 1, '184809094', '17753101138', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809094' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '邢秋珍', 1, '184809098', '13253618729', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809098' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '乔兰', 1, '184809100', '15600460067', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809100' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈玲', 1, '184809101', '13223713056', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809101' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '姚子薇', 1, '184809102', '15036112953', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809102' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '查先生', 1, '184809103', '13803890925', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809103' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '路先生', 1, '184809104', '15188377261', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809104' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王方', 1, '184809105', '13938259535', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809105' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘冰', 1, '184809106', '15838051760', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809106' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '周强', 1, '184809107', '15939431999', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809107' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '徐秀玲', 1, '184809108', '15565876018', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809108' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王丽平', 1, '184809109', '15838059755', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809109' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王晓岑', 1, '184809110', '13803820936', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809110' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '田园', 1, '184809111', '13673713596', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809111' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '韩家福', 1, '184809112', '13703926330', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809112' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘', 1, '184809113', '13523496810', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809113' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '陈国宪', 1, '184809115', '13838551523', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809115' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李静', 1, '184809116', '17703823712', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809116' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '王女士', 1, '184809117', '16639171468', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809117' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '崔玉欣', 1, '184809118', '13783614454', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809118' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李草洋', 1, '184809119', '18738489705', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809119' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '吕方', 1, '184809120', '13083715585', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809120' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '李栋博', 1, '184809121', '17719888087', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809121' AND is_delete = 0);
INSERT INTO vip_info (name, gender, card_number, phone_number, balance, org_id, is_delete, remark, create_time, update_time)
SELECT '刘献芝', 1, '184809122', '15138273687', 0.00, 7, 0, '美管家次卡迁移导入', NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM vip_info WHERE card_number = '184809122' AND is_delete = 0);

-- ============================================
-- 会员券实例 (vip_info_ticket)
-- ============================================

INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '邢喜莲', '15093352210', 0, '2026-04-05', NULL, CONCAT('MG85589771_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '181527865' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '韩照睿', '15517121203', 0, '2026-04-04', NULL, CONCAT('MG85575350_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '181527852' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '张旭', '15136129595', 0, '2026-03-22', NULL, CONCAT('MG85244431_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '214950901' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '韩先生', '18838136333', 0, '2026-03-19', NULL, CONCAT('MG85157877_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '201668501' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '刘女士', '15617679900', 0, '2026-03-16', NULL, CONCAT('MG85092885_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '184809099' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '杨先生', '17337109636', 0, '2026-03-16', NULL, CONCAT('MG85092825_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '184808968' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '周女士', '18736068837', 0, '2026-03-13', NULL, CONCAT('MG84997021_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '214530133' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '王先生', '18569972777', 0, '2026-03-12', NULL, CONCAT('MG84993604_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-33.0', 0, NOW(), NOW(), 33.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201410755' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '王女士', '13937190986', 0, '2026-03-12', NULL, CONCAT('MG84993554_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-33.0', 0, NOW(), NOW(), 33.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '212611738' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '赵静', '18537285668', 0, '2026-03-12', NULL, CONCAT('MG84989204_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-33.0', 0, NOW(), NOW(), 33.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '197182821' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '王晨阳', '18638640217', 0, '2026-03-10', NULL, CONCAT('MG84924772_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '173772684' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '马女士', '15515806010', 0, '2026-03-04', NULL, CONCAT('MG84743066_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '214213374' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '薛芳芳', '13937118217', 0, '2026-03-02', NULL, CONCAT('MG84710711_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '210691886' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '蔡琛', '13607661849', 0, '2026-02-28', NULL, CONCAT('MG84668204_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '214078468' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李倩', '13938535595', 0, '2026-02-10', NULL, CONCAT('MG84392542_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '213444311' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '1322-艾灸调理', 0, '周德海', '18637122576', 0, '2026-02-08', NULL, CONCAT('MG84353740_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-1322-艾灸调理-200.0', 0, NOW(), NOW(), 200.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '181527822' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '214-体验古法艾灸调理一次', 0, '李学良', '13838002046', 0, '2026-01-28', NULL, CONCAT('MG83944074_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-214-体验古法艾灸调理一次-49.5', 0, NOW(), NOW(), 49.50
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169958567' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '李美女', '13213177025', 0, '2026-01-25', NULL, CONCAT('MG83878957_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '185988191' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '赵爱菊', '15286807939', 0, '2026-01-24', NULL, CONCAT('MG83819102_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '183989461' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '李晓琳', '13503846600', 0, '2026-01-10', NULL, CONCAT('MG83374878_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '211130995' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '赵枝', '15093564769', 0, '2025-12-31', NULL, CONCAT('MG83068414_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '211486017' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '王芳', '13503991279', 0, '2025-12-25', NULL, CONCAT('MG82859467_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '199588920' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '王淑辉', '18537172727', 0, '2025-12-24', NULL, CONCAT('MG82831992_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '181527318' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '214-体验古法艾灸调理一次', 0, '周德海', '18637122576', 0, '2025-12-21', NULL, CONCAT('MG82751225_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-214-体验古法艾灸调理一次-49.5', 0, NOW(), NOW(), 49.50
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '181527822' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '李先生', '15093489056', 0, '2025-12-20', NULL, CONCAT('MG82720393_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '190022202' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '柏延青', '18203636121', 0, '2025-11-30', NULL, CONCAT('MG82134241_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '192652443' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背', 0, '张女士', '15038662102', 0, '2025-11-30', NULL, CONCAT('MG82134187_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背-49.5', 0, NOW(), NOW(), 49.50
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '210179954' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '吴丽华', '17398985656', 0, '2025-11-29', NULL, CONCAT('MG82097339_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '181527526' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '1322-艾灸调理', 0, '王先生', '18569972777', 0, '2025-11-25', NULL, CONCAT('MG81981064_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-1322-艾灸调理-200.0', 0, NOW(), NOW(), 200.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '201410755' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张三', '17537171531', 0, '2025-11-25', NULL, CONCAT('MG81974601_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-35.33', 0, NOW(), NOW(), 35.33
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '209934835' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '214-体验古法艾灸调理一次', 0, '吕孟宁', '18537115199', 0, '2025-11-18', NULL, CONCAT('MG81802706_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-214-体验古法艾灸调理一次-49.5', 0, NOW(), NOW(), 49.50
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '181527395' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '马先生', '15238826761', 0, '2025-11-16', NULL, CONCAT('MG81746563_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '209562239' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '符湘萍', '18625581116', 0, '2025-11-15', NULL, CONCAT('MG81702323_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '181527399' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背', 0, '徐广', '13838187047', 0, '2025-11-14', NULL, CONCAT('MG81692234_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背-49.5', 0, NOW(), NOW(), 49.50
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184345168' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背', 0, '魏鑫然', '13733876320', 0, '2025-11-14', NULL, CONCAT('MG81677356_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背-49.5', 0, NOW(), NOW(), 49.50
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '190884631' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '李艳荣', '13103829009', 0, '2025-10-31', NULL, CONCAT('MG81258504_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '208880585' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '王女士', '13526764967', 0, '2025-10-31', NULL, CONCAT('MG81254275_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '208874721' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '张琳琳', '15838182696', 0, '2025-10-29', NULL, CONCAT('MG81201734_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '181527290' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '李先生', '13949015776', 0, '2025-10-29', NULL, CONCAT('MG81201684_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '208806085' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '史婷伟', '18338723192', 0, '2025-10-25', NULL, CONCAT('MG81097102_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '197351426' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '谭凤', '13523518834', 0, '2025-10-23', NULL, CONCAT('MG81070904_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '206549789' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '谭凤', '13523518834', 0, '2025-10-23', NULL, CONCAT('MG81070905_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '206549789' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '214-体验古法艾灸调理一次', 0, '郭伟', '13343859556', 0, '2025-10-23', NULL, CONCAT('MG81063483_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-214-体验古法艾灸调理一次-49.5', 0, NOW(), NOW(), 49.50
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '181527977' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '214-体验古法艾灸调理一次', 0, '郭伟', '13343859556', 0, '2025-10-23', NULL, CONCAT('MG81063484_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-214-体验古法艾灸调理一次-49.5', 0, NOW(), NOW(), 49.50
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '181527977' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '王振民', '13733169451', 0, '2025-10-19', NULL, CONCAT('MG80958243_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '196806542' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '张新丽', '15903692186', 0, '2025-10-17', NULL, CONCAT('MG80922018_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '206790510' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李淑萍', '15036765572', 0, '2025-10-16', NULL, CONCAT('MG80877129_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '201672593' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '贾女士', '15039378301', 0, '2025-10-14', NULL, CONCAT('MG80838283_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '190156327' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '孙小景', '18937128280', 0, '2025-10-06', NULL, CONCAT('MG80623961_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '207846000' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李灵君', '18937171522', 0, '2025-09-29', NULL, CONCAT('MG80443381_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808983' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李灵君', '18937171522', 0, '2025-09-29', NULL, CONCAT('MG80443372_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '184808983' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '谢爱荣', '13213223283', 0, '2025-09-29', NULL, CONCAT('MG80432346_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '184808997' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '董女士', '13939016471', 0, '2025-09-25', NULL, CONCAT('MG80278395_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '207312065' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '徐先生', '15638107123', 0, '2025-09-24', NULL, CONCAT('MG80250478_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '186019806' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '肖', '15824855315', 0, '2025-09-21', NULL, CONCAT('MG80154985_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '189511239' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '张琳琳', '15838182696', 0, '2025-09-20', NULL, CONCAT('MG80128955_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '181527290' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '张琳琳', '15838182696', 0, '2025-09-20', NULL, CONCAT('MG80128869_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '181527290' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '常璐', '16603868937', 0, '2025-09-15', NULL, CONCAT('MG79989820_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '196740554' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '闫学森', '18595855799', 0, '2025-09-14', NULL, CONCAT('MG79955445_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-50.0', 0, NOW(), NOW(), 50.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '206824887' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '风玉琴', '13014503658', 0, '2025-09-10', NULL, CONCAT('MG79826963_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '206639725' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '胡肆糖', '15136452219', 0, '2025-09-09', NULL, CONCAT('MG79799925_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '206588797' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '魏巍', '15838254589', 0, '2025-09-06', NULL, CONCAT('MG79731532_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '184808982' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '徐红', '15939041312', 0, '2025-09-06', NULL, CONCAT('MG79731431_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '206490576' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '高新', '13653836542', 0, '2025-08-26', NULL, CONCAT('MG79453623_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808976' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '巴建设', '13838288043', 0, '2025-08-24', NULL, CONCAT('MG79411734_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-29.9', 0, NOW(), NOW(), 29.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '205576479' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '朱家惠', '15093678707', 0, '2025-08-23', NULL, CONCAT('MG79390200_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-29.9', 0, NOW(), NOW(), 29.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '205540727' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '陈全慧', '13613806988', 0, '2025-08-19', NULL, CONCAT('MG79286918_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '205381015' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '马桂玲', '13526751061', 0, '2025-07-28', NULL, CONCAT('MG78735423_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n UNION ALL SELECT 11 AS n UNION ALL SELECT 12 AS n UNION ALL SELECT 13 AS n UNION ALL SELECT 14 AS n UNION ALL SELECT 15 AS n UNION ALL SELECT 16 AS n UNION ALL SELECT 17 AS n UNION ALL SELECT 18 AS n UNION ALL SELECT 19 AS n UNION ALL SELECT 20 AS n UNION ALL SELECT 21 AS n UNION ALL SELECT 22 AS n UNION ALL SELECT 23 AS n UNION ALL SELECT 24 AS n UNION ALL SELECT 25 AS n UNION ALL SELECT 26 AS n) nums
WHERE vi.card_number = '184808969' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '翟英', '13384006652', 0, '2025-06-16', NULL, CONCAT('MG77633276_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201089053' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '赵鹏辉', '15093124152', 0, '2025-06-15', NULL, CONCAT('MG77622856_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n UNION ALL SELECT 11 AS n UNION ALL SELECT 12 AS n UNION ALL SELECT 13 AS n UNION ALL SELECT 14 AS n UNION ALL SELECT 15 AS n UNION ALL SELECT 16 AS n) nums
WHERE vi.card_number = '184808992' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '弓晶', '19139918092', 0, '2025-06-15', NULL, CONCAT('MG77614260_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '201461074' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '李承骏', '13526704552', 0, '2025-06-07', NULL, CONCAT('MG77388046_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '191710595' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '陈霞', '13703864980', 0, '2025-05-30', NULL, CONCAT('MG77183951_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '194055722' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '陈霞', '13703864980', 0, '2025-05-30', NULL, CONCAT('MG77183952_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '194055722' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '赵雅楠', '18337186786', 0, '2025-05-28', NULL, CONCAT('MG77131646_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-50.0', 0, NOW(), NOW(), 50.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201697676' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '赵杰', '18703609975', 0, '2025-05-26', NULL, CONCAT('MG77063825_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201578298' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张美女', '18638112055', 0, '2025-05-24', NULL, CONCAT('MG77008812_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201490052' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '明女士', '13333858535', 0, '2025-05-24', NULL, CONCAT('MG77008713_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201489305' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '陶先生', '13203883414', 0, '2025-05-23', NULL, CONCAT('MG77004985_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-30.0', 0, NOW(), NOW(), 30.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '189869820' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张坤', '15903656306', 0, '2025-05-23', NULL, CONCAT('MG76988100_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201460853' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '贾先生', '18037469008', 0, '2025-05-21', NULL, CONCAT('MG76933734_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201386510' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '裴老师', '19303971737', 0, '2025-05-19', NULL, CONCAT('MG76905132_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '194843199' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张与白', '17803820690', 0, '2025-05-19', NULL, CONCAT('MG76883837_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201296557' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '孟先生', '15617863719', 0, '2025-05-18', NULL, CONCAT('MG76856342_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201255527' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '99卡谢女士', '13592679350', 0, '2025-05-14', NULL, CONCAT('MG76747498_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809076' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '崔静', '18703995827', 0, '2025-05-14', NULL, CONCAT('MG76747461_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '201088839' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '冯先生', '13526851515', 0, '2025-05-14', NULL, CONCAT('MG76747421_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '201088776' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '李', '15738316199', 0, '2025-05-13', NULL, CONCAT('MG76712361_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171201242' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '李先生', '13526722682', 0, '2025-05-13', NULL, CONCAT('MG76712028_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '201055578' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '王女士', '13903859630', 0, '2025-05-13', NULL, CONCAT('MG76711967_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '201020539' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李云云', '18336375860', 0, '2025-05-10', NULL, CONCAT('MG76648448_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '184809096' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李亚平', '13303837690', 0, '2025-05-06', NULL, CONCAT('MG76510879_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '200752308' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '刘金山', '15333835007', 0, '2025-04-28', NULL, CONCAT('MG76262091_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '200337501' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '刘顺利', '18625557336', 0, '2025-04-25', NULL, CONCAT('MG76140752_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '200173211' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '董汉云', '13027784302', 0, '2025-04-23', NULL, CONCAT('MG76097459_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '200117168' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '李先生', '13323657678', 0, '2025-04-13', NULL, CONCAT('MG75842278_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '199686621' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '108-足疗套餐B', 0, '惠女士', '18739938993', 0, '2025-04-11', NULL, CONCAT('MG75780604_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-108-足疗套餐B-100.0', 0, NOW(), NOW(), 100.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '199586361' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '黄红萍', '13838569290', 0, '2025-03-25', NULL, CONCAT('MG75251876_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '198804930' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '姜秀玲', '18539280565', 0, '2025-03-13', NULL, CONCAT('MG74927952_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-30.0', 0, NOW(), NOW(), 30.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '207968686' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '谷奇', '13525532853', 0, '2025-03-06', NULL, CONCAT('MG74597084_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n UNION ALL SELECT 11 AS n UNION ALL SELECT 12 AS n UNION ALL SELECT 13 AS n UNION ALL SELECT 14 AS n UNION ALL SELECT 15 AS n UNION ALL SELECT 16 AS n UNION ALL SELECT 17 AS n UNION ALL SELECT 18 AS n UNION ALL SELECT 19 AS n UNION ALL SELECT 20 AS n UNION ALL SELECT 21 AS n UNION ALL SELECT 22 AS n UNION ALL SELECT 23 AS n UNION ALL SELECT 24 AS n UNION ALL SELECT 25 AS n) nums
WHERE vi.card_number = '184809048' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '位朋真', '18530057588', 0, '2025-02-22', NULL, CONCAT('MG74235844_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '197317127' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '周莘源', '13837199948', 0, '2025-02-15', NULL, CONCAT('MG74060400_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '197049400' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '庞红红', '13838255533', 0, '2025-02-10', NULL, CONCAT('MG73963717_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '196869583' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李杰', '13703849111', 0, '2025-02-08', NULL, CONCAT('MG73926663_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '184808985' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '小蕊', '15036186996', 0, '2025-02-05', NULL, CONCAT('MG73871496_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '196737978' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '陈月红', '15138919045', 0, '2025-01-21', NULL, CONCAT('MG73638221_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '196366556' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '王永强', '13903843219', 0, '2025-01-13', NULL, CONCAT('MG73369882_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-30.0', 0, NOW(), NOW(), 30.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '181527275' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '陈元科', '13674960098', 0, '2025-01-11', NULL, CONCAT('MG73304333_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-30.0', 0, NOW(), NOW(), 30.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n UNION ALL SELECT 11 AS n UNION ALL SELECT 12 AS n UNION ALL SELECT 13 AS n UNION ALL SELECT 14 AS n UNION ALL SELECT 15 AS n UNION ALL SELECT 16 AS n UNION ALL SELECT 17 AS n UNION ALL SELECT 18 AS n UNION ALL SELECT 19 AS n) nums
WHERE vi.card_number = '181527845' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '乔兰', '15600460067', 0, '2025-01-07', NULL, CONCAT('MG73155459_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '181527660' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '贾秀梅', '15039378301', 0, '2024-12-30', NULL, CONCAT('MG72875280_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-50.0', 0, NOW(), NOW(), 50.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '181527302' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '王翠萍', '15837150126', 0, '2024-12-26', NULL, CONCAT('MG72750001_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '195090892' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '李美佳', '15515537612', 0, '2024-12-18', NULL, CONCAT('MG72467905_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '194747463' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '魏爱波', '13676921165', 0, '2024-12-15', NULL, CONCAT('MG72383502_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-30.0', 0, NOW(), NOW(), 30.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n UNION ALL SELECT 11 AS n UNION ALL SELECT 12 AS n UNION ALL SELECT 13 AS n UNION ALL SELECT 14 AS n UNION ALL SELECT 15 AS n UNION ALL SELECT 16 AS n) nums
WHERE vi.card_number = '184644041' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '赵丽', '13523048596', 0, '2024-12-14', NULL, CONCAT('MG72351928_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '184809097' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '音女士', '15038216160', 0, '2024-12-08', NULL, CONCAT('MG72115695_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '184534920' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '杨洋', '13838251685', 0, '2024-12-02', NULL, CONCAT('MG71948214_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '194149882' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '赵海菲', '18736099998', 0, '2024-11-28', NULL, CONCAT('MG71785648_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-69.0', 0, NOW(), NOW(), 69.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '184708403' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '魏爱波', '13676921165', 0, '2024-11-23', NULL, CONCAT('MG71661877_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-79.0', 0, NOW(), NOW(), 79.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184644041' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '吕女士', '17596574484', 0, '2024-11-11', NULL, CONCAT('MG71267772_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '184809114' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '吕女士', '17596574484', 0, '2024-11-11', NULL, CONCAT('MG71267740_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-69.0', 0, NOW(), NOW(), 69.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '184809114' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '马鸣戈', '13937181055', 0, '2024-11-11', NULL, CONCAT('MG71260318_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '185720369' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '宗庆华', '13598017542', 0, '2024-11-10', NULL, CONCAT('MG71246280_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '193194044' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '李松杰', '13937102369', 0, '2024-11-08', NULL, CONCAT('MG71141867_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '193074295' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '樊建宇', '13525568751', 0, '2024-11-08', NULL, CONCAT('MG71141244_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '193073637' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '李静', '15803849391', 0, '2024-11-07', NULL, CONCAT('MG71106464_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-30.0', 0, NOW(), NOW(), 30.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '192975154' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '马晓慧', '17639298811', 0, '2024-11-01', NULL, CONCAT('MG70920058_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '181527293' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '徐先生', '15638107123', 0, '2024-10-29', NULL, CONCAT('MG70826659_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '186019806' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '曹瑞春', '13526678852', 0, '2024-10-25', NULL, CONCAT('MG70703982_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-30.0', 0, NOW(), NOW(), 30.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '184809081' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '张兆杏', '18629945512', 0, '2024-10-22', NULL, CONCAT('MG70574308_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '192012377' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '吴昱霖', '17303717019', 0, '2024-10-20', NULL, CONCAT('MG70529869_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '182791335' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '潘先生', '15617950975', 0, '2024-10-13', NULL, CONCAT('MG70350432_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '191710919' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '胡女士', '15038281545', 0, '2024-10-13', NULL, CONCAT('MG70302051_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '191664158' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '刘瑞丽', '13526503842', 0, '2024-10-11', NULL, CONCAT('MG70259231_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-69.0', 0, NOW(), NOW(), 69.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '191609876' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '徐进', '13837673222', 0, '2024-10-11', NULL, CONCAT('MG70254725_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '191601369' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '杨文乐', '15137139580', 0, '2024-09-25', NULL, CONCAT('MG69732036_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '190840964' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '刘女士', '13247195362', 0, '2024-09-14', NULL, CONCAT('MG69362631_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-30.0', 0, NOW(), NOW(), 30.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '190302099' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '王女士', '13071091113', 0, '2024-09-10', NULL, CONCAT('MG69263304_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-69.0', 0, NOW(), NOW(), 69.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '190143177' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '刘雯', '13071070773', 0, '2024-09-09', NULL, CONCAT('MG69200054_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '190096588' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '刘雯', '13071070773', 0, '2024-09-09', NULL, CONCAT('MG69200055_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '190096588' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '刘雯', '13071070773', 0, '2024-09-09', NULL, CONCAT('MG69200056_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '190096588' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '高原', '13838121054', 0, '2024-09-08', NULL, CONCAT('MG69175398_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-70.0', 0, NOW(), NOW(), 70.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '184809023' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '丁先生', '15890096270', 0, '2024-08-28', NULL, CONCAT('MG68820175_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184265868' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '张女士', '13333818588', 0, '2024-08-24', NULL, CONCAT('MG68707009_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-69.0', 0, NOW(), NOW(), 69.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '184809052' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '谢', '15837177337', 0, '2024-08-20', NULL, CONCAT('MG68567359_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '169745412' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '龚建秀', '15515659756', 0, '2024-08-19', NULL, CONCAT('MG68545739_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-30.0', 0, NOW(), NOW(), 30.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '181527558' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '胡丽英', '13949033282', 0, '2024-08-16', NULL, CONCAT('MG68459189_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '184808944' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '范女士', '13838394928', 0, '2024-08-15', NULL, CONCAT('MG68447522_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '182967030' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '陈玲', '13223713056', 0, '2024-08-15', NULL, CONCAT('MG68438948_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '181784938' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '张秘景', '13938440466', 0, '2024-08-10', NULL, CONCAT('MG68306897_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '188686096' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '张兰', '18910888617', 0, '2024-07-27', NULL, CONCAT('MG67932863_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-35.0', 0, NOW(), NOW(), 35.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '188030235' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李莹', '15136105861', 0, '2024-07-24', NULL, CONCAT('MG67857868_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-49.9', 0, NOW(), NOW(), 49.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '187919235' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '陈', '13938505661', 0, '2024-07-21', NULL, CONCAT('MG67751823_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-69.0', 0, NOW(), NOW(), 69.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '187789321' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '陆小哥', '17638106615', 0, '2024-07-21', NULL, CONCAT('MG67738756_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '185097667' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '陈', '13938505661', 0, '2024-07-17', NULL, CONCAT('MG67635897_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '187611384' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '付晓琳', '15093447811', 0, '2024-07-12', NULL, CONCAT('MG67522902_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-79.0', 0, NOW(), NOW(), 79.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '187447879' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '朱女士', '15939027808', 0, '2024-07-01', NULL, CONCAT('MG67223528_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '186986802' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '黄小雨', '15803880972', 0, '2024-06-30', NULL, CONCAT('MG67182012_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '183599374' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '朱爱莲', '13803862503', 0, '2024-06-21', NULL, CONCAT('MG66912532_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '186449677' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '卓玛秀', '19939711166', 0, '2024-06-10', NULL, CONCAT('MG66554510_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '185992160' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '李岚', '13673696660', 0, '2024-06-09', NULL, CONCAT('MG66544865_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '185976253' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '王', '13071091113', 0, '2024-06-07', NULL, CONCAT('MG66493710_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '185905310' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 0, '马晓慧', '17639298811', 0, '2024-05-31', NULL, CONCAT('MG66292159_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA-59.0', 0, NOW(), NOW(), 59.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n UNION ALL SELECT 11 AS n UNION ALL SELECT 12 AS n UNION ALL SELECT 13 AS n UNION ALL SELECT 14 AS n UNION ALL SELECT 15 AS n UNION ALL SELECT 16 AS n UNION ALL SELECT 17 AS n UNION ALL SELECT 18 AS n UNION ALL SELECT 19 AS n UNION ALL SELECT 20 AS n) nums
WHERE vi.card_number = '181527293' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '王淑辉', '18537172727', 0, '2024-05-28', NULL, CONCAT('MG66186488_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '181527318' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李女士', '15238651859', 0, '2024-05-22', NULL, CONCAT('MG66022755_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '183599835' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '陈芬哒', '13298158833', 0, '2024-05-18', NULL, CONCAT('MG65923379_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '184962186' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '何', '18037276585', 0, '2024-05-11', NULL, CONCAT('MG65720434_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '184643729' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '马京飞', '17737709209', 0, '2024-04-30', NULL, CONCAT('MG65387720_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184198372' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚,601-洗面', 0, '孙秀英', '13733087797', 0, '2024-04-16', NULL, CONCAT('MG64930482_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚,601-洗面-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '183333275' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚,601-洗面', 0, '王晨阳', '18638640217', 0, '2024-04-02', NULL, CONCAT('MG64559775_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚,601-洗面-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '173772684' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚,601-洗面', 0, '董雅娟', '17698002233', 0, '2024-04-01', NULL, CONCAT('MG64522109_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚,601-洗面-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '182626281' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 0, '王倩', '15638906813', 0, '2024-03-27', NULL, CONCAT('MG64374360_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '181868767' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚,601-洗面', 0, '田小兰', '15903626612', 0, '2024-03-24', NULL, CONCAT('MG64306842_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚,601-洗面-39.9', 0, NOW(), NOW(), 39.90
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '181527462' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 0, '胡鹏飞', '15638529091', 0, '2024-03-21', NULL, CONCAT('MG64236194_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '181645292' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 0, '陈丽霞', '18614984134', 0, '2024-03-21', NULL, CONCAT('MG64236188_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '181645272' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 0, '孙亚平', '15514383625', 0, '2024-03-21', NULL, CONCAT('MG64236179_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '181645251' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 0, '胡女士', '15290409020', 0, '2024-03-21', NULL, CONCAT('MG64236131_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '181645201' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 0, '刘全凤', '13598886853', 0, '2024-03-21', NULL, CONCAT('MG64236032_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '181599391' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟', 0, '刘全凤', '13598886853', 0, '2024-03-20', NULL, CONCAT('MG64207345_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '181599391' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '刘全凤', '13598886853', 0, '2024-03-20', NULL, CONCAT('MG64207346_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '181599391' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '付', '13700855983', 0, '2023-12-03', NULL, CONCAT('MG60965110_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '177437048' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '陈', '13526800103', 0, '2023-11-24', NULL, CONCAT('MG60701986_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '177042527' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '迟女士', '15522426728', 0, '2023-11-05', NULL, CONCAT('MG60156936_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '176241701' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '管', '13837113645', 0, '2023-11-02', NULL, CONCAT('MG60044727_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '176077200' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '15225074834', 0, '2023-11-01', NULL, CONCAT('MG60025680_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '176051638' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘玉华', '13523582760', 0, '2023-11-01', NULL, CONCAT('MG60025600_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '176051577' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '宋女士', '15137199295', 0, '2023-10-29', NULL, CONCAT('MG59942274_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '175908539' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '李女士', '17744612190', 0, '2023-10-23', NULL, CONCAT('MG59787990_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '175698251' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '', 0, '宋', '13838108196', 0, '2023-10-23', NULL, CONCAT('MG59762746_', nums.n), 7, 3, '美管家系统迁移-锦艺城店--0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '175670247' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '白', '13838028116', 0, '2023-10-21', NULL, CONCAT('MG59711530_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '175595578' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '张先生', '18137657592', 0, '2023-10-16', NULL, CONCAT('MG59605696_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '175450172' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '15838223689', 0, '2023-10-16', NULL, CONCAT('MG59604656_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '175448811' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '蒋', '18903814477', 0, '2023-10-07', NULL, CONCAT('MG59347309_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '174994727' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '范先生', '13343831360', 0, '2023-09-28', NULL, CONCAT('MG59110023_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '174639816' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '15617679900', 0, '2023-09-27', NULL, CONCAT('MG59086416_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '174596413' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '马', '13673373646', 0, '2023-09-26', NULL, CONCAT('MG59023412_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '174491563' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '高', '18503800495', 0, '2023-09-24', NULL, CONCAT('MG58958564_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '174399399' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '程', '15138489677', 0, '2023-09-22', NULL, CONCAT('MG58913959_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '170033203' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '宋', '13937199249', 0, '2023-09-21', NULL, CONCAT('MG58881300_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '174289314' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '18937621981', 0, '2023-09-21', NULL, CONCAT('MG58864609_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '174270317' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '孟', '15838309106', 0, '2023-09-20', NULL, CONCAT('MG58846984_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '174239520' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '江女士', '15638501071', 0, '2023-09-18', NULL, CONCAT('MG58789100_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169739011' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王宁', '18937137737', 0, '2023-09-18', NULL, CONCAT('MG58775347_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169796373' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '马女士', '17639298811', 0, '2023-09-17', NULL, CONCAT('MG58761832_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '173978845' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '18530037912', 0, '2023-09-14', NULL, CONCAT('MG58680094_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '173864074' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '孙女士', '18638563337', 0, '2023-09-14', NULL, CONCAT('MG58681814_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '173835339' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '项目已删除', 0, '宋女士', '18538086996', 0, '2023-09-13', NULL, CONCAT('MG58645925_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-项目已删除-45.0', 0, NOW(), NOW(), 45.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '173809341' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '杨', '13592591892', 0, '2023-09-13', NULL, CONCAT('MG58635306_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '173784768' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '荆', '13526682861', 0, '2023-09-11', NULL, CONCAT('MG58603261_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169721230' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '', 0, '张伟', '18037465161', 0, '2023-09-11', NULL, CONCAT('MG58602113_', nums.n), 7, 3, '美管家系统迁移-锦艺城店--0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169812040' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '郑', '19903711590', 0, '2023-09-11', NULL, CONCAT('MG58591811_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '173723491' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '关', '13508661096', 0, '2023-09-11', NULL, CONCAT('MG58591180_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '173722848' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '孟', '18539970953', 0, '2023-09-09', NULL, CONCAT('MG58547807_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '173648565' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '雷女士', '13523422468', 0, '2023-09-08', NULL, CONCAT('MG58515570_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '173596176' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '魏', '18137181005', 0, '2023-09-04', NULL, CONCAT('MG58401972_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '173424406' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '', 0, '王', '15038353355', 0, '2023-09-03', NULL, CONCAT('MG58380149_', nums.n), 7, 3, '美管家系统迁移-锦艺城店--0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169838985' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '18937623045', 0, '2023-08-29', NULL, CONCAT('MG58250451_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '173105758' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '刘女士', '18237857887', 0, '2023-08-27', NULL, CONCAT('MG58206841_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '172996579' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '林', '13253587888', 0, '2023-08-25', NULL, CONCAT('MG58140519_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172900786' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '16799973999', 0, '2023-08-23', NULL, CONCAT('MG58093180_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172791943' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '罗', '17337199905', 0, '2023-08-23', NULL, CONCAT('MG58091537_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '172789495' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '刘先生', '18339806011', 0, '2023-08-23', NULL, CONCAT('MG58090909_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172788525' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '申', '17724828835', 0, '2023-08-22', NULL, CONCAT('MG58067447_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172738677' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '李', '18660839493', 0, '2023-08-21', NULL, CONCAT('MG58043177_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '172704310' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '任', '15617859948', 0, '2023-08-21', NULL, CONCAT('MG58041980_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '172702233' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '杨', '13938515127', 0, '2023-08-21', NULL, CONCAT('MG58041820_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172702001' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '13838565595', 0, '2023-08-21', NULL, CONCAT('MG58041716_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172701854' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '17630009878', 0, '2023-08-21', NULL, CONCAT('MG58257316_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171107962' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 0, '刘先生', '15303718330', 0, '2023-08-19', NULL, CONCAT('MG57985627_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸-55.0', 0, NOW(), NOW(), 55.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '172627789' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '程女士', '18237118488', 0, '2023-08-19', NULL, CONCAT('MG57965261_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172600174' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '13838072163', 0, '2023-08-18', NULL, CONCAT('MG57956380_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '172587814' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13027511413', 0, '2023-08-10', NULL, CONCAT('MG57761074_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172212648' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '景', '13938352230', 0, '2023-08-10', NULL, CONCAT('MG57758730_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '172209472' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '白', '17611712900', 0, '2023-08-09', NULL, CONCAT('MG57742727_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172184385' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '15517569802', 0, '2023-08-07', NULL, CONCAT('MG57702459_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '172071149' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '', 0, '体验卡男', '13681194337', 0, '2023-08-06', NULL, CONCAT('MG57685265_', nums.n), 7, 3, '美管家系统迁移-锦艺城店--0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '172042757' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '17760745535', 0, '2023-08-06', NULL, CONCAT('MG57671118_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '172020338' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '乔', '13663016752', 0, '2023-08-06', NULL, CONCAT('MG57664289_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '172010817' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '岳', '15736796800', 0, '2023-08-03', NULL, CONCAT('MG57613941_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171938411' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '吕', '18503926982', 0, '2023-08-03', NULL, CONCAT('MG57612461_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171936241' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '吕', '13007617927', 0, '2023-08-03', NULL, CONCAT('MG57612421_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171936179' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '13783685558', 0, '2023-08-01', NULL, CONCAT('MG57570491_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171865354' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '15515962501', 0, '2023-07-29', NULL, CONCAT('MG57494696_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171721910' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '19913836699', 0, '2023-07-27', NULL, CONCAT('MG57451036_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171661612' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '时', '15538016830', 0, '2023-07-26', NULL, CONCAT('MG57425816_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171618857' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '15225117504', 0, '2023-07-25', NULL, CONCAT('MG57405303_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171579697' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '13673621322', 0, '2023-07-25', NULL, CONCAT('MG57405298_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171579685' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '邓', '13525530846', 0, '2023-07-25', NULL, CONCAT('MG57402422_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171576000' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '房东', '15890672392', 0, '2023-07-25', NULL, CONCAT('MG57402258_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171575799' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '任女士', '18703657303', 0, '2023-07-25', NULL, CONCAT('MG57401862_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171575185' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '18237196281', 0, '2023-07-23', NULL, CONCAT('MG57352728_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171511096' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '18036191608', 0, '2023-07-23', NULL, CONCAT('MG57351516_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171509204' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '15936267153', 0, '2023-07-23', NULL, CONCAT('MG57349704_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171506260' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '程', '13663806890', 0, '2023-07-22', NULL, CONCAT('MG57326652_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171460698' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李女生', '15515883701', 0, '2023-07-21', NULL, CONCAT('MG57295121_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171406942' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '18603839814', 0, '2023-07-20', NULL, CONCAT('MG57271682_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171373894' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '朱', '18539578990', 0, '2023-07-19', NULL, CONCAT('MG57250909_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171348369' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '高', '15837323235', 0, '2023-07-19', NULL, CONCAT('MG57244349_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171339613' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '邱', '13783655582', 0, '2023-07-19', NULL, CONCAT('MG57244066_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171339298' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '徐', '15515577377', 0, '2023-07-19', NULL, CONCAT('MG57241099_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171328618' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '职', '13592505722', 0, '2023-07-18', NULL, CONCAT('MG57230226_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171315409' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张华', '13903943867', 0, '2023-07-18', NULL, CONCAT('MG57208379_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171288627' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张勇', '13633933363', 0, '2023-07-17', NULL, CONCAT('MG57200636_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171265270' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '项目已删除', 0, '曹水林', '18037103871', 0, '2023-07-17', NULL, CONCAT('MG57223909_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-项目已删除-640.0', 0, NOW(), NOW(), 640.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171306277' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '徐', '13513800990', 0, '2023-07-15', NULL, CONCAT('MG57145662_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171162363' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '18539277201', 0, '2023-07-13', NULL, CONCAT('MG57102235_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171093488' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '姚', '15225125422', 0, '2023-07-13', NULL, CONCAT('MG57102193_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171093436' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13643808248', 0, '2023-07-13', NULL, CONCAT('MG57102065_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171093282' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '芦', '13213012009', 0, '2023-07-12', NULL, CONCAT('MG57076912_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169850121' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '姚', '13353808191', 0, '2023-07-12', NULL, CONCAT('MG57069558_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171044629' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '19937131213', 0, '2023-07-11', NULL, CONCAT('MG57059779_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '171032441' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '13949403046', 0, '2023-07-11', NULL, CONCAT('MG57050825_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '171017795' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '胡', '15003805885', 0, '2023-07-10', NULL, CONCAT('MG57027270_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170979831' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '范', '15890157197', 0, '2023-07-09', NULL, CONCAT('MG57003490_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170925527' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '孙', '15343828444', 0, '2023-07-07', NULL, CONCAT('MG56942898_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170833629' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '17335767831', 0, '2023-07-07', NULL, CONCAT('MG56928013_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170805174' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '孙', '13213142236', 0, '2023-07-06', NULL, CONCAT('MG56914842_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170784557' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13526672010', 0, '2023-07-05', NULL, CONCAT('MG56889019_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170733719' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '13569922811', 0, '2023-07-04', NULL, CONCAT('MG56870584_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170698680' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '杨', '15003999061', 0, '2023-07-03', NULL, CONCAT('MG56849860_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170658132' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '郭', '15538358388', 0, '2023-07-03', NULL, CONCAT('MG56849849_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170658116' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '周', '15617565956', 0, '2023-07-03', NULL, CONCAT('MG56849137_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170656692' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13017679389', 0, '2023-07-03', NULL, CONCAT('MG56849109_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170656651' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13503814589', 0, '2023-07-03', NULL, CONCAT('MG56848164_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170655232' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13838109899', 0, '2023-07-02', NULL, CONCAT('MG56824077_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170606089' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '高', '15136268561', 0, '2023-07-01', NULL, CONCAT('MG56797082_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170568564' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '陈', '13837193186', 0, '2023-07-01', NULL, CONCAT('MG56796712_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170567979' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '18920820923', 0, '2023-07-01', NULL, CONCAT('MG56796639_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170567876' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '高', '13303812653', 0, '2023-07-01', NULL, CONCAT('MG56792505_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170561557' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '史', '13633809591', 0, '2023-07-01', NULL, CONCAT('MG56773412_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170530390' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '宋', '15803880972', 0, '2023-06-30', NULL, CONCAT('MG56740743_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169858344' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13213070219', 0, '2023-06-29', NULL, CONCAT('MG56726409_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170405448' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '樊', '13629847598', 0, '2023-06-29', NULL, CONCAT('MG56713522_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170422689' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '孙', '18736018051', 0, '2023-06-29', NULL, CONCAT('MG56703608_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170416676' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '季', '18736033570', 0, '2023-06-29', NULL, CONCAT('MG56703547_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170416603' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '杨', '17719815562', 0, '2023-06-28', NULL, CONCAT('MG56678596_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170382814' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '佟', '19397945912', 0, '2023-06-27', NULL, CONCAT('MG56668527_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170366168' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张先生', '13733858396', 0, '2023-06-27', NULL, CONCAT('MG56665581_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170362254' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '曲', '15238007770', 0, '2023-06-26', NULL, CONCAT('MG56640495_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170322994' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '15515577897', 0, '2023-06-26', NULL, CONCAT('MG56636594_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170317474' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '孙-彭世', '15839201788', 0, '2023-06-26', NULL, CONCAT('MG56635677_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170316266' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '朱', '13523416345', 0, '2023-06-26', NULL, CONCAT('MG56628762_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170305659' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '杨', '13592495909', 0, '2023-06-26', NULL, CONCAT('MG56628711_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170305591' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '贾', '15238798625', 0, '2023-06-26', NULL, CONCAT('MG56628323_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170305221' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '冯', '18838155708', 0, '2023-06-25', NULL, CONCAT('MG56614719_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170277347' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '井', '15136121393', 0, '2023-06-25', NULL, CONCAT('MG56610262_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170269309' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '15286822801', 0, '2023-06-25', NULL, CONCAT('MG56594017_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170239296' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '龚', '18239955689', 0, '2023-06-24', NULL, CONCAT('MG56566179_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170204395' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '18838999402', 0, '2023-06-23', NULL, CONCAT('MG56559600_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170195955' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '杨先生', '13949313878', 0, '2023-06-23', NULL, CONCAT('MG56558346_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170193910' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13526794850', 0, '2023-06-23', NULL, CONCAT('MG56550629_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170182469' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '程', '13298322296', 0, '2023-06-23', NULL, CONCAT('MG56546066_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170166229' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '马', '15890162806', 0, '2023-06-22', NULL, CONCAT('MG56536326_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170151044' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '13733822127', 0, '2023-06-22', NULL, CONCAT('MG56536164_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170150603' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '金', '13703713918', 0, '2023-06-22', NULL, CONCAT('MG56536090_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170150478' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张先生', '13676926700', 0, '2023-06-22', NULL, CONCAT('MG56523633_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170131319' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '17796668052', 0, '2023-06-21', NULL, CONCAT('MG56517420_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170121013' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '15236116817', 0, '2023-06-21', NULL, CONCAT('MG56517344_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170120983' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '郭', '18614951334', 0, '2023-06-21', NULL, CONCAT('MG56511987_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170112986' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '18339723972', 0, '2023-06-20', NULL, CONCAT('MG56488840_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170081851' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '13673638863', 0, '2023-06-20', NULL, CONCAT('MG56487158_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170079416' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '郭', '13223023928', 0, '2023-06-20', NULL, CONCAT('MG56481216_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170071656' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '13903826828', 0, '2023-06-20', NULL, CONCAT('MG56479735_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170069934' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '13503739886', 0, '2023-06-20', NULL, CONCAT('MG56472308_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170064543' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '13015506267', 0, '2023-06-20', NULL, CONCAT('MG56467797_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170058170' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '彭', '13937189966', 0, '2023-06-19', NULL, CONCAT('MG56443202_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170026232' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '陈', '13523077783', 0, '2023-06-19', NULL, CONCAT('MG56441018_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170024297' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '闫', '15136215719', 0, '2023-06-19', NULL, CONCAT('MG56436230_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170019242' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '18937153488', 0, '2023-06-19', NULL, CONCAT('MG56429143_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '170007968' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '洪', '17737196369', 0, '2023-06-18', NULL, CONCAT('MG56424835_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170002848' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '余', '13235302332', 0, '2023-06-18', NULL, CONCAT('MG56424817_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '170002796' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '17729775567', 0, '2023-06-18', NULL, CONCAT('MG56417960_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169994419' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '汪', '13629845679', 0, '2023-06-18', NULL, CONCAT('MG56417788_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169994217' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '胡', '13803840268', 0, '2023-06-18', NULL, CONCAT('MG56415778_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169991616' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王先生', '17837134397', 0, '2023-06-18', NULL, CONCAT('MG56415207_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169990941' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '无名', '15003990583', 0, '2023-06-18', NULL, CONCAT('MG56412486_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169985360' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '15837121596', 0, '2023-06-18', NULL, CONCAT('MG56408993_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169980641' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '13526591258', 0, '2023-06-18', NULL, CONCAT('MG56408882_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169980506' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '13643856983', 0, '2023-06-18', NULL, CONCAT('MG56395649_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169958766' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '魏', '15981911711', 0, '2023-06-17', NULL, CONCAT('MG56379282_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169938310' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '苏', '15515730223', 0, '2023-06-17', NULL, CONCAT('MG56378100_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169936854' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '陶', '15978897703', 0, '2023-06-17', NULL, CONCAT('MG56378040_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169936748' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '夏', '15538138320', 0, '2023-06-17', NULL, CONCAT('MG56359706_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169904750' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '金', '15517555900', 0, '2023-06-16', NULL, CONCAT('MG56340694_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169883208' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '谷女士', '15639718386', 0, '2023-06-16', NULL, CONCAT('MG56339557_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169882136' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '18703607805', 0, '2023-06-15', NULL, CONCAT('MG56325421_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169866007' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '邢', '13838221966', 0, '2023-06-15', NULL, CONCAT('MG56325344_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169865849' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '樊', '15225683747', 0, '2023-06-15', NULL, CONCAT('MG56300219_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169827455' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '18530923938', 0, '2023-06-15', NULL, CONCAT('MG56300113_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169827339' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '张', '13839538002', 0, '2023-06-14', NULL, CONCAT('MG56287431_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169809327' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '18638033100', 0, '2023-06-14', NULL, CONCAT('MG56286423_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169807752' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '15981863925', 0, '2023-06-14', NULL, CONCAT('MG56285048_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169805681' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '朱', '15803834325', 0, '2023-06-14', NULL, CONCAT('MG56284993_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169805600' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13939088544', 0, '2023-06-14', NULL, CONCAT('MG56274520_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169793529' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '郎', '18737178605', 0, '2023-06-13', NULL, CONCAT('MG56266552_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169783039' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '13607666539', 0, '2023-06-13', NULL, CONCAT('MG56266168_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169782508' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '孟', '13838290538', 0, '2023-06-13', NULL, CONCAT('MG56257483_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169770271' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13938984418', 0, '2023-06-13', NULL, CONCAT('MG56257381_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169770140' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '赵', '13838070684', 0, '2023-06-12', NULL, CONCAT('MG56245186_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169755350' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '13271582829', 0, '2023-06-12', NULL, CONCAT('MG56244499_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169754161' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘', '18037381669', 0, '2023-06-12', NULL, CONCAT('MG56244466_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169754082' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王', '15803886816', 0, '2023-06-12', NULL, CONCAT('MG56244110_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169753586' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13140067857', 0, '2023-06-12', NULL, CONCAT('MG56239351_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169746255' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '李', '13406712309', 0, '2023-06-12', NULL, CONCAT('MG56238861_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169745731' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '王芳', '15936261656', 0, '2023-06-12', NULL, CONCAT('MG56234443_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169740920' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '仝', '17752505583', 0, '2023-06-11', NULL, CONCAT('MG56220786_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169717679' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '郑先生', '15136231248', 0, '2023-06-11', NULL, CONCAT('MG56219090_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '169715088' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '耿天增', '15517156621', 0, '2023-06-11', NULL, CONCAT('MG56211953_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169704772' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '芳女生', '17739773206', 0, '2023-06-11', NULL, CONCAT('MG56206120_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169695248' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,103-采耳,301-精品修脚', 0, '刘先生', '15003940281', 0, '2023-06-11', NULL, CONCAT('MG56205261_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,103-采耳,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '169694082' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '王艳丽', '18530071994', 0, NULL, NULL, CONCAT('MG65824680_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808943' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '刘全玉', '15981902126', 0, NULL, NULL, CONCAT('MG65824684_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808947' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '杜轶', '13603990607', 0, NULL, NULL, CONCAT('MG65824686_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808949' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '114-特色足疗70分钟', 0, '曹红', '15238377329', 0, NULL, NULL, CONCAT('MG65824687_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-114-特色足疗70分钟-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808950' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '常永斌', '13103710011', 0, NULL, NULL, CONCAT('MG65824688_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808951' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '贾萌萌', '13939055901', 0, NULL, NULL, CONCAT('MG65824689_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808952' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '樊女士', '18638548661', 0, NULL, NULL, CONCAT('MG65824690_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808953' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '杨合生', '13603863355', 0, NULL, NULL, CONCAT('MG65824691_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808954' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '曹华清', '13203733815', 0, NULL, NULL, CONCAT('MG65824692_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808955' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '吴小哈', '15188375269', 0, NULL, NULL, CONCAT('MG65824693_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808956' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '白冠一', '13608686660', 0, NULL, NULL, CONCAT('MG65824694_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808957' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '马家辉', '18703657744', 0, NULL, NULL, CONCAT('MG65824695_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808958' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '114-特色足疗70分钟', 0, '石涛', '15238387637', 0, NULL, NULL, CONCAT('MG65824696_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-114-特色足疗70分钟-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808959' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '张先生', '15038395666', 0, NULL, NULL, CONCAT('MG65824697_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808960' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '张庆阳', '15138681290', 0, NULL, NULL, CONCAT('MG65824698_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808961' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '114-特色足疗70分钟', 0, '黄津', '13783408979', 0, NULL, NULL, CONCAT('MG65824699_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-114-特色足疗70分钟-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808962' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '冯军涛', '13937173501', 0, NULL, NULL, CONCAT('MG65824700_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808963' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '冯军涛', '13937173501', 0, NULL, NULL, CONCAT('MG65824701_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808963' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '何女士', '13700847106', 0, NULL, NULL, CONCAT('MG65824703_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808965' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '+郭桂敏', '18538741959', 0, NULL, NULL, CONCAT('MG65824705_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '184808967' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '209-全身推拿', 0, '杨永', '18337173660', 0, NULL, NULL, CONCAT('MG65824710_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-209-全身推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184808971' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '王艳丽', '18530071994', 0, NULL, NULL, CONCAT('MG65824711_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184808943' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '王合金', '13803911229', 0, NULL, NULL, CONCAT('MG65824712_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184808972' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '陈钇辛', '16603871777', 0, NULL, NULL, CONCAT('MG65824713_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184808973' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '李鹏飞', '18337101697', 0, NULL, NULL, CONCAT('MG65824717_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184808977' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '王明霞', '15890107203', 0, NULL, NULL, CONCAT('MG65824720_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184808980' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '刘景周', '15837138840', 0, NULL, NULL, CONCAT('MG65824726_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '184808986' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '冀豫', '13526862887', 0, NULL, NULL, CONCAT('MG65824727_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808987' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '翟华伟', '13938555456', 0, NULL, NULL, CONCAT('MG65824734_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '184808993' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '周璐璐', '18937729707', 0, NULL, NULL, CONCAT('MG65824740_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '184808998' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '白金贵', '13683839705', 0, NULL, NULL, CONCAT('MG65824741_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184808999' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '翟玉', '15838310148', 0, NULL, NULL, CONCAT('MG65824744_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '184809001' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿', 0, '范女士', '13674985677', 0, NULL, NULL, CONCAT('MG65824748_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '184809005' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张女士', '13643836430', 0, NULL, NULL, CONCAT('MG65824749_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809006' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '王莹', '17320116680', 0, NULL, NULL, CONCAT('MG65824751_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809008' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张秋芬', '13592606016', 0, NULL, NULL, CONCAT('MG65824752_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809009' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '李艳梅', '13673623435', 0, NULL, NULL, CONCAT('MG65824753_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809010' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '郑敏', '13939319915', 0, NULL, NULL, CONCAT('MG65824754_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809011' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '于先哲', '18203996209', 0, NULL, NULL, CONCAT('MG65824755_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809012' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '张福利', '13949027868', 0, NULL, NULL, CONCAT('MG65824757_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809013' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '王倩玲', '13838026204', 0, NULL, NULL, CONCAT('MG65824758_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809014' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '马可', '13607693890', 0, NULL, NULL, CONCAT('MG65824759_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809015' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '蒋云', '15638178321', 0, NULL, NULL, CONCAT('MG65824760_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809016' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '熊远成', '19138013208', 0, NULL, NULL, CONCAT('MG65824761_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809017' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '周瑞杰', '13959271761', 0, NULL, NULL, CONCAT('MG65824762_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809018' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '姚汝明', '13526639626', 0, NULL, NULL, CONCAT('MG65824763_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809019' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '陈爱华', '15237701434', 0, NULL, NULL, CONCAT('MG65824764_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809020' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '吴宝花', '18638165984', 0, NULL, NULL, CONCAT('MG65824765_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809021' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '高慧兰', '13938615237', 0, NULL, NULL, CONCAT('MG65824768_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809024' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张书琴', '19337161618', 0, NULL, NULL, CONCAT('MG65824769_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809025' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '李玉芝', '13592598058', 0, NULL, NULL, CONCAT('MG65824770_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809026' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '99张西', '13007602038', 0, NULL, NULL, CONCAT('MG65824771_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809027' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '李女士', '13673001431', 0, NULL, NULL, CONCAT('MG65824772_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809028' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '吕先生', '18336010223', 0, NULL, NULL, CONCAT('MG65824773_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809029' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '宋女士', '15738317775', 0, NULL, NULL, CONCAT('MG65824774_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809030' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '062李女士', '13383822319', 0, NULL, NULL, CONCAT('MG65824775_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809031' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '李菊兰', '15291955292', 0, NULL, NULL, CONCAT('MG65824776_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809032' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '李志云', '13733835255', 0, NULL, NULL, CONCAT('MG65824777_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809033' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '周', '15515736009', 0, NULL, NULL, CONCAT('MG65824778_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809034' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '朱虎成', '15225122281', 0, NULL, NULL, CONCAT('MG65824779_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809035' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '朱虎成', '15225122281', 0, NULL, NULL, CONCAT('MG65824780_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809035' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '欧阳霞', '15639797516', 0, NULL, NULL, CONCAT('MG65824783_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809037' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '欧阳霞', '15639797516', 0, NULL, NULL, CONCAT('MG65824784_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809037' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '欧阳霞', '15639797516', 0, NULL, NULL, CONCAT('MG65824785_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809037' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '欧阳霞', '15639797516', 0, NULL, NULL, CONCAT('MG65824786_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809037' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '张先生 胡姐', '13603865080', 0, NULL, NULL, CONCAT('MG65824787_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809038' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '张先生 胡姐', '13603865080', 0, NULL, NULL, CONCAT('MG65824788_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809038' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '刘先生', '13838189201', 0, NULL, NULL, CONCAT('MG65824791_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809040' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '张晓燕', '18037573590', 0, NULL, NULL, CONCAT('MG65824792_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809041' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '张晓燕', '18037573590', 0, NULL, NULL, CONCAT('MG65824793_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809041' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '张晓燕', '18037573590', 0, NULL, NULL, CONCAT('MG65824794_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809041' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '张晓燕', '18037573590', 0, NULL, NULL, CONCAT('MG65824795_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809041' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '周德海', '18637122576', 0, NULL, NULL, CONCAT('MG65824796_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809042' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '王丽', '15737175668', 0, NULL, NULL, CONCAT('MG65824797_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809043' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '贝贝', '13461421604', 0, NULL, NULL, CONCAT('MG65824798_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809044' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '贝贝', '13461421604', 0, NULL, NULL, CONCAT('MG65824799_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809044' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '何女士', '13700847106', 0, NULL, NULL, CONCAT('MG65824801_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184808965' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '石笑峰', '13937115799', 0, NULL, NULL, CONCAT('MG65824802_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809046' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '李彤彤', '13938569634', 0, NULL, NULL, CONCAT('MG65824803_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809047' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '102-足疗套餐A', 0, '李彤彤', '13938569634', 0, NULL, NULL, CONCAT('MG65824804_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-102-足疗套餐A-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809047' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '113-至尊足疗80分钟,206-精油开背', 0, '郭伟', '13343859556', 0, NULL, NULL, CONCAT('MG65824807_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-113-至尊足疗80分钟,206-精油开背-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '184809050' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '陈钇辛', '16603871777', 0, NULL, NULL, CONCAT('MG65824808_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '184808973' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '陈钇辛', '16603871777', 0, NULL, NULL, CONCAT('MG65824809_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '184808973' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '段卫峰', '18537180101', 0, NULL, NULL, CONCAT('MG65824810_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '184809051' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '张女士', '13333818588', 0, NULL, NULL, CONCAT('MG65824811_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '184809052' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '刘彬', '15286800109', 0, NULL, NULL, CONCAT('MG65824812_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n) nums
WHERE vi.card_number = '184809053' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '周凝芳', '15981865902', 0, NULL, NULL, CONCAT('MG65824813_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809054' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '余君丽', '18595658404', 0, NULL, NULL, CONCAT('MG65824814_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n UNION ALL SELECT 11 AS n UNION ALL SELECT 12 AS n UNION ALL SELECT 13 AS n UNION ALL SELECT 14 AS n) nums
WHERE vi.card_number = '184809055' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李志红', '13733865481', 0, NULL, NULL, CONCAT('MG65824816_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n UNION ALL SELECT 10 AS n UNION ALL SELECT 11 AS n UNION ALL SELECT 12 AS n UNION ALL SELECT 13 AS n UNION ALL SELECT 14 AS n UNION ALL SELECT 15 AS n UNION ALL SELECT 16 AS n UNION ALL SELECT 17 AS n UNION ALL SELECT 18 AS n UNION ALL SELECT 19 AS n) nums
WHERE vi.card_number = '184809056' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '刘全凤', '13598886853', 0, NULL, NULL, CONCAT('MG65824817_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809057' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '孙亚平', '15514383625', 0, NULL, NULL, CONCAT('MG65824818_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809058' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张霞', '15638109296', 0, NULL, NULL, CONCAT('MG65824820_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809060' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李金环', '13333840337', 0, NULL, NULL, CONCAT('MG65824821_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809061' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '祁雯', '1000121187', 0, NULL, NULL, CONCAT('MG65824822_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809062' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张全友', '15810885205', 0, NULL, NULL, CONCAT('MG65824823_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809063' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '娇娇', '13203710656', 0, NULL, NULL, CONCAT('MG65824824_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809064' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '沈亮', '13526803537', 0, NULL, NULL, CONCAT('MG65824825_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809065' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '刘先生', '17737176577', 0, NULL, NULL, CONCAT('MG65824826_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809066' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '陈芊羽', '15638871833', 0, NULL, NULL, CONCAT('MG65824827_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809067' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '陈芊羽', '15638871833', 0, NULL, NULL, CONCAT('MG65824828_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809067' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '王巧云', '15515722886', 0, NULL, NULL, CONCAT('MG65824829_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809068' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '301-精品修脚', 0, '张彬彬', '16650237696', 0, NULL, NULL, CONCAT('MG65824830_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809069' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '马女士', '15003871086', 0, NULL, NULL, CONCAT('MG65824832_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809071' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '杨香粉', '15136196811', 0, NULL, NULL, CONCAT('MG65824833_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809072' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '任', '18538700095', 0, NULL, NULL, CONCAT('MG65824834_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809073' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '裴女士', '15936256897', 0, NULL, NULL, CONCAT('MG65824835_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809074' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张女士', '13837114130', 0, NULL, NULL, CONCAT('MG65824836_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809075' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '99卡谢女士', '13592679350', 0, NULL, NULL, CONCAT('MG65824837_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809076' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '胡爱欣', '18567531486', 0, NULL, NULL, CONCAT('MG65824838_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809077' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '103-采耳', 0, '曹红', '15238377329', 0, NULL, NULL, CONCAT('MG65824839_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-103-采耳-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184808950' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '曹红', '15238377329', 0, NULL, NULL, CONCAT('MG65824840_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184808950' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '梁女士', '13707581722', 0, NULL, NULL, CONCAT('MG65824843_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809079' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '边女士', '13523577795', 0, NULL, NULL, CONCAT('MG65824844_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809080' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '平平', '18737145558', 0, NULL, NULL, CONCAT('MG65824846_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809082' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '黄伟', '13733748620', 0, NULL, NULL, CONCAT('MG65824847_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809083' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '魏娜', '13598872479', 0, NULL, NULL, CONCAT('MG65824848_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809084' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '杨静', '15378786744', 0, NULL, NULL, CONCAT('MG65824849_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809085' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '崔女士', '18625522251', 0, NULL, NULL, CONCAT('MG65824850_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809086' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '夏勇', '13653838152', 0, NULL, NULL, CONCAT('MG65824851_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809087' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '申茹', '13598871135', 0, NULL, NULL, CONCAT('MG65824852_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809088' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张艳', '13938525895', 0, NULL, NULL, CONCAT('MG65824853_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809089' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '张少杰', '15729391111', 0, NULL, NULL, CONCAT('MG65824854_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809090' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '100-经典足道50分钟,104-局部推拿,301-精品修脚', 0, '张莹', '18303658503', 0, NULL, NULL, CONCAT('MG65824855_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-100-经典足道50分钟,104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809091' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '马倩', '15639269628', 0, NULL, NULL, CONCAT('MG65824857_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n) nums
WHERE vi.card_number = '184809093' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '曲锋', '17753101138', 0, NULL, NULL, CONCAT('MG65824858_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '184809094' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '王有才', '18595750693', 0, NULL, NULL, CONCAT('MG65824859_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n) nums
WHERE vi.card_number = '184809095' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '乔兰', '15600460067', 0, NULL, NULL, CONCAT('MG65824864_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '184809100' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '段卫峰', '18537180101', 0, NULL, NULL, CONCAT('MG65824866_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n) nums
WHERE vi.card_number = '184809051' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '姚子薇', '15036112953', 0, NULL, NULL, CONCAT('MG65824867_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809102' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '刘冰', '15838051760', 0, NULL, NULL, CONCAT('MG65824871_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '184809106' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '周强', '15939431999', 0, NULL, NULL, CONCAT('MG65824872_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '184809107' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '徐秀玲', '15565876018', 0, NULL, NULL, CONCAT('MG65824873_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '184809108' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '刘彬', '15286800109', 0, NULL, NULL, CONCAT('MG65824874_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n) nums
WHERE vi.card_number = '184809053' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '113-至尊足疗80分钟,206-精油开背', 0, '杨永', '18337173660', 0, NULL, NULL, CONCAT('MG65824875_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-113-至尊足疗80分钟,206-精油开背-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '184808971' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '113-至尊足疗80分钟,206-精油开背', 0, '王晓岑', '13803820936', 0, NULL, NULL, CONCAT('MG65824877_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-113-至尊足疗80分钟,206-精油开背-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809110' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '田园', '13673713596', 0, NULL, NULL, CONCAT('MG65824878_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '184809111' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '韩家福', '13703926330', 0, NULL, NULL, CONCAT('MG65824879_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '184809112' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '刘', '13523496810', 0, NULL, NULL, CONCAT('MG65824880_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n) nums
WHERE vi.card_number = '184809113' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '陈国宪', '13838551523', 0, NULL, NULL, CONCAT('MG65824882_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '184809115' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李静', '17703823712', 0, NULL, NULL, CONCAT('MG65824883_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '184809116' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '王女士', '16639171468', 0, NULL, NULL, CONCAT('MG65824884_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '184809117' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '崔玉欣', '13783614454', 0, NULL, NULL, CONCAT('MG65824885_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '184809118' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李草洋', '18738489705', 0, NULL, NULL, CONCAT('MG65824886_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '184809119' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '吕方', '13083715585', 0, NULL, NULL, CONCAT('MG65824887_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n) nums
WHERE vi.card_number = '184809120' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '李栋博', '17719888087', 0, NULL, NULL, CONCAT('MG65824888_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n) nums
WHERE vi.card_number = '184809121' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '靳斌', '17752563920', 0, NULL, NULL, CONCAT('MG65824890_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n) nums
WHERE vi.card_number = '184809070' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;
INSERT INTO vip_info_ticket (vip_info_id, vip_ticket_id, ticket_name, ticket_type, vip_name, vip_phone_number, status, claim_time, expiry_date, ticket_code, org_id, source_type, remark, is_delete, create_time, update_time, amount)
SELECT vi.id, vt.id, '104-局部推拿,301-精品修脚', 0, '张女士', '13333818588', 0, NULL, NULL, CONCAT('MG65824891_', nums.n), 7, 3, '美管家系统迁移-锦艺城店-104-局部推拿,301-精品修脚-0', 0, NOW(), NOW(), 0.00
FROM vip_info vi
CROSS JOIN vip_ticket vt
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 AS n UNION ALL SELECT 3 AS n UNION ALL SELECT 4 AS n UNION ALL SELECT 5 AS n UNION ALL SELECT 6 AS n UNION ALL SELECT 7 AS n UNION ALL SELECT 8 AS n UNION ALL SELECT 9 AS n) nums
WHERE vi.card_number = '184809052' AND vi.is_delete = 0
  AND vt.ticket_name = '美管家次卡迁移模板' AND vt.is_delete = 0;

-- ============================================
-- 迁移快照 (vip_migrate_card_snapshot)
-- ============================================

INSERT INTO vip_migrate_card_snapshot (old_card_id, old_member_id, item_id, item_name, sum_times, leave_times, sum_money, leave_money, once_money, buy_date, last_consume_time, emp_saler_names, emp_saler_ids, shop_name, sex, mobile, org_id) VALUES
(85589771, 181527865, '301', '301-精品修脚', 10, 9, 350.00, 315.00, 35.00, '2026-04-05 17:58:38', '2026-04-05 17:59:00', '郭佳棋(锦艺城店)', '23023389', '锦艺城店', '女', '15093352210', 7),
(85575350, 181527852, '-1', '104-局部推拿,301-精品修脚', 10, 7, 499.00, 349.30, 49.90, '2026-04-04 21:00:50', '2026-04-11 15:53:15', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15517121203', 7),
(85244431, 214950901, '-1', '104-局部推拿,301-精品修脚', 10, 6, 499.00, 299.40, 49.90, '2026-03-22 22:06:45', '2026-04-11 21:13:58', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '15136129595', 7),
(85176189, 214828655, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2026-03-20 16:43:53', '2026-04-13 16:49:37', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18037867988', 7),
(85157877, 201668501, '-1', '104-局部推拿,301-精品修脚', 10, 8, 499.00, 399.20, 49.90, '2026-03-19 22:24:14', '2026-03-19 22:25:52', '许宝三(锦艺城店)', '22962185', '锦艺城店', '男', '18838136333', 7),
(85092885, 184809099, '301', '301-精品修脚', 10, 9, 350.00, 315.00, 35.00, '2026-03-16 22:22:45', '2026-03-16 22:23:38', '王苗(锦艺城店)', '22823910', '锦艺城店', '女', '15617679900', 7),
(85092825, 184808968, '-1', '104-局部推拿,301-精品修脚', 10, 9, 499.00, 449.10, 49.90, '2026-03-16 22:16:52', '2026-03-16 22:17:44', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '17337109636', 7),
(84997021, 214530133, '301', '301-精品修脚', 10, 10, 350.00, 350.00, 35.00, '2026-03-13 10:53:50', NULL, '王孩(锦艺城店)', '21833611', '锦艺城店', '女', '18736068837', 7),
(84993604, 201410755, '301', '301-精品修脚', 3, 1, 99.00, 33.00, 33.00, '2026-03-12 21:40:16', '2026-04-09 16:25:17', '王孩(锦艺城店)', '21833611', '锦艺城店', '男', '18569972777', 7),
(84993554, 212611738, '301', '301-精品修脚', 3, 1, 99.00, 33.00, 33.00, '2026-03-12 21:37:59', '2026-04-06 18:44:11', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13937190986', 7),
(84989204, 197182821, '301', '301-精品修脚', 3, 3, 99.00, 99.00, 33.00, '2026-03-12 19:30:51', '2026-03-07 19:16:52', '王孩(锦艺城店)', '21833611', '锦艺城店', '女', '18537285668', 7),
(84924772, 173772684, '301', '301-精品修脚', 10, 10, 350.00, 350.00, 35.00, '2026-03-10 16:54:31', '2025-09-07 18:55:15', '王孩(锦艺城店)', '21833611', '锦艺城店', '男', '18638640217', 7),
(84743066, 214213374, '301', '301-精品修脚', 10, 5, 350.00, 175.00, 35.00, '2026-03-04 18:08:54', '2026-03-28 21:46:39', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15515806010', 7),
(84710711, 210691886, '301', '301-精品修脚', 10, 8, 350.00, 280.00, 35.00, '2026-03-02 21:02:01', '2026-04-03 20:37:44', '王孩(锦艺城店)', '21833611', '锦艺城店', '女', '13937118217', 7),
(84668204, 214078468, '301', '301-精品修脚', 10, 8, 350.00, 280.00, 35.00, '2026-02-28 21:48:59', '2026-03-06 19:59:33', '刘翠(锦艺城店)', '10655587', '锦艺城店', '女', '13607661849', 7),
(84392542, 213444311, '-1', '104-局部推拿,301-精品修脚', 10, 3, 499.00, 149.70, 49.90, '2026-02-10 13:04:33', '2026-03-06 18:46:52', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13938535595', 7),
(84353740, 181527822, '1322', '1322-艾灸调理', 10, 10, 2000.00, 2000.00, 200.00, '2026-02-08 22:26:42', '2026-04-05 20:11:55', '王孩(锦艺城店)', '21833611', '锦艺城店', '女', '18637122576', 7),
(83967572, 185175861, '301', '301-精品修脚', 3, 0, 63.00, 0.00, 21.00, '2026-01-28 22:13:00', '2026-02-24 13:36:27', '备用工号(锦艺城店)', '21064207', '锦艺城店', '女', '15838359663', 7),
(83944074, 169958567, '214', '214-体验古法艾灸调理一次', 2, 1, 99.00, 49.50, 49.50, '2026-01-28 13:20:29', '2026-04-12 11:14:33', '王孩(锦艺城店)', '21833611', '锦艺城店', '女', '13838002046', 7),
(83940217, 212675771, '214', '214-体验古法艾灸调理一次', 2, 0, 99.00, 0.00, 49.50, '2026-01-28 10:47:37', '2026-03-27 11:35:53', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18625527120', 7),
(83921466, 211132271, '214', '214-体验古法艾灸调理一次', 2, 0, 99.00, 0.00, 49.50, '2026-01-27 16:16:39', '2026-04-13 16:52:10', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15093382528', 7),
(83878957, 185988191, '301', '301-精品修脚', 6, 4, 239.40, 159.60, 39.90, '2026-01-25 22:00:39', '2026-01-25 22:01:59', '备用工号(锦艺城店)', '21064207', '锦艺城店', '女', '13213177025', 7),
(83878524, 212611738, '301', '301-精品修脚', 3, 0, 106.00, 0.00, 35.33, '2026-01-25 21:49:30', '2026-04-06 18:44:11', '备用工号(锦艺城店)', '21064207', '锦艺城店', '女', '13937190986', 7),
(83819102, 183989461, '301', '301-精品修脚', 10, 9, 350.00, 315.00, 35.00, '2026-01-24 15:22:34', '2026-04-01 10:52:22', '王孩(锦艺城店)', '21833611', '锦艺城店', '女', '15286807939', 7),
(83374878, 211130995, '301', '301-精品修脚', 10, 7, 350.00, 245.00, 35.00, '2026-01-10 10:58:17', '2026-03-20 14:13:59', '杨柯(锦艺城店)', '22222572', '锦艺城店', '女', '13503846600', 7),
(83068414, 211486017, '301', '301-精品修脚', 10, 5, 350.00, 175.00, 35.00, '2025-12-31 17:41:22', '2026-03-11 17:50:46', '高燕贞(锦艺城店),杨柯(锦艺城店)', '13937467,22222572', '锦艺城店', '女', '15093564769', 7),
(82916223, 211257540, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-12-27 17:44:55', '2026-01-18 17:06:51', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '13837123310', 7),
(82859467, 199588920, '-1', '104-局部推拿,301-精品修脚', 10, 6, 499.00, 299.40, 49.90, '2025-12-25 19:59:01', '2026-03-23 19:59:13', '杨柯(锦艺城店)', '22222572', '锦艺城店', '女', '13503991279', 7),
(82831992, 181527318, '301', '301-精品修脚', 10, 10, 350.00, 350.00, 35.00, '2025-12-24 20:32:57', '2026-02-27 19:56:20', '王孩(锦艺城店)', '21833611', '锦艺城店', '女', '18537172727', 7),
(82751225, 181527822, '214', '214-体验古法艾灸调理一次', 2, 1, 99.00, 49.50, 49.50, '2025-12-21 21:50:56', '2026-04-05 20:11:55', '王孩(锦艺城店)', '21833611', '锦艺城店', '女', '18637122576', 7),
(82720393, 190022202, '301', '301-精品修脚', 10, 7, 350.00, 245.00, 35.00, '2025-12-20 21:47:26', '2026-04-11 20:38:15', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15093489056', 7),
(82134241, 192652443, '-1', '104-局部推拿,301-精品修脚', 10, 6, 499.00, 299.40, 49.90, '2025-11-30 23:00:35', '2026-04-06 22:04:02', '杨柯(锦艺城店)', '22222572', '锦艺城店', '女', '18203636121', 7),
(82134187, 210179954, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 1, 99.00, 49.50, 49.50, '2025-11-30 22:56:31', '2025-12-15 15:57:35', '焦长丽(锦艺城店)', '22348157', '锦艺城店', '女', '15038662102', 7),
(82097339, 181527526, '301', '301-精品修脚', 10, 6, 350.00, 210.00, 35.00, '2025-11-29 19:48:48', '2026-02-27 20:08:46', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '17398985656', 7),
(82058073, 197351426, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-11-29 11:25:23', '2026-03-21 11:43:58', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18338723192', 7),
(82039444, 182938465, '214', '214-体验古法艾灸调理一次', 2, 0, 99.00, 0.00, 49.50, '2025-11-28 15:22:14', '2026-03-03 12:10:19', '高燕贞(锦艺城店)', '13937467', '锦艺城店', '女', '13783502817', 7),
(81981064, 201410755, '1322', '1322-艾灸调理', 5, 3, 1000.00, 600.00, 200.00, '2025-11-25 22:47:26', '2026-04-09 16:25:17', '高燕贞(锦艺城店)', '13937467', '锦艺城店', '男', '18569972777', 7),
(81974601, 209934835, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 106.00, 35.34, 35.33, '2025-11-25 18:38:13', '2025-11-25 18:38:38', '备用工号(锦艺城店)', '21064207', '锦艺城店', '男', '17537171531', 7),
(81970729, 198527591, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 10, 0, 0.00, 0.00, 0.00, '2025-11-25 16:46:18', '2026-04-13 22:08:23', '备用工号(锦艺城店)', '21064207', '锦艺城店', '男', '18173905611', 7),
(81879322, 184808975, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 10, 0, 799.00, 0.00, 79.90, '2025-11-21 23:05:25', '2026-04-13 16:51:14', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15290826594', 7),
(81802706, 181527395, '214', '214-体验古法艾灸调理一次', 2, 1, 99.00, 49.50, 49.50, '2025-11-18 20:53:31', '2025-11-22 18:57:56', '高燕贞(锦艺城店)', '13937467', '锦艺城店', '女', '18537115199', 7),
(81779382, 181527460, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-17 21:11:22', '2026-03-29 14:45:26', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13083715585', 7),
(81746563, 209562239, '301', '301-精品修脚', 10, 7, 350.00, 245.00, 35.00, '2025-11-16 17:39:55', '2026-03-10 16:29:07', '杨柯(锦艺城店)', '22222572', '锦艺城店', '男', '15238826761', 7),
(81719913, 169865953, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-15 18:30:54', '2026-01-24 18:17:39', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13673377360', 7),
(81702323, 181527399, '301', '301-精品修脚', 10, 9, 350.00, 315.00, 35.00, '2025-11-15 11:43:33', '2026-03-21 16:48:30', '杨柯(锦艺城店)', '22222572', '锦艺城店', '女', '18625581116', 7),
(81692234, 184345168, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 2, 99.00, 99.00, 49.50, '2025-11-14 19:11:30', '2026-03-30 21:36:39', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '13838187047', 7),
(81677356, 190884631, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 1, 99.00, 49.50, 49.50, '2025-11-14 12:20:00', '2026-04-11 12:32:31', '焦长丽(锦艺城店)', '22348157', '锦艺城店', '女', '13733876320', 7),
(81670285, 209445087, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-13 21:29:05', '2025-11-16 20:07:09', '焦长丽(锦艺城店)', '22348157', '锦艺城店', '女', '15637122839', 7),
(81649556, 184808975, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-13 12:32:18', '2026-04-13 16:51:14', '焦长丽(锦艺城店)', '22348157', '锦艺城店', '女', '15290826594', 7),
(81634880, 181527336, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-12 17:45:47', '2026-03-28 21:51:30', '焦长丽(锦艺城店)', '22348157', '锦艺城店', '女', '18039666700', 7),
(81550131, 209313652, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-09 23:59:59', '2025-11-09 23:59:59', '焦长丽(锦艺城店)', '22348157', '锦艺城店', '女', '19337852565', 7),
(81545505, 207968686, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-09 20:41:47', '2026-03-20 20:43:30', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18539280565', 7),
(81524909, 198527591, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-09 14:30:23', '2026-04-13 22:08:23', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '18173905611', 7),
(81524910, 198527591, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 1, 0, 799.00, 0.00, 799.00, '2025-11-09 14:30:23', '2026-04-13 22:08:23', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '18173905611', 7),
(81512806, 169968228, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-08 22:43:20', '2026-01-03 23:31:41', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '17760770952', 7),
(81512807, 169968228, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-11-08 22:43:20', '2026-01-03 23:31:41', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '17760770952', 7),
(81487821, 181527419, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-08 13:42:26', '2026-04-10 17:39:44', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13343859556', 7),
(81487774, 201386463, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-08 13:41:26', '2025-12-15 18:19:14', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18037465161', 7),
(81487682, 181527587, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背', 2, 0, 99.00, 0.00, 49.50, '2025-11-08 13:39:23', '2026-03-14 22:08:03', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18736022332', 7),
(81258504, 208880585, '301', '301-精品修脚', 10, 3, 350.00, 105.00, 35.00, '2025-10-31 13:41:20', '2026-04-12 17:00:16', '李云飞(锦艺城店),杨柯(锦艺城店)', '10599768,22222572', '锦艺城店', '女', '13103829009', 7),
(81254275, 208874721, '-1', '104-局部推拿,301-精品修脚', 10, 8, 499.00, 399.20, 49.90, '2025-10-31 11:10:10', '2025-11-02 11:05:56', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13526764967', 7),
(81248644, 201386463, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-10-30 20:28:27', '2025-12-15 18:19:14', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18037465161', 7),
(81201734, 181527290, '301', '301-精品修脚', 10, 4, 350.00, 140.00, 35.00, '2025-10-29 10:27:33', '2026-03-28 20:09:08', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15838182696', 7),
(81201684, 208806085, '301', '301-精品修脚', 10, 6, 350.00, 210.00, 35.00, '2025-10-29 10:24:20', '2026-04-09 11:03:00', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '13949015776', 7),
(81166050, 207968686, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-10-27 20:00:51', '2026-03-20 20:43:30', '杨柯(锦艺城店)', '22222572', '锦艺城店', '女', '18539280565', 7),
(81097102, 197351426, '301', '301-精品修脚', 10, 3, 350.00, 105.00, 35.00, '2025-10-25 11:35:01', '2026-03-21 11:43:58', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18338723192', 7),
(81070903, 206549789, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-10-23 22:47:46', '2026-04-01 20:34:18', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13523518834', 7),
(81070904, 206549789, '-1', '104-局部推拿,301-精品修脚', 10, 10, 499.00, 499.00, 49.90, '2025-10-23 22:47:46', '2026-04-01 20:34:18', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13523518834', 7),
(81070905, 206549789, '-1', '104-局部推拿,301-精品修脚', 10, 3, 499.00, 149.70, 49.90, '2025-10-23 22:47:46', '2026-04-01 20:34:18', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13523518834', 7),
(81063482, 181527977, '214', '214-体验古法艾灸调理一次', 2, 0, 99.00, 0.00, 49.50, '2025-10-23 18:06:07', '2026-04-10 17:39:44', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13343859556', 7),
(81063483, 181527977, '214', '214-体验古法艾灸调理一次', 2, 2, 99.00, 99.00, 49.50, '2025-10-23 18:06:07', '2026-04-10 17:39:44', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13343859556', 7),
(81063484, 181527977, '214', '214-体验古法艾灸调理一次', 2, 2, 99.00, 99.00, 49.50, '2025-10-23 18:06:07', '2026-04-10 17:39:44', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13343859556', 7),
(80958243, 196806542, '-1', '104-局部推拿,301-精品修脚', 10, 6, 499.00, 299.40, 49.90, '2025-10-19 13:25:22', '2026-04-05 21:27:34', '王金山(锦艺城店),杨柯(锦艺城店)', '10599769,22222572', '锦艺城店', '女', '13733169451', 7),
(80937985, 208382859, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 106.00, 0.00, 35.33, '2025-10-18 16:43:27', '2025-12-19 22:00:26', '备用工号(锦艺城店)', '21064207', '锦艺城店', '男', '13849057021', 7),
(80922018, 206790510, '-1', '104-局部推拿,301-精品修脚', 10, 4, 499.00, 199.60, 49.90, '2025-10-17 21:23:39', '2026-04-11 18:50:01', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15903692186', 7),
(80877129, 201672593, '-1', '104-局部推拿,301-精品修脚', 10, 9, 499.00, 449.10, 49.90, '2025-10-16 11:12:44', '2025-10-16 11:14:03', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15036765572', 7),
(80838283, 190156327, '301', '301-精品修脚', 10, 4, 350.00, 140.00, 35.00, '2025-10-14 16:10:54', '2026-03-23 11:18:17', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15039378301', 7),
(80682425, 207968686, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-10-08 19:44:54', '2026-03-20 20:43:30', '王孩(锦艺城店)', '21833611', '锦艺城店', '女', '18539280565', 7),
(80623961, 207846000, '-1', '104-局部推拿,301-精品修脚', 10, 4, 499.00, 199.60, 49.90, '2025-10-06 13:03:53', '2026-03-09 16:47:18', '李云飞(锦艺城店),王孩(锦艺城店)', '10599768,21833611', '锦艺城店', '女', '18937128280', 7),
(80443381, 184808983, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2025-09-29 22:44:43', '2026-03-26 17:19:59', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18937171522', 7),
(80443372, 184808983, '-1', '104-局部推拿,301-精品修脚', 10, 10, 399.00, 399.00, 39.90, '2025-09-29 22:44:18', '2026-03-26 17:19:59', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18937171522', 7),
(80443337, 184808983, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-09-29 22:42:35', '2026-03-26 17:19:59', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18937171522', 7),
(80432346, 184808997, '301', '301-精品修脚', 10, 6, 350.00, 210.00, 35.00, '2025-09-29 18:31:51', '2026-02-08 21:39:06', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13213223283', 7),
(80278395, 207312065, '301', '301-精品修脚', 10, 5, 350.00, 175.00, 35.00, '2025-09-25 20:25:51', '2026-03-05 18:32:23', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13939016471', 7),
(80250478, 186019806, '-1', '104-局部推拿,301-精品修脚', 10, 10, 499.00, 499.00, 49.90, '2025-09-24 20:48:24', '2025-09-24 20:49:10', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '15638107123', 7),
(80214721, 195217020, '214', '214-体验古法艾灸调理一次', 2, 0, 99.00, 0.00, 49.50, '2025-09-23 16:34:09', '2026-03-23 18:48:57', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '18768863125', 7),
(80192971, 201410755, '214', '214-体验古法艾灸调理一次', 2, 0, 99.00, 0.00, 49.50, '2025-09-22 17:20:00', '2026-04-09 16:25:17', '员工已删除', '19647568', '锦艺城店', '男', '18569972777', 7),
(80154985, 189511239, '301', '301-精品修脚', 10, 4, 350.00, 140.00, 35.00, '2025-09-21 15:28:16', '2026-03-11 16:46:09', '员工已删除', '19647568', '锦艺城店', '男', '15824855315', 7),
(80128955, 181527290, '-1', '104-局部推拿,301-精品修脚', 10, 8, 499.00, 399.20, 49.90, '2025-09-20 17:56:35', '2026-03-28 20:09:08', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15838182696', 7),
(80128906, 181527290, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-09-20 17:55:22', '2026-03-28 20:09:08', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15838182696', 7),
(80128869, 181527290, '-1', '104-局部推拿,301-精品修脚', 10, 8, 499.00, 399.20, 49.90, '2025-09-20 17:54:34', '2026-03-28 20:09:08', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15838182696', 7),
(79989820, 196740554, '-1', '104-局部推拿,301-精品修脚', 10, 3, 399.00, 119.70, 39.90, '2025-09-15 19:04:55', '2026-04-02 19:21:46', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '16603868937', 7),
(79955445, 206824887, '-1', '104-局部推拿,301-精品修脚', 10, 2, 500.00, 100.00, 50.00, '2025-09-14 18:05:50', '2025-12-02 12:51:36', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '18595855799', 7),
(79933651, 206790510, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-09-13 22:53:47', '2026-04-11 18:50:01', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15903692186', 7),
(79826963, 206639725, '301', '301-精品修脚', 10, 7, 350.00, 245.00, 35.00, '2025-09-10 13:20:15', '2026-03-28 13:21:50', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13014503658', 7),
(79799925, 206588797, '301', '301-精品修脚', 10, 8, 350.00, 280.00, 35.00, '2025-09-09 12:28:33', '2025-12-06 11:42:52', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15136452219', 7),
(79771098, 206549789, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-09-07 20:50:17', '2026-04-01 20:34:18', '员工已删除', '19647568', '锦艺城店', '女', '13523518834', 7),
(79731532, 184808982, '301', '301-精品修脚', 10, 4, 350.00, 140.00, 35.00, '2025-09-06 16:52:14', '2026-02-07 15:17:15', '王金山(锦艺城店),员工已删除', '10599769,19647568', '锦艺城店', '女', '15838254589', 7),
(79731431, 206490576, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2025-09-06 16:49:49', '2026-03-03 20:21:59', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15939041312', 7),
(79706451, 169968228, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-09-05 17:09:06', '2026-01-03 23:31:41', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '17760770952', 7),
(79453623, 184808976, '301', '301-精品修脚', 10, 1, 350.00, 35.00, 35.00, '2025-08-26 16:01:54', '2026-03-16 15:49:13', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13653836542', 7),
(79438235, 205617524, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-08-25 18:55:27', '2026-01-19 13:56:38', '员工已删除', '19647568', '锦艺城店', '女', '13782229706', 7),
(79411734, 205576479, '301', '301-精品修脚', 10, 7, 299.00, 209.30, 29.90, '2025-08-24 17:39:53', '2026-02-06 20:31:21', '员工已删除', '19647568', '锦艺城店', '男', '13838288043', 7),
(79390200, 205540727, '301', '301-精品修脚', 10, 3, 299.00, 89.70, 29.90, '2025-08-23 19:25:15', '2026-03-13 19:49:08', '员工已删除', '19647568', '锦艺城店', '女', '15093678707', 7),
(79324865, 169865953, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-08-20 21:42:19', '2026-01-24 18:17:39', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13673377360', 7),
(79286918, 205381015, '-1', '104-局部推拿,301-精品修脚', 10, 8, 399.00, 319.20, 39.90, '2025-08-19 12:57:47', '2025-09-15 12:46:36', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13613806988', 7),
(78735423, 184808969, '-1', '104-局部推拿,301-精品修脚', 30, 26, 1197.00, 1037.40, 39.90, '2025-07-28 11:17:47', '2026-03-07 18:10:24', '刘许(锦艺城店)', '11874695', '锦艺城店', '女', '13526751061', 7),
(78486771, 204118888, '-1', '213-古法抚阳瑶灸调理一次,214-体验古法艾灸调理一次', 1, 0, 69.00, 0.00, 69.00, '2025-07-17 21:54:40', '2026-04-10 22:13:15', '员工已删除', '19647568', '锦艺城店', '女', '13676951817', 7),
(78317833, 169968228, '301', '301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-07-10 23:37:43', '2026-01-03 23:31:41', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '17760770952', 7),
(77782742, 184809099, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2025-06-20 21:38:33', '2026-03-16 22:23:38', '员工已删除', '10621389', '锦艺城店', '女', '15617679900', 7),
(77633276, 201089053, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2025-06-16 14:43:23', '2025-11-27 16:32:37', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13384006652', 7),
(77622856, 184808992, '104', '104-局部推拿', 30, 16, 1197.00, 638.40, 39.90, '2025-06-15 21:28:32', '2026-03-11 19:49:04', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15093124152', 7),
(77616124, 181527382, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-06-15 18:36:31', '2026-03-30 17:33:04', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15981878251', 7),
(77614260, 201461074, '-1', '104-局部推拿,301-精品修脚', 10, 3, 399.00, 119.70, 39.90, '2025-06-15 18:00:08', '2025-07-07 17:21:45', '员工已删除', '10621389', '锦艺城店', '女', '19139918092', 7),
(77569443, 201122423, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-06-14 12:36:04', '2025-09-13 19:02:50', '员工已删除', '19647568', '锦艺城店', '女', '15516988198', 7),
(77563568, 169865953, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-06-13 23:59:59', '2026-01-24 18:17:39', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13673377360', 7),
(77429727, 196740554, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-06-08 23:39:43', '2026-04-02 19:21:46', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '16603868937', 7),
(77390896, 201623282, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-06-07 19:06:23', '2025-09-24 19:50:02', '员工已删除', '10621389', '锦艺城店', '女', '13523036766', 7),
(77388046, 191710595, '301', '301-精品修脚', 10, 2, 350.00, 70.00, 35.00, '2025-06-07 18:04:41', '2026-04-03 21:17:34', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13526704552', 7),
(77186543, 192652443, '-1', '104-局部推拿,301-精品修脚', 10, 0, 500.00, 0.00, 50.00, '2025-05-30 23:20:40', '2026-04-06 22:04:02', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18203636121', 7),
(77183951, 194055722, '-1', '104-局部推拿,301-精品修脚', 10, 10, 399.00, 399.00, 39.90, '2025-05-30 21:20:04', '2026-03-18 15:53:36', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13703864980', 7),
(77183952, 194055722, '-1', '104-局部推拿,301-精品修脚', 10, 4, 399.00, 159.60, 39.90, '2025-05-30 21:20:04', '2026-03-18 15:53:36', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13703864980', 7),
(77175427, 201623282, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-05-30 17:42:01', '2025-09-24 19:50:02', '员工已删除', '10621389', '锦艺城店', '女', '13523036766', 7),
(77151428, 189511239, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2025-05-29 20:09:12', '2026-03-11 16:46:09', '员工已删除', '10621389', '锦艺城店', '男', '15824855315', 7),
(77131646, 201697676, '-1', '104-局部推拿,301-精品修脚', 10, 1, 500.00, 50.00, 50.00, '2025-05-28 23:09:56', '2026-03-26 22:24:08', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18337186786', 7),
(77112494, 201672593, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-28 11:44:41', '2025-10-16 11:14:03', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15036765572', 7),
(77112481, 201672560, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-28 11:43:49', '2026-03-09 16:47:18', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18937128280', 7),
(77108925, 201668501, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-05-27 22:14:43', '2026-03-19 22:25:52', '员工已删除', '19647568', '锦艺城店', '男', '18838136333', 7),
(77087646, 201623282, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-27 11:45:28', '2025-09-24 19:50:02', '员工已删除', '10621389', '锦艺城店', '女', '13523036766', 7),
(77067983, 201583052, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-26 12:57:31', '2025-06-25 19:01:24', '员工已删除', '10621389', '锦艺城店', '女', '18695887755', 7),
(77067968, 201583023, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-26 12:56:44', '2025-06-08 22:17:15', '员工已删除', '10621389', '锦艺城店', '女', '15981815113', 7),
(77063825, 201578298, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2025-05-26 09:20:51', '2025-06-25 23:04:12', '员工已删除', '10621389', '锦艺城店', '女', '18703609975', 7),
(77038651, 201543917, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-25 12:05:22', '2025-06-23 23:40:58', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15039051992', 7),
(77038609, 201543861, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-25 12:04:25', '2025-05-27 15:18:46', '员工已删除', '10621389', '锦艺城店', '女', '15517368185', 7),
(77008812, 201490052, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2025-05-24 11:59:41', '2025-07-07 16:51:44', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18638112055', 7),
(77008753, 201489354, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-24 11:57:24', '2025-06-07 14:02:51', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '13513890310', 7),
(77008713, 201489305, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2025-05-24 11:56:01', '2025-06-27 22:42:52', '员工已删除', '10621389', '锦艺城店', '女', '13333858535', 7),
(77008660, 201489253, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-24 11:54:10', '2025-06-17 17:36:28', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13903834599', 7),
(77004985, 189869820, '301', '301-精品修脚', 20, 5, 600.00, 150.00, 30.00, '2025-05-23 23:01:01', '2026-04-06 15:52:46', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13203883414', 7),
(76988286, 201461107, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-23 14:12:22', '2025-06-18 22:02:52', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13598652006', 7),
(76988261, 201461074, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-23 14:11:31', '2025-07-07 17:21:45', '员工已删除', '10621389', '锦艺城店', '女', '19139918092', 7),
(76988231, 201461014, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-23 14:10:24', '2025-06-20 17:57:26', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15294631677', 7),
(76988136, 201460893, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-23 14:07:28', '2025-06-15 16:38:26', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '19059621357', 7),
(76988100, 201460853, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2025-05-23 14:06:33', '2025-06-09 18:05:43', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15903656306', 7),
(76959409, 201424879, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-22 11:47:43', '2025-07-14 14:20:41', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18939625636', 7),
(76959384, 201424844, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-22 11:46:49', '2025-07-23 16:38:52', '员工已删除', '10621389', '锦艺城店', '女', '16696686567', 7),
(76959327, 201424799, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-22 11:45:39', '2025-07-20 15:53:37', '员工已删除', '19647568', '锦艺城店', '女', '15938710765', 7),
(76959305, 201424766, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-22 11:44:40', '2025-07-22 12:45:21', '员工已删除', '10621389', '锦艺城店', '女', '18137270778', 7),
(76959237, 201424720, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-22 11:42:52', '2025-06-13 14:46:52', '员工已删除', '10621389', '锦艺城店', '女', '19871482868', 7),
(76933734, 201386510, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2025-05-21 12:02:36', '2025-06-27 22:40:34', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '18037469008', 7),
(76933710, 201386463, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-21 12:01:34', '2025-12-15 18:19:14', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18037465161', 7),
(76933661, 201386371, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-21 11:59:16', '2025-05-21 13:45:42', '员工已删除', '10621389', '锦艺城店', '女', '15939039930', 7),
(76920513, 201366651, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-20 17:31:54', '2025-05-24 20:07:11', '员工已删除', '10621389', '锦艺城店', '男', '13608499428', 7),
(76920484, 201366586, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-20 17:30:26', '2025-06-13 13:06:34', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '13653800760', 7),
(76905132, 194843199, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2025-05-19 22:12:58', '2025-07-25 22:33:25', '员工已删除,员工已删除', '10621389,19647568', '锦艺城店', '女', '19303971737', 7),
(76883837, 201296557, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2025-05-19 11:25:07', '2025-05-29 14:58:03', '员工已删除', '10621389', '锦艺城店', '女', '17803820690', 7),
(76883775, 201296512, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-19 11:23:21', '2025-07-02 15:33:22', '员工已删除', '19647568', '锦艺城店', '女', '15188266891', 7),
(76856342, 201255527, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2025-05-18 12:40:29', '2025-06-22 17:17:33', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '15617863719', 7),
(76856306, 201255464, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-18 12:39:22', '2025-06-13 21:25:29', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '15515990371', 7),
(76854135, 201254182, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-18 12:13:14', '2025-06-23 15:12:03', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15637181886', 7),
(76854085, 201254110, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-18 12:11:41', '2025-06-20 15:37:13', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18537167283', 7),
(76854023, 201248731, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-18 12:10:12', '2025-07-01 16:56:26', '员工已删除', '10621389', '锦艺城店', '女', '13027730072', 7),
(76820156, 201190638, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-17 10:32:25', '2025-05-28 16:01:53', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18530065305', 7),
(76770576, 201122484, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-15 11:23:47', '2025-07-13 12:01:34', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13523400110', 7),
(76770555, 201122455, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-15 11:23:00', '2025-07-15 22:39:41', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15515879305', 7),
(76770521, 201122423, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-15 11:21:50', '2025-09-13 19:02:50', '员工已删除', '19647568', '锦艺城店', '女', '15516988198', 7),
(76770502, 201122397, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-15 11:20:43', '2025-05-17 14:06:53', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13838562918', 7),
(76770453, 201122367, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-15 11:19:21', '2025-06-28 18:01:42', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15803829932', 7),
(76770412, 201122312, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-15 11:17:52', '2025-05-27 16:35:36', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18339980330', 7),
(76747717, 201089185, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-14 12:03:17', '2025-07-01 13:07:17', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15038129211', 7),
(76747678, 201089152, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-14 12:02:10', '2026-04-07 13:05:36', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '13837096618', 7),
(76747612, 201089053, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-14 11:59:19', '2025-11-27 16:32:37', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13384006652', 7),
(76747563, 201088996, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-14 11:57:51', '2025-07-11 19:47:09', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15515729030', 7),
(76747519, 201088933, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-14 11:56:00', '2025-06-17 20:02:55', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15515889598', 7),
(76747498, 184809076, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2025-05-14 11:54:19', '2025-06-17 17:35:04', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13592679350', 7),
(76747461, 201088839, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, '2025-05-14 11:52:29', NULL, '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18703995827', 7),
(76747421, 201088776, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2025-05-14 11:50:21', '2025-05-27 16:41:56', '员工已删除', '19647568', '锦艺城店', '男', '13526851515', 7),
(76747376, 201088705, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-14 11:47:59', '2025-05-30 12:17:39', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18768391194', 7),
(76712465, 201056136, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-13 12:17:01', '2025-05-19 19:06:48', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13526815156', 7),
(76712420, 201056081, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-13 12:15:21', '2026-03-12 13:19:17', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '13015527755', 7),
(76712387, 201056031, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-13 12:14:04', '2025-05-20 16:43:53', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18568875113', 7),
(76712361, 171201242, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2025-05-13 12:13:01', '2025-07-01 15:56:06', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15738316199', 7),
(76712309, 201055922, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-13 12:11:00', '2025-07-09 23:15:50', '员工已删除', '10621389', '锦艺城店', '女', '13633862151', 7),
(76712199, 201055799, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-13 12:06:56', '2025-05-27 18:16:32', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15688889321', 7),
(76712184, 201055766, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2025-05-13 12:05:43', '2025-07-01 22:35:21', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15837103169', 7),
(76712028, 201055578, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, '2025-05-13 11:59:58', NULL, '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '13526722682', 7),
(76711967, 201020539, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2025-05-13 11:58:10', '2025-05-13 12:02:23', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13903859630', 7),
(76648448, 184809096, '-1', '104-局部推拿,301-精品修脚', 10, 6, 499.00, 299.40, 49.90, '2025-05-10 22:08:12', '2026-01-05 16:58:43', '员工已删除', '10621389', '锦艺城店', '女', '18336375860', 7),
(76510879, 200752308, '-1', '104-局部推拿,301-精品修脚', 10, 7, 399.00, 279.30, 39.90, '2025-05-06 21:21:17', '2025-07-26 20:45:56', '员工已删除', '19647568', '锦艺城店', '男', '13303837690', 7),
(76262091, 200337501, '301', '301-精品修脚', 10, 2, 350.00, 70.00, 35.00, '2025-04-28 22:23:08', '2026-04-11 22:52:18', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '15333835007', 7),
(76140752, 200173211, '-1', '104-局部推拿,301-精品修脚', 10, 4, 399.00, 159.60, 39.90, '2025-04-25 12:07:10', '2026-03-19 10:56:14', '员工已删除', '10621389', '锦艺城店', '男', '18625557336', 7),
(76097459, 200117168, '-1', '104-局部推拿,301-精品修脚', 10, 8, 399.00, 319.20, 39.90, '2025-04-23 17:53:15', '2025-04-23 17:53:58', '员工已删除', '19647568', '锦艺城店', '女', '13027784302', 7),
(76016882, 190022202, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2025-04-20 19:45:58', '2026-04-11 20:38:15', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15093489056', 7),
(75842278, 199686621, '301', '301-精品修脚', 10, 5, 350.00, 175.00, 35.00, '2025-04-13 22:43:56', '2026-04-01 22:27:10', '员工已删除', '19647568', '锦艺城店', '男', '13323657678', 7),
(75782543, 199588920, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2025-04-11 17:57:32', '2026-03-23 19:59:13', '员工已删除', '19647568', '锦艺城店', '女', '13503991279', 7),
(75780604, 199586361, '108', '108-足疗套餐B', 10, 1, 1000.00, 100.00, 100.00, '2025-04-11 17:00:30', '2025-09-10 15:07:26', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18739938993', 7),
(75764684, 207968686, '104', '104-局部推拿', 30, 0, 1197.00, 0.00, 39.90, '2025-04-10 20:46:30', '2026-03-20 20:43:30', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18539280565', 7),
(75251876, 198804930, '-1', '104-局部推拿,301-精品修脚', 10, 4, 399.00, 159.60, 39.90, '2025-03-25 12:18:12', '2026-03-12 18:06:00', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13838569290', 7),
(74975999, 183486483, '104', '104-局部推拿', 30, 0, 1197.00, 0.00, 39.90, '2025-03-15 12:39:34', '2025-07-01 17:01:04', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13526887094', 7),
(74927952, 207968686, '301', '301-精品修脚', 20, 6, 600.00, 180.00, 30.00, '2025-03-13 23:05:19', '2026-03-20 20:43:30', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18539280565', 7),
(74597084, 184809048, '104', '104-局部推拿', 30, 25, 1197.00, 997.50, 39.90, '2025-03-06 19:39:03', '2026-02-05 20:05:58', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13525532853', 7),
(74572212, 197936285, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, -0.00, 39.90, '2025-03-05 23:42:03', '2025-04-06 17:40:13', '员工已删除', '10621389', '锦艺城店', '女', '15515778810', 7),
(74256004, 197351426, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-02-23 18:18:48', '2026-03-21 11:43:58', '员工已删除', '18984671', '锦艺城店', '女', '18338723192', 7),
(74235844, 197317127, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2025-02-22 21:10:29', '2025-07-09 18:44:30', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18530057588', 7),
(74235754, 197319194, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-02-22 21:07:08', '2025-04-26 18:59:26', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13607681723', 7),
(74135761, 197182821, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-02-18 15:40:00', '2026-03-07 19:16:52', '员工已删除', '10621389', '锦艺城店', '女', '18537285668', 7),
(74060400, 197049400, '-1', '104-局部推拿,301-精品修脚', 10, 4, 399.00, 159.60, 39.90, '2025-02-15 14:56:32', '2026-01-31 15:56:36', '员工已删除', '10621389', '锦艺城店', '女', '13837199948', 7),
(73978028, 184808969, '104', '104-局部推拿', 30, 0, 1197.00, 0.00, 39.90, '2025-02-11 15:05:09', '2026-03-07 18:10:24', '员工已删除', '10621389', '锦艺城店', '女', '13526751061', 7),
(73963717, 196869583, '104', '104-局部推拿', 10, 6, 399.00, 239.40, 39.90, '2025-02-10 17:58:38', '2025-04-02 14:05:38', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13838255533', 7),
(73926663, 184808985, '-1', '104-局部推拿,301-精品修脚', 10, 5, 399.00, 199.50, 39.90, '2025-02-08 20:23:44', '2026-04-06 18:21:42', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13703849111', 7),
(73918614, 196806542, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2025-02-08 15:46:44', '2026-04-05 21:27:34', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13733169451', 7),
(73873040, 196740554, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-02-05 22:42:54', '2026-04-02 19:21:46', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '16603868937', 7),
(73871496, 196737978, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2025-02-05 20:36:35', '2025-08-28 20:41:48', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15036186996', 7),
(73722781, 196497125, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-01-23 17:51:14', '2026-02-10 16:36:48', '员工已删除', '10621389', '锦艺城店', '男', '18903830195', 7),
(73703059, 192652443, '-1', '104-局部推拿,301-精品修脚', 10, 0, 500.00, 0.00, 50.00, '2025-01-22 23:20:56', '2026-04-06 22:04:02', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18203636121', 7),
(73638221, 196366556, '-1', '104-局部推拿,301-精品修脚', 10, 5, 399.00, 199.50, 39.90, '2025-01-21 12:16:44', '2026-02-04 12:13:17', '李云飞(锦艺城店),王金山(锦艺城店)', '10599768,10599769', '锦艺城店', '女', '15138919045', 7),
(73369882, 181527275, '301', '301-精品修脚', 20, 1, 600.00, 30.00, 30.00, '2025-01-13 18:27:52', '2026-04-10 22:08:16', '员工已删除', '10621389', '锦艺城店', '女', '13903843219', 7),
(73369883, 181527275, '301', '301-精品修脚', 20, 0, 600.00, 0.00, 30.00, '2025-01-13 18:27:52', '2026-04-10 22:08:16', '员工已删除', '10621389', '锦艺城店', '女', '13903843219', 7),
(73340083, 195906640, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2025-01-12 19:52:50', '2026-04-03 10:39:58', '王金山(锦艺城店),员工已删除', '10599769,10621389', '锦艺城店', '男', '17837196978', 7),
(73304333, 181527845, '301', '301-精品修脚', 20, 19, 600.00, 570.00, 30.00, '2025-01-11 20:53:23', '2026-02-08 16:17:39', '员工已删除', '10621389', '锦艺城店', '女', '13674960098', 7),
(73155459, 181527660, '301', '301-精品修脚', 10, 6, 350.00, 210.00, 35.00, '2025-01-07 14:01:31', '2026-03-29 14:01:20', '李云飞(锦艺城店),王金山(锦艺城店)', '10599768,10599769', '锦艺城店', '女', '15600460067', 7),
(72992971, 189511239, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2025-01-02 14:52:59', '2026-03-11 16:46:09', '员工已删除', '10621389', '锦艺城店', '男', '15824855315', 7),
(72885631, 195238654, '104', '104-局部推拿', 10, 0, 399.00, -0.00, 39.90, '2024-12-30 15:19:00', '2026-03-26 17:18:45', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15126177203', 7),
(72875280, 181527302, '-1', '104-局部推拿,301-精品修脚', 10, 3, 500.00, 150.00, 50.00, '2024-12-30 11:17:53', '2026-03-23 11:18:17', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15039378301', 7),
(72750001, 195090892, '104', '104-局部推拿', 10, 1, 399.00, 39.90, 39.90, '2024-12-26 19:40:00', '2025-06-10 20:07:05', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15837150126', 7),
(72709423, 195032328, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-12-25 17:19:35', '2026-02-25 12:55:19', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15803849392', 7),
(72700267, 195022645, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-12-25 14:10:13', '2025-07-15 21:01:23', '员工已删除', '10621389', '锦艺城店', '男', '18737190517', 7),
(72682145, 184809048, '104', '104-局部推拿', 10, 0, 499.00, 0.00, 49.90, '2024-12-24 18:32:49', '2026-02-05 20:05:58', '员工已删除', '10621389', '锦艺城店', '女', '13525532853', 7),
(72665684, 194981198, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-12-24 12:06:29', '2025-07-28 11:13:10', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '15639298280', 7),
(72659991, 194975756, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-12-23 22:04:43', '2025-07-13 12:02:52', '员工已删除', '10621389', '锦艺城店', '男', '13803892953', 7),
(72632577, 170418418, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-12-22 23:18:15', '2026-01-26 15:16:46', '员工已删除', '10621389', '锦艺城店', '女', '15937121813', 7),
(72548568, 194843199, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-12-20 19:00:21', '2025-07-25 22:33:25', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '19303971737', 7),
(72467905, 194747463, '104', '104-局部推拿', 10, 4, 399.00, 159.60, 39.90, '2024-12-18 14:43:57', '2025-04-06 17:41:15', '李云飞(锦艺城店),员工已删除', '10599768,10621389', '锦艺城店', '女', '15515537612', 7),
(72453348, 194732488, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-12-17 20:31:45', '2025-12-30 17:12:29', '李云飞(锦艺城店),高燕贞(锦艺城店)', '10599768,13937467', '锦艺城店', '女', '13148227907', 7),
(72383502, 184644041, '301', '301-精品修脚', 20, 16, 600.00, 480.00, 30.00, '2024-12-15 18:50:46', '2025-10-27 14:30:03', '李云飞(锦艺城店),员工已删除', '10599768,10621389', '锦艺城店', '女', '13676921165', 7),
(72351928, 184809097, '301', '301-精品修脚', 10, 5, 350.00, 175.00, 35.00, '2024-12-14 21:55:34', '2025-04-25 21:34:38', '员工已删除', '10621389', '锦艺城店', '女', '13523048596', 7),
(72234712, 184809099, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-12-11 23:29:29', '2026-03-16 22:23:38', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15617679900', 7),
(72115695, 184534920, '301', '301-精品修脚', 10, 8, 350.00, 280.00, 35.00, '2024-12-08 13:53:57', '2025-05-19 22:22:13', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15038216160', 7),
(72115530, 194385294, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-12-08 13:49:30', '2024-12-24 21:19:25', '员工已删除', '10609292', '锦艺城店', '女', '13503844988', 7),
(72013134, 184809095, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-12-05 11:50:58', '2025-04-23 18:43:02', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18595750693', 7),
(72013135, 184809095, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-12-05 11:50:58', '2025-04-23 18:43:02', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18595750693', 7),
(72007276, 194239013, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-12-04 21:47:43', '2026-03-17 20:53:53', '王金山(锦艺城店),员工已删除', '10599769,10621389', '锦艺城店', '女', '15738315363', 7),
(71948214, 194149882, '104', '104-局部推拿', 10, 1, 399.00, 39.90, 39.90, '2024-12-02 21:04:08', '2025-08-25 22:26:58', '员工已删除', '10621389', '锦艺城店', '女', '13838251685', 7),
(71906588, 181527270, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-12-01 16:55:30', '2026-03-22 16:31:08', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15537251018', 7),
(71894914, 194055722, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-12-01 12:43:23', '2026-03-18 15:53:36', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13703864980', 7),
(71785648, 184708403, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 20, 10, 1380.00, 690.00, 69.00, '2024-11-28 13:20:55', '2025-06-16 17:01:54', '员工已删除', '10609292', '锦艺城店', '女', '18736099998', 7),
(71678067, 193720960, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-11-24 14:45:55', '2025-06-06 22:58:51', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15981867936', 7),
(71661877, 184644041, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 10, 3, 790.00, 237.00, 79.00, '2024-11-23 19:45:37', '2025-10-27 14:30:03', '员工已删除', '10609292', '锦艺城店', '女', '13676921165', 7),
(71557436, 183989675, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-11-20 12:33:34', '2026-04-01 10:52:22', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15286807939', 7),
(71490329, 185175861, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-11-17 20:44:32', '2026-02-24 13:36:27', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15838359663', 7),
(71459449, 193454132, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-11-16 22:21:47', '2026-03-06 22:40:43', '员工已删除,员工已删除', '10609292,10621389', '锦艺城店', '女', '18737325787', 7),
(71385315, 190674384, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 20, 0, 1380.00, 0.00, 69.00, '2024-11-14 20:49:15', '2026-03-14 21:51:26', '员工已删除', '10609292', '锦艺城店', '女', '13949131618', 7),
(71267772, 184809114, '104', '104-局部推拿', 10, 6, 399.00, 239.40, 39.90, '2024-11-11 16:41:30', '2025-03-20 14:47:32', '员工已删除', '10609292', '锦艺城店', '女', '17596574484', 7),
(71267740, 184809114, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 20, 8, 1380.00, 552.00, 69.00, '2024-11-11 16:40:44', '2025-03-20 14:47:32', '员工已删除', '10609292', '锦艺城店', '女', '17596574484', 7),
(71260318, 185720369, '104', '104-局部推拿', 10, 4, 399.00, 159.60, 39.90, '2024-11-11 14:18:46', '2025-02-16 15:54:26', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13937181055', 7),
(71246280, 193194044, '-1', '104-局部推拿,301-精品修脚', 10, 2, 399.00, 79.80, 39.90, '2024-11-10 22:03:09', '2025-05-12 14:33:56', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13598017542', 7),
(71153244, 193073637, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-11-08 19:24:51', '2025-02-18 15:55:18', '员工已删除', '10621389', '锦艺城店', '女', '13525568751', 7),
(71152177, 193086413, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-11-08 19:05:23', '2024-11-11 15:54:35', '李云飞(锦艺城店),员工已删除', '10599768,10621389', '锦艺城店', '女', '15225465242', 7),
(71141867, 193074295, '301', '301-精品修脚', 10, 2, 350.00, 70.00, 35.00, '2024-11-08 16:04:40', '2025-09-27 12:13:05', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '13937102369', 7),
(71141244, 193073637, '301', '301-精品修脚', 10, 4, 350.00, 140.00, 35.00, '2024-11-08 15:51:41', '2025-02-18 15:55:18', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13525568751', 7),
(71106464, 192975154, '301', '301-精品修脚', 20, 9, 600.00, 270.00, 30.00, '2024-11-07 15:27:32', '2026-02-25 12:54:49', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15803849391', 7),
(70954527, 192652443, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-11-02 22:24:10', '2026-04-06 22:04:02', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18203636121', 7),
(70920058, 181527293, '104', '104-局部推拿', 10, 6, 399.00, 239.40, 39.90, '2024-11-01 22:32:16', '2025-09-25 21:29:31', '员工已删除', '10609292', '锦艺城店', '女', '17639298811', 7),
(70826659, 186019806, '-1', '104-局部推拿,301-精品修脚', 10, 3, 499.00, 149.70, 49.90, '2024-10-29 20:00:58', '2025-09-24 20:49:10', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '15638107123', 7),
(70703982, 184809081, '301', '301-精品修脚', 20, 6, 600.00, 180.00, 30.00, '2024-10-25 21:18:23', '2026-03-13 15:49:07', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13526678852', 7),
(70649862, 207968686, '104', '104-局部推拿', 30, 0, 1197.00, 0.00, 39.90, '2024-10-24 21:42:11', '2026-03-20 20:43:30', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18539280565', 7),
(70624942, 207968686, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-10-23 22:57:19', '2026-03-20 20:43:30', '高燕贞(锦艺城店)', '13937467', '锦艺城店', '女', '18539280565', 7),
(70598173, 192043626, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-10-22 22:52:52', '2024-12-22 15:47:45', '员工已删除', '10621389', '锦艺城店', '男', '13014583123', 7),
(70574308, 192012377, '301', '301-精品修脚', 10, 8, 350.00, 280.00, 35.00, '2024-10-22 10:11:01', '2025-08-26 16:09:32', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '18629945512', 7),
(70529869, 182791335, '301', '301-精品修脚', 10, 1, 350.00, 35.00, 35.00, '2024-10-20 15:41:54', '2025-11-01 20:15:33', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '17303717019', 7),
(70432447, 184345168, '301', '301-精品修脚', 20, 0, 600.00, 0.00, 30.00, '2024-10-16 23:32:35', '2026-03-30 21:36:39', '员工已删除', '10621389', '锦艺城店', '男', '13838187047', 7),
(70432417, 184345168, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-10-16 23:26:54', '2026-03-30 21:36:39', '员工已删除', '10621389', '锦艺城店', '男', '13838187047', 7),
(70432418, 184345168, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-10-16 23:26:54', '2026-03-30 21:36:39', '员工已删除', '10621389', '锦艺城店', '男', '13838187047', 7),
(70432419, 184345168, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-10-16 23:26:54', '2026-03-30 21:36:39', '员工已删除', '10621389', '锦艺城店', '男', '13838187047', 7),
(70350432, 191710919, '301', '301-精品修脚', 10, 2, 350.00, 70.00, 35.00, '2024-10-13 23:17:03', '2025-09-02 17:29:52', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '15617950975', 7),
(70350241, 191710595, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-10-13 22:46:53', '2026-04-03 21:17:34', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13526704552', 7),
(70302051, 191664158, '301', '301-精品修脚', 10, 4, 350.00, 140.00, 35.00, '2024-10-13 12:07:32', '2026-01-11 18:17:08', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15038281545', 7),
(70259231, 191609876, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 20, 5, 1380.00, 345.00, 69.00, '2024-10-11 18:44:24', '2025-06-08 17:10:29', '员工已删除', '10609292', '锦艺城店', '女', '13526503842', 7),
(70254725, 191601369, '301', '301-精品修脚', 10, 3, 350.00, 105.00, 35.00, '2024-10-11 16:56:36', '2026-03-21 17:20:36', '高燕贞(锦艺城店)', '13937467', '锦艺城店', '男', '13837673222', 7),
(70111637, 181527306, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 20, 0, 1380.00, 0.00, 69.00, '2024-10-06 17:59:50', '2026-03-24 19:09:47', '员工已删除', '10609292', '锦艺城店', '女', '18037160069', 7),
(69732036, 190840964, '104', '104-局部推拿', 10, 4, 399.00, 159.60, 39.90, '2024-09-25 22:35:55', '2025-03-15 22:06:57', '员工已删除', '10609292', '锦艺城店', '女', '15137139580', 7),
(69479313, 181527290, '301', '301-精品修脚', 10, 0, 300.00, 0.00, 30.00, '2024-09-17 18:10:45', '2026-03-28 20:09:08', '员工已删除', '10621389', '锦艺城店', '女', '15838182696', 7),
(69479314, 181527290, '301', '301-精品修脚', 10, 0, 300.00, 0.00, 30.00, '2024-09-17 18:10:45', '2026-03-28 20:09:08', '员工已删除', '10621389', '锦艺城店', '女', '15838182696', 7),
(69430464, 181527306, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-09-15 22:15:51', '2026-03-24 19:09:47', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18037160069', 7),
(69430465, 181527306, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-09-15 22:15:51', '2026-03-24 19:09:47', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18037160069', 7),
(69430466, 181527306, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-09-15 22:15:51', '2026-03-24 19:09:47', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18037160069', 7),
(69430467, 181527306, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-09-15 22:15:51', '2026-03-24 19:09:47', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18037160069', 7),
(69430468, 181527306, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-09-15 22:15:51', '2026-03-24 19:09:47', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18037160069', 7),
(69430469, 181527306, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-09-15 22:15:51', '2026-03-24 19:09:47', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18037160069', 7),
(69362631, 190302099, '301', '301-精品修脚', 10, 6, 300.00, 180.00, 30.00, '2024-09-14 11:03:22', '2026-03-31 11:45:31', '员工已删除', '10621389', '锦艺城店', '女', '13247195362', 7),
(69362632, 190302099, '301', '301-精品修脚', 10, 0, 300.00, 0.00, 30.00, '2024-09-14 11:03:22', '2026-03-31 11:45:31', '员工已删除', '10621389', '锦艺城店', '女', '13247195362', 7),
(69268869, 190156327, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2024-09-10 22:10:45', '2026-03-23 11:18:17', '员工已删除', '10621389', '锦艺城店', '女', '15039378301', 7),
(69263304, 190143177, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 20, 3, 1380.00, 207.00, 69.00, '2024-09-10 19:21:27', '2025-08-24 17:43:29', '员工已删除', '10609292', '锦艺城店', '女', '13071091113', 7),
(69200435, 190097265, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-09-09 15:40:45', '2025-02-18 13:21:19', '员工已删除', '12612467', '锦艺城店', '女', '15803888795', 7),
(69200054, 190096588, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2024-09-09 15:29:16', '2025-04-26 13:47:29', '员工已删除', '10609292', '锦艺城店', '女', '13071070773', 7),
(69200055, 190096588, '-1', '104-局部推拿,301-精品修脚', 10, 10, 399.00, 399.00, 39.90, '2024-09-09 15:29:16', '2025-04-26 13:47:29', '员工已删除', '10609292', '锦艺城店', '女', '13071070773', 7),
(69200056, 190096588, '-1', '104-局部推拿,301-精品修脚', 10, 10, 399.00, 399.00, 39.90, '2024-09-09 15:29:16', '2025-04-26 13:47:29', '员工已删除', '10609292', '锦艺城店', '女', '13071070773', 7),
(69175398, 184809023, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 20, 7, 1400.00, 490.00, 70.00, '2024-09-08 17:53:23', '2025-08-18 21:20:30', '员工已删除', '10621389', '锦艺城店', '女', '13838121054', 7),
(69151619, 190022202, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-09-07 21:41:17', '2026-04-11 20:38:15', '员工已删除', '14155667', '锦艺城店', '女', '15093489056', 7),
(69021090, 169865953, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2024-09-02 20:55:29', '2026-01-24 18:17:39', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13673377360', 7),
(68820312, 189511239, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-08-28 19:50:20', '2026-03-11 16:46:09', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '15824855315', 7),
(68820175, 184265868, '104', '104-局部推拿', 10, 1, 499.00, 49.90, 49.90, '2024-08-28 19:46:12', '2024-10-09 19:26:49', '员工已删除', '10621389', '锦艺城店', '男', '15890096270', 7),
(68707009, 184809052, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 20, 10, 1380.00, 690.00, 69.00, '2024-08-24 21:55:55', '2026-04-01 11:43:00', '员工已删除', '10609292', '锦艺城店', '女', '13333818588', 7),
(68676885, 187211409, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 10, 0, 790.00, 0.00, 79.00, '2024-08-23 21:47:36', '2026-03-13 19:52:50', '员工已删除', '10609292', '锦艺城店', '女', '18638527031', 7),
(68567359, 169745412, '-1', '104-局部推拿,301-精品修脚', 10, 3, 350.00, 105.00, 35.00, '2024-08-20 10:48:39', '2026-03-20 21:26:37', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '15837177337', 7),
(68545739, 181527558, '-1', '104-局部推拿,301-精品修脚', 10, 5, 300.00, 150.00, 30.00, '2024-08-19 12:44:01', '2025-08-24 20:58:16', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15515659756', 7),
(68545740, 181527558, '-1', '104-局部推拿,301-精品修脚', 10, 0, 300.00, 0.00, 30.00, '2024-08-19 12:44:01', '2025-08-24 20:58:16', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15515659756', 7),
(68492879, 181527265, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-17 19:00:57', '2026-03-26 17:19:59', '王金山(锦艺城店),员工已删除', '10599769,14155667', '锦艺城店', '女', '18937171522', 7),
(68492880, 181527265, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-17 19:00:57', '2026-03-26 17:19:59', '王金山(锦艺城店),员工已删除', '10599769,14155667', '锦艺城店', '女', '18937171522', 7),
(68492881, 181527265, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-17 19:00:57', '2026-03-26 17:19:59', '王金山(锦艺城店),员工已删除', '10599769,14155667', '锦艺城店', '女', '18937171522', 7),
(68476395, 181528121, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-08-17 11:30:24', '2026-03-07 19:01:25', '员工已删除', '10621389', '锦艺城店', '女', '13903862303', 7),
(68475693, 181527603, '-1', '104-局部推拿,301-精品修脚', 10, 0, 300.00, 0.00, 30.00, '2024-08-17 11:08:05', '2026-04-06 15:52:46', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13203883414', 7),
(68475695, 181527603, '-1', '104-局部推拿,301-精品修脚', 10, 0, 300.00, 0.00, 30.00, '2024-08-17 11:08:05', '2026-04-06 15:52:46', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13203883414', 7),
(68459188, 184808944, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-08-16 15:21:05', '2026-03-23 16:30:07', '员工已删除', '10621389', '锦艺城店', '女', '13949033282', 7),
(68459189, 184808944, '104', '104-局部推拿', 10, 5, 399.00, 199.50, 39.90, '2024-08-16 15:21:05', '2026-03-23 16:30:07', '员工已删除', '10621389', '锦艺城店', '女', '13949033282', 7),
(68459190, 184808944, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-08-16 15:21:05', '2026-03-23 16:30:07', '员工已删除', '10621389', '锦艺城店', '女', '13949033282', 7),
(68447522, 182967030, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2024-08-15 21:20:08', '2025-11-13 20:19:12', '王金山(锦艺城店),员工已删除', '10599769,12612467', '锦艺城店', '女', '13838394928', 7),
(68447523, 182967030, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-15 21:20:08', '2025-11-13 20:19:12', '王金山(锦艺城店),员工已删除', '10599769,12612467', '锦艺城店', '女', '13838394928', 7),
(68447524, 182967030, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-15 21:20:08', '2025-11-13 20:19:12', '王金山(锦艺城店),员工已删除', '10599769,12612467', '锦艺城店', '女', '13838394928', 7),
(68438948, 181784938, '301', '301-精品修脚', 10, 3, 0.00, 0.00, 0.00, '2024-08-15 16:51:21', '2026-03-30 14:10:03', '刘许(锦艺城店)', '11874695', '锦艺城店', '女', '13223713056', 7),
(68371922, 181527290, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-12 16:35:04', '2026-03-28 20:09:08', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15838182696', 7),
(68371923, 181527290, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-12 16:35:04', '2026-03-28 20:09:08', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15838182696', 7),
(68371924, 181527290, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-12 16:35:04', '2026-03-28 20:09:08', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '15838182696', 7),
(68371601, 184808976, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-08-12 16:25:26', '2026-03-16 15:49:13', '员工已删除', '10621389', '锦艺城店', '女', '13653836542', 7),
(68357991, 184345168, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-11 22:52:42', '2026-03-30 21:36:39', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '13838187047', 7),
(68357992, 184345168, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-11 22:52:42', '2026-03-30 21:36:39', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '13838187047', 7),
(68357993, 184345168, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-11 22:52:42', '2026-03-30 21:36:39', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '13838187047', 7),
(68306897, 188686096, '301', '301-精品修脚', 10, 3, 350.00, 105.00, 35.00, '2024-08-10 10:54:35', '2025-05-25 17:02:04', '李云飞(锦艺城店),员工已删除', '10599768,12612467', '锦艺城店', '女', '13938440466', 7),
(68208314, 181527399, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-07 22:09:53', '2026-03-21 16:48:30', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18625581116', 7),
(68208315, 181527399, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, -0.00, 39.90, '2024-08-07 22:09:53', '2026-03-21 16:48:30', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18625581116', 7),
(68208316, 181527399, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-08-07 22:09:53', '2026-03-21 16:48:30', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18625581116', 7),
(68164361, 188462257, '301', '301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-08-06 11:12:38', '2026-04-03 16:35:39', '员工已删除', '10621389', '锦艺城店', '女', '13733185802', 7),
(68158490, 188454121, '-1', '104-局部推拿,301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-08-05 20:22:51', '2025-08-03 17:57:40', '员工已删除', '10621389', '锦艺城店', '女', '13937173050', 7),
(67945882, 188051404, '-1', '104-局部推拿,301-精品修脚', 10, 0, 499.00, 0.00, 49.90, '2024-07-28 16:22:53', '2024-09-20 22:10:53', '王金山(锦艺城店),员工已删除', '10599769,10621389', '锦艺城店', '女', '18239268213', 7),
(67944163, 184809007, '-1', '104-局部推拿,301-精品修脚', 10, 0, 350.00, 0.00, 35.00, '2024-07-28 15:40:10', '2025-03-13 21:12:45', '员工已删除', '10621389', '锦艺城店', '女', '18530080362', 7),
(67937284, 169958567, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-07-28 12:05:04', '2026-04-12 11:14:33', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13838002046', 7),
(67937285, 169958567, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-07-28 12:05:04', '2026-04-12 11:14:33', '李云飞(锦艺城店)', ',10599768', '锦艺城店', '女', '13838002046', 7),
(67937286, 169958567, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-07-28 12:05:04', '2026-04-12 11:14:33', '李云飞(锦艺城店)', ',10599768', '锦艺城店', '女', '13838002046', 7),
(67932863, 188030235, '-1', '104-局部推拿,301-精品修脚', 10, 4, 350.00, 140.00, 35.00, '2024-07-27 22:10:10', '2024-09-29 22:32:46', '员工已删除', '10609292', '锦艺城店', '男', '18910888617', 7),
(67923958, 181527306, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-07-27 17:56:19', '2026-03-24 19:09:47', '员工已删除', '10621389', '锦艺城店', '女', '18037160069', 7),
(67923959, 181527306, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-07-27 17:56:19', '2026-03-24 19:09:47', '王金山(锦艺城店)', ',10599769', '锦艺城店', '女', '18037160069', 7),
(67923960, 181527306, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-07-27 17:56:19', '2026-03-24 19:09:47', '员工已删除', ',10609292', '锦艺城店', '女', '18037160069', 7),
(67903045, 185067650, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-07-26 20:02:44', '2025-02-06 22:54:48', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15736758089', 7),
(67903046, 185067650, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-07-26 20:02:44', '2025-02-06 22:54:48', '李云飞(锦艺城店)', ',10599768', '锦艺城店', '女', '15736758089', 7),
(67903047, 185067650, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-07-26 20:02:44', '2025-02-06 22:54:48', '李云飞(锦艺城店)', ',10599768', '锦艺城店', '女', '15736758089', 7),
(67857868, 187919235, '-1', '104-局部推拿,301-精品修脚', 10, 1, 499.00, 49.90, 49.90, '2024-07-24 19:10:13', '2025-05-30 15:04:42', '员工已删除', '10621389', '锦艺城店', '女', '15136105861', 7),
(67751823, 187789321, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 20, 5, 1380.00, 345.00, 69.00, '2024-07-21 17:20:56', '2026-03-05 17:12:57', '员工已删除', '10609292', '锦艺城店', '女', '13938505661', 7),
(67738756, 185097667, '104', '104-局部推拿', 10, 4, 399.00, 159.60, 39.90, '2024-07-21 11:04:47', '2025-07-12 20:47:46', '员工已删除', '10609292', '锦艺城店', '男', '17638106615', 7),
(67635897, 187611384, '104', '104-局部推拿', 10, 5, 399.00, 199.50, 39.90, '2024-07-17 12:30:18', '2026-03-05 17:12:57', '员工已删除', '10609292', '锦艺城店', '女', '13938505661', 7),
(67522902, 187447879, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 10, 2, 790.00, 158.00, 79.00, '2024-07-12 22:03:11', '2024-09-26 19:06:41', '王金山(锦艺城店),员工已删除', '10599769,10609292', '锦艺城店', '女', '15093447811', 7),
(67432171, 184345168, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-07-09 17:17:11', '2026-03-30 21:36:39', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '13838187047', 7),
(67364699, 187211409, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-07-06 22:08:39', '2026-03-13 19:52:50', '员工已删除', '10609292', '锦艺城店', '女', '18638527031', 7),
(67348025, 187187254, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-07-06 15:16:59', '2024-10-11 22:20:37', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '18539987100', 7),
(67233507, 187007048, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-07-01 21:48:39', '2025-04-10 22:29:35', '员工已删除,员工已删除', '10609292,14155667', '锦艺城店', '女', '17337141889', 7),
(67223528, 186986802, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2024-07-01 16:51:34', '2024-09-29 20:21:56', '王金山(锦艺城店),员工已删除', '10599769,10621389', '锦艺城店', '女', '15939027808', 7),
(67182012, 183599374, '-1', '104-局部推拿,301-精品修脚', 10, 4, 399.00, 159.60, 39.90, '2024-06-30 22:46:55', '2024-09-25 22:25:07', '员工已删除', '14155667', '锦艺城店', '男', '15803880972', 7),
(67011817, 186602969, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, -0.00, 39.90, '2024-06-24 21:12:26', '2025-11-13 20:19:12', '员工已删除', '10621389', '锦艺城店', '女', '13838394928', 7),
(66987438, 186559227, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-06-23 22:31:35', '2026-04-09 22:08:16', '员工已删除,员工已删除', '10621389,14155667', '锦艺城店', '男', '13838005175', 7),
(66912532, 186449677, '-1', '104-局部推拿,301-精品修脚', 10, 5, 399.00, 199.50, 39.90, '2024-06-21 17:14:46', '2026-03-24 17:19:45', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13803862503', 7),
(66774049, 186282590, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-06-16 23:02:23', '2025-07-12 17:43:22', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '17329315555', 7),
(66773974, 186282477, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-06-16 22:55:17', '2026-04-02 22:45:53', '员工已删除', '12612467', '锦艺城店', '男', '15838351859', 7),
(66767031, 207968686, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-06-16 19:22:57', '2026-03-20 20:43:30', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18539280565', 7),
(66767032, 207968686, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-06-16 19:22:57', '2026-03-20 20:43:30', '王金山(锦艺城店)', ',10599769', '锦艺城店', '女', '18539280565', 7),
(66638783, 186122742, '104', '104-局部推拿', 10, 0, 399.00, -0.00, 39.90, '2024-06-13 12:16:50', '2024-10-03 11:12:37', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '18037797511', 7),
(66627816, 183984678, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-06-12 20:17:08', '2026-03-22 19:59:35', '员工已删除', '10609292', '锦艺城店', '女', '18768890235', 7),
(66569690, 186019806, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-06-10 20:39:24', '2025-09-24 20:49:10', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '15638107123', 7),
(66554510, 185992160, '-1', '104-局部推拿,301-精品修脚', 10, 1, 399.00, 39.90, 39.90, '2024-06-10 11:04:36', '2025-02-21 16:14:36', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '19939711166', 7),
(66552814, 185988191, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-06-09 22:52:04', '2026-01-25 22:01:59', '员工已删除,员工已删除', '10609292,12612467', '锦艺城店', '女', '13213177025', 7),
(66544865, 185976253, '104', '104-局部推拿', 10, 2, 399.00, 79.80, 39.90, '2024-06-09 18:57:28', '2026-03-30 20:02:04', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '13673696660', 7),
(66493710, 185905310, '104', '104-局部推拿', 10, 1, 399.00, 39.90, 39.90, '2024-06-07 22:40:07', '2025-08-24 17:43:29', '员工已删除', '10609292', '锦艺城店', '女', '13071091113', 7),
(66292159, 181527293, '-1', '105-小腿排酸,205-腹部按摩,206-精油开背,208-头疗SPA', 50, 20, 2950.00, 1180.00, 59.00, '2024-05-31 22:02:03', '2025-09-25 21:29:31', '员工已删除', '10609292', '锦艺城店', '女', '17639298811', 7),
(66186488, 181527318, '-1', '104-局部推拿,301-精品修脚', 10, 2, 399.00, 79.80, 39.90, '2024-05-28 12:40:35', '2026-02-27 19:56:20', '员工已删除', '11484177', '锦艺城店', '女', '18537172727', 7),
(66181810, 169968228, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-05-27 23:26:31', '2026-01-03 23:31:41', '李云飞(锦艺城店)', '10599768', '锦艺城店', '男', '17760770952', 7),
(66066764, 185175861, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-05-23 22:44:00', '2026-02-24 13:36:27', '员工已删除', '11484177', '锦艺城店', '女', '15838359663', 7),
(66041368, 185146952, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-05-22 22:29:00', '2025-02-21 19:33:40', '王龙龙(锦艺城店),员工已删除', '10814452,13390068', '锦艺城店', '女', '18137157779', 7),
(66022755, 183599835, '-1', '104-局部推拿,301-精品修脚', 10, 2, 399.00, 79.80, 39.90, '2024-05-22 14:31:15', '2024-06-07 13:50:19', '员工已删除', '10621389', '锦艺城店', '女', '15238651859', 7),
(66014674, 185097705, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-05-21 23:12:11', '2025-08-23 15:47:36', '李云飞(锦艺城店),于江群(锦艺城店)', '10599768,10615209', '锦艺城店', '女', '15038307973', 7),
(65989174, 185067650, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-05-21 10:25:06', '2025-02-06 22:54:48', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15736758089', 7),
(65989175, 185067650, '104', '104-局部推拿', 10, 0, 399.00, 0.00, 39.90, '2024-05-21 10:25:06', '2025-02-06 22:54:48', '李云飞(锦艺城店)', ',10599768', '锦艺城店', '女', '15736758089', 7),
(65923379, 184962186, '104', '104-局部推拿', 10, 4, 399.00, 159.60, 39.90, '2024-05-18 22:26:00', '2024-10-29 22:16:48', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13298158833', 7),
(65861297, 176297481, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-05-16 23:11:58', '2024-07-18 22:41:06', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15838013119', 7),
(65846021, 184833158, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-05-16 15:30:11', '2025-01-05 17:03:11', '员工已删除', '10621389', '锦艺城店', '女', '15937113767', 7),
(65720434, 184643729, '-1', '104-局部推拿,301-精品修脚', 10, 9, 399.00, 359.10, 39.90, '2024-05-11 22:32:18', '2024-06-20 21:48:25', '员工已删除,员工已删除', '10609292,12612467', '锦艺城店', '女', '18037276585', 7),
(65628081, 184534920, '104', '104-局部推拿', 10, 0, 398.00, 0.00, 39.80, '2024-05-08 22:53:09', '2025-05-19 22:22:13', '员工已删除', '11484177', '锦艺城店', '女', '15038216160', 7),
(65628082, 184534920, '104', '104-局部推拿', 10, 0, 398.00, 0.00, 39.80, '2024-05-08 22:53:09', '2025-05-19 22:22:13', '王金山(锦艺城店)', ',10599769', '锦艺城店', '女', '15038216160', 7),
(65617849, 184520498, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-05-08 17:44:56', '2024-10-13 16:48:00', '员工已删除', '11484177', '锦艺城店', '男', '15038193202', 7),
(65566116, 184460807, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-05-06 18:28:49', '2025-10-15 18:20:24', '员工已删除,员工已删除', '10621389,11484177', '锦艺城店', '男', '17398960789', 7),
(65486059, 184345168, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-05-03 21:39:26', '2026-03-30 21:36:39', '王金山(锦艺城店)', '10599769', '锦艺城店', '男', '13838187047', 7),
(65402048, 184221131, '-1', '104-局部推拿,301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-04-30 22:15:10', '2024-08-12 18:56:28', '员工已删除', '10609292', '锦艺城店', '男', '15515550528', 7),
(65387720, 184198372, '-1', '104-局部推拿,301-精品修脚', 10, 3, 399.00, 119.70, 39.90, '2024-04-30 17:22:12', '2024-08-12 20:57:05', '王龙龙(锦艺城店)', '10814452', '锦艺城店', '男', '17737709209', 7),
(65202868, 183965232, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-04-25 16:12:01', '2024-09-05 16:34:36', '刘许(锦艺城店)', '11874695', '锦艺城店', '女', '15639297787', 7),
(65126232, 183731526, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-04-23 11:51:20', '2025-04-19 10:46:30', '员工已删除', '11484177', '锦艺城店', '女', '13838174939', 7),
(65053670, 183509594, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-04-20 17:58:37', '2024-07-02 14:48:41', '员工已删除,员工已删除', '10609292,10621389', '锦艺城店', '女', '18137843702', 7),
(64939235, 169746124, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-04-16 20:38:33', '2025-08-22 18:51:10', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15093107218', 7),
(64939236, 169746124, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-04-16 20:38:33', '2025-08-22 18:51:10', '李云飞(锦艺城店)', ',10599768', '锦艺城店', '女', '15093107218', 7),
(64930482, 183333275, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 1, 399.00, 39.90, 39.90, '2024-04-16 16:47:38', '2025-05-06 22:23:39', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13733087797', 7),
(64853842, 207968686, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-04-13 21:30:50', '2026-03-20 20:43:30', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18539280565', 7),
(64853843, 207968686, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-04-13 21:30:50', '2026-03-20 20:43:30', '王金山(锦艺城店)', ',10599769', '锦艺城店', '女', '18539280565', 7),
(64707776, 182967030, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, -0.00, 39.90, '2024-04-08 20:39:52', '2025-11-13 20:19:12', '员工已删除,王金山(锦艺城店)', '10609292,10599769', '锦艺城店', '女', '13838394928', 7),
(64685303, 181844124, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-04-07 22:24:08', '2024-04-27 20:35:26', '--', '', '锦艺城店', '女', '15036387394', 7),
(64633388, 182842027, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-04-05 22:15:40', '2024-10-01 22:35:01', '员工已删除,王金山(锦艺城店)', '10609292,10599769', '锦艺城店', '女', '13523055717', 7),
(64559775, 173772684, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 2, 399.00, 79.80, 39.90, '2024-04-02 21:04:41', '2025-09-07 18:55:15', '员工已删除', '10621389', '锦艺城店', '男', '18638640217', 7),
(64522109, 182626281, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 5, 399.00, 199.50, 39.90, '2024-04-01 15:43:44', '2024-04-06 15:52:31', '李云飞(锦艺城店),员工已删除,员工已删除', '10599768,10621389,11484177', '锦艺城店', '女', '17698002233', 7),
(64490605, 174281794, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-03-31 17:15:44', '2024-12-25 22:46:24', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '18736066183', 7),
(64402619, 181844195, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-28 14:31:00', '2024-05-21 19:25:55', '--', '', '锦艺城店', '女', '13552344448', 7),
(64401577, 181905174, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-28 13:59:35', '2024-04-12 22:47:47', '--', '', '锦艺城店', '女', '15378724406', 7),
(64401540, 181905137, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-28 13:58:34', '2024-05-10 21:16:06', '--', '', '锦艺城店', '女', '13201153999', 7),
(64374360, 181868767, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 1, 0.00, 0.00, 0.00, '2024-03-27 12:48:15', '2024-03-28 23:02:49', '--', '', '锦艺城店', '女', '15638906813', 7),
(64323688, 181784938, '301', '301-精品修脚', 10, 0, 399.00, 0.00, 39.90, '2024-03-25 12:20:31', '2026-03-30 14:10:03', '王金山(锦艺城店)', '10599769', '锦艺城店', '女', '13223713056', 7),
(64306842, 181527462, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 6, 399.00, 239.40, 39.90, '2024-03-24 16:54:41', '2025-05-11 11:30:23', '李云飞(锦艺城店)', '10599768', '锦艺城店', '女', '15903626612', 7),
(64306843, 181527462, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-03-24 16:54:41', '2025-05-11 11:30:23', '李云飞(锦艺城店)', ',10599768', '锦艺城店', '女', '15903626612', 7),
(64301762, 181753690, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-03-24 14:57:07', '2025-04-23 18:43:02', '员工已删除', '11484177', '锦艺城店', '女', '18595750693', 7),
(64301763, 181753690, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-03-24 14:57:07', '2025-04-23 18:43:02', '员工已删除', ',11484177', '锦艺城店', '女', '18595750693', 7),
(64289682, 181716162, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-23 21:47:05', '2024-11-14 22:19:11', '--', '', '锦艺城店', '女', '13014560701', 7),
(64265734, 181687244, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-23 11:30:00', '2024-04-27 16:57:10', '--', '', '锦艺城店', '男', '18737198699', 7),
(64261467, 181679854, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-03-22 23:11:56', '2024-12-02 15:41:55', '李云飞(锦艺城店),员工已删除', '10599768,11484177', '锦艺城店', '女', '18825989852', 7),
(64251075, 181663383, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-22 17:21:40', '2024-04-06 19:18:08', '--', '', '锦艺城店', '女', '15893546728', 7),
(64236212, 181645317, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-21 22:21:56', '2024-04-09 11:25:43', '--', '', '锦艺城店', '女', '13203827085', 7),
(64236204, 181645304, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-21 22:21:21', '2024-04-08 17:10:02', '--', '', '锦艺城店', '女', '13103939126', 7),
(64236194, 181645292, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 1, 0.00, 0.00, 0.00, '2024-03-21 22:20:36', '2024-04-02 20:00:20', '--', '', '锦艺城店', '女', '15638529091', 7),
(64236188, 181645272, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 1, 0.00, 0.00, 0.00, '2024-03-21 22:19:44', '2024-04-28 18:14:24', '--', '', '锦艺城店', '女', '18614984134', 7),
(64236179, 181645251, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 2, 0.00, 0.00, 0.00, '2024-03-21 22:18:52', '2024-04-27 20:04:16', '--', '', '锦艺城店', '女', '15514383625', 7),
(64236162, 171201242, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-21 22:18:10', '2025-07-01 15:56:06', '--', '', '锦艺城店', '女', '15738316199', 7),
(64236131, 181645201, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 2, 0.00, 0.00, 0.00, '2024-03-21 22:16:30', '2024-03-23 18:03:11', '--', '', '锦艺城店', '女', '15290409020', 7),
(64236096, 181645163, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-21 22:14:31', '2024-07-12 15:43:14', '--', '', '锦艺城店', '女', '15093204171', 7),
(64236067, 181645144, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 0, 0.00, 0.00, 0.00, '2024-03-21 22:13:14', '2024-06-27 10:36:38', '--', '', '锦艺城店', '女', '13838962965', 7),
(64236032, 181599391, '-1', '100-经典足道50分钟,104-局部推拿,206-精油开背,301-精品修脚,601-洗面', 3, 2, 0.00, 0.00, 0.00, '2024-03-21 22:10:55', '2024-06-18 18:11:54', '--', '', '锦艺城店', '女', '13598886853', 7),
(64227253, 181629171, '-1', '104-局部推拿,301-精品修脚,601-洗面', 10, 0, 399.00, 0.00, 39.90, '2024-03-21 17:15:24', '2024-12-23 18:36:17', '员工已删除', '11484177', '锦艺城店', '男', '17796650311', 7),
(64207345, 181599391, '100', '100-经典足道50分钟', 1, 1, 0.00, 0.00, 0.00, '2024-03-20 18:48:26', '2024-06-18 18:11:54', '--', '', '锦艺城店', '女', '13598886853', 7),
(64207346, 181599391, '104', '104-局部推拿', 1, 1, 0.00, 0.00, 0.00, '2024-03-20 18:48:26', '2024-06-18 18:11:54', '--', '', '锦艺城店', '女', '13598886853', 7),
(64207347, 181599391, '301', '301-精品修脚', 1, 0, 0.00, 0.00, 0.00, '2024-03-20 18:48:26', '2024-06-18 18:11:54', '--', '', '锦艺城店', '女', '13598886853', 7),
(61911573, 173809341, '100', '100-经典足道50分钟', 10, 0, 450.00, 0.00, 45.00, '2023-12-30 18:33:57', '2026-01-21 14:55:38', '--', '', '锦艺城店', '女', '18538086996', 7),
(61028477, 171125949, '301', '301-精品修脚', -99, 0, 199.00, 0.00, 0.00, '2023-12-05 22:10:45', '2024-03-15 19:13:49', '--', '', '锦艺城店', '女', '13937051998', 7),
(60965110, 177437048, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-12-03 18:18:09', '2023-12-03 18:18:30', '员工已删除', '9410328', '锦艺城店', '女', '13700855983', 7),
(60701986, 177042527, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-11-24 17:29:34', '2023-11-24 17:29:52', '员工已删除', '9410328', '锦艺城店', '男', '13526800103', 7),
(60566050, 170193805, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-11-19 17:04:29', '2024-08-16 21:33:59', '员工已删除', '9410328', '锦艺城店', '男', '13592585501', 7),
(60156936, 176241701, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-11-05 21:15:09', '2023-11-26 19:53:23', '员工已删除', '10149487', '锦艺城店', '女', '15522426728', 7),
(60044727, 176077200, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-11-02 11:37:58', '2023-11-06 16:57:40', '员工已删除', '9664826', '锦艺城店', '女', '13837113645', 7),
(60025680, 176051638, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-11-01 16:42:50', '2023-11-10 17:34:32', '员工已删除', '10149487', '锦艺城店', '女', '15225074834', 7),
(60025600, 176051577, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-11-01 16:41:22', '2023-11-01 16:41:48', '员工已删除', '10149487', '锦艺城店', '女', '13523582760', 7),
(59982935, 169708661, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-10-31 11:37:58', '2024-01-27 22:14:01', '员工已删除', '9357447', '锦艺城店', '女', '15324885591', 7),
(59957777, 175929176, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-10-30 11:07:37', '2024-04-13 16:27:23', '员工已删除', '10149506', '锦艺城店', '男', '13623826180', 7),
(59942274, 175908539, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-10-29 17:06:12', '2023-11-12 16:36:33', '员工已删除', '10149487', '锦艺城店', '女', '15137199295', 7),
(59940118, 169756310, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-10-29 16:21:01', '2025-10-13 19:29:39', '员工已删除', '9410328', '锦艺城店', '男', '15039090826', 7),
(59924034, 175884800, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-10-28 23:16:51', '2026-03-05 20:38:09', '员工已删除,员工已删除,员工已删除', '9357447,9410328,10149487', '锦艺城店', '女', '17562615447', 7),
(59921530, 175881218, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-10-28 21:18:45', '2023-12-01 13:30:12', '员工已删除', '9357447', '锦艺城店', '男', '18638010326', 7),
(59905077, 175856963, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-10-28 15:10:40', '2023-11-26 21:37:29', '员工已删除,员工已删除', '9357447,10149506', '锦艺城店', '男', '15903616130', 7),
(59862192, 175794001, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-10-26 20:46:03', '2024-05-12 23:59:59', '员工已删除', '10149506', '锦艺城店', '女', '15093210767', 7),
(59787990, 175698251, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 3, 550.00, 165.00, 55.00, '2023-10-23 20:15:47', '2023-11-06 20:23:22', '员工已删除,员工已删除', '9357486,9410328', '锦艺城店', '女', '17744612190', 7),
(59762746, 175670247, '-1', '', 3, 2, 0.00, 0.00, 0.00, '2023-10-23 14:27:29', '2023-10-23 14:27:49', '员工已删除', '10149506', '锦艺城店', '女', '13838108196', 7),
(59719835, 175607060, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-10-21 19:02:36', '2023-10-29 21:08:25', '员工已删除', '9357486', '锦艺城店', '女', '15515512321', 7),
(59711530, 175595578, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-10-21 16:05:03', '2023-10-23 15:46:20', '员工已删除', '9357486', '锦艺城店', '女', '13838028116', 7),
(59638388, 175495047, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-10-18 15:53:17', '2023-11-03 14:57:01', '员工已删除', '10149506', '锦艺城店', '男', '18336330197', 7),
(59638222, 175495047, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-10-18 15:48:46', '2023-11-03 14:57:01', '员工已删除', '9664826', '锦艺城店', '男', '18336330197', 7),
(59605696, 175450172, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 5, 550.00, 275.00, 55.00, '2023-10-16 23:08:56', '2023-10-27 14:13:44', '员工已删除', '9357486', '锦艺城店', '男', '18137657592', 7),
(59604656, 175448811, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-10-16 21:53:00', '2023-10-16 21:53:32', '员工已删除', '9357446', '锦艺城店', '女', '15838223689', 7),
(59604573, 171269072, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-10-16 21:48:52', '2026-03-22 19:08:55', '员工已删除', '10149506', '锦艺城店', '女', '15003886836', 7),
(59546103, 169931394, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-10-14 19:46:51', '2024-11-18 17:20:16', '--', '', '锦艺城店', '男', '13938259535', 7),
(59540374, 170116117, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-10-14 18:11:27', '2024-03-31 17:22:41', '员工已删除,员工已删除', '9357486,9664826', '锦艺城店', '女', '13623860750', 7),
(59402537, 171682128, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-10-09 17:58:00', '2023-11-25 21:00:59', '员工已删除', '10149487', '锦艺城店', '女', '18937179062', 7),
(59384390, 175050916, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-10-08 20:23:58', '2025-09-07 11:39:37', '员工已删除,员工已删除', '9410328,10149487', '锦艺城店', '男', '15838236525', 7),
(59347309, 174994727, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-10-07 15:35:35', '2023-10-07 15:35:56', '员工已删除', '10149487', '锦艺城店', '女', '18903814477', 7),
(59333973, 174975801, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-10-06 21:33:20', '2023-10-08 20:32:07', '员工已删除', '10149487', '锦艺城店', '男', '13838338265', 7),
(59238647, 171599671, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-10-03 13:04:47', '2025-02-28 19:59:23', '员工已删除', '10149487', '锦艺城店', '男', '13526626257', 7),
(59132118, 170194035, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-28 22:35:39', '2023-10-08 19:23:17', '员工已删除', '9730472', '锦艺城店', '女', '13938528421', 7),
(59110023, 174639816, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-09-28 15:05:51', '2023-09-28 15:06:07', '--', '', '锦艺城店', '男', '13343831360', 7),
(59086416, 174596413, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-09-27 21:23:34', '2026-03-16 22:23:38', '员工已删除', '9357447', '锦艺城店', '女', '15617679900', 7),
(59051676, 170367148, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-09-26 22:51:27', '2025-04-06 19:35:07', '员工已删除', '9357486', '锦艺城店', '男', '18538020014', 7),
(59051654, 170367148, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-09-26 22:49:24', '2025-04-06 19:35:07', '员工已删除', '9410328', '锦艺城店', '男', '18538020014', 7),
(59023412, 174491563, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-09-26 12:11:14', '2023-09-26 12:11:31', '员工已删除', '9410328', '锦艺城店', '女', '13673373646', 7),
(58981799, 169790453, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-24 20:48:49', '2023-09-30 11:10:29', '员工已删除', '9357488', '锦艺城店', '女', '15136227238', 7),
(58958564, 174399399, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-09-24 13:27:50', '2023-09-24 13:28:11', '员工已删除', '9664826', '锦艺城店', '女', '18503800495', 7),
(58940914, 170266168, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-23 18:38:58', '2025-04-11 16:58:08', '员工已删除', '9357447', '锦艺城店', '女', '15890107203', 7),
(58932519, 169896352, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-09-23 16:11:48', '2025-07-01 16:56:26', '员工已删除', '9410328', '锦艺城店', '男', '13027730072', 7),
(58932346, 170744033, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-09-23 16:08:34', '2023-09-23 16:10:34', '员工已删除', '9664826', '锦艺城店', '女', '13014559768', 7),
(58913959, 170033203, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 7, 550.00, 385.00, 55.00, '2023-09-22 21:01:31', '2023-11-20 20:45:18', '员工已删除,员工已删除', '9410328,9730472', '锦艺城店', '女', '15138489677', 7),
(58899540, 174319257, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-22 15:13:46', '2023-09-30 17:36:13', '员工已删除', '9730472', '锦艺城店', '男', '15639007267', 7),
(58885435, 174294401, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-21 21:00:09', '2024-10-01 20:40:02', '--', '', '锦艺城店', '男', '13383713881', 7),
(58881300, 174289314, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-09-21 19:16:43', '2023-09-21 19:16:59', '员工已删除', '9664826', '锦艺城店', '女', '13937199249', 7),
(58864661, 174270376, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-21 11:59:15', '2023-09-30 20:31:03', '员工已删除', '9730472', '锦艺城店', '女', '18539902848', 7),
(58864609, 174270317, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-09-21 11:57:29', '2023-09-28 15:12:24', '员工已删除', '9357486', '锦艺城店', '女', '18937621981', 7),
(58858827, 174254988, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-09-20 23:04:31', '2023-10-31 23:18:06', '员工已删除,员工已删除,员工已删除,员工已删除', '9357447,9357486,9410328,10085126', '锦艺城店', '女', '13837171114', 7),
(58854514, 174249731, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-20 20:30:54', '2023-09-30 20:05:42', '员工已删除', '9357447', '锦艺城店', '男', '15890697161', 7),
(58846984, 174239520, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-09-20 17:23:10', '2023-09-20 17:24:14', '员工已删除', '9410328', '锦艺城店', '女', '15838309106', 7),
(58845538, 174237532, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-20 16:54:09', '2023-09-30 17:40:36', '--', '', '锦艺城店', '男', '13676955503', 7),
(58807949, 174078434, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-19 13:46:53', '2023-09-30 12:26:43', '员工已删除', '9357488', '锦艺城店', '女', '13803830865', 7),
(58797585, 169931394, '301', '301-精品修脚', -99, 0, 199.00, 0.00, 0.00, '2023-09-18 20:59:17', '2024-11-18 17:20:16', '员工已删除', '9357488', '锦艺城店', '男', '13938259535', 7),
(58789100, 169739011, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-09-18 17:12:08', '2023-09-18 17:12:55', '员工已删除', '9357447', '锦艺城店', '女', '15638501071', 7),
(58775347, 169796373, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-09-18 10:19:39', '2023-10-26 11:10:40', '--', '', '锦艺城店', '女', '18937137737', 7),
(58761832, 173978845, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 5, 550.00, 275.00, 55.00, '2023-09-17 18:19:20', '2025-09-25 21:29:31', '员工已删除,员工已删除', '9357486,9664826', '锦艺城店', '女', '17639298811', 7),
(58729848, 173931956, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-16 18:35:45', '2023-11-21 16:13:58', '员工已删除', '9357488', '锦艺城店', '女', '13938500220', 7),
(58729680, 169929675, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-09-16 18:31:59', '2023-12-25 17:53:03', '员工已删除', '9410328', '锦艺城店', '男', '18695888500', 7),
(58723187, 172577378, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-09-16 16:39:07', '2026-03-24 19:09:47', '员工已删除', '9357488', '锦艺城店', '女', '18037160069', 7),
(58702883, 173894132, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-15 20:22:38', '2023-11-20 15:45:52', '员工已删除', '9730472', '锦艺城店', '女', '18037889899', 7),
(58701901, 173892930, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-15 19:59:27', '2023-10-03 19:04:34', '员工已删除', '9664826', '锦艺城店', '女', '17639343413', 7),
(58680094, 173864074, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-09-14 22:38:08', '2023-09-14 22:38:24', '员工已删除', '9357488', '锦艺城店', '男', '18530037912', 7),
(58677515, 169941452, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-09-14 21:02:50', '2026-01-17 18:08:16', '员工已删除', '9357488', '锦艺城店', '女', '13503998687', 7),
(58676130, 170040209, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-14 20:27:24', '2023-09-28 22:41:41', '--', '', '锦艺城店', '男', '18638677998', 7),
(58681814, 173835339, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-09-14 00:00:00', '2023-09-15 10:12:34', '员工已删除', '9410328', '锦艺城店', '女', '18638563337', 7),
(58647817, 173812009, '301', '301-精品修脚', -99, -99, 199.00, 199.00, 0.00, '2023-09-13 19:40:12', '2024-06-21 17:31:32', '员工已删除', '9730472', '锦艺城店', '女', '13643712837', 7);

INSERT INTO vip_migrate_card_snapshot (old_card_id, old_member_id, item_id, item_name, sum_times, leave_times, sum_money, leave_money, once_money, buy_date, last_consume_time, emp_saler_names, emp_saler_ids, shop_name, sex, mobile, org_id) VALUES
(58646344, 173809886, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-13 18:49:39', '2023-09-26 21:23:47', '员工已删除', '9730472', '锦艺城店', '男', '13723053190', 7),
(58645925, 173809341, '110', '项目已删除', 10, 10, 450.00, 450.00, 45.00, '2023-09-13 18:37:12', '2026-01-21 14:55:38', '员工已删除,员工已删除', '9664826,9730472', '锦艺城店', '女', '18538086996', 7),
(58635306, 173784768, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-09-13 13:35:56', '2023-09-26 18:39:15', '员工已删除', '9410328', '锦艺城店', '男', '13592591892', 7),
(58628483, 173775611, '301', '301-精品修脚', -99, -99, 199.00, 199.00, 0.00, '2023-09-12 22:16:06', '2025-04-25 21:34:38', '员工已删除', '9730472', '锦艺城店', '女', '13523048596', 7),
(58626195, 173772684, '301', '301-精品修脚', -99, 0, 199.00, 0.00, 0.00, '2023-09-12 20:52:14', '2025-09-07 18:55:15', '员工已删除', '9664826', '锦艺城店', '男', '18638640217', 7),
(58604502, 173743981, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-12 10:30:24', '2023-09-14 11:04:35', '--', '', '锦艺城店', '女', '13803863867', 7),
(58603503, 169812040, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-09-11 23:59:59', '2025-12-15 18:19:14', '员工已删除', '9357488', '锦艺城店', '男', '18037465161', 7),
(58603261, 169721230, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 1, 550.00, 55.00, 55.00, '2023-09-11 23:02:24', '2024-09-24 22:00:35', '员工已删除', '9664826', '锦艺城店', '女', '13526682861', 7),
(58602113, 169812040, '-1', '', 3, 1, 0.00, 0.00, 0.00, '2023-09-11 21:42:23', '2025-12-15 18:19:14', '员工已删除', '9357488', '锦艺城店', '男', '18037465161', 7),
(58599298, 170071542, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-09-11 20:08:51', '2023-09-27 18:33:56', '员工已删除', '9357488', '锦艺城店', '女', '15238031915', 7),
(58591811, 173723491, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, '2023-09-11 16:59:35', NULL, '--', '', '锦艺城店', '男', '19903711590', 7),
(58591180, 173722848, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-09-11 16:44:35', '2023-09-29 22:30:34', '--', '', '锦艺城店', '女', '13508661096', 7),
(58569988, 170228429, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-10 18:41:24', '2024-11-07 15:10:32', '员工已删除', '9357447', '锦艺城店', '女', '13703863224', 7),
(58551895, 171289903, '301', '301-精品修脚', -99, -99, 199.00, 199.00, 0.00, '2023-09-10 11:31:31', '2025-05-12 22:32:52', '员工已删除', '9730472', '锦艺城店', '男', '18603853023', 7),
(58547807, 173648565, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-09-09 22:26:08', '2023-09-09 22:27:15', '员工已删除', '9410328', '锦艺城店', '男', '18539970953', 7),
(58541326, 169939369, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-09 19:26:35', '2023-09-22 19:44:04', '员工已删除', '9664826', '锦艺城店', '女', '13938251558', 7),
(58541262, 173639113, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-09 19:25:01', '2023-09-22 19:43:30', '员工已删除', '9730472', '锦艺城店', '男', '13938243376', 7),
(58517961, 173599161, '301', '301-精品修脚', -99, -99, 199.00, 199.00, 0.00, '2023-09-08 22:10:30', '2024-05-11 18:51:45', '员工已删除,员工已删除,员工已删除', '9357447,9410328,9730472', '锦艺城店', '女', '15713899953', 7),
(58515656, 173596396, '301', '301-精品修脚', -99, -99, 199.00, 199.00, 0.00, '2023-09-08 21:01:35', '2024-02-25 19:12:45', '员工已删除,员工已删除', '9357488,9664826', '锦艺城店', '男', '13526715150', 7),
(58515570, 173596176, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 4, 550.00, 220.00, 55.00, '2023-09-08 20:59:14', '2024-02-25 19:11:47', '员工已删除,员工已删除', '9357488,9664826', '锦艺城店', '女', '13523422468', 7),
(58515488, 173596176, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-08 20:57:00', '2024-02-25 19:11:47', '员工已删除', '9664826', '锦艺城店', '女', '13523422468', 7),
(58511094, 173587454, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-08 18:50:37', '2023-09-20 13:55:05', '员工已删除', '9730472', '锦艺城店', '男', '13837108773', 7),
(58508096, 170277287, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-08 17:20:28', '2023-09-29 23:31:57', '员工已删除', '9730472', '锦艺城店', '男', '18937626566', 7),
(58508023, 173583508, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-09-08 17:18:24', '2023-10-19 15:35:27', '员工已删除', '9664826', '锦艺城店', '女', '18703676987', 7),
(58507886, 173583357, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-09-08 17:14:59', '2023-10-16 15:30:18', '员工已删除', '9357446', '锦艺城店', '男', '15937160888', 7),
(58483617, 173551219, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-07 16:58:32', '2023-09-29 20:53:04', '员工已删除', '9664826', '锦艺城店', '男', '15638400452', 7),
(58483585, 173551219, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-07 16:57:22', '2023-09-29 20:53:04', '员工已删除', '9730472', '锦艺城店', '男', '15638400452', 7),
(58468325, 172713062, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-07 10:56:52', '2023-09-23 16:35:08', '员工已删除', '9357488', '锦艺城店', '男', '18950151312', 7),
(58455798, 173515481, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-09-06 18:39:10', '2025-12-25 18:51:34', '员工已删除', '9410328', '锦艺城店', '女', '15093118704', 7),
(58434709, 173465821, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-06 10:20:24', '2023-10-05 21:58:11', '员工已删除', '9664826', '锦艺城店', '女', '13803815770', 7),
(58434645, 173465821, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-06 10:18:59', '2023-10-05 21:58:11', '员工已删除', '9664826', '锦艺城店', '女', '13803815770', 7),
(58418534, 173445323, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-09-05 16:06:13', '2024-08-19 14:08:56', '员工已删除', '9730472', '锦艺城店', '女', '15938758868', 7),
(58417410, 173444045, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-05 15:33:40', '2023-09-27 18:37:26', '--', '', '锦艺城店', '男', '13937128142', 7),
(58444295, 171350531, '301', '301-精品修脚', -99, -99, 199.00, 199.00, 0.00, '2023-09-05 00:00:00', '2023-11-26 16:52:01', '员工已删除', '9357447', '锦艺城店', '男', '13603415335', 7),
(58401972, 173424406, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-09-04 19:00:17', '2023-09-07 21:11:29', '员工已删除', '9730472', '锦艺城店', '女', '18137181005', 7),
(58382290, 173389637, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-03 21:04:17', '2023-09-30 20:06:13', '员工已删除', '9357447', '锦艺城店', '女', '17737712003', 7),
(58380149, 169838985, '-1', '', 3, 2, 0.00, 0.00, 0.00, '2023-09-03 20:15:13', '2023-09-03 21:41:07', '--', '', '锦艺城店', '男', '15038353355', 7),
(58376018, 173380277, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-03 18:34:29', '2023-09-29 21:32:43', '员工已删除', '9357488', '锦艺城店', '男', '15515920890', 7),
(58372813, 173376072, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-03 17:32:23', '2023-09-23 16:22:24', '员工已删除', '9357447', '锦艺城店', '女', '15290889610', 7),
(58364301, 173354095, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-09-03 14:17:05', '2024-05-19 14:20:50', '员工已删除,员工已删除', '9410328,9730472', '锦艺城店', '女', '13073739125', 7),
(58356448, 173339927, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-02 23:07:04', '2023-09-28 10:54:55', '员工已删除', '9410328', '锦艺城店', '女', '18503860110', 7),
(58356414, 173339927, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-02 23:03:43', '2023-09-28 10:54:55', '员工已删除', '9664826', '锦艺城店', '女', '18503860110', 7),
(58353162, 173334657, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-02 20:49:56', '2023-09-25 17:01:13', '--', '', '锦艺城店', '女', '13598892166', 7),
(58353104, 173334545, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-02 20:48:36', '2023-09-25 17:00:36', '--', '', '锦艺城店', '女', '13523530936', 7),
(58319627, 169812040, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-09-01 17:49:45', '2025-12-15 18:19:14', '员工已删除', '9730472', '锦艺城店', '男', '18037465161', 7),
(58310774, 173245089, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-09-01 13:55:57', '2023-09-04 15:10:56', '员工已删除', '9410328', '锦艺城店', '女', '13603848587', 7),
(58255551, 170043644, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-30 12:05:28', '2023-09-17 21:24:05', '员工已删除', '9357486', '锦艺城店', '男', '13523078550', 7),
(58251864, 169756310, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-08-29 23:59:59', '2025-10-13 19:29:39', '员工已删除,员工已删除', '9357488,9410328', '锦艺城店', '男', '15039090826', 7),
(58250451, 173105758, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-29 21:41:15', '2023-08-29 21:41:34', '--', '', '锦艺城店', '女', '18937623045', 7),
(58235646, 173065605, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-29 13:49:05', '2023-11-27 23:27:25', '--', '', '锦艺城店', '女', '15981892167', 7),
(58206841, 172996579, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 1, 550.00, 55.00, 55.00, '2023-08-27 23:51:22', '2023-11-01 23:45:57', '员工已删除,员工已删除,员工已删除,员工已删除', '9357447,9357488,9357548,9664826', '锦艺城店', '女', '18237857887', 7),
(58204406, 172992736, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-27 21:20:03', '2023-09-22 20:26:21', '员工已删除', '9410328', '锦艺城店', '女', '15836989295', 7),
(58204373, 172992654, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-27 21:18:36', '2023-09-22 20:26:52', '员工已删除', '9357488', '锦艺城店', '男', '15837516256', 7),
(58191064, 172973156, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-08-27 16:06:22', '2026-02-24 13:59:24', '员工已删除', '9357447', '锦艺城店', '男', '13525570085', 7),
(58189559, 172971001, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-27 15:29:36', '2023-10-20 20:25:40', '员工已删除', '9664826', '锦艺城店', '女', '17638765835', 7),
(58164575, 172937994, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-26 17:17:16', '2023-09-09 18:34:08', '员工已删除', '9664826', '锦艺城店', '男', '18538723082', 7),
(58164452, 172937865, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-26 17:15:13', '2023-09-25 17:57:04', '员工已删除', '9730472', '锦艺城店', '女', '13014232688', 7),
(58144846, 172907041, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-08-25 21:51:45', '2023-10-14 20:23:12', '员工已删除', '9730472', '锦艺城店', '女', '18737164806', 7),
(58140519, 172900786, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-25 19:45:14', '2023-08-25 19:45:32', '员工已删除', '9357548', '锦艺城店', '男', '13253587888', 7),
(58119086, 170363201, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-24 22:25:40', '2023-10-03 10:55:39', '员工已删除', '9730472', '锦艺城店', '女', '13837192526', 7),
(58111107, 172820312, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-24 18:15:38', '2023-09-22 14:49:19', '员工已删除', '9357548', '锦艺城店', '女', '18037155515', 7),
(58105701, 172811737, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-08-24 15:50:14', '2023-09-07 18:08:56', '员工已删除,员工已删除', '9357488,9883951', '锦艺城店', '女', '15937191339', 7),
(58095430, 172795405, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-08-23 23:04:04', '2023-12-23 19:22:27', '员工已删除', '9357548', '锦艺城店', '女', '18622637317', 7),
(58093180, 172791943, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-23 21:10:34', '2023-08-23 21:10:49', '员工已删除', '9730472', '锦艺城店', '女', '16799973999', 7),
(58091537, 172789495, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-23 20:20:49', '2023-08-31 19:06:34', '员工已删除', '9410328', '锦艺城店', '女', '17337199905', 7),
(58090909, 172788525, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 2, 550.00, 110.00, 55.00, '2023-08-23 20:00:55', '2023-11-02 21:40:04', '员工已删除,员工已删除', '9357447,9357488', '锦艺城店', '男', '18339806011', 7),
(58067447, 172738677, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-22 21:27:41', '2023-08-22 21:28:01', '员工已删除', '9357447', '锦艺城店', '女', '17724828835', 7),
(58046828, 172713062, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-22 11:06:54', '2023-09-23 16:35:08', '员工已删除', '9357488', '锦艺城店', '男', '18950151312', 7),
(58043177, 172704310, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 4, 550.00, 220.00, 55.00, '2023-08-21 23:59:59', '2024-05-11 21:06:47', '员工已删除,员工已删除', '9357447,9410328', '锦艺城店', '男', '18660839493', 7),
(58041980, 172702233, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-21 21:54:53', '2023-08-29 11:24:53', '--', '', '锦艺城店', '女', '15617859948', 7),
(58041947, 172702153, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-21 21:52:59', '2023-09-30 20:03:37', '员工已删除', '9357447', '锦艺城店', '男', '13938555601', 7),
(58041820, 172702001, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-21 21:47:41', '2023-08-21 21:48:14', '员工已删除', '9730472', '锦艺城店', '女', '13938515127', 7),
(58041716, 172701854, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-21 21:44:14', '2023-08-21 21:44:43', '员工已删除', '9357548', '锦艺城店', '男', '13838565595', 7),
(58257316, 171107962, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-21 00:00:00', '2023-08-30 13:24:48', '员工已删除', '9730472', '锦艺城店', '女', '17630009878', 7),
(58005002, 172654859, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-20 17:17:59', '2023-10-14 20:18:54', '员工已删除', '9357548', '锦艺城店', '女', '18638941985', 7),
(58000879, 172649128, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-20 15:44:15', '2023-09-02 15:44:36', '员工已删除', '9357486', '锦艺城店', '女', '13526775589', 7),
(58000318, 172648409, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-20 15:31:42', '2023-09-14 17:06:45', '员工已删除', '9357447', '锦艺城店', '女', '13775493313', 7),
(57987765, 172630917, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-19 23:23:14', '2023-09-25 22:10:50', '员工已删除', '9664826', '锦艺城店', '男', '18037173768', 7),
(57986909, 172629546, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 0, 550.00, 0.00, 55.00, '2023-08-19 22:12:06', '2023-10-12 20:22:34', '员工已删除,员工已删除,员工已删除,员工已删除', '9357488,9357548,9410328,9664826', '锦艺城店', '女', '15237111105', 7),
(57986401, 169740994, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-19 21:53:39', '2023-08-24 21:14:24', '员工已删除', '9357447', '锦艺城店', '男', '15617710915', 7),
(57985627, 172627789, '-1', '100-经典足道50分钟,103-采耳,104-局部推拿,105-小腿排酸', 10, 4, 550.00, 220.00, 55.00, '2023-08-19 21:31:06', '2023-12-03 13:49:57', '员工已删除', '9357488', '锦艺城店', '男', '15303718330', 7),
(57974677, 172612131, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-19 16:52:32', '2023-09-24 14:43:25', '员工已删除', '9357548', '锦艺城店', '女', '15324839298', 7),
(57965261, 172600174, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-19 13:02:54', '2023-08-19 13:03:11', '员工已删除', '9357486', '锦艺城店', '女', '18237118488', 7),
(57956380, 172587814, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-18 21:28:27', '2023-09-30 22:12:36', '员工已删除', '9357488', '锦艺城店', '男', '13838072163', 7),
(57954597, 172585059, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-18 20:35:58', '2023-09-29 20:11:27', '员工已删除', '9730472', '锦艺城店', '女', '17365984118', 7),
(57954548, 172584964, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-18 20:34:31', '2023-09-29 20:10:57', '员工已删除', '9357488', '锦艺城店', '女', '17760735556', 7),
(57949472, 172577378, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-18 17:59:07', '2026-03-24 19:09:47', '员工已删除', '9664826', '锦艺城店', '女', '18037160069', 7),
(57947797, 172575223, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-18 17:11:39', '2023-08-31 16:28:48', '员工已删除', '9730472', '锦艺城店', '女', '13598428703', 7),
(57946071, 169853529, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-18 16:24:36', '2023-08-18 16:25:08', '员工已删除', '9357447', '锦艺城店', '女', '13663861836', 7),
(57767377, 172222487, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-10 20:43:50', '2023-12-03 18:15:15', '员工已删除', '9410328', '锦艺城店', '男', '15903660077', 7),
(57762672, 172214923, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-10 17:54:49', '2023-09-10 16:40:54', '员工已删除', '9357548', '锦艺城店', '女', '13393731556', 7),
(57761074, 172212648, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-10 16:59:48', '2023-08-10 17:00:05', '员工已删除', '9730472', '锦艺城店', '男', '13027511413', 7),
(57758730, 172209472, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-10 15:41:28', '2023-11-24 17:28:23', '员工已删除', '9357447', '锦艺城店', '男', '13938352230', 7),
(57742727, 172184385, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-09 18:15:23', '2023-08-09 18:15:44', '员工已删除', '9357486', '锦艺城店', '女', '17611712900', 7),
(57724374, 172116254, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-08 21:40:45', '2023-08-30 22:13:23', '员工已删除', '9357548', '锦艺城店', '女', '15639715400', 7),
(57714066, 172088623, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-08 15:48:44', '2023-09-06 17:21:43', '员工已删除', '9664826', '锦艺城店', '男', '13683808702', 7),
(57702459, 172071149, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-07 19:55:49', '2023-08-22 20:07:38', '员工已删除', '9730472', '锦艺城店', '女', '15517569802', 7),
(57701898, 172070337, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-07 19:36:09', '2023-10-11 18:45:17', '员工已删除', '9730472', '锦艺城店', '女', '15136282018', 7),
(57685265, 172042757, '-1', '', 3, 2, 0.00, 0.00, 0.00, '2023-08-06 21:27:22', '2023-08-06 21:28:28', '员工已删除', '9730472', '锦艺城店', '男', '13681194337', 7),
(57684606, 172041861, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-06 21:07:46', '2023-10-29 21:09:30', '--', '', '锦艺城店', '女', '13633825797', 7),
(57671169, 172020436, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-06 14:43:54', '2023-11-02 15:23:41', '员工已删除', '9730472', '锦艺城店', '女', '13503713343', 7),
(57671118, 172020338, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-06 14:41:54', '2023-11-06 13:38:14', '员工已删除', '9357488', '锦艺城店', '女', '17760745535', 7),
(57664289, 172010817, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-06 10:27:11', '2023-08-22 15:33:33', '员工已删除', '9357486', '锦艺城店', '女', '13663016752', 7),
(57661460, 170043644, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-05 21:39:17', '2023-09-17 21:24:05', '员工已删除', '9357486', '锦艺城店', '男', '13523078550', 7),
(57644254, 169871986, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-05 13:54:12', '2023-11-01 18:19:49', '员工已删除', '9410328', '锦艺城店', '女', '13838232228', 7),
(57639715, 171975241, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-05 10:58:30', '2023-09-16 17:29:22', '员工已删除', '9357488', '锦艺城店', '女', '13271550296', 7),
(57613941, 171938411, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-08-03 21:39:04', '2023-08-03 21:39:20', '员工已删除', '9357447', '锦艺城店', '男', '15736796800', 7),
(57612461, 171936241, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-03 20:51:25', '2023-09-07 23:59:59', '员工已删除', '9664826', '锦艺城店', '男', '18503926982', 7),
(57612421, 171936179, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-03 20:50:07', '2023-09-07 23:59:59', '员工已删除', '9357488', '锦艺城店', '男', '13007617927', 7),
(57594507, 171904696, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-02 22:56:49', '2023-10-05 22:43:54', '员工已删除', '9357447', '锦艺城店', '男', '15670603112', 7),
(57589670, 171896776, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-02 19:39:27', '2026-03-19 15:15:36', '员工已删除', '9357488', '锦艺城店', '女', '13673620902', 7),
(57586851, 171892571, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-02 18:05:00', '2023-09-30 13:18:25', '员工已删除', '9664826', '锦艺城店', '女', '13703909120', 7),
(57583937, 171888574, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-02 16:32:34', '2023-09-27 20:37:10', '员工已删除', '9357447', '锦艺城店', '女', '13461572199', 7),
(57576469, 171874297, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-08-02 11:48:25', '2023-08-21 18:24:26', '员工已删除', '9357548', '锦艺城店', '女', '13643867722', 7),
(57570491, 171865354, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-08-01 20:42:06', '2023-11-10 17:04:43', '员工已删除', '9357447', '锦艺城店', '男', '13783685558', 7),
(57551991, 171815541, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-31 22:35:09', '2023-09-01 19:23:58', '员工已删除', '9357548', '锦艺城店', '女', '16639795158', 7),
(57511497, 170416241, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-30 16:30:37', '2023-09-23 15:44:07', '员工已删除', '9410328', '锦艺城店', '女', '18603827000', 7),
(57502149, 171733532, '-1', '', 3, 0, 0.00, 0.00, 0.00, '2023-07-30 11:19:18', '2023-07-30 11:21:59', '员工已删除,员工已删除', '9537735,9537740', '锦艺城店', '女', '15993716868', 7),
(57494696, 171721910, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-29 19:41:25', '2023-07-29 19:41:52', '员工已删除', '9357447', '锦艺城店', '女', '15515962501', 7),
(57470126, 171685532, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-28 21:01:39', '2023-08-07 20:51:53', '员工已删除', '9357548', '锦艺城店', '男', '15093452995', 7),
(57469860, 171685147, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-28 20:52:57', '2023-10-26 21:42:44', '员工已删除', '9664826', '锦艺城店', '女', '18530086787', 7),
(57467822, 171682128, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-28 19:43:07', '2023-11-25 21:00:59', '员工已删除', '9410328', '锦艺城店', '女', '18937179062', 7),
(57465910, 171679683, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-28 18:41:54', '2026-04-11 18:48:06', '员工已删除', '9410328', '锦艺城店', '男', '13607693890', 7),
(57465848, 171679629, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-28 18:40:32', '2024-12-20 22:20:52', '员工已删除', '9664826', '锦艺城店', '女', '13598863626', 7),
(57451036, 171661612, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-27 22:32:23', '2023-11-30 22:50:39', '员工已删除', '9357548', '锦艺城店', '男', '19913836699', 7),
(57447779, 171657799, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-27 20:40:42', '2023-08-10 22:14:24', '员工已删除', '9357486', '锦艺城店', '女', '13140100030', 7),
(57437690, 171639903, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-27 15:53:32', '2023-09-06 21:44:03', '--', '', '锦艺城店', '女', '18837198331', 7),
(57425816, 171618857, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-26 21:55:08', '2023-08-24 21:13:32', '员工已删除', '9357486', '锦艺城店', '女', '15538016830', 7),
(57420525, 171599671, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-26 19:01:56', '2025-02-28 19:59:23', '员工已删除', '9357548', '锦艺城店', '男', '13526626257', 7),
(57405303, 171579697, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-25 23:18:10', '2023-09-07 23:59:59', '员工已删除', '9664826', '锦艺城店', '男', '15225117504', 7),
(57405298, 171579685, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-25 23:16:50', '2023-09-07 23:59:59', '员工已删除', '9357527', '锦艺城店', '男', '13673621322', 7),
(57402422, 171576000, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-25 21:01:53', '2023-07-25 21:02:13', '员工已删除', '9357527', '锦艺城店', '女', '13525530846', 7),
(57402258, 171575799, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-25 20:57:30', '2023-07-25 22:25:42', '员工已删除', '9357488', '锦艺城店', '男', '15890672392', 7),
(57401862, 171575185, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-25 20:44:49', '2023-07-25 20:45:09', '员工已删除', '9357548', '锦艺城店', '女', '18703657303', 7),
(57376571, 171544730, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-24 20:46:27', '2026-03-05 17:12:57', '--', '', '锦艺城店', '女', '13938505661', 7),
(57352728, 171511096, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-23 21:00:08', '2023-08-05 17:49:14', '员工已删除', '9357527', '锦艺城店', '女', '18237196281', 7),
(57351516, 171509204, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-23 20:28:18', '2023-09-11 20:40:49', '员工已删除', '9357447', '锦艺城店', '女', '18036191608', 7),
(57349704, 171506260, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-23 19:36:28', '2023-11-03 12:58:25', '员工已删除', '9357447', '锦艺城店', '女', '15936267153', 7),
(57332927, 171470433, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-23 11:46:19', '2023-08-21 11:19:04', '员工已删除', '9357447', '锦艺城店', '女', '13603868296', 7),
(57331393, 171468283, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-23 10:48:18', '2023-11-30 18:38:43', '员工已删除', '9357488', '锦艺城店', '女', '15136188269', 7),
(57326652, 171460698, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-22 20:48:40', '2023-10-13 20:26:19', '员工已删除', '9357488', '锦艺城店', '女', '13663806890', 7),
(57322431, 171453268, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-22 18:51:10', '2023-08-26 20:00:52', '员工已删除', '9357447', '锦艺城店', '女', '15637268278', 7),
(57295121, 171406942, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-21 18:56:06', '2023-07-21 18:56:24', '员工已删除', '9357488', '锦艺城店', '女', '15515883701', 7),
(57293968, 170594725, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-21 18:22:47', '2026-04-10 17:39:44', '员工已删除', '9357447', '锦艺城店', '女', '13343859556', 7),
(57290035, 171401108, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-21 16:40:23', '2023-08-01 23:01:15', '员工已删除', '9357488', '锦艺城店', '男', '15353505170', 7),
(57271682, 171373894, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-20 18:57:54', '2023-11-03 20:48:32', '员工已删除', '9357447', '锦艺城店', '男', '18603839814', 7),
(57270448, 171372248, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-20 18:18:08', '2023-08-04 16:09:34', '员工已删除', '9357548', '锦艺城店', '女', '15038327323', 7),
(57257843, 171357354, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-20 11:26:22', '2023-09-30 12:56:05', '员工已删除', '9357548', '锦艺城店', '女', '13838063160', 7),
(57252359, 171350531, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-19 21:21:10', '2023-11-26 16:52:01', '员工已删除', '9357447', '锦艺城店', '男', '13603415335', 7),
(57250909, 171348369, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-19 20:36:40', '2023-07-19 20:37:00', '员工已删除', '9410328', '锦艺城店', '男', '18539578990', 7),
(57244349, 171339613, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-19 17:18:04', '2023-10-24 20:52:31', '员工已删除', '9357447', '锦艺城店', '男', '15837323235', 7),
(57244066, 171339298, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-19 17:10:53', '2023-07-19 17:12:59', '员工已删除', '9357527', '锦艺城店', '女', '13783655582', 7),
(57241148, 171328682, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-19 15:46:46', '2023-08-20 18:22:40', '员工已删除', '9357486', '锦艺城店', '男', '16650255673', 7),
(57241099, 171328618, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-19 15:45:17', '2023-08-06 22:46:48', '员工已删除', '9357527', '锦艺城店', '女', '15515577377', 7),
(57235309, 171320945, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-19 12:26:58', '2024-03-03 18:09:14', '员工已删除', '9410328', '锦艺城店', '女', '15837186268', 7),
(57230226, 171315409, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-18 22:51:36', '2023-10-22 21:45:58', '员工已删除', '9357527', '锦艺城店', '女', '13592505722', 7),
(57227865, 171312095, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-18 21:11:50', '2023-09-14 19:24:25', '员工已删除', '9357548', '锦艺城店', '女', '13333833558', 7),
(57209139, 171289954, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-18 12:35:01', '2024-12-20 15:52:40', '--', '', '锦艺城店', '女', '13526852933', 7),
(57209100, 171289903, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-18 12:33:19', '2025-05-12 22:32:52', '--', '', '锦艺城店', '男', '18603853023', 7),
(57208379, 171288627, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-18 12:06:35', '2023-07-18 12:07:00', '员工已删除', '9357447', '锦艺城店', '男', '13903943867', 7),
(57208319, 171288547, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-18 12:04:27', '2023-10-23 11:12:55', '员工已删除', '9357486', '锦艺城店', '女', '15539121945', 7),
(57203205, 171269235, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-17 22:09:45', '2023-10-07 21:13:18', '员工已删除', '9357486', '锦艺城店', '女', '13783456928', 7),
(57201167, 171266109, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-17 20:49:17', '2024-09-07 21:33:10', '员工已删除', '9357527', '锦艺城店', '女', '13140099722', 7),
(57201100, 170000197, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-17 20:47:11', '2023-08-11 21:13:56', '员工已删除', '9357548', '锦艺城店', '女', '18539288975', 7),
(57201066, 170000308, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-17 20:45:43', '2023-08-11 21:13:18', '员工已删除', '9357447', '锦艺城店', '男', '13526654373', 7),
(57200636, 171265270, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-17 20:30:52', '2023-07-17 20:31:14', '员工已删除', '9357488', '锦艺城店', '男', '13633933363', 7),
(57223909, 171306277, '613', '项目已删除', 3, 1, 1920.00, 640.00, 640.00, '2023-07-17 00:00:00', '2023-07-19 17:14:17', '员工已删除,员工已删除', '9537735,9537740', '锦艺城店', '男', '18037103871', 7),
(57178107, 171232580, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-16 21:34:17', '2023-08-31 16:40:34', '员工已删除', '9357527', '锦艺城店', '女', '15981910519', 7),
(57177830, 171232208, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-16 21:26:22', '2023-11-15 19:05:36', '员工已删除', '9357488', '锦艺城店', '男', '15036036462', 7),
(57175292, 171227754, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-16 20:09:35', '2023-08-09 20:16:34', '员工已删除', '9410328', '锦艺城店', '男', '13603862602', 7),
(57172438, 171201242, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-16 19:07:19', '2025-07-01 15:56:06', '员工已删除', '9357447', '锦艺城店', '女', '15738316199', 7),
(57150671, 171170685, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-15 21:31:27', '2023-09-27 16:43:30', '员工已删除', '9357486', '锦艺城店', '女', '13772343038', 7),
(57145662, 171162363, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-15 19:07:04', '2023-07-15 19:07:26', '员工已删除', '9410328', '锦艺城店', '女', '13513800990', 7),
(57126744, 171134151, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-14 22:35:06', '2023-12-23 23:23:40', '员工已删除', '9357486', '锦艺城店', '女', '18637163920', 7),
(57121252, 171125949, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-14 19:33:39', '2024-03-15 19:13:49', '员工已删除', '9357488', '锦艺城店', '女', '13937051998', 7),
(57119386, 171116216, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-14 18:34:06', '2023-08-10 16:52:34', '员工已删除', '9357486', '锦艺城店', '女', '13083662213', 7),
(57119324, 169709083, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-14 18:32:13', '2024-06-08 23:15:50', '员工已删除', '9357548', '锦艺城店', '男', '18638637160', 7),
(57117909, 171114344, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-14 17:52:00', '2023-09-26 18:13:08', '员工已删除', '9357488', '锦艺城店', '女', '18203664009', 7),
(57112707, 171107962, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-14 15:16:32', '2023-08-30 13:24:48', '员工已删除', '9357447', '锦艺城店', '女', '17630009878', 7),
(57102235, 171093488, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-13 21:35:42', '2023-07-13 21:35:58', '员工已删除', '9357548', '锦艺城店', '女', '18539277201', 7),
(57102193, 171093436, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-13 21:34:20', '2023-07-13 21:34:37', '员工已删除', '9357486', '锦艺城店', '女', '15225125422', 7),
(57102065, 171093282, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-13 21:30:39', '2023-10-29 20:18:39', '员工已删除', '9410328', '锦艺城店', '女', '13643808248', 7),
(57101994, 171093177, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-13 21:28:14', '2023-10-29 20:19:23', '员工已删除', '9357488', '锦艺城店', '男', '18937654083', 7),
(57099360, 171089212, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-13 20:04:09', '2023-08-24 20:11:35', '员工已删除', '9410328', '锦艺城店', '女', '13253570267', 7),
(57097604, 171086520, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-13 19:06:22', '2023-09-30 17:10:19', '员工已删除', '9357486', '锦艺城店', '女', '13838002395', 7),
(57091118, 171079294, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-13 16:33:01', '2023-09-20 17:13:21', '员工已删除', '9357486', '锦艺城店', '女', '15824865868', 7),
(57091081, 171079236, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-13 16:31:32', '2023-09-20 17:12:55', '员工已删除', '9357548', '锦艺城店', '男', '15517153259', 7),
(57089159, 171077315, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-13 15:49:17', '2025-05-06 19:56:34', '员工已删除', '9357488', '锦艺城店', '女', '16637125308', 7),
(57088876, 171076965, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-13 15:39:35', '2023-08-13 10:42:29', '员工已删除', '9357488', '锦艺城店', '女', '15981889768', 7),
(57082186, 171063177, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-13 11:04:15', '2023-07-31 11:10:04', '员工已删除', '9357548', '锦艺城店', '女', '15515715806', 7),
(57080678, 171060546, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-12 23:02:26', '2023-07-29 20:49:03', '员工已删除', '9357488', '锦艺城店', '女', '18638153717', 7),
(57076912, 169850121, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-12 20:21:30', '2023-07-22 22:19:02', '员工已删除', '9410328', '锦艺城店', '女', '13213012009', 7),
(57069558, 171044629, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-12 16:26:49', '2023-08-05 20:15:56', '员工已删除', '9357488', '锦艺城店', '男', '13353808191', 7),
(57059779, 171032441, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-11 23:18:29', '2023-09-24 13:09:36', '员工已删除', '9357488', '锦艺城店', '男', '19937131213', 7),
(57056880, 171026257, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-11 20:54:05', '2023-07-23 21:57:23', '员工已删除', '9357527', '锦艺城店', '女', '13608691017', 7),
(57050825, 171017795, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-11 17:41:05', '2023-07-11 17:41:23', '员工已删除', '9410328', '锦艺城店', '女', '13949403046', 7),
(57034514, 170042724, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-11 11:07:29', '2024-05-20 11:32:36', '员工已删除', '9357447', '锦艺城店', '女', '15038059020', 7),
(57027270, 170979831, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-10 22:19:50', '2023-07-10 23:16:01', '员工已删除', '9357447', '锦艺城店', '男', '15003805885', 7),
(57004483, 170043644, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-09 22:48:22', '2023-09-17 21:24:05', '员工已删除', '9357486', '锦艺城店', '男', '13523078550', 7),
(57003490, 170925527, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-09 21:53:11', '2023-07-09 21:54:07', '员工已删除', '9410328', '锦艺城店', '女', '15890157197', 7),
(57003220, 170925140, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-09 21:45:05', '2023-09-10 23:40:21', '员工已删除', '9357486', '锦艺城店', '女', '13530321950', 7),
(56986788, 169875331, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-09 14:58:45', '2023-09-06 15:34:47', '员工已删除', '9357548', '锦艺城店', '女', '13703701703', 7),
(56977384, 170887830, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-08 22:30:14', '2023-10-21 14:23:54', '员工已删除', '9357548', '锦艺城店', '男', '13613714099', 7),
(56956034, 170850204, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-08 13:23:31', '2023-08-26 11:18:40', '员工已删除', '9357527', '锦艺城店', '女', '13783495827', 7),
(57047701, 171013930, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-08 00:00:00', '2023-09-24 17:33:51', '员工已删除', '9410328', '锦艺城店', '男', '17729751886', 7),
(56942898, 170833629, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-07 22:27:32', '2023-10-03 21:00:44', '员工已删除', '9357527', '锦艺城店', '女', '15343828444', 7),
(56932242, 170818392, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-07 16:56:34', '2024-08-13 22:30:33', '员工已删除', '9410328', '锦艺城店', '女', '18638282611', 7),
(56928598, 170805825, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-07 15:01:16', '2023-09-04 11:21:05', '员工已删除', '9357486', '锦艺城店', '女', '13849196833', 7),
(56928013, 170805174, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-07 14:45:34', '2023-07-07 14:45:59', '员工已删除', '9357447', '锦艺城店', '男', '17335767831', 7),
(56923070, 170798629, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-07 11:28:01', '2023-07-14 11:31:50', '员工已删除', '9357486', '锦艺城店', '女', '13343859557', 7),
(56920495, 170793413, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-06 22:37:24', '2023-09-05 20:08:17', '员工已删除', '9357527', '锦艺城店', '女', '18003819008', 7),
(56920074, 170792813, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-06 22:12:09', '2023-08-19 20:30:14', '员工已删除', '9357486', '锦艺城店', '女', '18736025522', 7),
(56916627, 170787328, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-06 20:14:23', '2026-03-25 18:45:32', '员工已删除', '9357486', '锦艺城店', '男', '15515701618', 7),
(56914842, 170784557, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-06 19:16:05', '2023-07-09 18:10:47', '员工已删除', '9357527', '锦艺城店', '女', '13213142236', 7),
(56909057, 170777057, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-06 16:31:00', '2023-07-28 14:24:51', '--', '', '锦艺城店', '女', '13838011444', 7),
(56896147, 170745336, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-05 21:39:45', '2023-07-24 21:26:53', '员工已删除', '9357447', '锦艺城店', '女', '13849191198', 7),
(56895414, 170744033, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-05 21:13:16', '2023-09-23 16:10:34', '员工已删除', '9357527', '锦艺城店', '女', '13014559768', 7),
(56890518, 169933539, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-05 18:26:36', '2025-06-08 20:09:08', '员工已删除', '9357486', '锦艺城店', '女', '13633855731', 7),
(56890493, 169933539, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-05 18:25:42', '2025-06-08 20:09:08', '员工已删除', '9357486', '锦艺城店', '女', '13633855731', 7),
(56889019, 170733719, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-05 17:43:32', '2023-07-05 17:43:50', '员工已删除', '9357447', '锦艺城店', '男', '13526672010', 7),
(56887549, 170731708, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-05 16:56:10', '2023-07-12 14:27:49', '员工已删除', '9357488', '锦艺城店', '男', '13073779887', 7),
(56886173, 170730016, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-05 16:13:47', '2024-10-22 20:00:21', '员工已删除', '9357447', '锦艺城店', '男', '15617851996', 7),
(56870584, 170698680, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-04 20:51:57', '2023-08-05 17:49:50', '员工已删除', '9357488', '锦艺城店', '女', '13569922811', 7),
(56863942, 170676501, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-04 17:21:16', '2026-01-16 15:44:57', '员工已删除', '9357488', '锦艺城店', '女', '18037099590', 7),
(56849860, 170658132, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-03 23:33:30', '2023-10-11 20:11:29', '员工已删除', '9357447', '锦艺城店', '女', '15003999061', 7),
(56849849, 170658116, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-03 23:31:45', '2023-07-03 23:32:07', '员工已删除', '9357488', '锦艺城店', '男', '15538358388', 7),
(56849677, 170277967, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-03 22:59:51', '2023-08-02 22:38:19', '员工已删除', '9357548', '锦艺城店', '女', '13083712996', 7),
(56849137, 170656692, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-03 22:12:42', '2023-07-03 22:13:02', '员工已删除', '9357548', '锦艺城店', '女', '15617565956', 7),
(56849109, 170656651, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-03 22:10:51', '2023-07-03 22:11:14', '员工已删除', '9357447', '锦艺城店', '女', '13017679389', 7),
(56848164, 170655232, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-03 21:28:32', '2023-07-03 21:28:56', '员工已删除', '9357528', '锦艺城店', '男', '13503814589', 7),
(56838684, 169934089, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-03 15:59:37', '2023-07-31 15:35:55', '员工已删除', '9357548', '锦艺城店', '女', '15514568766', 7),
(56838375, 170633051, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-03 15:49:29', '2023-09-18 14:41:43', '员工已删除', '9357548', '锦艺城店', '男', '13253462886', 7),
(56836178, 170630093, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-03 14:30:57', '2026-03-23 11:18:17', '员工已删除', '9357447', '锦艺城店', '女', '15039378301', 7),
(56824077, 170606089, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-02 21:34:12', '2023-08-07 21:55:38', '员工已删除', '9357488', '锦艺城店', '男', '13838109899', 7),
(56823279, 170605013, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 21:10:34', '2023-09-30 16:25:04', '员工已删除', '9357548', '锦艺城店', '女', '18939262988', 7),
(56823223, 170604901, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 21:08:37', '2026-04-01 21:53:44', '员工已删除', '9362827', '锦艺城店', '女', '13838075998', 7),
(56819570, 170598756, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 19:21:04', '2023-09-14 16:07:43', '员工已删除', '9357548', '锦艺城店', '女', '15286847700', 7),
(56818589, 170597199, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 18:52:16', '2023-09-16 18:54:28', '员工已删除', '9357447', '锦艺城店', '女', '13071080123', 7),
(56817925, 170596284, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 18:35:28', '2023-07-30 16:16:59', '员工已删除', '9357486', '锦艺城店', '女', '13213105886', 7),
(56816606, 170594504, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 18:04:31', '2023-09-23 18:19:52', '员工已删除', '9357486', '锦艺城店', '女', '18039234300', 7),
(56816515, 170594378, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 18:02:32', '2023-09-23 18:19:13', '员工已删除', '9357447', '锦艺城店', '女', '13598805244', 7),
(56805780, 170578664, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 13:40:10', '2023-09-04 11:33:46', '员工已删除', '9357447', '锦艺城店', '女', '13073751704', 7),
(56802322, 170574219, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 11:42:42', '2023-08-21 16:48:44', '员工已删除', '9357486', '锦艺城店', '男', '15537107796', 7),
(56801636, 170574145, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-02 11:40:41', '2023-08-21 16:49:15', '员工已删除', '9357488', '锦艺城店', '女', '15515630591', 7),
(56797082, 170568564, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-01 22:37:25', '2023-08-18 20:40:44', '员工已删除', '9357447', '锦艺城店', '男', '15136268561', 7),
(56796712, 170567979, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-07-01 22:15:33', '2023-07-01 22:16:53', '员工已删除', '9357528', '锦艺城店', '男', '13837193186', 7),
(56796639, 170567876, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-01 22:13:21', '2023-07-01 22:13:44', '员工已删除', '9357548', '锦艺城店', '女', '18920820923', 7),
(56795599, 169958304, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-01 21:38:06', '2023-11-14 20:30:00', '--', '', '锦艺城店', '女', '15538183532', 7),
(56792505, 170561557, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-01 20:10:57', '2023-07-01 20:11:18', '员工已删除', '9357488', '锦艺城店', '男', '13303812653', 7),
(56784914, 169709083, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-07-01 17:07:02', '2024-06-08 23:15:50', '员工已删除', '9357548', '锦艺城店', '男', '18638637160', 7),
(56773412, 170530390, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-07-01 12:04:20', '2023-07-01 12:04:43', '员工已删除', '9362827', '锦艺城店', '女', '13633809591', 7),
(56764434, 170503227, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-30 21:56:34', '2023-07-30 22:41:01', '员工已删除', '9410328', '锦艺城店', '女', '15603711780', 7),
(56763313, 170501917, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-30 21:28:47', '2023-07-16 22:16:38', '员工已删除', '9357548', '锦艺城店', '女', '13303828290', 7),
(56752086, 170416241, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-30 18:58:28', '2023-09-23 15:44:07', '员工已删除', '9410328', '锦艺城店', '女', '18603827000', 7),
(56740743, 169858344, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-30 15:29:06', '2025-03-10 16:24:34', '员工已删除', '9410328', '锦艺城店', '女', '15803880972', 7),
(56738458, 170450622, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-30 14:20:26', '2024-06-01 12:44:16', '员工已删除', '9357527', '锦艺城店', '女', '13937181105', 7),
(56738394, 170450548, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-30 14:18:43', '2024-09-21 12:22:17', '员工已删除', '9357488', '锦艺城店', '女', '15938754599', 7),
(56726409, 170405448, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-29 20:38:09', '2023-08-28 17:18:42', '--', '', '锦艺城店', '女', '13213070219', 7),
(56725149, 170429867, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-29 20:06:54', '2023-09-27 19:56:55', '员工已删除', '9362827', '锦艺城店', '女', '13607664032', 7),
(56713522, 170422689, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-29 17:56:14', '2023-07-24 18:53:31', '员工已删除', '9395286', '锦艺城店', '男', '13629847598', 7),
(56711268, 170421636, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-29 17:40:43', '2023-08-03 20:45:49', '员工已删除', '9357486', '锦艺城店', '男', '15333866619', 7),
(56705563, 170418912, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-29 17:11:26', '2023-10-07 11:23:00', '员工已删除', '9362827', '锦艺城店', '女', '13837129663', 7),
(56705486, 170418830, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-29 17:09:51', '2023-09-26 10:55:29', '员工已删除', '9362827', '锦艺城店', '女', '15037192101', 7),
(56705417, 170418713, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-29 17:08:11', '2023-09-29 17:04:35', '员工已删除', '9357548', '锦艺城店', '男', '18039970826', 7),
(56703608, 170416676, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-29 16:19:25', '2023-08-31 22:47:30', '员工已删除', '9357548', '锦艺城店', '女', '18736018051', 7),
(56703547, 170416603, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-29 16:17:52', '2023-08-31 22:47:56', '员工已删除', '9362827', '锦艺城店', '男', '18736033570', 7),
(56703194, 170416241, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-29 16:08:46', '2023-09-23 15:44:07', '员工已删除', '9357527', '锦艺城店', '女', '18603827000', 7),
(56692060, 170400009, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-28 22:13:29', '2023-07-15 20:19:55', '员工已删除', '9357488', '锦艺城店', '男', '13508062550', 7),
(56691929, 170399822, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-28 22:07:54', '2023-07-12 21:04:04', '员工已删除', '9395286', '锦艺城店', '女', '18638911285', 7),
(56685038, 170390507, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-28 18:40:45', '2023-09-27 16:04:03', '员工已删除', '9357447', '锦艺城店', '女', '13027783399', 7),
(56684925, 170390394, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-28 18:38:11', '2023-07-21 16:45:09', '员工已删除', '9357548', '锦艺城店', '女', '18538703111', 7),
(56680692, 170385235, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-28 16:36:53', '2023-10-08 14:49:10', '员工已删除', '9410328', '锦艺城店', '男', '13733836183', 7),
(56678596, 170382814, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-28 15:38:36', '2023-06-28 15:38:50', '员工已删除', '9410328', '锦艺城店', '男', '17719815562', 7),
(56674835, 170378898, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-28 13:47:06', '2023-07-25 11:42:49', '--', '', '锦艺城店', '女', '15514371965', 7),
(56668776, 169945376, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-27 22:55:28', '2024-04-05 21:40:31', '--', '', '锦艺城店', '女', '17630036840', 7),
(56668527, 170366168, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-27 22:30:09', '2023-07-27 23:13:16', '员工已删除', '9410328', '锦艺城店', '男', '19397945912', 7),
(56668463, 170366089, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-27 22:25:56', '2023-08-21 19:47:32', '员工已删除', '9410328', '锦艺城店', '男', '18345010105', 7),
(56668430, 170366037, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-27 22:23:40', '2023-07-03 19:26:53', '员工已删除', '9357486', '锦艺城店', '女', '13783466100', 7),
(56667519, 170364876, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-27 21:45:51', '2023-11-06 21:21:05', '员工已删除', '9395286', '锦艺城店', '男', '15538136653', 7),
(56666303, 170363201, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-27 21:07:05', '2023-10-03 10:55:39', '员工已删除', '9372092', '锦艺城店', '女', '13837192526', 7),
(56665581, 170362254, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-27 20:47:05', '2023-08-27 17:18:52', '员工已删除', '9362827', '锦艺城店', '男', '13733858396', 7),
(56643651, 170326203, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-27 11:04:12', '2023-08-13 19:10:32', '员工已删除', '9410328', '锦艺城店', '女', '13403713293', 7),
(56641071, 170323726, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-26 23:13:49', '2023-09-05 19:50:52', '员工已删除', '9357447', '锦艺城店', '男', '13460338911', 7),
(56640495, 170322994, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-26 22:29:00', '2023-06-26 22:29:25', '--', '', '锦艺城店', '女', '15238007770', 7),
(56640055, 170322353, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-26 22:05:08', '2023-11-18 20:08:34', '--', '', '锦艺城店', '女', '15890624713', 7),
(56636594, 170317474, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-26 20:11:31', '2023-06-26 20:11:56', '员工已删除', '9357488', '锦艺城店', '女', '15515577897', 7),
(56635802, 170316434, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-26 19:48:38', '2023-09-16 20:21:23', '员工已删除', '9362827', '锦艺城店', '男', '13603828109', 7),
(56635677, 170316266, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-26 19:45:14', '2023-06-28 11:42:39', '员工已删除', '9372092', '锦艺城店', '男', '15839201788', 7),
(56632168, 170309279, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-26 18:33:15', '2024-01-03 18:24:58', '员工已删除', '9362827', '锦艺城店', '女', '13837117281', 7),
(56632106, 170309219, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-26 18:31:23', '2023-08-19 16:48:52', '员工已删除', '9410328', '锦艺城店', '女', '15996776037', 7),
(56628762, 170305659, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-26 17:02:31', '2023-06-26 17:02:54', '员工已删除', '9357527', '锦艺城店', '男', '13523416345', 7),
(56628711, 170305591, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-26 17:00:45', '2023-06-26 17:01:04', '员工已删除', '9395286', '锦艺城店', '男', '13592495909', 7),
(56628534, 170305420, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-26 16:56:25', '2023-07-30 22:18:59', '员工已删除', '9357488', '锦艺城店', '女', '15617895677', 7),
(56628434, 170305333, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-26 16:54:45', '2023-07-30 22:19:42', '员工已删除', '9357447', '锦艺城店', '女', '18503816166', 7),
(56628323, 170305221, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-26 16:52:17', '2023-07-24 16:51:58', '员工已删除', '9372092', '锦艺城店', '女', '15238798625', 7),
(56615175, 170277967, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 22:43:26', '2023-08-02 22:38:19', '员工已删除', '9357486', '锦艺城店', '女', '13083712996', 7),
(56614719, 170277347, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-25 22:12:48', '2023-07-04 19:34:04', '员工已删除', '9357527', '锦艺城店', '男', '18838155708', 7),
(56614688, 170277287, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 22:10:59', '2023-09-29 23:31:57', '员工已删除', '9357486', '锦艺城店', '男', '18937626566', 7),
(56610720, 170270081, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 20:29:37', '2023-10-13 19:39:48', '员工已删除', '9357527', '锦艺城店', '女', '13838161658', 7),
(56610634, 170269943, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 20:27:16', '2023-10-13 19:40:21', '员工已删除', '9357486', '锦艺城店', '女', '13523049592', 7),
(56610262, 170269309, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-25 20:13:53', '2023-06-25 20:14:21', '员工已删除', '9357548', '锦艺城店', '男', '15136121393', 7),
(56608098, 170266168, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 19:07:43', '2025-04-11 16:58:08', '员工已删除', '9357488', '锦艺城店', '女', '15890107203', 7),
(56607979, 170265979, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 19:03:55', '2023-06-30 18:39:49', '员工已删除', '9357527', '锦艺城店', '男', '19937804689', 7),
(56607905, 170265899, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 19:02:03', '2023-08-07 16:50:00', '员工已删除', '9357486', '锦艺城店', '女', '13526693449', 7),
(56607425, 170265287, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 18:48:49', '2023-07-18 16:50:58', '员工已删除', '9357548', '锦艺城店', '女', '15603715081', 7),
(56607194, 170264989, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 18:41:57', '2023-08-03 19:25:39', '员工已删除', '9362827', '锦艺城店', '男', '15290803406', 7),
(56604594, 170262617, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 17:57:01', '2023-07-10 16:45:08', '员工已删除', '9357548', '锦艺城店', '女', '18137274993', 7),
(56603998, 169833452, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 17:39:54', '2024-05-04 20:06:44', '员工已删除', '9395286', '锦艺城店', '男', '13803716131', 7),
(56603871, 170261734, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 17:37:06', '2023-08-27 20:45:32', '员工已删除', '9362827', '锦艺城店', '男', '18937655539', 7),
(56597356, 170243319, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 15:32:51', '2023-09-04 15:11:57', '员工已删除', '9357527', '锦艺城店', '女', '13643807007', 7),
(56594017, 170239296, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-25 13:46:09', '2023-11-20 14:25:49', '员工已删除', '9410328', '锦艺城店', '女', '15286822801', 7),
(56593283, 170238390, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 13:22:19', '2025-06-10 16:00:07', '员工已删除', '9362827', '锦艺城店', '女', '15038245655', 7),
(56593233, 170238298, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 13:20:18', '2023-07-05 15:07:58', '员工已删除', '9362827', '锦艺城店', '男', '13523008039', 7),
(56591274, 170236246, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 12:11:21', '2024-11-12 11:56:29', '员工已删除', '9357548', '锦艺城店', '女', '13613813562', 7),
(56590581, 170235473, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 11:44:51', '2023-10-26 12:14:22', '员工已删除', '9410328', '锦艺城店', '女', '18137866068', 7),
(56590507, 170235433, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-25 11:42:57', '2023-10-11 12:05:44', '员工已删除', '9357447', '锦艺城店', '男', '18539918111', 7),
(56586858, 170230919, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 22:23:51', '2023-10-21 20:11:45', '员工已删除', '9357548', '锦艺城店', '男', '13849466111', 7),
(56586838, 170230881, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 22:22:13', '2023-10-21 20:12:24', '员工已删除', '9362827', '锦艺城店', '女', '13663859199', 7),
(56586816, 170230841, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 22:20:39', '2023-07-15 11:47:51', '员工已删除', '9357447', '锦艺城店', '女', '18390759636', 7),
(56586770, 170230778, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 22:18:12', '2023-09-06 11:11:17', '员工已删除', '9357488', '锦艺城店', '女', '17374375912', 7),
(56585129, 170228511, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 21:17:12', '2023-06-29 21:30:00', '员工已删除', '9395286', '锦艺城店', '女', '13783623086', 7),
(56585058, 170228429, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 21:15:29', '2024-11-07 15:10:32', '员工已删除', '9357486', '锦艺城店', '女', '13703863224', 7),
(56580196, 170222077, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 19:10:14', '2023-09-23 19:30:49', '员工已删除', '9357488', '锦艺城店', '女', '13203809086', 7),
(56580145, 170221986, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 19:08:28', '2023-09-17 21:22:02', '员工已删除', '9357548', '锦艺城店', '男', '18839779276', 7),
(56578437, 170219879, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 18:27:23', '2025-10-21 17:30:38', '员工已删除', '9410328', '锦艺城店', '女', '13673683531', 7),
(56578348, 170219776, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 18:25:20', '2023-09-10 15:35:18', '员工已删除', '9357486', '锦艺城店', '女', '13043022922', 7),
(56575391, 170215907, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 17:25:00', '2023-08-22 18:17:18', '员工已删除', '9357527', '锦艺城店', '女', '13525536084', 7),
(56571226, 170211012, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 15:48:27', '2023-08-12 15:21:25', '--', '', '锦艺城店', '女', '13027721220', 7),
(56571118, 170210862, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 15:45:21', '2023-09-20 17:13:53', '--', '', '锦艺城店', '男', '13838047047', 7),
(56566259, 170204518, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 13:22:22', '2023-07-10 18:36:20', '员工已删除', '9357527', '锦艺城店', '女', '13683713500', 7),
(56566223, 170204452, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 13:20:57', '2023-07-10 18:35:48', '员工已删除', '9357447', '锦艺城店', '女', '13937123992', 7),
(56566179, 170204395, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-24 13:19:17', '2023-06-24 13:19:35', '员工已删除', '9362827', '锦艺城店', '男', '18239955689', 7),
(56566122, 170204346, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 13:17:36', '2023-07-10 18:35:12', '员工已删除', '9357548', '锦艺城店', '女', '13783405600', 7),
(56564265, 170202073, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-24 12:14:03', '2023-09-23 16:35:32', '员工已删除', '9362827', '锦艺城店', '男', '13838523615', 7),
(56559600, 170195955, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-23 22:27:32', '2023-06-23 22:27:53', '员工已删除', '9362827', '锦艺城店', '女', '18838999402', 7),
(56558872, 170194736, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 21:47:31', '2023-07-18 22:11:47', '员工已删除', '9357527', '锦艺城店', '女', '18239953667', 7),
(56558839, 170194683, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 21:45:47', '2023-10-15 20:47:41', '员工已删除', '9395286', '锦艺城店', '女', '17343000065', 7),
(56558426, 170194035, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 21:30:48', '2023-10-08 19:23:17', '--', '', '锦艺城店', '女', '13938528421', 7),
(56558346, 170193910, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-23 21:28:35', '2023-08-06 17:48:31', '--', '', '锦艺城店', '男', '13949313878', 7),
(56558279, 170193805, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 21:26:14', '2024-08-16 21:33:59', '--', '', '锦艺城店', '男', '13592585501', 7),
(56556721, 170191385, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 20:35:07', '2023-07-26 17:57:25', '员工已删除', '9395286', '锦艺城店', '女', '13674955817', 7),
(56554439, 170187883, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 19:21:12', '2024-12-07 14:32:37', '员工已删除', '9362827', '锦艺城店', '女', '15538360633', 7),
(56554335, 170187735, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 19:18:11', '2023-11-18 11:21:59', '员工已删除', '9357488', '锦艺城店', '男', '17622671071', 7),
(56554281, 170187652, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 19:16:31', '2023-08-08 15:04:24', '员工已删除', '9362827', '锦艺城店', '男', '13820696461', 7),
(56551995, 170184339, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 18:10:29', '2023-09-01 21:52:28', '员工已删除', '9410328', '锦艺城店', '男', '15093051977', 7),
(56550629, 170182469, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-23 17:35:10', '2023-06-23 17:35:30', '员工已删除', '9395286', '锦艺城店', '女', '13526794850', 7),
(56549808, 170181423, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 17:15:31', '2026-04-03 18:33:13', '员工已删除', '9357447', '锦艺城店', '女', '13783596996', 7),
(56547226, 170178107, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 16:11:56', '2023-08-24 21:12:45', '--', '', '锦艺城店', '男', '18039218787', 7),
(56546066, 170166229, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-23 15:38:53', '2023-10-14 16:07:31', '员工已删除', '9357486', '锦艺城店', '男', '13298322296', 7),
(56545974, 170166086, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-23 15:35:42', '2023-06-25 10:34:04', '员工已删除', '9362827', '锦艺城店', '女', '18703807178', 7),
(56536535, 170151373, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-22 23:02:28', '2023-10-02 22:03:51', '员工已删除', '9357488', '锦艺城店', '女', '13607662740', 7),
(56536326, 170151044, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-22 22:37:33', '2023-08-08 22:49:31', '员工已删除', '9362827', '锦艺城店', '女', '15890162806', 7),
(56536315, 170151023, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-22 22:36:10', '2023-08-08 22:50:15', '员工已删除', '9410328', '锦艺城店', '女', '13937196087', 7),
(56536164, 170150603, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-22 22:14:38', '2023-09-16 21:12:37', '员工已删除', '9357527', '锦艺城店', '女', '13733822127', 7),
(56536090, 170150478, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-22 22:07:58', '2023-06-26 19:50:44', '员工已删除', '9410328', '锦艺城店', '女', '13703713918', 7),
(56533352, 170145432, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-22 19:35:31', '2023-09-28 17:18:30', '员工已删除', '9410328', '锦艺城店', '女', '18037108196', 7),
(56533284, 169812224, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-22 19:33:08', '2023-07-12 12:02:17', '员工已删除', '9395286', '锦艺城店', '男', '13383822319', 7),
(56531161, 170142181, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-22 18:11:33', '2023-08-23 21:04:11', '员工已删除', '9357527', '锦艺城店', '男', '15517535002', 7),
(56523633, 170131319, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-22 14:11:53', '2023-11-24 15:47:01', '--', '', '锦艺城店', '男', '13676926700', 7),
(56520962, 170127320, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-22 12:15:17', '2026-04-06 15:52:46', '--', '', '锦艺城店', '男', '13203883414', 7),
(56520791, 170127030, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-22 12:05:54', '2023-09-28 16:14:04', '--', '', '锦艺城店', '男', '15003855195', 7),
(56520745, 170126943, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-22 12:03:26', '2023-09-28 16:14:33', '--', '', '锦艺城店', '男', '13007601900', 7),
(56517495, 170121211, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-21 22:31:18', '2023-08-25 23:01:57', '员工已删除', '9357527', '锦艺城店', '男', '15188317600', 7),
(56517420, 170121013, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-21 22:27:03', '2023-07-27 20:44:51', '员工已删除', '9395286', '锦艺城店', '女', '17796668052', 7),
(56517344, 170120983, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-21 22:22:09', '2023-07-27 20:45:33', '员工已删除', '9357486', '锦艺城店', '女', '15236116817', 7),
(56515601, 170118516, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-21 21:20:36', '2023-08-07 19:40:57', '员工已删除', '9357527', '锦艺城店', '女', '18439887806', 7),
(56514027, 170116117, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-21 20:32:11', '2024-03-31 17:22:41', '员工已删除', '9357486', '锦艺城店', '女', '13623860750', 7),
(56512024, 170113070, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-21 19:29:44', '2023-10-14 11:03:18', '员工已删除', '9362827', '锦艺城店', '男', '13253441395', 7),
(56511987, 170112986, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-21 19:28:11', '2023-06-21 19:28:30', '员工已删除', '9357527', '锦艺城店', '女', '18614951334', 7),
(56505289, 170105805, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-21 16:42:32', '2023-07-26 21:43:51', '员工已删除', '9357486', '锦艺城店', '女', '13623807308', 7),
(56499870, 170100761, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-21 14:53:32', '2023-07-01 11:25:22', '员工已删除', '9357488', '锦艺城店', '女', '13393731132', 7),
(56488840, 170081851, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-20 22:54:48', '2023-06-20 22:55:06', '员工已删除', '9357527', '锦艺城店', '男', '18339723972', 7),
(56487550, 170079929, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 21:44:21', '2023-07-06 22:42:03', '员工已删除', '9357548', '锦艺城店', '女', '13460593381', 7),
(56487489, 170079854, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 21:42:36', '2023-09-12 21:59:21', '员工已删除', '9357488', '锦艺城店', '女', '13663806800', 7),
(56487435, 170079782, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 21:41:04', '2025-12-15 21:20:47', '员工已删除', '9395286', '锦艺城店', '男', '13643813106', 7),
(56487158, 170079416, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-20 21:32:53', '2023-09-16 21:12:07', '员工已删除', '9357527', '锦艺城店', '男', '13673638863', 7),
(56487056, 170079286, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 21:30:08', '2023-07-27 21:04:04', '员工已删除', '9362827', '锦艺城店', '男', '18037456441', 7),
(56485998, 170077955, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 21:00:44', '2023-07-17 20:29:02', '员工已删除', '9357548', '锦艺城店', '女', '18803970533', 7),
(56485934, 170077873, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 20:59:02', '2026-03-25 20:56:25', '员工已删除', '9395286', '锦艺城店', '男', '13849177765', 7),
(56484322, 170075578, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 20:12:19', '2023-08-22 18:27:51', '员工已删除', '9362827', '锦艺城店', '男', '15136468837', 7),
(56484276, 170075501, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 20:10:42', '2023-12-03 18:13:37', '员工已删除', '9357548', '锦艺城店', '女', '13703821852', 7),
(56484228, 170075381, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 20:09:04', '2023-11-04 20:34:02', '员工已删除', '9357527', '锦艺城店', '女', '13837159903', 7),
(56484101, 170075278, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 20:06:29', '2023-07-20 22:00:22', '员工已删除', '9362827', '锦艺城店', '女', '13683801486', 7),
(56481216, 170071656, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-20 18:48:49', '2023-06-25 20:35:27', '员工已删除', '9410328', '锦艺城店', '女', '13223023928', 7),
(56481121, 170071542, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 18:46:39', '2023-09-27 18:33:56', '员工已删除', '9357488', '锦艺城店', '女', '15238031915', 7),
(56479735, 170069934, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-20 18:09:29', '2023-06-20 18:09:51', '员工已删除', '9362827', '锦艺城店', '男', '13903826828', 7),
(56477776, 170068764, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 17:51:08', '2023-08-23 18:45:58', '员工已删除', '9357528', '锦艺城店', '女', '15890600200', 7),
(56477689, 170068696, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 17:49:14', '2026-02-24 19:37:41', '员工已删除', '9357486', '锦艺城店', '女', '15038036188', 7),
(56472308, 170064543, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-20 16:28:38', '2023-06-20 16:29:06', '员工已删除', '9362827', '锦艺城店', '男', '13503739886', 7),
(56467797, 170058170, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-20 14:25:06', '2023-07-18 22:53:11', '员工已删除', '9357548', '锦艺城店', '女', '13015506267', 7),
(56467468, 170057787, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 14:13:58', '2023-08-25 21:43:47', '员工已删除', '9357447', '锦艺城店', '女', '13598879540', 7),
(56462600, 170052326, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 13:18:24', '2023-08-25 21:43:07', '员工已删除', '9357486', '锦艺城店', '女', '18530830877', 7),
(56459605, 170043644, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 11:41:47', '2023-09-17 21:24:05', '员工已删除', '9357548', '锦艺城店', '男', '13523078550', 7),
(56458354, 170042724, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 11:07:52', '2024-05-20 11:32:36', '员工已删除', '9357488', '锦艺城店', '女', '15038059020', 7),
(56457199, 170041996, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-20 10:34:51', '2023-07-15 11:46:59', '员工已删除', '9395286', '锦艺城店', '女', '15738375370', 7),
(56455978, 170040219, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 23:37:32', '2023-07-31 21:41:56', '员工已删除', '9395286', '锦艺城店', '男', '19031974235', 7),
(56455970, 170040209, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 23:36:00', '2023-09-28 22:41:41', '员工已删除', '9357447', '锦艺城店', '男', '18638677998', 7),
(56455963, 170040185, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 23:34:02', '2023-07-31 21:41:34', '员工已删除', '9410328', '锦艺城店', '男', '13592516153', 7),
(56455819, 170039931, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 23:12:00', '2024-02-22 17:31:35', '员工已删除', '9357548', '锦艺城店', '女', '15838306159', 7),
(56455804, 170039908, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 23:10:14', '2023-09-13 21:58:42', '员工已删除', '9362827', '锦艺城店', '男', '18236961853', 7),
(56455800, 170039892, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 23:08:19', '2023-06-26 22:02:37', '员工已删除', '9395286', '锦艺城店', '女', '13653861123', 7),
(56455261, 170039226, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 22:29:14', '2024-08-09 21:32:25', '员工已删除', '9410328', '锦艺城店', '男', '18638015769', 7),
(56452583, 170036447, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 21:11:07', '2023-07-26 20:56:14', '员工已删除', '9357447', '锦艺城店', '女', '17337192272', 7),
(56450040, 170033285, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 20:03:23', '2023-09-01 20:13:14', '员工已删除', '9357488', '锦艺城店', '女', '18739909434', 7),
(56449981, 170033203, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 20:01:28', '2023-11-20 20:45:18', '员工已删除', '9357486', '锦艺城店', '女', '15138489677', 7),
(56449916, 170033110, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 19:59:28', '2023-08-13 21:30:01', '员工已删除', '9395286', '锦艺城店', '女', '15515812432', 7),
(56449824, 170033018, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 19:57:39', '2023-06-29 12:03:37', '员工已删除', '9357447', '锦艺城店', '女', '18749231610', 7),
(56446939, 170029656, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 18:41:44', '2023-10-02 10:58:50', '员工已删除', '9410328', '锦艺城店', '女', '13513801071', 7),
(56443202, 170026232, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-19 17:40:40', '2023-06-19 17:41:01', '员工已删除', '9395286', '锦艺城店', '男', '13937189966', 7),
(56443096, 170026085, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 17:37:25', '2023-07-11 20:55:28', '员工已删除', '9357488', '锦艺城店', '男', '15837175717', 7),
(56441872, 170025145, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 17:14:07', '2024-01-27 23:59:59', '员工已删除', '9357447', '锦艺城店', '女', '15639269686', 7),
(56441018, 170024297, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-19 16:54:19', '2023-06-19 16:54:42', '员工已删除', '9362827', '锦艺城店', '女', '13523077783', 7),
(56436230, 170019242, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-19 14:59:25', '2023-08-13 16:09:51', '员工已删除', '9357548', '锦艺城店', '女', '15136215719', 7),
(56436149, 170019124, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 14:57:15', '2023-09-24 18:01:56', '员工已删除', '9362827', '锦艺城店', '女', '13700886620', 7),
(56429143, 170007968, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-19 11:38:34', '2023-06-19 11:38:52', '员工已删除', '9395286', '锦艺城店', '女', '18937153488', 7),
(56429058, 170007908, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 11:36:41', '2025-05-10 22:35:27', '员工已删除', '9357447', '锦艺城店', '男', '13653977806', 7),
(56426774, 170005190, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 10:39:49', '2023-09-30 16:51:17', '员工已删除', '9362827', '锦艺城店', '女', '15286811864', 7),
(56426727, 170005127, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 10:36:56', '2023-07-25 22:43:43', '员工已删除', '9357548', '锦艺城店', '女', '16696232119', 7),
(56490963, 170085141, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-19 00:00:00', '2023-09-26 12:06:16', '员工已删除', '9357488', '锦艺城店', '女', '13183014181', 7),
(56424835, 170002848, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-18 23:01:21', '2023-07-04 23:45:02', '员工已删除', '9410328', '锦艺城店', '男', '17737196369', 7),
(56424817, 170002796, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-18 22:59:28', '2023-07-04 23:45:35', '员工已删除', '9357486', '锦艺城店', '男', '13235302332', 7),
(56424811, 170001708, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 22:58:48', '2023-11-12 21:12:29', '员工已删除', '9357486', '锦艺城店', '男', '13393718340', 7),
(56424001, 170001708, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 22:15:03', '2023-11-12 21:12:29', '员工已删除', '9357488', '锦艺城店', '男', '13393718340', 7),
(56423928, 170001601, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 22:12:17', '2023-07-27 22:31:08', '员工已删除', '9395286', '锦艺城店', '男', '13838213805', 7),
(56423398, 169995203, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 21:58:17', '2023-09-24 16:43:00', '员工已删除', '9410328', '锦艺城店', '女', '13783687832', 7),
(56422816, 170000308, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 21:42:22', '2023-08-11 21:13:18', '员工已删除', '9357447', '锦艺城店', '男', '13526654373', 7),
(56422713, 170000197, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 21:40:13', '2023-08-11 21:13:56', '员工已删除', '9357548', '锦艺城店', '女', '18539288975', 7),
(56419909, 169996764, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 20:36:27', '2023-10-19 15:12:54', '员工已删除', '9410328', '锦艺城店', '女', '13733167487', 7),
(56417960, 169994419, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-18 19:56:37', '2023-07-24 20:37:32', '员工已删除', '9410328', '锦艺城店', '女', '17729775567', 7),
(56417788, 169994217, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-18 19:53:28', '2023-09-16 16:45:54', '员工已删除', '9395286', '锦艺城店', '男', '13629845679', 7),
(56415778, 169991616, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-18 19:08:36', '2023-08-27 18:55:16', '员工已删除', '9395286', '锦艺城店', '男', '13803840268', 7),
(56415207, 169990941, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-18 18:56:38', '2023-06-21 22:50:24', '员工已删除', '9357486', '锦艺城店', '男', '17837134397', 7),
(56412486, 169985360, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-18 18:31:48', '2023-06-18 18:32:10', '员工已删除', '9410328', '锦艺城店', '女', '15003990583', 7),
(56408993, 169980641, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-18 17:34:17', '2023-07-07 11:25:29', '员工已删除', '9395286', '锦艺城店', '女', '15837121596', 7),
(56408882, 169980506, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-18 17:32:08', '2023-06-18 17:32:29', '员工已删除', '9357488', '锦艺城店', '女', '13526591258', 7),
(56408166, 169979666, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 17:18:30', '2023-07-29 17:26:47', '员工已删除', '9357447', '锦艺城店', '女', '13838250857', 7),
(56407855, 169979279, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 17:12:15', '2023-09-02 11:29:46', '员工已删除', '9357548', '锦艺城店', '女', '18039667251', 7),
(56402198, 169968228, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 15:38:31', '2026-01-03 23:31:41', '员工已删除', '9357548', '锦艺城店', '男', '17760770952', 7),
(56399821, 169965423, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 14:47:39', '2023-10-31 16:28:58', '员工已删除', '9357488', '锦艺城店', '男', '15188399986', 7),
(56399611, 169965107, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 14:41:59', '2023-06-29 19:56:36', '员工已删除', '9357486', '锦艺城店', '女', '13607673779', 7),
(56398707, 169963955, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 14:19:51', '2024-08-06 15:57:31', '员工已删除', '9410328', '锦艺城店', '女', '13525525991', 7),
(56398568, 169963817, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 14:16:52', '2023-07-03 16:59:21', '员工已删除', '9357447', '锦艺城店', '男', '15393707929', 7),
(56398317, 169963507, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 14:11:19', '2023-08-21 22:25:49', '员工已删除', '9410328', '锦艺城店', '女', '13598317639', 7),
(56398039, 169958567, '100', '100-经典足道50分钟', 1, 0, 0.00, 0.00, 0.00, '2023-06-18 14:04:47', '2026-04-12 11:14:33', '--', '', '锦艺城店', '女', '13838002046', 7),
(56397646, 169958567, '100', '100-经典足道50分钟', 1, 0, 0.00, 0.00, 0.00, '2023-06-18 13:53:53', '2026-04-12 11:14:33', '--', '', '锦艺城店', '女', '13838002046', 7),
(56395649, 169958766, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-18 13:26:36', '2023-06-18 13:27:05', '员工已删除', '9357486', '锦艺城店', '男', '13643856983', 7),
(56395478, 169958567, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 13:21:52', '2026-04-12 11:14:33', '员工已删除', '9362827', '锦艺城店', '女', '13838002046', 7),
(56395345, 169958304, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 13:17:51', '2023-11-14 20:30:00', '员工已删除', '9357488', '锦艺城店', '女', '15538183532', 7),
(56391755, 169954119, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 11:37:15', '2023-06-22 20:51:13', '员工已删除', '9357488', '锦艺城店', '男', '13545970828', 7),
(56390868, 169953370, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 11:12:39', '2023-09-28 13:31:13', '员工已删除', '9357486', '锦艺城店', '女', '16603993821', 7),
(56390734, 169953207, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 11:09:15', '2023-09-30 11:03:19', '员工已删除', '9357447', '锦艺城店', '男', '13700886778', 7),
(56389512, 169951834, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-18 10:31:44', '2023-11-08 15:50:40', '员工已删除', '9357548', '锦艺城店', '男', '13676968977', 7),
(56387808, 169949998, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 23:53:04', '2023-08-19 20:51:24', '员工已删除', '9357447', '锦艺城店', '女', '18239950668', 7),
(56387765, 169949917, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 23:43:16', '2023-08-19 20:51:50', '员工已删除', '9357548', '锦艺城店', '男', '13271580366', 7),
(56385501, 169946716, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 21:35:58', '2023-07-15 23:17:59', '员工已删除', '9357488', '锦艺城店', '男', '13333338603', 7),
(56384518, 169945376, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 21:11:28', '2024-04-05 21:40:31', '员工已删除', '9395286', '锦艺城店', '女', '17630036840', 7),
(56382569, 169942891, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 20:25:31', '2023-08-25 22:25:10', '员工已删除', '9372092', '锦艺城店', '男', '15036005220', 7),
(56381961, 169941986, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 20:09:27', '2023-07-17 21:23:34', '员工已删除', '9357488', '锦艺城店', '女', '13592588995', 7),
(56381615, 169941452, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 20:00:24', '2026-01-17 18:08:16', '员工已删除', '9357486', '锦艺城店', '女', '13503998687', 7),
(56380107, 169939501, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 19:24:02', '2023-07-07 20:48:31', '员工已删除', '9362827', '锦艺城店', '男', '18039291369', 7),
(56380046, 169939369, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 19:21:47', '2023-09-22 19:44:04', '员工已删除', '9395286', '锦艺城店', '女', '13938251558', 7),
(56379282, 169938310, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-17 19:02:01', '2023-07-13 18:23:35', '员工已删除', '9357548', '锦艺城店', '男', '15981911711', 7),
(56378193, 169936953, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 18:36:58', '2024-04-14 16:14:00', '员工已删除', '9357447', '锦艺城店', '女', '13707627697', 7),
(56378100, 169936854, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-17 18:35:09', '2023-09-17 22:37:51', '员工已删除', '9395286', '锦艺城店', '男', '15515730223', 7),
(56378040, 169936748, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-17 18:33:17', '2023-09-09 15:10:23', '员工已删除', '9357486', '锦艺城店', '女', '15978897703', 7),
(56376240, 169934656, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 17:55:09', '2024-09-15 22:53:04', '员工已删除', '9357548', '锦艺城店', '女', '13592414162', 7),
(56375752, 169934238, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 17:47:46', '2023-08-26 22:23:12', '员工已删除', '9372092', '锦艺城店', '女', '18538194344', 7),
(56375607, 169934089, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 17:45:03', '2023-07-31 15:35:55', '员工已删除', '9395286', '锦艺城店', '女', '15514568766', 7),
(56375493, 169933968, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 17:43:16', '2024-12-16 11:45:15', '员工已删除', '9357488', '锦艺城店', '女', '13140061731', 7),
(56374666, 169933164, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 17:29:34', '2023-07-21 16:44:29', '员工已删除', '9362827', '锦艺城店', '女', '13838073639', 7),
(56373193, 169931394, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 17:00:47', '2024-11-18 17:20:16', '员工已删除', '9357447', '锦艺城店', '男', '13938259535', 7),
(56371722, 169929675, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 16:29:54', '2023-12-25 17:53:03', '员工已删除', '9357486', '锦艺城店', '男', '18695888500', 7),
(56371499, 169929419, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 16:25:06', '2023-08-26 14:58:56', '员工已删除', '9357548', '锦艺城店', '女', '18638071593', 7),
(56371383, 169929209, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 16:22:48', '2023-08-04 19:19:53', '员工已删除', '9362827', '锦艺城店', '男', '15538273705', 7),
(56371086, 169928961, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 16:16:59', '2023-09-22 15:14:34', '员工已删除', '9372092', '锦艺城店', '男', '13569597689', 7),
(56367206, 169914005, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 14:56:48', '2023-07-01 23:16:48', '员工已删除', '9372092', '锦艺城店', '女', '15238315120', 7),
(56364547, 169910867, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 13:50:41', '2023-09-16 18:54:56', '员工已删除', '9357447', '锦艺城店', '男', '18695866808', 7),
(56359706, 169904750, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-17 11:25:50', '2023-07-01 15:54:18', '员工已删除', '9357488', '锦艺城店', '男', '15538138320', 7),
(56359627, 169904556, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 11:23:07', '2023-09-02 13:56:55', '员工已删除', '9372092', '锦艺城店', '女', '15938750156', 7),
(56359482, 169904477, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-17 11:18:25', '2023-09-04 15:11:18', '员工已删除', '9395286', '锦艺城店', '男', '13526833006', 7),
(56356370, 169901004, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 23:42:40', '2023-08-08 21:24:11', '员工已删除', '9372092', '锦艺城店', '男', '13733186803', 7),
(56355736, 169900365, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 22:50:25', '2023-07-28 19:44:38', '员工已删除', '9357486', '锦艺城店', '男', '13598827989', 7),
(56354675, 169899216, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 22:03:30', '2023-09-10 20:04:41', '员工已删除', '9357548', '锦艺城店', '男', '13460228020', 7),
(56354599, 169899136, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 22:01:12', '2023-07-14 21:54:53', '员工已删除,员工已删除', '9357447,9395286', '锦艺城店', '男', '18639550881', 7),
(56354556, 169899085, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 21:59:39', '2023-07-15 21:37:03', '员工已删除', '9362827', '锦艺城店', '女', '15936214021', 7),
(56354487, 169899018, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 21:57:43', '2023-11-25 21:11:46', '员工已删除', '9357488', '锦艺城店', '男', '16696117739', 7),
(56353911, 169898264, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 21:40:34', '2023-08-02 22:57:34', '员工已删除', '9362827', '锦艺城店', '男', '15517151517', 7),
(56353852, 169790453, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 21:38:43', '2023-09-30 11:10:29', '员工已删除', '9362827', '锦艺城店', '女', '15136227238', 7),
(56352371, 169896543, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 21:01:46', '2023-09-01 21:16:12', '员工已删除', '9372092', '锦艺城店', '男', '13673355935', 7),
(56352292, 169896482, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 21:00:26', '2023-09-27 22:22:54', '员工已删除', '9395286', '锦艺城店', '男', '15003801943', 7),
(56352206, 169896352, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 20:57:43', '2025-07-01 16:56:26', '员工已删除', '9357488', '锦艺城店', '男', '13027730072', 7),
(56350171, 169893659, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 20:02:55', '2023-06-25 21:43:45', '员工已删除,员工已删除', '9357486,9395286', '锦艺城店', '女', '17838306997', 7),
(56350110, 169893578, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 20:01:03', '2023-09-15 11:12:38', '员工已删除', '9372092', '锦艺城店', '女', '17788135598', 7),
(56346826, 169889525, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 18:27:37', '2023-09-02 21:33:43', '员工已删除', '9357488', '锦艺城店', '男', '13183003122', 7),
(56346778, 169889440, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 18:26:08', '2023-09-02 21:34:29', '员工已删除', '9362827', '锦艺城店', '女', '13525574610', 7),
(56344971, 169887451, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 17:41:16', '2023-08-21 21:38:37', '员工已删除', '9395286', '锦艺城店', '男', '18657505833', 7),
(56341754, 169884264, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 16:28:19', '2023-07-05 16:57:14', '员工已删除', '9357447', '锦艺城店', '女', '15090081515', 7),
(56340775, 169883281, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 16:07:32', '2023-07-11 17:03:06', '员工已删除', '9372092', '锦艺城店', '男', '15517555800', 7),
(56340694, 169883208, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-16 16:05:36', '2023-06-24 18:02:24', '员工已删除', '9357486', '锦艺城店', '女', '15517555900', 7),
(56339557, 169882136, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-16 15:40:32', '2024-05-14 14:39:53', '员工已删除', '9357447', '锦艺城店', '女', '15639718386', 7);

INSERT INTO vip_migrate_card_snapshot (old_card_id, old_member_id, item_id, item_name, sum_times, leave_times, sum_money, leave_money, once_money, buy_date, last_consume_time, emp_saler_names, emp_saler_ids, shop_name, sex, mobile, org_id) VALUES
(56336160, 169878700, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 14:22:17', '2023-08-18 16:31:05', '员工已删除', '9357488', '锦艺城店', '女', '13803829713', 7),
(56334176, 169875427, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 13:46:42', '2023-06-27 17:04:42', '员工已删除', '9372092', '锦艺城店', '女', '18503896970', 7),
(56334094, 169875331, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 13:44:12', '2023-09-06 15:34:47', '员工已删除', '9362827', '锦艺城店', '女', '13703701703', 7),
(56330724, 169872080, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 12:11:51', '2023-08-08 21:53:01', '员工已删除', '9357447', '锦艺城店', '男', '13653835673', 7),
(56330576, 169871986, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-16 12:08:08', '2023-11-01 18:19:49', '员工已删除', '9357486', '锦艺城店', '女', '13838232228', 7),
(56325471, 169866091, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 22:38:37', '2023-08-21 15:20:58', '员工已删除', '9357488', '锦艺城店', '男', '15038197191', 7),
(56325441, 169866049, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 22:36:42', '2023-07-03 16:16:29', '--', '', '锦艺城店', '男', '13603456821', 7),
(56325421, 169866007, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-15 22:35:05', '2023-07-31 22:33:54', '员工已删除', '9357548', '锦艺城店', '女', '18703607805', 7),
(56325401, 169865953, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 22:33:22', '2026-01-24 18:17:39', '员工已删除', '9357447', '锦艺城店', '女', '13673377360', 7),
(56325344, 169865849, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-15 22:29:20', '2023-08-19 22:55:25', '员工已删除', '9362827', '锦艺城店', '女', '13838221966', 7),
(56322644, 169861308, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 20:46:32', '2023-10-03 16:02:11', '员工已删除', '9357548', '锦艺城店', '男', '18211605381', 7),
(56322207, 169860556, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 20:33:38', '2023-08-11 19:34:28', '员工已删除', '9357486', '锦艺城店', '男', '13203717055', 7),
(56321486, 169859392, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 20:12:09', '2023-07-17 20:44:20', '员工已删除', '9357548', '锦艺城店', '女', '15903605896', 7),
(56321134, 169858817, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 20:02:36', '2023-11-07 19:30:58', '员工已删除', '9357488', '锦艺城店', '女', '17638560759', 7),
(56321032, 169858666, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 20:00:22', '2025-08-23 13:24:27', '员工已删除', '9357548', '锦艺城店', '女', '13277102462', 7),
(56320904, 169858486, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 19:57:02', '2023-10-02 21:27:07', '--', '', '锦艺城店', '女', '15093487897', 7),
(56320823, 169858344, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 19:54:08', '2025-03-10 16:24:34', '--', '', '锦艺城店', '女', '15803880972', 7),
(56317077, 169853529, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 18:11:07', '2023-08-18 16:25:08', '员工已删除', '9357447', '锦艺城店', '女', '13663861836', 7),
(56316910, 169853354, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 18:06:00', '2023-10-17 18:22:49', '员工已删除', '9372092', '锦艺城店', '女', '13526577916', 7),
(56316842, 169853254, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 18:04:01', '2023-06-28 18:05:50', '--', '', '锦艺城店', '女', '13523063472', 7),
(56313994, 169850361, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 16:52:07', '2023-06-29 21:58:49', '员工已删除', '9357447', '锦艺城店', '女', '18539407920', 7),
(56313915, 169850261, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 16:49:43', '2023-09-09 18:45:45', '员工已删除', '9357488', '锦艺城店', '女', '13592421892', 7),
(56313805, 169850121, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 16:46:34', '2023-07-22 22:19:02', '员工已删除', '9357486', '锦艺城店', '女', '13213012009', 7),
(56307692, 169840739, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 16:11:47', '2023-09-25 10:36:09', '员工已删除', '9357447', '锦艺城店', '女', '18638197292', 7),
(56307607, 169840627, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 16:09:15', '2023-09-28 16:57:07', '员工已删除', '9357548', '锦艺城店', '女', '13949077648', 7),
(56307452, 169840502, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 16:06:15', '2023-09-28 16:57:35', '员工已删除', '9362827', '锦艺城店', '女', '13598075161', 7),
(56305458, 169839146, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 15:54:17', '2023-07-31 16:30:56', '员工已删除', '9357488', '锦艺城店', '女', '13513806666', 7),
(56305238, 169838985, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 15:50:06', '2023-09-03 21:41:07', '员工已删除', '9357486', '锦艺城店', '男', '15038353355', 7),
(56302270, 169833452, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 14:35:22', '2024-05-04 20:06:44', '员工已删除', '9357488', '锦艺城店', '男', '13803716131', 7),
(56302194, 169833336, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 14:32:38', '2023-08-11 22:11:15', '员工已删除', '9357548', '锦艺城店', '男', '18903715618', 7),
(56300288, 169827525, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 13:25:19', '2023-07-11 20:27:22', '员工已删除', '9362827', '锦艺城店', '女', '13598869076', 7),
(56300219, 169827455, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-15 13:22:31', '2023-06-29 18:45:17', '员工已删除', '9357488', '锦艺城店', '女', '15225683747', 7),
(56300113, 169827339, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-15 13:19:13', '2023-06-29 18:45:44', '员工已删除', '9357548', '锦艺城店', '男', '18530923938', 7),
(56300081, 169827292, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 13:17:31', '2023-07-13 17:28:29', '员工已删除', '9357486', '锦艺城店', '女', '18137170567', 7),
(56300011, 169827227, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 13:15:54', '2023-06-18 19:09:46', '员工已删除', '9357447', '锦艺城店', '男', '13503860607', 7),
(56299968, 169827167, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 13:14:16', '2023-06-18 19:10:35', '员工已删除', '9372092', '锦艺城店', '女', '15837162887', 7),
(56293728, 169818914, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-15 12:19:51', '2024-01-16 11:17:40', '员工已删除', '9357548', '锦艺城店', '男', '13073705126', 7),
(56290536, 169814182, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 23:41:40', '2023-09-19 22:56:42', '员工已删除', '9362830', '锦艺城店', '男', '18739919007', 7),
(56290534, 169814170, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 23:39:49', '2023-09-19 22:57:12', '员工已删除', '9357486', '锦艺城店', '女', '13140012336', 7),
(56290404, 169813954, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 23:15:37', '2023-08-19 23:20:48', '员工已删除', '9372092', '锦艺城店', '女', '15515772600', 7),
(56290381, 169813895, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 23:10:15', '2023-09-07 12:45:04', '--', '', '锦艺城店', '女', '15939296250', 7),
(56290351, 169813878, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 23:08:53', '2024-04-18 13:28:07', '--', '', '锦艺城店', '女', '15890657879', 7),
(56290344, 169813850, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 23:07:28', '2023-06-17 21:28:56', '--', '', '锦艺城店', '女', '13526659391', 7),
(56290330, 169813819, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 23:05:49', '2023-06-27 18:38:37', '员工已删除', '9357488', '锦艺城店', '女', '15638198258', 7),
(56290319, 169813801, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 23:04:25', '2023-12-31 21:06:41', '员工已删除', '9362830', '锦艺城店', '女', '13503844152', 7),
(56289541, 169812324, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 21:58:45', '2023-07-05 21:42:18', '员工已删除', '9362827', '锦艺城店', '男', '13938233064', 7),
(56289459, 169812224, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 21:55:12', '2023-07-12 12:02:17', '员工已删除', '9357486', '锦艺城店', '男', '13383822319', 7),
(56289308, 169812040, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 21:49:45', '2025-12-15 18:19:14', '员工已删除', '9372092', '锦艺城店', '男', '18037465161', 7),
(56289272, 169811981, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 21:47:59', '2026-03-31 21:24:38', '员工已删除', '9357447', '锦艺城店', '男', '13383868377', 7),
(56289204, 169811831, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 21:44:45', '2023-07-18 20:41:31', '员工已删除', '9357488', '锦艺城店', '女', '13937177310', 7),
(56289142, 169811722, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 21:42:02', '2023-10-05 20:28:59', '员工已删除', '9362830', '锦艺城店', '女', '13523460617', 7),
(56289051, 169811614, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 21:38:26', '2023-08-08 11:58:20', '员工已删除', '9362827', '锦艺城店', '男', '15303836111', 7),
(56289022, 169811557, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 21:36:47', '2023-07-01 20:33:39', '员工已删除', '9357486', '锦艺城店', '男', '13592167376', 7),
(56287431, 169809327, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-14 20:44:59', '2023-06-19 20:50:22', '员工已删除', '9357488', '锦艺城店', '女', '13839538002', 7),
(56287334, 169809205, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 20:42:10', '2024-01-15 19:31:24', '员工已删除', '9357447', '锦艺城店', '女', '13633830400', 7),
(56286493, 169807868, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 20:12:35', '2023-07-26 19:59:26', '--', '', '锦艺城店', '男', '13526543770', 7),
(56286423, 169807752, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-14 20:10:31', '2023-06-16 15:31:08', '员工已删除', '9362830', '锦艺城店', '女', '18638033100', 7),
(56285497, 169806369, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 19:41:03', '2024-01-11 19:47:12', '员工已删除', '9362827', '锦艺城店', '男', '15237507889', 7),
(56285431, 169806305, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 19:39:19', '2023-07-08 17:11:02', '--', '', '锦艺城店', '男', '15838347110', 7),
(56285370, 169806226, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 19:37:36', '2023-07-08 17:10:08', '员工已删除', '9362830', '锦艺城店', '女', '13838517515', 7),
(56285048, 169805681, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-14 19:24:44', '2023-07-10 15:30:11', '员工已删除', '9357488', '锦艺城店', '男', '15981863925', 7),
(56284993, 169805600, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-14 19:22:50', '2023-07-21 12:20:29', '员工已删除', '9357447', '锦艺城店', '女', '15803834325', 7),
(56279178, 169798662, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 16:28:27', '2023-07-31 17:04:24', '员工已删除', '9357486', '锦艺城店', '男', '14788888538', 7),
(56279112, 169798589, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 16:26:36', '2026-03-30 17:33:04', '员工已删除', '9357527', '锦艺城店', '女', '15981878251', 7),
(56277109, 169796373, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 15:26:40', '2023-10-26 11:10:40', '员工已删除', '9362827', '锦艺城店', '女', '18937137737', 7),
(56276442, 169795641, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 15:07:07', '2023-06-19 11:34:27', '员工已删除', '9357486', '锦艺城店', '女', '13526024009', 7),
(56275684, 169794744, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 14:43:50', '2023-06-25 15:31:13', '员工已删除', '9362827', '锦艺城店', '女', '13383822796', 7),
(56274583, 169793599, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 14:09:32', '2023-06-28 12:06:25', '--', '', '锦艺城店', '女', '13393902808', 7),
(56274520, 169793529, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-14 14:07:53', '2023-07-12 16:27:56', '员工已删除', '9362830', '锦艺城店', '男', '13939088544', 7),
(56271959, 169790453, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 12:30:04', '2023-09-30 11:10:29', '员工已删除', '9372092', '锦艺城店', '女', '15136227238', 7),
(56271805, 169790293, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 12:25:01', '2024-06-18 11:08:08', '员工已删除', '9357527', '锦艺城店', '女', '13676992258', 7),
(56271754, 169790215, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 12:22:41', '2023-07-13 12:00:34', '员工已删除', '9357486', '锦艺城店', '女', '18749452606', 7),
(56271710, 169790169, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-14 12:20:52', '2023-07-19 21:20:05', '员工已删除', '9357548', '锦艺城店', '女', '13373950908', 7),
(56268010, 169785410, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 23:19:22', '2023-06-19 23:05:40', '员工已删除', '9357447', '锦艺城店', '女', '13613867646', 7),
(56267794, 169784991, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 22:42:15', '2023-07-02 22:03:15', '员工已删除', '9357527', '锦艺城店', '女', '13949485308', 7),
(56267639, 169784701, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 22:25:17', '2023-07-01 12:11:53', '员工已删除', '9357447', '锦艺城店', '女', '18039667281', 7),
(56267626, 169784668, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 22:23:09', '2023-06-23 20:17:12', '员工已删除', '9372092', '锦艺城店', '女', '18737165357', 7),
(56266668, 169783228, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 21:32:00', '2023-06-28 21:38:41', '员工已删除', '9357548', '锦艺城店', '女', '18860365910', 7),
(56266552, 169783039, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-13 21:27:26', '2023-06-13 21:27:49', '员工已删除', '9357488', '锦艺城店', '男', '18737178605', 7),
(56266413, 169782852, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 21:21:54', '2023-09-15 23:08:38', '员工已删除', '9362827', '锦艺城店', '女', '18838940262', 7),
(56266367, 169782791, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 21:20:13', '2023-07-28 18:37:55', '员工已删除', '9357527', '锦艺城店', '女', '13700887493', 7),
(56266325, 169782720, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 21:18:33', '2023-06-22 21:28:59', '员工已删除', '9357447', '锦艺城店', '女', '17539565802', 7),
(56266264, 169782649, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 21:16:41', '2023-07-20 20:10:15', '员工已删除', '9357486', '锦艺城店', '女', '17739788812', 7),
(56266223, 169782579, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 21:14:48', '2023-07-14 15:56:29', '员工已删除', '9362830', '锦艺城店', '男', '15649060116', 7),
(56266168, 169782508, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-13 21:13:03', '2023-06-26 20:03:13', '员工已删除', '9357548', '锦艺城店', '女', '13607666539', 7),
(56265033, 169780863, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 20:34:44', '2023-06-24 19:12:43', '员工已删除', '9362830', '锦艺城店', '女', '13598089676', 7),
(56264956, 169780758, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 20:32:16', '2023-10-26 16:38:26', '员工已删除', '9362827', '锦艺城店', '女', '15639904746', 7),
(56264887, 169780678, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 20:30:20', '2023-06-30 20:12:56', '员工已删除', '9362827', '锦艺城店', '女', '17719944162', 7),
(56263463, 169778768, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 19:46:53', '2023-06-27 19:28:39', '员工已删除', '9357486', '锦艺城店', '女', '15138957805', 7),
(56263396, 169778696, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 19:45:06', '2023-06-24 16:24:12', '员工已删除', '9372092', '锦艺城店', '女', '13526438815', 7),
(56260045, 169773115, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 17:50:42', '2023-07-03 20:49:58', '员工已删除', '9357527', '锦艺城店', '女', '18737463321', 7),
(56259027, 169771921, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 17:21:18', '2023-06-27 21:36:51', '员工已删除', '9362830', '锦艺城店', '女', '15738822093', 7),
(56257483, 169770271, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-13 16:38:32', '2023-07-13 15:36:45', '员工已删除', '9362827', '锦艺城店', '男', '13838290538', 7),
(56257454, 169770211, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 16:36:54', '2023-08-02 20:51:35', '员工已删除', '9357548', '锦艺城店', '女', '15036237199', 7),
(56257381, 169770140, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-13 16:35:01', '2023-07-04 20:22:26', '员工已删除', '9357447', '锦艺城店', '女', '13938984418', 7),
(56257171, 169769935, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 16:30:10', '2023-11-28 16:15:36', '员工已删除', '9362827', '锦艺城店', '女', '18569931872', 7),
(56253657, 169765803, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 14:46:11', '2023-08-01 16:15:35', '员工已删除', '9357527', '锦艺城店', '男', '15136170397', 7),
(56253509, 169765643, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 14:41:20', '2023-08-09 15:20:07', '员工已删除', '9357486', '锦艺城店', '女', '13598091870', 7),
(56253300, 169765442, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 14:34:23', '2023-06-15 12:30:23', '员工已删除', '9362830', '锦艺城店', '男', '13126790773', 7),
(56253209, 169765334, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 14:32:10', '2023-06-29 15:13:56', '员工已删除', '9372092', '锦艺城店', '女', '13513807672', 7),
(56247904, 169758965, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 11:10:47', '2023-09-19 21:49:13', '员工已删除', '9362827', '锦艺城店', '女', '18240718440', 7),
(56247858, 169758911, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 11:08:52', '2023-08-28 13:16:54', '员工已删除', '9362827', '锦艺城店', '女', '15538213715', 7),
(56247685, 169758705, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-13 11:01:44', '2023-07-22 20:48:11', '员工已删除', '9357446', '锦艺城店', '女', '17093783333', 7),
(56245611, 169756310, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 23:49:55', '2025-10-13 19:29:39', '员工已删除', '9362827', '锦艺城店', '男', '15039090826', 7),
(56245418, 169755766, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 22:55:25', '2023-07-05 22:34:22', '员工已删除', '9362228', '锦艺城店', '女', '18937623043', 7),
(56245186, 169755350, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-12 22:31:12', '2023-06-12 22:31:31', '员工已删除', '9362827', '锦艺城店', '女', '13838070684', 7),
(56244541, 169754221, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 21:49:32', '2023-08-09 18:17:12', '员工已删除', '9357486', '锦艺城店', '女', '19913850196', 7),
(56244499, 169754161, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-12 21:47:44', '2023-06-12 21:48:05', '员工已删除', '9357548', '锦艺城店', '女', '13271582829', 7),
(56244466, 169754082, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-12 21:45:48', '2023-06-12 21:46:08', '员工已删除', '9357447', '锦艺城店', '女', '18037381669', 7),
(56244241, 169753705, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 21:37:04', '2023-08-22 20:46:26', '员工已删除', '9362827', '锦艺城店', '女', '18738195814', 7),
(56244110, 169753586, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-12 21:33:16', '2023-06-12 21:33:37', '员工已删除', '9362830', '锦艺城店', '男', '15803886816', 7),
(56244043, 169753449, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 21:30:13', '2023-09-02 20:18:18', '员工已删除', '9365987', '锦艺城店', '女', '13838348187', 7),
(56243974, 169753307, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 21:26:32', '2023-07-17 22:43:56', '员工已删除', '9357527', '锦艺城店', '女', '17630574101', 7),
(56243884, 169753137, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 21:22:24', '2023-07-17 22:44:26', '员工已删除', '9372092', '锦艺城店', '男', '18538942050', 7),
(56243806, 169753013, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 21:19:28', '2023-06-18 17:03:46', '员工已删除', '9357486', '锦艺城店', '女', '13623712371', 7),
(56243702, 169752833, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 21:15:37', '2023-12-03 21:16:14', '员工已删除', '9362827', '锦艺城店', '女', '15515828111', 7),
(56241802, 169749919, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 20:12:20', '2024-07-12 20:43:25', '员工已删除', '9365987', '锦艺城店', '女', '15138953921', 7),
(56241252, 169748973, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 19:53:24', '2023-08-05 19:16:29', '员工已删除', '9362830', '锦艺城店', '男', '18625666883', 7),
(56240802, 169748347, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 19:38:58', '2023-09-29 18:00:49', '员工已删除', '9362827', '锦艺城店', '男', '13721650601', 7),
(56239351, 169746255, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-12 18:49:10', '2023-07-19 21:47:26', '员工已删除', '9372092', '锦艺城店', '女', '13140067857', 7),
(56239211, 169746124, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 18:46:02', '2025-08-22 18:51:10', '员工已删除', '9362228', '锦艺城店', '女', '15093107218', 7),
(56238861, 169745731, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-12 18:35:34', '2023-06-12 18:36:07', '员工已删除', '9357548', '锦艺城店', '男', '13406712309', 7),
(56238816, 169745659, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 18:33:34', '2023-07-01 18:59:29', '员工已删除', '9365987', '锦艺城店', '女', '15003858463', 7),
(56238724, 169745553, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 18:30:37', '2023-08-02 16:01:48', '员工已删除', '9357447', '锦艺城店', '男', '15237195530', 7),
(56238606, 169745412, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 18:26:57', '2026-03-20 21:26:37', '员工已删除', '9362827', '锦艺城店', '男', '15837177337', 7),
(56236773, 169743343, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 17:32:49', '2024-06-03 11:34:47', '员工已删除', '9357527', '锦艺城店', '男', '13782763180', 7),
(56236719, 169743263, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 17:31:00', '2025-05-24 18:38:44', '员工已删除', '9362827', '锦艺城店', '男', '13782627109', 7),
(56236533, 169743067, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 17:26:27', '2025-09-01 16:35:46', '员工已删除', '9357488', '锦艺城店', '男', '18939515231', 7),
(56236468, 169742978, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 17:24:32', '2023-06-17 16:56:03', '员工已删除', '9357548', '锦艺城店', '女', '15036092966', 7),
(56236372, 169742891, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 17:22:12', '2023-09-04 16:07:17', '员工已删除', '9362830', '锦艺城店', '女', '17746964010', 7),
(56236193, 169742685, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 17:17:26', '2023-08-07 21:00:38', '员工已删除', '9357447', '锦艺城店', '男', '15619358353', 7),
(56234676, 169741109, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 16:39:50', '2023-09-12 21:11:56', '员工已删除', '9362228', '锦艺城店', '女', '17303711020', 7),
(56234514, 169740994, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 16:36:53', '2023-08-24 21:14:24', '员工已删除', '9357486', '锦艺城店', '男', '15617710915', 7),
(56234443, 169740920, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-12 16:34:53', '2023-06-19 22:37:59', '员工已删除', '9362827', '锦艺城店', '女', '15936261656', 7),
(56234287, 169740711, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 16:30:36', '2023-07-12 22:59:52', '员工已删除', '9357488', '锦艺城店', '男', '15537151688', 7),
(56233486, 169739811, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 16:07:43', '2024-11-05 13:45:06', '员工已删除', '9357488', '锦艺城店', '女', '13633816270', 7),
(56233386, 169739669, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 16:04:58', '2023-09-20 16:15:48', '员工已删除', '9362830', '锦艺城店', '男', '13938567656', 7),
(56233319, 169739615, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 16:03:03', '2023-06-24 16:24:57', '员工已删除', '9357527', '锦艺城店', '女', '17637109601', 7),
(56233166, 169739440, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 15:58:16', '2023-07-16 19:46:41', '员工已删除', '9362827', '锦艺城店', '男', '13939027727', 7),
(56233036, 169739325, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 15:54:43', '2023-09-14 14:36:29', '员工已删除', '9362827', '锦艺城店', '男', '13594736599', 7),
(56232969, 169739243, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 15:52:48', '2023-07-05 11:30:02', '员工已删除', '9357488', '锦艺城店', '男', '13403899880', 7),
(56232897, 169739128, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 15:50:31', '2023-09-17 19:23:53', '员工已删除', '9357486', '锦艺城店', '男', '18323001380', 7),
(56232781, 169739011, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-12 15:47:33', '2023-09-18 17:12:55', '员工已删除', '9357447', '锦艺城店', '女', '15638501071', 7),
(56223087, 169721266, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:59:58', '2023-07-14 22:49:44', '员工已删除', '9357527', '锦艺城店', '女', '18337179972', 7),
(56223074, 169721230, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:57:40', '2024-09-24 22:00:35', '员工已删除', '9365987', '锦艺城店', '女', '13526682861', 7),
(56223052, 169721196, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:55:51', '2023-07-24 22:06:47', '员工已删除', '9362228', '锦艺城店', '女', '13700853543', 7),
(56223035, 169721145, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:53:45', '2023-06-28 23:01:32', '员工已删除', '9362830', '锦艺城店', '男', '13598028780', 7),
(56222999, 169721104, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:51:48', '2023-08-10 21:06:31', '员工已删除', '9357548', '锦艺城店', '女', '18639167874', 7),
(56222979, 169721057, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:49:34', '2023-08-10 21:05:56', '员工已删除', '9357528', '锦艺城店', '男', '18639167974', 7),
(56222778, 169720732, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:36:33', '2023-08-21 22:14:35', '员工已删除', '9365987', '锦艺城店', '女', '13674993938', 7),
(56222754, 169720683, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:34:32', '2023-08-21 22:13:10', '员工已删除', '9362228', '锦艺城店', '女', '13592360116', 7),
(56222729, 169720635, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:32:37', '2023-06-26 16:53:23', '员工已删除', '9362830', '锦艺城店', '男', '15188305277', 7),
(56222697, 169720582, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:30:12', '2023-09-08 21:59:36', '员工已删除', '9357447', '锦艺城店', '女', '15188516899', 7),
(56222666, 169720522, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:28:06', '2023-08-11 21:43:37', '员工已删除', '9362827', '锦艺城店', '女', '13253517613', 7),
(56222604, 169720453, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:25:04', '2023-08-09 19:41:07', '员工已删除', '9357447', '锦艺城店', '女', '13783474113', 7),
(56222515, 169720331, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 22:20:43', '2023-06-22 22:48:50', '员工已删除', '9357447', '锦艺城店', '男', '18272576518', 7),
(56221399, 169718556, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 21:37:16', '2023-06-20 21:08:53', '员工已删除', '9365987', '锦艺城店', '女', '18538281587', 7),
(56221345, 169718454, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 21:35:07', '2024-12-07 17:17:58', '员工已删除', '9362228', '锦艺城店', '男', '13939035287', 7),
(56221214, 169718303, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 21:32:10', '2023-07-30 17:08:12', '员工已删除', '9357548', '锦艺城店', '男', '13949088003', 7),
(56220945, 169717879, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 21:23:32', '2023-07-06 18:45:29', '员工已删除', '9357527', '锦艺城店', '男', '13523492223', 7),
(56220865, 169717791, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 21:21:12', '2024-10-04 17:25:00', '员工已删除', '9362827', '锦艺城店', '女', '13608433790', 7),
(56220786, 169717679, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-11 21:19:11', '2023-06-11 21:19:35', '员工已删除', '9357528', '锦艺城店', '男', '17752505583', 7),
(56219090, 169715088, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 2, 0.00, 0.00, 0.00, '2023-06-11 20:35:52', '2023-06-11 20:36:23', '员工已删除', '9357548', '锦艺城店', '男', '15136231248', 7),
(56218956, 169714948, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 20:32:21', '2023-07-15 23:03:26', '员工已删除', '9362228', '锦艺城店', '女', '13253673651', 7),
(56218712, 169714551, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 20:25:21', '2023-07-18 21:36:31', '员工已删除', '9362830', '锦艺城店', '男', '15225100857', 7),
(56218529, 169714232, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 20:20:06', '2023-08-26 19:32:27', '员工已删除', '9357528', '锦艺城店', '女', '15838227072', 7),
(56218427, 169714053, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 20:17:15', '2023-09-24 15:06:52', '员工已删除', '9357447', '锦艺城店', '女', '13673715476', 7),
(56218247, 169713750, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 20:12:05', '2023-09-24 15:07:19', '员工已删除', '9357527', '锦艺城店', '男', '13673711945', 7),
(56215266, 169709083, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 18:54:11', '2024-06-08 23:15:50', '员工已删除', '9357548', '锦艺城店', '男', '18638637160', 7),
(56215038, 169708661, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 18:47:43', '2024-01-27 22:14:01', '员工已删除', '9357447', '锦艺城店', '女', '15324885591', 7),
(56214793, 169708334, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 18:42:24', '2023-07-12 11:54:13', '员工已删除', '9357548', '锦艺城店', '女', '13503813255', 7),
(56214673, 169708171, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 18:39:20', '2023-07-18 12:08:01', '员工已删除', '9362228', '锦艺城店', '男', '13393738483', 7),
(56214506, 169707944, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 18:35:49', '2023-08-04 17:40:11', '员工已删除', '9362827', '锦艺城店', '女', '15138915728', 7),
(56214415, 169707789, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 18:33:36', '2023-06-17 14:35:19', '员工已删除', '9357548', '锦艺城店', '女', '15043022879', 7),
(56214256, 169707616, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 18:30:29', '2024-10-22 17:47:52', '员工已删除', '9365987', '锦艺城店', '女', '15890139852', 7),
(56214131, 169707471, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 18:28:00', '2023-06-26 20:53:58', '员工已删除', '9357527', '锦艺城店', '女', '15690886598', 7),
(56212532, 169705505, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 17:55:03', '2023-10-27 10:50:33', '员工已删除', '9362827', '锦艺城店', '男', '00000000000', 7),
(56211953, 169704772, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-11 17:44:21', '2023-11-24 19:59:19', '员工已删除', '9357528', '锦艺城店', '男', '15517156621', 7),
(56211840, 169704582, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 17:41:41', '2023-09-17 14:57:29', '员工已删除', '9362228', '锦艺城店', '女', '13333986310', 7),
(56211749, 169704463, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 17:39:37', '2025-11-22 19:36:21', '员工已删除', '9362830', '锦艺城店', '女', '13937169063', 7),
(56211623, 169704317, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 17:37:11', '2023-09-11 15:39:10', '员工已删除', '9362228', '锦艺城店', '女', '16696102040', 7),
(56211540, 169704176, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 17:34:53', '2023-09-10 16:40:26', '员工已删除', '9357447', '锦艺城店', '女', '13783479893', 7),
(56211412, 169704046, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 17:32:39', '2023-08-18 20:38:30', '员工已删除', '9365987', '锦艺城店', '男', '15638833397', 7),
(56206226, 169695483, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 15:39:23', '2023-09-10 15:34:34', '员工已删除', '9362827', '锦艺城店', '男', '13643835056', 7),
(56206120, 169695248, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-11 15:36:51', '2023-10-18 13:50:48', '员工已删除', '9362830', '锦艺城店', '女', '17739773206', 7),
(56205692, 169694721, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 15:26:06', '2023-06-14 16:30:36', '员工已删除', '9357527', '锦艺城店', '男', '15038389105', 7),
(56205571, 169694505, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 15:23:21', '2024-06-19 14:27:38', '员工已删除', '9357447', '锦艺城店', '女', '13253384998', 7),
(56205427, 169694344, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 15:19:43', '2023-09-01 22:26:30', '员工已删除', '9362228', '锦艺城店', '男', '15039061918', 7),
(56205261, 169694082, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 1, 0.00, 0.00, 0.00, '2023-06-11 15:15:48', '2023-06-15 14:33:48', '员工已删除', '9357548', '锦艺城店', '男', '15003940281', 7),
(56204486, 169693130, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 14:58:01', '2023-06-24 21:30:53', '员工已删除', '9362830', '锦艺城店', '男', '18137171588', 7),
(56204367, 207968686, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 14:54:43', '2026-03-20 20:43:30', '员工已删除', '9362827', '锦艺城店', '女', '18539280565', 7),
(56204189, 169692656, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 14:50:16', '2024-07-18 21:56:55', '员工已删除', '9357447', '锦艺城店', '男', '13253618729', 7),
(56203861, 169692230, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 14:41:17', '2023-09-16 11:06:29', '员工已删除', '9362228', '锦艺城店', '女', '15517505061', 7),
(56202512, 169690148, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 13:59:56', '2023-06-13 17:25:04', '员工已删除', '9362830', '锦艺城店', '女', '13653975573', 7),
(56200678, 169687386, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 13:01:49', '2024-07-03 18:27:58', '员工已删除', '9357447', '锦艺城店', '男', '15093353979', 7),
(56199752, 169682268, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 12:32:38', '2023-09-17 12:53:51', '员工已删除', '9362830', '锦艺城店', '男', '13849043827', 7),
(56199657, 169682162, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 12:29:27', '2025-07-05 11:48:59', '员工已删除', '9357548', '锦艺城店', '男', '15003810317', 7),
(56199548, 169682039, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 12:26:07', '2023-11-24 15:11:54', '员工已删除', '9362827', '锦艺城店', '女', '19139777789', 7),
(56197743, 169678823, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 11:28:39', '2023-07-12 15:30:54', '员工已删除', '9357527', '锦艺城店', '男', '13619849095', 7),
(56197456, 169679125, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 11:16:39', '2023-07-12 15:31:52', '员工已删除', '9362830', '锦艺城店', '女', '13721416619', 7),
(56197025, 169678516, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 11:01:04', '2023-06-14 10:39:23', '员工已删除', '9357548', '锦艺城店', '男', '13598001350', 7),
(56196919, 169678002, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 10:56:26', '2023-08-22 10:57:02', '员工已删除', '9357447', '锦艺城店', '男', '13598524766', 7),
(56196574, 169677771, '-1', '100-经典足道50分钟,103-采耳,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, '2023-06-11 10:42:03', '2023-08-20 21:09:06', '员工已删除', '9362827', '锦艺城店', '女', '13849528107', 7),
(65824678, 184808941, '301', '301-精品修脚', 1, 0, 0.00, 0.00, 0.00, NULL, '2024-07-12 20:43:25', '--', '', '锦艺城店', '女', '15138953921', 7),
(65824679, 184808942, '104', '104-局部推拿', 1, 0, 0.00, 0.00, 0.00, NULL, '2024-12-12 21:49:41', '--', '', '锦艺城店', '女', '13526601116', 7),
(65824680, 184808943, '104', '104-局部推拿', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18530071994', 7),
(65824681, 184808944, '104', '104-局部推拿', 1, 0, 0.00, 0.00, 0.00, NULL, '2026-03-23 16:30:07', '--', '', '锦艺城店', '女', '13949033282', 7),
(65824682, 184808945, '104', '104-局部推拿', 1, 0, 0.00, 0.00, 0.00, NULL, '2026-03-21 16:48:30', '--', '', '锦艺城店', '女', '18625581116', 7),
(65824683, 184808946, '104', '104-局部推拿', 1, 0, 0.00, 0.00, 0.00, NULL, '2026-03-10 20:09:37', '--', '', '锦艺城店', '女', '13613802882', 7),
(65824684, 184808947, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15981902126', 7),
(65824685, 184808948, '301', '301-精品修脚', 1, 0, 0.00, 0.00, 0.00, NULL, '2024-06-13 21:40:11', '--', '', '锦艺城店', '女', '15738502374', 7),
(65824686, 184808949, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, '2025-09-15 21:58:41', '--', '', '锦艺城店', '女', '13603990607', 7),
(65824687, 184808950, '114', '114-特色足疗70分钟', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15238377329', 7),
(65824688, 184808951, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13103710011', 7),
(65824689, 184808952, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13939055901', 7),
(65824690, 184808953, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18638548661', 7),
(65824691, 184808954, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13603863355', 7),
(65824692, 184808955, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13203733815', 7),
(65824693, 184808956, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15188375269', 7),
(65824694, 184808957, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-01-27 23:03:06', '--', '', '锦艺城店', '女', '13608686660', 7),
(65824695, 184808958, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18703657744', 7),
(65824696, 184808959, '114', '114-特色足疗70分钟', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-03-28 13:44:06', '--', '', '锦艺城店', '女', '15238387637', 7),
(65824697, 184808960, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15038395666', 7),
(65824698, 184808961, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15138681290', 7),
(65824699, 184808962, '114', '114-特色足疗70分钟', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13783408979', 7),
(65824700, 184808963, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13937173501', 7),
(65824701, 184808963, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13937173501', 7),
(65824702, 184808964, '114', '114-特色足疗70分钟', 1, 0, 0.00, 0.00, 0.00, NULL, '2026-04-11 16:15:58', '--', '', '锦艺城店', '女', '15515700088', 7),
(65824703, 184808965, '301', '301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-04-11 11:45:15', '--', '', '锦艺城店', '女', '13700847106', 7),
(65824704, 184808966, '104', '104-局部推拿', 10, 0, 0.00, 0.00, 0.00, NULL, '2026-04-11 15:50:47', '--', '', '锦艺城店', '女', '13838572828', 7),
(65824705, 184808967, '104', '104-局部推拿', 10, 4, 0.00, 0.00, 0.00, NULL, '2025-04-30 21:02:22', '--', '', '锦艺城店', '女', '18538741959', 7),
(65824706, 184808968, '104', '104-局部推拿', 12, 0, 0.00, 0.00, 0.00, NULL, '2026-03-16 22:17:44', '--', '', '锦艺城店', '女', '17337109636', 7),
(65824707, 184808969, '104', '104-局部推拿', 14, 0, 0.00, 0.00, 0.00, NULL, '2026-03-07 18:10:24', '--', '', '锦艺城店', '女', '13526751061', 7),
(65824708, 184808946, '104', '104-局部推拿', 16, 0, 0.00, 0.00, 0.00, NULL, '2026-03-10 20:09:37', '--', '', '锦艺城店', '女', '13613802882', 7),
(65824709, 184808970, '301', '301-精品修脚', 2, 0, 0.00, 0.00, 0.00, NULL, '2024-06-30 10:33:03', '--', '', '锦艺城店', '女', '13673391012', 7),
(65824710, 184808971, '209', '209-全身推拿', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18337173660', 7),
(65824711, 184808943, '301', '301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18530071994', 7),
(65824712, 184808972, '104', '104-局部推拿', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13803911229', 7),
(65824713, 184808973, '104', '104-局部推拿', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '16603871777', 7),
(65824714, 184808974, '104', '104-局部推拿', 3, 0, 0.00, 0.00, 0.00, NULL, '2024-08-09 21:32:25', '--', '', '锦艺城店', '女', '18638015769', 7),
(65824715, 184808975, '104', '104-局部推拿', 3, 0, 0.00, 0.00, 0.00, NULL, '2026-04-13 16:51:14', '--', '', '锦艺城店', '女', '15290826594', 7),
(65824716, 184808976, '301', '301-精品修脚', 3, 0, 0.00, 0.00, 0.00, NULL, '2026-03-16 15:49:13', '--', '', '锦艺城店', '女', '13653836542', 7),
(65824717, 184808977, '104', '104-局部推拿', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18337101697', 7),
(65824718, 184808978, '104', '104-局部推拿', 4, 0, 0.00, 0.00, 0.00, NULL, '2026-04-07 21:20:40', '--', '', '锦艺城店', '女', '13803716292', 7),
(65824719, 184808979, '301', '301-精品修脚', 4, 0, 0.00, 0.00, 0.00, NULL, '2024-07-20 16:03:55', '--', '', '锦艺城店', '女', '13838134935', 7),
(65824720, 184808980, '104', '104-局部推拿', 4, 3, 0.00, 0.00, 0.00, NULL, '2025-04-11 16:58:08', '--', '', '锦艺城店', '女', '15890107203', 7),
(65824721, 184808981, '301', '301-精品修脚', 4, 0, 0.00, 0.00, 0.00, NULL, '2024-07-11 23:36:38', '--', '', '锦艺城店', '女', '15690886113', 7),
(65824722, 184808982, '104', '104-局部推拿', 4, 0, 0.00, 0.00, 0.00, NULL, '2026-02-07 15:17:15', '--', '', '锦艺城店', '女', '15838254589', 7),
(65824723, 184808983, '301', '301-精品修脚', 4, 0, 0.00, 0.00, 0.00, NULL, '2026-03-26 17:19:59', '--', '', '锦艺城店', '女', '18937171522', 7),
(65824724, 184808984, '104', '104-局部推拿', 5, 0, 0.00, 0.00, 0.00, NULL, '2024-10-22 17:47:52', '--', '', '锦艺城店', '女', '15890139852', 7),
(65824725, 184808985, '104', '104-局部推拿', 5, 0, 0.00, 0.00, 0.00, NULL, '2026-04-06 18:21:42', '--', '', '锦艺城店', '女', '13703849111', 7),
(65824726, 184808986, '301', '301-精品修脚', 5, 5, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15837138840', 7),
(65824727, 184808987, '301', '301-精品修脚', 5, 1, 0.00, 0.00, 0.00, NULL, '2025-12-02 18:07:26', '--', '', '锦艺城店', '女', '13526862887', 7),
(65824728, 184808988, '301', '301-精品修脚', 5, 0, 0.00, 0.00, 0.00, NULL, '2024-12-04 21:41:18', '--', '', '锦艺城店', '女', '13683805105', 7),
(65824729, 184808989, '301', '301-精品修脚', 5, 0, 0.00, 0.00, 0.00, NULL, '2025-12-28 17:09:43', '--', '', '锦艺城店', '女', '15237105162', 7),
(65824730, 184808990, '301', '301-精品修脚', 5, 0, 0.00, 0.00, 0.00, NULL, '2024-09-02 16:11:33', '--', '', '锦艺城店', '女', '15038010201', 7),
(65824731, 184808966, '301', '301-精品修脚', 5, 0, 0.00, 0.00, 0.00, NULL, '2026-04-11 15:50:47', '--', '', '锦艺城店', '女', '13838572828', 7),
(65824732, 184808991, '104', '104-局部推拿', 5, 0, 0.00, 0.00, 0.00, NULL, '2025-01-17 20:55:51', '--', '', '锦艺城店', '女', '15136425200', 7),
(65824733, 184808992, '104', '104-局部推拿', 5, 0, 0.00, 0.00, 0.00, NULL, '2026-03-11 19:49:04', '--', '', '锦艺城店', '女', '15093124152', 7),
(65824734, 184808993, '104', '104-局部推拿', 5, 5, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13938555456', 7),
(65824735, 184808994, '301', '301-精品修脚', 6, 0, 0.00, 0.00, 0.00, NULL, '2024-12-26 16:02:14', '--', '', '锦艺城店', '女', '15838323390', 7),
(65824736, 184808995, '104', '104-局部推拿', 6, 0, 0.00, 0.00, 0.00, NULL, '2026-03-28 17:25:21', '--', '', '锦艺城店', '女', '13233869158', 7),
(65824737, 184808995, '301', '301-精品修脚', 6, 0, 0.00, 0.00, 0.00, NULL, '2026-03-28 17:25:21', '--', '', '锦艺城店', '女', '13233869158', 7),
(65824738, 184808996, '104', '104-局部推拿', 7, 0, 0.00, 0.00, 0.00, NULL, '2026-04-02 22:50:44', '--', '', '锦艺城店', '女', '13592665836', 7),
(65824739, 184808997, '301', '301-精品修脚', 7, 0, 0.00, 0.00, 0.00, NULL, '2026-02-08 21:39:06', '--', '', '锦艺城店', '女', '13213223283', 7),
(65824740, 184808998, '301', '301-精品修脚', 7, 7, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18937729707', 7),
(65824741, 184808999, '301', '301-精品修脚', 7, 3, 0.00, 0.00, 0.00, NULL, '2026-01-15 11:14:17', '--', '', '锦艺城店', '女', '13683839705', 7),
(65824742, 184808994, '104', '104-局部推拿', 8, 0, 0.00, 0.00, 0.00, NULL, '2024-12-26 16:02:14', '--', '', '锦艺城店', '女', '15838323390', 7),
(65824743, 184809000, '104', '104-局部推拿', 8, 0, 0.00, 0.00, 0.00, NULL, '2026-03-24 17:27:49', '--', '', '锦艺城店', '女', '13569290223', 7),
(65824744, 184809001, '301', '301-精品修脚', 8, 7, 0.00, 0.00, 0.00, NULL, '2024-05-16 20:06:57', '--', '', '锦艺城店', '女', '15838310148', 7),
(65824745, 184809002, '104', '104-局部推拿', 8, 0, 0.00, 0.00, 0.00, NULL, '2025-12-30 11:41:49', '--', '', '锦艺城店', '女', '15639070400', 7),
(65824746, 184809003, '104', '104-局部推拿', 9, 0, 0.00, 0.00, 0.00, NULL, '2025-09-07 11:38:30', '--', '', '锦艺城店', '女', '18003716999', 7),
(65824747, 184809004, '104', '104-局部推拿', 9, 0, 0.00, 0.00, 0.00, NULL, '2024-11-28 12:32:26', '--', '', '锦艺城店', '女', '15803879989', 7),
(65824748, 184809005, '104', '104-局部推拿', 9, 9, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13674985677', 7),
(65824749, 184809006, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13643836430', 7),
(65824750, 184809007, '-1', '104-局部推拿,301-精品修脚', 1, 0, 0.00, 0.00, 0.00, NULL, '2025-03-13 21:12:45', '--', '', '锦艺城店', '女', '18530080362', 7),
(65824751, 184809008, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '17320116680', 7),
(65824752, 184809009, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13592606016', 7),
(65824753, 184809010, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13673623435', 7),
(65824754, 184809011, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, '2025-06-24 14:45:57', '--', '', '锦艺城店', '女', '13939319915', 7),
(65824755, 184809012, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18203996209', 7),
(65824756, 184808997, '-1', '104-局部推拿,301-精品修脚', 1, 0, 0.00, 0.00, 0.00, NULL, '2026-02-08 21:39:06', '--', '', '锦艺城店', '女', '13213223283', 7),
(65824757, 184809013, '-1', '104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13949027868', 7),
(65824758, 184809014, '-1', '104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-03-13 11:38:48', '--', '', '锦艺城店', '女', '13838026204', 7),
(65824759, 184809015, '-1', '104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-04-11 18:48:06', '--', '', '锦艺城店', '女', '13607693890', 7),
(65824760, 184809016, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15638178321', 7),
(65824761, 184809017, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '19138013208', 7),
(65824762, 184809018, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13959271761', 7),
(65824763, 184809019, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13526639626', 7),
(65824764, 184809020, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15237701434', 7),
(65824765, 184809021, '-1', '104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, '2025-11-14 22:25:30', '--', '', '锦艺城店', '女', '18638165984', 7),
(65824766, 184809022, '-1', '104-局部推拿,301-精品修脚', 1, 0, 0.00, 0.00, 0.00, NULL, '2026-03-18 11:07:04', '--', '', '锦艺城店', '女', '15138969712', 7),
(65824767, 184809023, '-1', '104-局部推拿,301-精品修脚', 1, 0, 0.00, 0.00, 0.00, NULL, '2025-08-18 21:20:30', '--', '', '锦艺城店', '女', '13838121054', 7),
(65824768, 184809024, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13938615237', 7),
(65824769, 184809025, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '19337161618', 7),
(65824770, 184809026, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13592598058', 7),
(65824771, 184809027, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13007602038', 7),
(65824772, 184809028, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13673001431', 7),
(65824773, 184809029, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18336010223', 7),
(65824774, 184809030, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15738317775', 7),
(65824775, 184809031, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13383822319', 7),
(65824776, 184809032, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15291955292', 7),
(65824777, 184809033, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-03-19 20:01:26', '--', '', '锦艺城店', '女', '13733835255', 7),
(65824778, 184809034, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15515736009', 7),
(65824779, 184809035, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15225122281', 7),
(65824780, 184809035, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15225122281', 7),
(65824781, 184809036, '102', '102-足疗套餐A', 1, 0, 0.00, 0.00, 0.00, NULL, '2024-08-18 17:13:41', '--', '', '锦艺城店', '女', '13938585035', 7),
(65824782, 184809036, '102', '102-足疗套餐A', 1, 0, 0.00, 0.00, 0.00, NULL, '2024-08-18 17:13:41', '--', '', '锦艺城店', '女', '13938585035', 7),
(65824783, 184809037, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15639797516', 7),
(65824784, 184809037, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15639797516', 7),
(65824785, 184809037, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15639797516', 7),
(65824786, 184809037, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15639797516', 7),
(65824787, 184809038, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13603865080', 7),
(65824788, 184809038, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13603865080', 7),
(65824789, 184809039, '102', '102-足疗套餐A', 1, 0, 0.00, 0.00, 0.00, NULL, '2025-11-15 15:47:57', '--', '', '锦艺城店', '女', '18503838901', 7),
(65824790, 184809040, '102', '102-足疗套餐A', 1, 0, 0.00, 0.00, 0.00, NULL, '2025-07-14 14:23:39', '--', '', '锦艺城店', '女', '13838189201', 7),
(65824791, 184809040, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2025-07-14 14:23:39', '--', '', '锦艺城店', '女', '13838189201', 7),
(65824792, 184809041, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2025-05-15 11:55:52', '--', '', '锦艺城店', '女', '18037573590', 7),
(65824793, 184809041, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2025-05-15 11:55:52', '--', '', '锦艺城店', '女', '18037573590', 7),
(65824794, 184809041, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2025-05-15 11:55:52', '--', '', '锦艺城店', '女', '18037573590', 7),
(65824795, 184809041, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2025-05-15 11:55:52', '--', '', '锦艺城店', '女', '18037573590', 7),
(65824796, 184809042, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-04-05 20:11:55', '--', '', '锦艺城店', '女', '18637122576', 7),
(65824797, 184809043, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15737175668', 7),
(65824798, 184809044, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-01-05 14:32:31', '--', '', '锦艺城店', '女', '13461421604', 7),
(65824799, 184809044, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-01-05 14:32:31', '--', '', '锦艺城店', '女', '13461421604', 7),
(65824800, 184809045, '102', '102-足疗套餐A', 1, 0, 0.00, 0.00, 0.00, NULL, '2026-03-08 16:43:35', '--', '', '锦艺城店', '女', '13703905592', 7),
(65824801, 184808965, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-04-11 11:45:15', '--', '', '锦艺城店', '女', '13700847106', 7),
(65824802, 184809046, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2025-10-21 22:16:00', '--', '', '锦艺城店', '女', '13937115799', 7),
(65824803, 184809047, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-03-25 17:29:04', '--', '', '锦艺城店', '女', '13938569634', 7),
(65824804, 184809047, '102', '102-足疗套餐A', 1, 1, 0.00, 0.00, 0.00, NULL, '2026-03-25 17:29:04', '--', '', '锦艺城店', '女', '13938569634', 7),
(65824805, 184809048, '-1', '104-局部推拿,301-精品修脚', 10, 0, 0.00, 0.00, 0.00, NULL, '2026-02-05 20:05:58', '--', '', '锦艺城店', '女', '13525532853', 7),
(65824806, 184809049, '-1', '104-局部推拿,301-精品修脚', 10, 0, 0.00, 0.00, 0.00, NULL, '2025-12-18 16:22:24', '--', '', '锦艺城店', '女', '13721436225', 7),
(65824807, 184809050, '-1', '113-至尊足疗80分钟,206-精油开背', 10, 6, 0.00, 0.00, 0.00, NULL, '2026-04-10 17:39:44', '--', '', '锦艺城店', '女', '13343859556', 7),
(65824808, 184808973, '-1', '104-局部推拿,301-精品修脚', 10, 10, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '16603871777', 7),
(65824809, 184808973, '-1', '104-局部推拿,301-精品修脚', 10, 10, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '16603871777', 7),
(65824810, 184809051, '-1', '104-局部推拿,301-精品修脚', 10, 10, 0.00, 0.00, 0.00, NULL, '2024-09-08 11:22:27', '--', '', '锦艺城店', '女', '18537180101', 7),
(65824811, 184809052, '-1', '104-局部推拿,301-精品修脚', 10, 10, 0.00, 0.00, 0.00, NULL, '2026-04-01 11:43:00', '--', '', '锦艺城店', '女', '13333818588', 7),
(65824812, 184809053, '-1', '104-局部推拿,301-精品修脚', 10, 10, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15286800109', 7),
(65824813, 184809054, '-1', '104-局部推拿,301-精品修脚', 13, 3, 0.00, 0.00, 0.00, NULL, '2026-04-03 15:43:42', '--', '', '锦艺城店', '女', '15981865902', 7),
(65824814, 184809055, '-1', '104-局部推拿,301-精品修脚', 17, 14, 0.00, 0.00, 0.00, NULL, '2024-09-03 21:22:52', '--', '', '锦艺城店', '女', '18595658404', 7),
(65824815, 184808944, '-1', '104-局部推拿,301-精品修脚', 18, 0, 0.00, 0.00, 0.00, NULL, '2026-03-23 16:30:07', '--', '', '锦艺城店', '女', '13949033282', 7),
(65824816, 184809056, '-1', '104-局部推拿,301-精品修脚', 19, 19, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13733865481', 7),
(65824817, 184809057, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 1, 0.00, 0.00, 0.00, NULL, '2024-06-18 18:11:54', '--', '', '锦艺城店', '女', '13598886853', 7),
(65824818, 184809058, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15514383625', 7),
(65824819, 184809059, '-1', '104-局部推拿,301-精品修脚', 2, 0, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15324885591', 7),
(65824820, 184809060, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, '2025-01-10 20:10:07', '--', '', '锦艺城店', '女', '15638109296', 7),
(65824821, 184809061, '-1', '104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13333840337', 7),
(65824822, 184809062, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '1000121187', 7),
(65824823, 184809063, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15810885205', 7),
(65824824, 184809064, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13203710656', 7),
(65824825, 184809065, '-1', '104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13526803537', 7),
(65824826, 184809066, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '17737176577', 7),
(65824827, 184809067, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, '2024-10-29 15:48:32', '--', '', '锦艺城店', '女', '15638871833', 7),
(65824828, 184809067, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, '2024-10-29 15:48:32', '--', '', '锦艺城店', '女', '15638871833', 7),
(65824829, 184809068, '-1', '104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, '2025-04-03 21:26:31', '--', '', '锦艺城店', '女', '15515722886', 7),
(65824830, 184809069, '301', '301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, '2025-07-13 19:45:52', '--', '', '锦艺城店', '女', '16650237696', 7),
(65824831, 184809070, '-1', '104-局部推拿,301-精品修脚', 2, 0, 0.00, 0.00, 0.00, NULL, '2025-10-25 18:57:17', '--', '', '锦艺城店', '女', '17752563920', 7),
(65824832, 184809071, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15003871086', 7),
(65824833, 184809072, '-1', '104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15136196811', 7),
(65824834, 184809073, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18538700095', 7),
(65824835, 184809074, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15936256897', 7),
(65824836, 184809075, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13837114130', 7),
(65824837, 184809076, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, '2025-06-17 17:35:04', '--', '', '锦艺城店', '女', '13592679350', 7),
(65824838, 184809077, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18567531486', 7),
(65824839, 184808950, '103', '103-采耳', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15238377329', 7),
(65824840, 184808950, '-1', '104-局部推拿,301-精品修脚', 2, 2, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15238377329', 7),
(65824841, 184808992, '-1', '104-局部推拿,301-精品修脚', 20, 0, 0.00, 0.00, 0.00, NULL, '2026-03-11 19:49:04', '--', '', '锦艺城店', '女', '15093124152', 7),
(65824842, 184809078, '-1', '104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, NULL, '2024-06-21 19:16:03', '--', '', '锦艺城店', '女', '18595806743', 7),
(65824843, 184809079, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13707581722', 7),
(65824844, 184809080, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13523577795', 7),
(65824845, 184809081, '-1', '104-局部推拿,301-精品修脚', 3, 0, 0.00, 0.00, 0.00, NULL, '2026-03-13 15:49:07', '--', '', '锦艺城店', '女', '13526678852', 7),
(65824846, 184809082, '-1', '104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18737145558', 7),
(65824847, 184809083, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13733748620', 7),
(65824848, 184809084, '-1', '104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13598872479', 7),
(65824849, 184809085, '-1', '104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15378786744', 7),
(65824850, 184809086, '-1', '104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18625522251', 7),
(65824851, 184809087, '-1', '104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13653838152', 7),
(65824852, 184809088, '-1', '104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, '2024-07-06 19:15:43', '--', '', '锦艺城店', '女', '13598871135', 7),
(65824853, 184809089, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13938525895', 7),
(65824854, 184809090, '-1', '104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, '2026-04-01 22:11:46', '--', '', '锦艺城店', '女', '15729391111', 7),
(65824855, 184809091, '-1', '100-经典足道50分钟,104-局部推拿,301-精品修脚', 3, 3, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18303658503', 7),
(65824856, 184809092, '-1', '104-局部推拿,301-精品修脚', 4, 0, 0.00, 0.00, 0.00, NULL, '2025-01-04 21:57:38', '--', '', '锦艺城店', '女', '15839837763', 7),
(65824857, 184809093, '-1', '104-局部推拿,301-精品修脚', 4, 2, 0.00, 0.00, 0.00, NULL, '2025-06-02 15:00:27', '--', '', '锦艺城店', '女', '15639269628', 7),
(65824858, 184809094, '-1', '104-局部推拿,301-精品修脚', 4, 4, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '17753101138', 7),
(65824859, 184809095, '-1', '104-局部推拿,301-精品修脚', 4, 4, 0.00, 0.00, 0.00, NULL, '2025-04-23 18:43:02', '--', '', '锦艺城店', '女', '18595750693', 7),
(65824860, 184809096, '-1', '104-局部推拿,301-精品修脚', 4, 0, 0.00, 0.00, 0.00, NULL, '2026-01-05 16:58:43', '--', '', '锦艺城店', '女', '18336375860', 7),
(65824861, 184809097, '-1', '104-局部推拿,301-精品修脚', 5, 0, 0.00, 0.00, 0.00, NULL, '2025-04-25 21:34:38', '--', '', '锦艺城店', '女', '13523048596', 7),
(65824862, 184809098, '-1', '104-局部推拿,301-精品修脚', 5, 0, 0.00, 0.00, 0.00, NULL, '2024-07-18 21:56:55', '--', '', '锦艺城店', '女', '13253618729', 7),
(65824863, 184809099, '-1', '104-局部推拿,301-精品修脚', 5, 0, 0.00, 0.00, 0.00, NULL, '2026-03-16 22:23:38', '--', '', '锦艺城店', '女', '15617679900', 7),
(65824864, 184809100, '-1', '104-局部推拿,301-精品修脚', 5, 5, 0.00, 0.00, 0.00, NULL, '2026-03-29 14:01:20', '--', '', '锦艺城店', '女', '15600460067', 7),
(65824865, 184809101, '-1', '104-局部推拿,301-精品修脚', 5, 0, 0.00, 0.00, 0.00, NULL, '2026-03-30 14:10:03', '--', '', '锦艺城店', '女', '13223713056', 7),
(65824866, 184809051, '-1', '104-局部推拿,301-精品修脚', 5, 5, 0.00, 0.00, 0.00, NULL, '2024-09-08 11:22:27', '--', '', '锦艺城店', '女', '18537180101', 7),
(65824867, 184809102, '-1', '104-局部推拿,301-精品修脚', 6, 1, 0.00, 0.00, 0.00, NULL, '2024-06-11 21:53:47', '--', '', '锦艺城店', '女', '15036112953', 7),
(65824868, 184809103, '-1', '104-局部推拿,301-精品修脚', 6, 0, 0.00, 0.00, 0.00, NULL, '2024-08-08 16:02:58', '--', '', '锦艺城店', '女', '13803890925', 7),
(65824869, 184809104, '-1', '104-局部推拿,301-精品修脚', 6, 0, 0.00, 0.00, 0.00, NULL, '2024-12-28 20:46:21', '--', '', '锦艺城店', '女', '15188377261', 7),
(65824870, 184809105, '-1', '113-至尊足疗80分钟,206-精油开背', 6, 0, 0.00, 0.00, 0.00, NULL, '2024-11-18 17:20:16', '--', '', '锦艺城店', '女', '13938259535', 7),
(65824871, 184809106, '-1', '104-局部推拿,301-精品修脚', 6, 6, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15838051760', 7),
(65824872, 184809107, '-1', '104-局部推拿,301-精品修脚', 6, 6, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15939431999', 7),
(65824873, 184809108, '-1', '104-局部推拿,301-精品修脚', 6, 6, 0.00, 0.00, 0.00, NULL, '2025-12-28 16:12:40', '--', '', '锦艺城店', '女', '15565876018', 7),
(65824874, 184809053, '-1', '104-局部推拿,301-精品修脚', 6, 6, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '15286800109', 7),
(65824875, 184808971, '-1', '113-至尊足疗80分钟,206-精油开背', 7, 7, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18337173660', 7),
(65824876, 184809109, '-1', '113-至尊足疗80分钟,206-精油开背', 7, 0, 0.00, 0.00, 0.00, NULL, '2026-04-09 15:56:35', '--', '', '锦艺城店', '女', '15838059755', 7),
(65824877, 184809110, '-1', '113-至尊足疗80分钟,206-精油开背', 7, 1, 0.00, 0.00, 0.00, NULL, '2025-06-26 16:25:30', '--', '', '锦艺城店', '女', '13803820936', 7),
(65824878, 184809111, '-1', '104-局部推拿,301-精品修脚', 7, 7, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13673713596', 7),
(65824879, 184809112, '-1', '104-局部推拿,301-精品修脚', 7, 7, 0.00, 0.00, 0.00, NULL, '2025-11-15 22:01:43', '--', '', '锦艺城店', '女', '13703926330', 7),
(65824880, 184809113, '-1', '104-局部推拿,301-精品修脚', 7, 7, 0.00, 0.00, 0.00, NULL, '2024-11-08 15:53:08', '--', '', '锦艺城店', '女', '13523496810', 7),
(65824881, 184809114, '-1', '113-至尊足疗80分钟,206-精油开背', 8, 0, 0.00, 0.00, 0.00, NULL, '2025-03-20 14:47:32', '--', '', '锦艺城店', '女', '17596574484', 7),
(65824882, 184809115, '-1', '104-局部推拿,301-精品修脚', 8, 8, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13838551523', 7),
(65824883, 184809116, '-1', '104-局部推拿,301-精品修脚', 8, 8, 0.00, 0.00, 0.00, NULL, '2025-10-29 19:47:00', '--', '', '锦艺城店', '女', '17703823712', 7),
(65824884, 184809117, '-1', '104-局部推拿,301-精品修脚', 8, 8, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '16639171468', 7),
(65824885, 184809118, '-1', '104-局部推拿,301-精品修脚', 8, 8, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '13783614454', 7),
(65824886, 184809119, '-1', '104-局部推拿,301-精品修脚', 8, 8, 0.00, 0.00, 0.00, NULL, NULL, '--', '', '锦艺城店', '女', '18738489705', 7),
(65824887, 184809120, '-1', '104-局部推拿,301-精品修脚', 8, 8, 0.00, 0.00, 0.00, NULL, '2026-03-29 14:45:26', '--', '', '锦艺城店', '女', '13083715585', 7),
(65824888, 184809121, '-1', '104-局部推拿,301-精品修脚', 9, 1, 0.00, 0.00, 0.00, NULL, '2026-03-08 13:22:02', '--', '', '锦艺城店', '女', '17719888087', 7),
(65824889, 184809122, '-1', '104-局部推拿,301-精品修脚', 9, 0, 0.00, 0.00, 0.00, NULL, '2024-12-02 11:45:19', '--', '', '锦艺城店', '女', '15138273687', 7),
(65824890, 184809070, '-1', '104-局部推拿,301-精品修脚', 9, 3, 0.00, 0.00, 0.00, NULL, '2025-10-25 18:57:17', '--', '', '锦艺城店', '女', '17752563920', 7),
(65824891, 184809052, '-1', '104-局部推拿,301-精品修脚', 9, 9, 0.00, 0.00, 0.00, NULL, '2026-04-01 11:43:00', '--', '', '锦艺城店', '女', '13333818588', 7);


COMMIT;
