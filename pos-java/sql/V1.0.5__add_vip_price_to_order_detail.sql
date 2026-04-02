ALTER TABLE order_detail ADD COLUMN vip_price DECIMAL(10,2) DEFAULT 0.00 NULL COMMENT 'VIP价格' AFTER true_price;

-- test ok
-- 生产环境已更新：2026/4/2