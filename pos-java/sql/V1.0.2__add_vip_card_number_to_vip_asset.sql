-- Add vip_card_number field to vip_asset table
-- This field stores the VIP card number from vip_info.card_number

ALTER TABLE vip_asset
ADD COLUMN vip_card_number VARCHAR(50) NULL COMMENT '会员卡号';

-- Create index for performance if needed
CREATE INDEX idx_vip_asset_vip_card_number ON vip_asset(vip_card_number);