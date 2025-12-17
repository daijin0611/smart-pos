-- Add vip_card_number field to vip_asset table
-- This field stores the VIP card number from vip_info.card_number

ALTER TABLE vip_asset
    ADD COLUMN card_type_id VARCHAR(50) NULL COMMENT '兼容美管家会员卡类型分类ID';

-- Create index for performance if needed
CREATE INDEX idx_vip_asset_card_type_id ON vip_asset(card_type_id);
