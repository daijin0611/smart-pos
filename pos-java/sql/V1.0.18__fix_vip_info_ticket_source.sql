-- V1.0.18 补充优惠券的 source_code 和 source_type
-- 原因：VipInfoTicketServiceImpl.createVipInfoTicket 中未设置 sourceCode/sourceType，
--       导致充值赠送的优惠券在冲正时无法被查询和回退。
-- 范围：仅处理 remark='充值活动赠送' 且 active_id IS NOT NULL 的优惠券，
--       通过 vip_info_id + active_id + create_time 关联到对应的充值记录。

-- 关联逻辑：
--   vip_info_ticket.active_id → vip_recharge_history.activity_id
--   vip_info_ticket.vip_info_id → vip_recharge_history.vip_id
--   vip_info_ticket.create_time ≈ vip_recharge_history.recharge_time（秒级一致）

UPDATE vip_info_ticket t
INNER JOIN vip_recharge_history h
    ON t.vip_info_id = h.vip_id
    AND t.active_id = h.activity_id
    AND t.create_time = h.recharge_time
SET t.source_code = h.history_code,
    t.source_type = 1
WHERE t.source_code IS NULL
  AND t.is_delete = 0
  AND t.remark = '充值活动赠送'
  AND t.active_id IS NOT NULL;
