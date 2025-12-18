-- Add asset_name field to vip_asset table
-- This field stores the name of the VIP asset

ALTER TABLE vip_asset
    ADD COLUMN asset_name VARCHAR(100) NULL COMMENT '资产名称';

-- Create index for performance if needed
CREATE INDEX idx_vip_asset_name ON vip_asset(asset_name);