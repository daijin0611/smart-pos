ALTER TABLE order_detail ADD COLUMN vip_price DECIMAL(10,2) DEFAULT 0.00 NULL COMMENT 'VIP价格' AFTER true_price;

-- test ok