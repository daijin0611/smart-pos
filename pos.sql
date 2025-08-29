/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云服务器
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 39.107.119.113:3366
 Source Schema         : pos

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 29/08/2025 16:26:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for kpi_detail
-- ----------------------------
DROP TABLE IF EXISTS `kpi_detail`;
CREATE TABLE `kpi_detail`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `service_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务编号',
  `service_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务名称',
  `service_type` tinyint NULL DEFAULT NULL COMMENT '业务类型',
  `item_type` tinyint NULL DEFAULT NULL COMMENT '上钟类型',
  `user_id` bigint NULL DEFAULT NULL COMMENT '技师id',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '提成技师',
  `performance` decimal(10, 2) NULL DEFAULT NULL COMMENT '业绩金额',
  `commission` decimal(10, 2) NULL DEFAULT NULL COMMENT '提成金额',
  `org_id` bigint NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '业绩明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of kpi_detail
-- ----------------------------
INSERT INTO `kpi_detail` VALUES (1, '2025-08-25 23:58:11', '2025-08-25 23:58:11', 0, NULL, 'H17561374909895727', '充值', 3, 3, 4, '杨杰宏', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (2, '2025-08-26 00:10:01', '2025-08-26 00:10:01', 0, NULL, 'H17561380555682946', '充值', 3, 3, 4, '杨杰宏', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (3, '2025-08-26 00:12:52', '2025-08-26 00:12:52', 0, NULL, 'H17561383334800658', '充值', 3, 3, 4, '杨杰宏', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (4, '2025-08-26 14:30:52', '2025-08-26 14:30:52', 0, NULL, 'H17561898522238524', '充值', 3, 3, 6, '张秀英', 1000.00, 30.00, 1);
INSERT INTO `kpi_detail` VALUES (5, '2025-08-26 14:47:56', '2025-08-26 14:47:56', 0, NULL, 'H17561908755124136', '充值', 3, 3, 6, '张秀英', 1000.00, 30.00, 1);
INSERT INTO `kpi_detail` VALUES (6, '2025-08-26 15:41:28', '2025-08-26 15:41:28', 0, NULL, 'H17561940881394219', '充值', 3, 3, 6, '张秀英', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (7, '2025-08-26 15:41:28', '2025-08-26 15:41:28', 0, NULL, 'H17561940881394219', '充值', 3, 3, 11, '朱晓明', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (8, '2025-08-26 16:01:41', '2025-08-26 16:01:41', 0, NULL, 'H17561953009314387', '充值', 3, 3, 6, '张秀英', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (9, '2025-08-26 16:01:41', '2025-08-26 16:01:41', 0, NULL, 'H17561953009314387', '充值', 3, 3, 11, '朱晓明', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (10, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, NULL, 'H17562004049215416', '充值', 3, 3, 6, '张秀英', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (11, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, NULL, 'H17562004049215416', '充值', 3, 3, 11, '朱晓明', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (12, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, NULL, 'H17562016786556535', '充值', 3, 3, 6, '张秀英', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (13, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, NULL, 'H17562016786556535', '充值', 3, 3, 11, '朱晓明', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (14, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, NULL, 'H17562020537136683', '充值', 3, 3, 6, '张秀英', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (15, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, NULL, 'H17562020537136683', '充值', 3, 3, 11, '朱晓明', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (16, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, NULL, 'H17564375885058808', '充值', 3, 3, 6, '张秀英', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (17, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, NULL, 'H17564375885058808', '充值', 3, 3, 11, '朱晓明', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (18, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, NULL, 'H17564376618793709', '充值', 3, 3, 6, '张秀英', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (19, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, NULL, 'H17564376618793709', '充值', 3, 3, 11, '朱晓明', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (20, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, NULL, 'H17564503346202507', '充值', 3, 3, 6, '张秀英', 500.00, 15.00, 1);
INSERT INTO `kpi_detail` VALUES (21, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, NULL, 'H17564503346202507', '充值', 3, 3, 11, '朱晓明', 500.00, 15.00, 1);

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '员工id',
  `detail_type` tinyint NULL DEFAULT NULL COMMENT '业务类型（0 产品，1 服务，2 套餐）',
  `server_id` bigint NULL DEFAULT NULL COMMENT '订单业务id',
  `std_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '标准价',
  `true_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '实际单价',
  `quantity` int NULL DEFAULT NULL COMMENT '销售数量',
  `server_type` tinyint NULL DEFAULT NULL COMMENT '上钟类型（0 点钟，1 加钟，2 轮牌）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '销售单号',
  `order_time` datetime NOT NULL COMMENT '开单时间',
  `order_status` tinyint NULL DEFAULT NULL COMMENT '订单状态',
  `vip_id` bigint NULL DEFAULT NULL COMMENT '会员id',
  `vip_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '顾客名称',
  `vip_card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员卡号',
  `vip_phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员电话号',
  `vip_balance` decimal(10, 2) NULL DEFAULT NULL COMMENT '会员余额',
  `settle_time` datetime NULL DEFAULT NULL COMMENT '结算时间',
  `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '应收金额',
  `actual_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '实收金额',
  `discount_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠金额',
  `bed_id` bigint NULL DEFAULT NULL COMMENT '床位id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '收银人id',
  `customer_type` tinyint NULL DEFAULT NULL COMMENT '顾客类型（0 会员，1 散客）',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收银人名称',
  `bed_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '床位名称',
  `org_id` bigint NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_info
-- ----------------------------

-- ----------------------------
-- Table structure for order_sales_summary
-- ----------------------------
DROP TABLE IF EXISTS `order_sales_summary`;
CREATE TABLE `order_sales_summary`  (
  `date` date NULL DEFAULT NULL COMMENT '销售日期',
  `total_turnover` decimal(18, 2) NULL DEFAULT NULL COMMENT '总营业额',
  `total_actual_receipt` decimal(18, 2) NULL DEFAULT NULL COMMENT '总实收金额',
  `total_single_time` int NULL DEFAULT NULL COMMENT '总单次数量',
  `total_people_time` int NULL DEFAULT NULL COMMENT '总人次',
  `total_project_count` int NULL DEFAULT NULL COMMENT '总项目数',
  `alipay_payment` decimal(18, 2) NULL DEFAULT NULL COMMENT '支付宝支付金额',
  `bank_card_payment` decimal(18, 2) NULL DEFAULT NULL COMMENT '银行卡支付金额',
  `cash_payment` decimal(18, 2) NULL DEFAULT NULL COMMENT '现金支付金额',
  `electronic_coupon_payment` decimal(18, 2) NULL DEFAULT NULL COMMENT '电子优惠券支付金额',
  `membership_card_payment` decimal(18, 2) NULL DEFAULT NULL COMMENT '会员卡支付金额',
  `wechat_payment` decimal(18, 2) NULL DEFAULT NULL COMMENT '微信支付金额',
  `cash_recharge` decimal(18, 2) NULL DEFAULT NULL COMMENT '现金充值金额',
  `wechat_recharge` decimal(18, 2) NULL DEFAULT NULL COMMENT '微信充值金额'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '销售数据汇总表，整合销售、支付、充值相关数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_sales_summary
-- ----------------------------

-- ----------------------------
-- Table structure for payment_detail
-- ----------------------------
DROP TABLE IF EXISTS `payment_detail`;
CREATE TABLE `payment_detail`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `active_type` tinyint NULL DEFAULT NULL COMMENT '业务类型',
  `active_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务编号',
  `active_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '业务名称',
  `payment_type` tinyint NULL DEFAULT NULL COMMENT '支付方式',
  `payment_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '支付方式名称',
  `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '支付金额',
  `payment_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '结算状态',
  `org_id` bigint NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '支付明细表，记录各种业务的支付详情。' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of payment_detail
-- ----------------------------
INSERT INTO `payment_detail` VALUES (1, '2025-08-25 23:58:11', '2025-08-26 14:38:38', 0, NULL, 3, 'H17561374909895727', '充值', 0, '微信支付', 500.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (2, '2025-08-26 00:10:01', '2025-08-26 14:38:38', 0, NULL, 3, 'H17561380555682946', '充值', 0, '微信支付', 500.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (3, '2025-08-26 00:12:52', '2025-08-26 14:38:38', 0, NULL, 3, 'H17561383334800658', '充值', 0, '微信支付', 500.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (4, '2025-08-26 14:30:52', '2025-08-26 14:38:38', 0, NULL, 3, 'H17561898522238524', '充值', 0, '微信支付', 1000.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (5, '2025-08-26 14:47:56', '2025-08-26 14:47:56', 0, NULL, 3, 'H17561908755124136', '充值', 0, NULL, 1000.00, '已结算', NULL);
INSERT INTO `payment_detail` VALUES (6, '2025-08-26 15:41:28', '2025-08-26 15:41:28', 0, NULL, 3, 'H17561940881394219', '充值', 0, '微信支付', 1000.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (7, '2025-08-26 16:01:41', '2025-08-26 16:01:41', 0, NULL, 3, 'H17561953009314387', '充值', 0, '微信支付', 1000.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (8, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, NULL, 3, 'H17562004049215416', '充值', 0, '微信支付', 1000.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (9, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, NULL, 3, 'H17562016786556535', '充值', 0, '微信支付', 500.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (10, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, NULL, 3, 'H17562016786556535', '充值', 1, '支付宝支付', 500.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (11, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, NULL, 3, 'H17562020537136683', '充值', 0, '微信支付', 1000.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (12, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, NULL, 3, 'H17564375885058808', '充值', 0, '微信支付', 1000.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (13, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, NULL, 3, 'H17564376618793709', '充值', 0, '微信支付', 1000.00, '已结算', 1);
INSERT INTO `payment_detail` VALUES (14, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, NULL, 3, 'H17564503346202507', '充值', 0, '微信支付', 1000.00, '已结算', 1);

-- ----------------------------
-- Table structure for room_bed
-- ----------------------------
DROP TABLE IF EXISTS `room_bed`;
CREATE TABLE `room_bed`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `bed_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '床位名称',
  `room_info_id` bigint NULL DEFAULT NULL COMMENT '房间id',
  `status` tinyint NULL DEFAULT 0 COMMENT '床位状态（0 空闲中，1 服务中， 2 暂停使用）',
  `org_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '床位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of room_bed
-- ----------------------------
INSERT INTO `room_bed` VALUES (39, '2025-07-17 19:57:52', '2025-07-23 21:23:31', 0, NULL, '一楼-床位1', 91, 1, 1);
INSERT INTO `room_bed` VALUES (40, '2025-07-17 19:57:57', '2025-07-26 00:39:35', 0, NULL, '一楼-床位2', 91, 0, 1);
INSERT INTO `room_bed` VALUES (41, '2025-07-17 19:58:01', '2025-07-23 21:23:24', 0, NULL, '一楼-床位3', 91, 0, 1);
INSERT INTO `room_bed` VALUES (42, '2025-07-17 19:58:14', '2025-07-23 20:01:20', 0, NULL, '二楼-床位1', 92, 0, 1);
INSERT INTO `room_bed` VALUES (43, '2025-07-17 19:58:18', '2025-07-23 20:01:24', 0, NULL, '二楼-床位2', 92, 0, 1);
INSERT INTO `room_bed` VALUES (44, '2025-07-17 19:58:20', '2025-07-23 20:01:28', 0, NULL, '二楼-床位3', 92, 0, 1);
INSERT INTO `room_bed` VALUES (45, '2025-07-17 19:58:57', '2025-07-23 20:01:54', 0, NULL, '三楼-床位1', 93, 0, 1);
INSERT INTO `room_bed` VALUES (46, '2025-07-17 19:59:00', '2025-07-23 20:01:58', 0, NULL, '三楼-床位2', 93, 0, 1);
INSERT INTO `room_bed` VALUES (47, '2025-07-17 19:59:03', '2025-07-23 20:02:03', 0, NULL, '三楼-床位3', 93, 1, 1);
INSERT INTO `room_bed` VALUES (48, '2025-07-19 21:54:19', '2025-07-23 20:02:36', 0, NULL, '一楼-床位4', 91, 1, 1);
INSERT INTO `room_bed` VALUES (49, '2025-07-22 14:11:53', '2025-07-22 14:12:37', 0, NULL, 'VIP包间A', 94, 0, 2);
INSERT INTO `room_bed` VALUES (50, '2025-07-22 14:12:00', '2025-07-22 14:12:37', 0, NULL, 'VIP包间B', 94, 0, 2);
INSERT INTO `room_bed` VALUES (51, '2025-07-22 14:12:10', '2025-07-22 16:01:51', 0, NULL, 'VIP包间c', 94, 2, 2);
INSERT INTO `room_bed` VALUES (52, '2025-07-23 19:33:23', '2025-07-23 19:49:13', 0, NULL, '卡座1', 95, 0, 1);
INSERT INTO `room_bed` VALUES (53, '2025-07-23 19:34:54', '2025-07-23 19:34:54', 0, NULL, '卡座2', 95, 0, 1);
INSERT INTO `room_bed` VALUES (54, '2025-07-23 19:35:29', '2025-07-23 19:35:29', 0, NULL, '卡座3', 95, 0, 1);
INSERT INTO `room_bed` VALUES (55, '2025-07-23 20:00:45', '2025-07-23 20:02:40', 0, NULL, '一楼-床位5', 91, 0, 1);
INSERT INTO `room_bed` VALUES (56, '2025-07-23 21:23:53', '2025-07-23 21:23:53', 0, NULL, '卡座4', 95, 0, 1);
INSERT INTO `room_bed` VALUES (57, '2025-07-26 00:39:51', '2025-07-26 00:39:51', 0, NULL, '一楼-床位6', 91, 0, 1);

-- ----------------------------
-- Table structure for room_info
-- ----------------------------
DROP TABLE IF EXISTS `room_info`;
CREATE TABLE `room_info`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `room_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间名',
  `org_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 96 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '房间表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of room_info
-- ----------------------------
INSERT INTO `room_info` VALUES (91, '2025-07-17 19:57:24', '2025-07-23 19:21:41', 0, NULL, '一楼', 1);
INSERT INTO `room_info` VALUES (92, '2025-07-17 19:57:32', '2025-07-26 00:40:06', 0, NULL, '二楼', 1);
INSERT INTO `room_info` VALUES (93, '2025-07-17 19:57:40', '2025-07-23 20:01:45', 0, NULL, '三楼', 1);
INSERT INTO `room_info` VALUES (94, '2025-07-21 17:43:53', '2025-07-22 14:07:18', 0, '豪华VIP包间，配备独立卫生间', 'VIP包间B', 2);
INSERT INTO `room_info` VALUES (95, '2025-07-23 19:28:03', '2025-07-23 21:23:45', 0, NULL, '大厅', 1);

-- ----------------------------
-- Table structure for server_cure_ticket
-- ----------------------------
DROP TABLE IF EXISTS `server_cure_ticket`;
CREATE TABLE `server_cure_ticket`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注（其它描述）',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '疗程卷名称',
  `encode` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '疗程编码',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '疗程价格',
  `type` tinyint NULL DEFAULT NULL COMMENT '提成类型（0 固定金额，1 比例提成）',
  `commission_value` decimal(5, 2) NULL DEFAULT NULL COMMENT '提成值（固定/比例）',
  `commission_base` tinyint NULL DEFAULT NULL COMMENT '提成基准（0 标准价，1 实收价）',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态（0 启用，1 禁用）',
  `org_id` bigint NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '疗程券表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of server_cure_ticket
-- ----------------------------
INSERT INTO `server_cure_ticket` VALUES (1, '2025-08-20 17:11:35', '2025-08-20 21:59:57', 0, '', '500元10次', '39', 500.00, 0, 0.00, NULL, 1, 1);
INSERT INTO `server_cure_ticket` VALUES (3, '2025-08-20 21:34:58', '2025-08-20 21:34:58', 0, '', '1999元疗程', '39', 1999.00, 1, NULL, 3, 0, 1);

-- ----------------------------
-- Table structure for server_cure_ticket_detail
-- ----------------------------
DROP TABLE IF EXISTS `server_cure_ticket_detail`;
CREATE TABLE `server_cure_ticket_detail`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注（其它描述）',
  `cure_ticket_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '疗程券id',
  `vip_ticket_id` bigint NULL DEFAULT NULL COMMENT '优惠券id',
  `vip_ticket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '优惠券名称',
  `vip_ticket_num` int NULL DEFAULT NULL COMMENT '优惠券数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '疗程券内容表（关联server_cure_ticket, vip_ticket）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of server_cure_ticket_detail
-- ----------------------------
INSERT INTO `server_cure_ticket_detail` VALUES (1, NULL, 8, 3, NULL, 0);
INSERT INTO `server_cure_ticket_detail` VALUES (2, NULL, 7, 0, NULL, NULL);
INSERT INTO `server_cure_ticket_detail` VALUES (3, NULL, 10, 0, NULL, 0);
INSERT INTO `server_cure_ticket_detail` VALUES (4, NULL, 10, 0, NULL, 0);
INSERT INTO `server_cure_ticket_detail` VALUES (5, NULL, 1, 2, '99元项目任选', 10);
INSERT INTO `server_cure_ticket_detail` VALUES (6, NULL, 3, 3, '199元项目任选', 10);
INSERT INTO `server_cure_ticket_detail` VALUES (7, NULL, 3, 2, '99元项目任选', 10);

-- ----------------------------
-- Table structure for server_item
-- ----------------------------
DROP TABLE IF EXISTS `server_item`;
CREATE TABLE `server_item`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注(其他描述)',
  `item_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目名称',
  `item_encode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务项目编码',
  `server_time` int NOT NULL COMMENT '服务时长',
  `item_price` decimal(10, 2) NOT NULL COMMENT '标准价',
  `vip_item_price` decimal(10, 2) NOT NULL COMMENT '会员价',
  `is_discounts` tinyint NOT NULL DEFAULT 0 COMMENT '是否参与打折（0 允许，1 禁止）',
  `commission_type` tinyint NOT NULL DEFAULT 0 COMMENT '提成类型（0 固定金额，1 比例提成）',
  `commission_value_rotation` decimal(5, 2) UNSIGNED ZEROFILL NOT NULL COMMENT '提成值（固定/比例）（轮牌）',
  `commission_value_appointment` decimal(5, 2) UNSIGNED ZEROFILL NOT NULL COMMENT '提成值（固定/比例）（点钟）',
  `commission_value_extend` decimal(5, 2) UNSIGNED ZEROFILL NOT NULL COMMENT '提成值（固定/比例）（加钟）',
  `commission_base` tinyint NOT NULL DEFAULT 0 COMMENT '提成基准（0 标准价，1 实收价）',
  `item_status` tinyint NOT NULL DEFAULT 0 COMMENT '项目状态（0 启用， 1 禁用）',
  `org_id` bigint NOT NULL DEFAULT 1 COMMENT '机构id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '服务项目' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of server_item
-- ----------------------------
INSERT INTO `server_item` VALUES (1, '2025-07-28 18:08:17', '2025-08-01 18:30:48', 0, '这是一个服务项目的备注信息', '足疗按摩', 'SRV001', 60, 100.00, 80.00, 0, 1, 010.00, 015.00, 012.00, 1, 0, 1);
INSERT INTO `server_item` VALUES (2, '2025-08-01 00:47:09', '2025-08-01 18:30:52', 0, '', '采耳', 'SRV002', 60, 100.00, 90.00, 1, 0, 010.00, 010.00, 010.00, 0, 0, 1);

-- ----------------------------
-- Table structure for server_package
-- ----------------------------
DROP TABLE IF EXISTS `server_package`;
CREATE TABLE `server_package`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注（其他描述）',
  `package_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '服务套餐名称\r\n套餐名称',
  `package_encode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '套餐编码',
  `package_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '散客价',
  `package_price_vip` decimal(10, 2) NULL DEFAULT NULL COMMENT '会员价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '服务套餐表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of server_package
-- ----------------------------
INSERT INTO `server_package` VALUES (1, '2025-05-12 22:17:38', '2025-07-16 16:26:21', 0, '', '测试套餐1', '111', 100.00, 80.00);
INSERT INTO `server_package` VALUES (2, '2025-05-13 19:47:26', '2025-07-16 16:26:42', 0, NULL, '测试套餐2', '222', 200.00, 180.00);

-- ----------------------------
-- Table structure for server_package_detail
-- ----------------------------
DROP TABLE IF EXISTS `server_package_detail`;
CREATE TABLE `server_package_detail`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `package_detail_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '服务套餐明细名称',
  `package_tool_number` tinyint NULL DEFAULT NULL COMMENT '套餐明细使用物品数量',
  `package_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '服务套餐明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of server_package_detail
-- ----------------------------
INSERT INTO `server_package_detail` VALUES (23, '2025-07-16 16:26:22', '2025-07-16 16:26:22', 0, NULL, '一次性工具', 5, 1);
INSERT INTO `server_package_detail` VALUES (24, '2025-07-16 16:26:22', '2025-07-16 16:26:22', 0, NULL, '一次性工具1', 1, 1);
INSERT INTO `server_package_detail` VALUES (25, '2025-07-16 16:26:22', '2025-07-16 16:26:22', 0, NULL, '一次性工具2', 3, 1);
INSERT INTO `server_package_detail` VALUES (28, '2025-07-16 16:26:42', '2025-07-16 16:26:42', 0, NULL, '二次性工具', 5, 2);
INSERT INTO `server_package_detail` VALUES (29, '2025-07-16 16:26:42', '2025-07-16 16:26:42', 0, NULL, '一次性工具2', 5, 2);

-- ----------------------------
-- Table structure for server_product
-- ----------------------------
DROP TABLE IF EXISTS `server_product`;
CREATE TABLE `server_product`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注(其他描述)',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `product_encode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品编码',
  `product_price` decimal(10, 2) NOT NULL COMMENT '标准价',
  `vip_product_price` decimal(10, 2) NOT NULL COMMENT '会员价',
  `is_discount` tinyint NOT NULL COMMENT '是否参与打折（0 是，1 否）',
  `commission_type` tinyint NOT NULL COMMENT '提成类型（0 固定提成， 1 比例提成）',
  `commission_value` decimal(5, 2) NOT NULL COMMENT '提成值（固定/比例）根据提成类型而定',
  `commission_base` tinyint NOT NULL DEFAULT 0 COMMENT '提成价格（提成值计算基准 0：标准价 1：实收价）',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '产品状态（0 启用，1 禁用）',
  `unit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '服务产品单位',
  `org_id` bigint NOT NULL DEFAULT 1 COMMENT '机构id',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '库存',
  `version` int NOT NULL DEFAULT 1 COMMENT '乐观锁版本号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '产品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of server_product
-- ----------------------------
INSERT INTO `server_product` VALUES (1, NULL, '2025-07-31 15:33:17', 0, '特殊产品', '基础护理2', 'PROD003', 100.00, 80.00, 1, 0, 30.00, 0, 0, 'piece', 1, 305, 7);
INSERT INTO `server_product` VALUES (2, NULL, '2025-07-31 22:19:30', 0, '', '工具2', '0006', 60.00, 50.00, 1, 0, 30.00, 0, 0, 'piece', 1, 105, 2);
INSERT INTO `server_product` VALUES (3, NULL, '2025-07-31 22:22:18', 0, '', '工具', '0004', 80.00, 70.00, 0, 0, 30.00, 0, 0, 'piece', 1, 115, 3);
INSERT INTO `server_product` VALUES (4, NULL, '2025-08-01 18:31:37', 0, '', '服务产品名称', '0001', 0.00, 0.00, 0, 0, 30.00, 0, 0, 'piece', 1, 150, 2);
INSERT INTO `server_product` VALUES (5, '2025-04-26 00:07:15', '2025-07-31 22:22:57', 0, '', '服务产品名称1', '11111', 90.00, 80.00, 0, 0, 30.00, 0, 0, 'piece', 1, 15, 3);
INSERT INTO `server_product` VALUES (6, '2025-04-26 18:09:40', '2025-07-31 22:23:06', 0, '', '范德萨', '0005', 88.00, 66.00, 0, 0, 30.00, 0, 0, 'box', 1, 0, 7);
INSERT INTO `server_product` VALUES (7, '2025-05-07 14:57:27', '2025-07-31 14:30:31', 0, '消耗品', '二次性手套', '1111', 10.00, 22.00, 1, 0, 30.00, 0, 1, 'piece', 1, 0, 1);
INSERT INTO `server_product` VALUES (8, '2025-05-28 23:38:41', '2025-07-31 15:34:07', 0, '特殊产品', '基础护理22', 'PROD002', 100.00, 800.00, 0, 1, 30.00, 0, 0, 'piece', 1, 0, 4);
INSERT INTO `server_product` VALUES (9, '2025-05-30 22:51:10', '2025-07-31 14:23:54', 0, '特殊产品', '基础护理', 'PROD001', 55.00, 55.00, 0, 1, 30.00, 0, 1, 'piece', 1, 0, 1);
INSERT INTO `server_product` VALUES (10, '2025-05-30 22:54:33', '2025-07-31 14:23:54', 0, '特殊产品', '基础护理', 'D001', 100.00, 80.00, 1, 1, 30.00, 0, 0, 'piece', 1, 15, 6);
INSERT INTO `server_product` VALUES (11, '2025-05-30 22:54:48', '2025-07-31 14:23:54', 0, '特殊产品', '基础护理', 'PROD001', 100.00, 80.00, 1, 1, 30.00, 0, 1, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (12, '2025-05-30 22:57:18', '2025-07-31 14:23:54', 0, '特殊产品', '基础护理', 'PROD001', 100.00, 80.00, 0, 1, 30.00, 0, 1, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (13, '2025-05-30 22:58:50', '2025-07-31 14:23:54', 0, '特殊产品', '基础护理', 'PR001', 100.00, 80.00, 0, 1, 30.00, 0, 1, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (14, '2025-05-30 23:07:00', '2025-07-31 14:23:54', 0, '特殊产品', '基础护理', 'PR001', 100.00, 80.00, 0, 2, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (15, '2025-05-30 23:29:40', '2025-07-31 14:23:54', 0, '', '工具', '8901', 50.00, 30.00, 1, 0, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (16, '2025-05-31 00:05:51', '2025-07-31 14:23:54', 0, '特殊产品', '基础护理', 'PR001', 100.00, 80.00, 0, 1, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (17, '2025-05-31 00:07:11', '2025-07-31 14:23:54', 0, '特殊产品', '基础护理', 'PR001', 100.00, 80.00, 0, 1, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (18, '2025-06-05 02:13:02', '2025-07-31 14:23:54', 0, NULL, '你好', 'C001', 9.00, 4.00, 0, 1, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (19, '2025-06-05 21:54:50', '2025-07-31 14:23:54', 0, NULL, '你好', 'C002', 7.00, 557.00, 0, 1, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (20, '2025-06-05 22:36:26', '2025-07-31 14:23:54', 0, NULL, '发', 'C009', 4.00, 4.00, 1, 1, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (21, '2025-06-05 23:21:15', '2025-07-31 14:23:54', 0, '', '表单', 'C003', 8.00, 0.00, 1, 1, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (22, '2025-06-07 15:53:03', '2025-07-31 14:23:54', 0, '', '你好', 'C0002', 9.00, 9.00, 0, 1, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (23, '2025-06-13 00:38:38', '2025-07-31 14:23:54', 0, '', '辅导啊', 'MU003', 9.00, 988.00, 0, 1, 30.00, 0, 1, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (24, '2025-07-14 15:09:16', '2025-07-31 14:23:55', 0, '000', '京东', 'C002', 7.00, 8.00, 1, 1, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (25, '2025-07-22 18:04:36', '2025-07-31 14:23:55', 0, '特殊产品', '基础护理', 'PROD001', 100.00, 90.00, 0, 1, 30.00, 0, 0, 'piece', 2, 0, 1);
INSERT INTO `server_product` VALUES (26, '2025-08-01 09:33:03', '2025-08-01 15:33:27', 0, '特殊产品', '玫瑰精油', 'PROD005', 100.00, 80.00, 0, 1, 0.15, 0, 0, 'piece', 1, 5, 2);

-- ----------------------------
-- Table structure for server_recharge_role
-- ----------------------------
DROP TABLE IF EXISTS `server_recharge_role`;
CREATE TABLE `server_recharge_role`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注（其他描述）',
  `recharge_role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '充值提成规则名称',
  `recharge_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '充值金额',
  `commission_type` tinyint NULL DEFAULT NULL COMMENT '提成类型',
  `recharge_commission_value` decimal(5, 2) NULL DEFAULT NULL COMMENT '提成值（比例）',
  `status` tinyint NULL DEFAULT NULL,
  `org_id` bigint NOT NULL COMMENT '机构id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '充值提成规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of server_recharge_role
-- ----------------------------
INSERT INTO `server_recharge_role` VALUES (1, '2025-07-02 19:41:46', '2025-08-25 23:57:49', 0, '', '默认充值提成规则（统一提成3%）', 1.00, 1, 3.00, 0, 1);
INSERT INTO `server_recharge_role` VALUES (2, '2025-07-03 19:42:10', '2025-08-02 12:30:19', 0, '', '固定金额提成', 300.00, 1, 30.00, 0, 1);
INSERT INTO `server_recharge_role` VALUES (3, '2025-07-16 19:43:10', '2025-08-02 12:30:19', 0, '', '销售提成', 100.00, 1, 10.00, 0, 1);
INSERT INTO `server_recharge_role` VALUES (4, '2025-07-16 19:43:28', '2025-08-02 12:30:19', 0, '', '销售比例提成', 1.00, 0, 10.00, 0, 1);
INSERT INTO `server_recharge_role` VALUES (5, '2025-08-02 14:13:17', '2025-08-02 14:16:43', 0, 'elit deserunt dolore voluptate', 'test100', 740.00, 0, 10.00, 1, 1);

-- ----------------------------
-- Table structure for stock_in_item
-- ----------------------------
DROP TABLE IF EXISTS `stock_in_item`;
CREATE TABLE `stock_in_item`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注(其他描述)',
  `product_id` bigint NOT NULL COMMENT '商品id',
  `product_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品编码（冗余字段方便展示）',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名称（冗余字段方便展示）',
  `unit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '单位',
  `quantity` int NOT NULL COMMENT '入库数量',
  `price` decimal(10, 2) NOT NULL COMMENT '入库单价',
  `in_order_id` bigint NOT NULL COMMENT '入库单id',
  `in_order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '入库单号',
  `org_id` bigint NOT NULL COMMENT '机构id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '入库明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_in_item
-- ----------------------------
INSERT INTO `stock_in_item` VALUES (1, '2025-07-23 23:53:49', '2025-07-24 14:26:24', 0, '', 14, 'PR001', '基础护理', '个', 5, 50.00, 1, 'SIO17532860055751401', 1);
INSERT INTO `stock_in_item` VALUES (2, '2025-07-23 23:53:49', '2025-07-24 14:26:24', 0, '', 15, '8901', '工具', '个', 5, 10.00, 1, 'SIO17532860055751401', 1);
INSERT INTO `stock_in_item` VALUES (3, '2025-07-24 00:06:33', '2025-07-24 14:26:24', 0, '', 14, 'PR001', '基础护理', '个', 5, 50.00, 2, 'SIO17532867928066430', 1);
INSERT INTO `stock_in_item` VALUES (4, '2025-07-24 00:06:33', '2025-07-24 14:26:24', 0, '', 15, '8901', '工具', '个', 5, 10.00, 2, 'SIO17532867928066430', 1);
INSERT INTO `stock_in_item` VALUES (5, '2025-07-24 00:17:53', '2025-07-24 14:26:24', 0, '', 14, 'PR001', '基础护理', '个', 5, 50.00, 3, 'SIO17532874727820134', 1);
INSERT INTO `stock_in_item` VALUES (6, '2025-07-24 00:17:53', '2025-07-24 14:26:24', 0, '', 15, '8901', '工具', '个', 5, 10.00, 3, 'SIO17532874727820134', 1);
INSERT INTO `stock_in_item` VALUES (8, '2025-07-25 16:24:55', '2025-07-25 16:24:55', 0, '正常入库', 16, 'PROD001', '商品A', '个', 100, 10.00, 5, 'SIO17534318949691073', 1);
INSERT INTO `stock_in_item` VALUES (9, '2025-07-27 20:40:44', '2025-07-27 20:40:44', 0, '正常入库', 1, 'PROD001', '商品A', '个', 100, 10.00, 8, 'SIO17536200437550430', 1);
INSERT INTO `stock_in_item` VALUES (10, '2025-07-27 20:40:44', '2025-07-27 20:40:44', 0, '正常入库', 1, 'PROD001', '商品A', '个', 100, 10.00, 8, 'SIO17536200437550430', 1);
INSERT INTO `stock_in_item` VALUES (11, '2025-07-27 21:25:29', '2025-07-27 21:25:29', 0, '正常入库', 2, '0001', '工具', 'piece', 100, 10.00, 12, 'SIO17536227284429937', 1);
INSERT INTO `stock_in_item` VALUES (12, '2025-07-27 21:25:29', '2025-07-27 21:25:29', 0, '正常入库', 3, '0001', '工具', 'piece', 100, 10.00, 12, 'SIO17536227284429937', 1);
INSERT INTO `stock_in_item` VALUES (13, '2025-07-27 21:25:29', '2025-07-27 21:25:29', 0, '正常入库', 4, '0002', '服务产品名称', 'piece', 100, 10.00, 12, 'SIO17536227284429937', 1);
INSERT INTO `stock_in_item` VALUES (14, '2025-07-28 10:23:11', '2025-07-28 10:23:11', 0, '正常入库', 1, 'PROD001', '基础护理2', 'piece', 100, 10.00, 15, 'SIO17536693910141286', 1);
INSERT INTO `stock_in_item` VALUES (15, '2025-07-28 10:23:11', '2025-07-28 10:23:11', 0, '正常入库', 2, '0001', '工具', 'piece', 100, 10.00, 15, 'SIO17536693910141286', 1);
INSERT INTO `stock_in_item` VALUES (16, '2025-07-29 16:07:32', '2025-07-29 16:07:32', 0, '正常入库', 4, '0002', '服务产品名称', 'piece', 100, 10.00, 19, 'SIO17537764516653818', 1);
INSERT INTO `stock_in_item` VALUES (17, '2025-07-31 22:08:26', '2025-07-31 22:08:26', 0, '', 1, 'PROD003', '基础护理2', 'piece', 300, 100.00, 21, 'SIO17539709054948016', 1);
INSERT INTO `stock_in_item` VALUES (18, '2025-07-31 22:16:42', '2025-07-31 22:16:42', 0, '', 1, 'PROD003', '基础护理2', 'piece', 1, 100.00, 22, 'SIO17539714016447149', 1);
INSERT INTO `stock_in_item` VALUES (19, '2025-07-31 22:17:26', '2025-07-31 22:17:26', 0, '', 1, 'PROD003', '基础护理2', 'piece', 1, 100.00, 23, 'SIO17539714454610702', 1);
INSERT INTO `stock_in_item` VALUES (20, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 3, '0004', '工具', 'piece', 10, 80.00, 24, 'SIO17539737884882457', 1);
INSERT INTO `stock_in_item` VALUES (21, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 5, '11111', '服务产品名称1', 'piece', 10, 90.00, 24, 'SIO17539737884882457', 1);
INSERT INTO `stock_in_item` VALUES (22, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 8, 'PROD002', '基础护理22', 'piece', 10, 100.00, 24, 'SIO17539737884882457', 1);
INSERT INTO `stock_in_item` VALUES (23, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 6, '0005', '范德萨', 'box', 10, 88.00, 24, 'SIO17539737884882457', 1);
INSERT INTO `stock_in_item` VALUES (24, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 10, 'D001', '基础护理', 'piece', 10, 100.00, 24, 'SIO17539737884882457', 1);
INSERT INTO `stock_in_item` VALUES (25, '2025-07-31 23:03:14', '2025-07-31 23:03:14', 0, '', 1, 'PROD003', '基础护理2', 'piece', 5, 100.00, 25, 'SIO17539741941372545', 1);
INSERT INTO `stock_in_item` VALUES (26, '2025-07-31 23:03:21', '2025-07-31 23:03:21', 0, '', 2, '0006', '工具2', 'piece', 5, 60.00, 26, 'SIO17539742006186105', 1);
INSERT INTO `stock_in_item` VALUES (27, '2025-07-31 23:03:26', '2025-07-31 23:03:26', 0, '', 3, '0004', '工具', 'piece', 5, 80.00, 27, 'SIO17539742057363780', 1);
INSERT INTO `stock_in_item` VALUES (28, '2025-07-31 23:03:29', '2025-07-31 23:03:29', 0, '', 6, '0005', '范德萨', 'box', 5, 88.00, 28, 'SIO17539742088240943', 1);
INSERT INTO `stock_in_item` VALUES (29, '2025-07-31 23:03:33', '2025-07-31 23:03:33', 0, '', 5, '11111', '服务产品名称1', 'piece', 5, 90.00, 29, 'SIO17539742126835321', 1);
INSERT INTO `stock_in_item` VALUES (30, '2025-07-31 23:03:40', '2025-07-31 23:03:40', 0, '', 10, 'D001', '基础护理', 'piece', 5, 100.00, 30, 'SIO17539742197366595', 1);
INSERT INTO `stock_in_item` VALUES (31, '2025-08-01 00:09:10', '2025-08-01 00:09:10', 0, '', 10, 'D001', '基础护理', 'piece', 2, 100.00, 31, 'SIO17539781496663606', 1);
INSERT INTO `stock_in_item` VALUES (32, '2025-08-02 13:03:26', '2025-08-02 13:03:26', 0, '', 26, 'PROD005', '玫瑰精油', 'piece', 5, 100.00, 32, 'SIO17541110056909655', 1);
INSERT INTO `stock_in_item` VALUES (33, '2025-08-02 13:03:35', '2025-08-02 13:03:35', 0, '', 6, '0005', '范德萨', 'box', 5, 88.00, 33, 'SIO17541110149043789', 1);

-- ----------------------------
-- Table structure for stock_in_order
-- ----------------------------
DROP TABLE IF EXISTS `stock_in_order`;
CREATE TABLE `stock_in_order`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注(其他描述)',
  `total_price` decimal(10, 2) NOT NULL COMMENT '总金额',
  `operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作人',
  `order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '入库单编号',
  `org_id` bigint NOT NULL DEFAULT 1 COMMENT '机构id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '库存入库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_in_order
-- ----------------------------
INSERT INTO `stock_in_order` VALUES (1, '2025-07-23 23:53:33', '2025-07-23 23:53:33', 0, '测试订单', 300.00, '马晓明', 'SIO17532860055751401', 1);
INSERT INTO `stock_in_order` VALUES (2, '2025-07-24 00:06:33', '2025-07-24 00:06:33', 0, '测试订单', 300.00, '马晓明', 'SIO17532867928066430', 1);
INSERT INTO `stock_in_order` VALUES (3, '2025-07-24 00:17:53', '2025-07-24 00:17:53', 0, '测试订单', 300.00, '马晓明', 'SIO17532874727820134', 1);
INSERT INTO `stock_in_order` VALUES (5, '2025-07-25 16:24:55', '2025-07-25 16:24:55', 0, '采购入库', 1000.00, 'admin', 'SIO17534318949691073', 1);
INSERT INTO `stock_in_order` VALUES (8, '2025-07-27 20:40:44', '2025-07-27 20:40:44', 0, '采购入库', 1000.00, 'admin', 'SIO17536200437550430', 1);
INSERT INTO `stock_in_order` VALUES (12, '2025-07-27 21:25:28', '2025-07-27 21:25:28', 0, '采购入库', 3000.00, 'admin', 'SIO17536227284429937', 1);
INSERT INTO `stock_in_order` VALUES (15, '2025-07-28 10:23:11', '2025-07-28 10:23:11', 0, '采购入库', 3000.00, 'admin', 'SIO17536693910141286', 1);
INSERT INTO `stock_in_order` VALUES (19, '2025-07-29 16:07:32', '2025-07-29 16:07:32', 0, '采购入库', 1000.00, 'admin', 'SIO17537764516653818', 1);
INSERT INTO `stock_in_order` VALUES (21, '2025-07-31 22:08:25', '2025-07-31 22:08:25', 0, '', 30000.00, '朱晓明', 'SIO17539709054948016', 1);
INSERT INTO `stock_in_order` VALUES (22, '2025-07-31 22:16:42', '2025-07-31 22:16:42', 0, '', 100.00, '朱晓明', 'SIO17539714016447149', 1);
INSERT INTO `stock_in_order` VALUES (23, '2025-07-31 22:17:25', '2025-07-31 22:17:25', 0, '', 100.00, '朱晓明', 'SIO17539714454610702', 1);
INSERT INTO `stock_in_order` VALUES (24, '2025-07-31 22:56:28', '2025-07-31 22:56:28', 0, '', 4580.00, '朱晓明', 'SIO17539737884882457', 1);
INSERT INTO `stock_in_order` VALUES (25, '2025-07-31 23:03:14', '2025-07-31 23:03:14', 0, '', 500.00, '朱晓明', 'SIO17539741941372545', 1);
INSERT INTO `stock_in_order` VALUES (26, '2025-07-31 23:03:21', '2025-07-31 23:03:21', 0, '', 300.00, '朱晓明', 'SIO17539742006186105', 1);
INSERT INTO `stock_in_order` VALUES (27, '2025-07-31 23:03:26', '2025-07-31 23:03:26', 0, '', 400.00, '朱晓明', 'SIO17539742057363780', 1);
INSERT INTO `stock_in_order` VALUES (28, '2025-07-31 23:03:29', '2025-07-31 23:03:29', 0, '', 440.00, '朱晓明', 'SIO17539742088240943', 1);
INSERT INTO `stock_in_order` VALUES (29, '2025-07-31 23:03:33', '2025-07-31 23:03:33', 0, '', 450.00, '朱晓明', 'SIO17539742126835321', 1);
INSERT INTO `stock_in_order` VALUES (30, '2025-07-31 23:03:40', '2025-07-31 23:03:40', 0, '', 500.00, '朱晓明', 'SIO17539742197366595', 1);
INSERT INTO `stock_in_order` VALUES (31, '2025-08-01 00:09:10', '2025-08-01 00:09:10', 0, '', 200.00, '朱晓明', 'SIO17539781496663606', 1);
INSERT INTO `stock_in_order` VALUES (32, '2025-08-02 13:03:26', '2025-08-02 13:03:26', 0, '', 500.00, '朱晓明', 'SIO17541110056909655', 1);
INSERT INTO `stock_in_order` VALUES (33, '2025-08-02 13:03:35', '2025-08-02 13:03:35', 0, '', 440.00, '朱晓明', 'SIO17541110149043789', 1);

-- ----------------------------
-- Table structure for stock_log
-- ----------------------------
DROP TABLE IF EXISTS `stock_log`;
CREATE TABLE `stock_log`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注(其他描述)',
  `order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '单号',
  `order_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '单号类型',
  `product_id` bigint NULL DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品名称',
  `product_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品编码',
  `operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作人',
  `quantity` int NULL DEFAULT NULL COMMENT '数量',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `total_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '总金额',
  `org_id` bigint NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '库存流水表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_log
-- ----------------------------
INSERT INTO `stock_log` VALUES (1, '2025-07-23 23:53:49', '2025-07-23 23:53:49', 0, '', 'SIO17532860055751401', '入库', 14, '基础护理', 'PR001', '马晓明', 5, 50.00, 250.00, 1);
INSERT INTO `stock_log` VALUES (2, '2025-07-23 23:53:49', '2025-07-23 23:53:49', 0, '', 'SIO17532860055751401', '入库', 15, '工具', '8901', '马晓明', 5, 10.00, 50.00, 1);
INSERT INTO `stock_log` VALUES (3, '2025-07-24 00:06:33', '2025-07-24 00:06:33', 0, '', 'SIO17532867928066430', '入库', 14, '基础护理', 'PR001', '马晓明', 5, 50.00, 250.00, 1);
INSERT INTO `stock_log` VALUES (4, '2025-07-24 00:06:33', '2025-07-24 00:06:33', 0, '', 'SIO17532867928066430', '入库', 15, '工具', '8901', '马晓明', 5, 10.00, 50.00, 1);
INSERT INTO `stock_log` VALUES (5, '2025-07-24 00:17:53', '2025-07-24 00:17:53', 0, '', 'SIO17532874727820134', '入库', 14, '基础护理', 'PR001', '马晓明', 5, 50.00, 250.00, 1);
INSERT INTO `stock_log` VALUES (6, '2025-07-24 00:17:53', '2025-07-24 00:17:53', 0, '', 'SIO17532874727820134', '入库', 15, '工具', '8901', '马晓明', 5, 10.00, 50.00, 1);
INSERT INTO `stock_log` VALUES (7, '2025-07-24 16:52:58', '2025-07-24 16:52:58', 0, NULL, '出库17533471780278801', '出库', 14, '基础护理', 'PR001', 'manager', 5, 100.00, 500.00, 1);
INSERT INTO `stock_log` VALUES (8, '2025-07-24 16:52:58', '2025-07-24 16:52:58', 0, NULL, '出库17533471780278801', '出库', 15, '工具', '8901', 'manager', 3, 50.00, 150.00, 1);
INSERT INTO `stock_log` VALUES (9, '2025-07-24 16:56:49', '2025-07-24 16:56:49', 0, NULL, 'SOO17533474086061847', '出库', 14, '基础护理', 'PR001', 'manager', 5, 100.00, 500.00, 1);
INSERT INTO `stock_log` VALUES (10, '2025-07-24 16:56:49', '2025-07-24 16:56:49', 0, NULL, 'SOO17533474086061847', '出库', 15, '工具', '8901', 'manager', 3, 50.00, 150.00, 1);
INSERT INTO `stock_log` VALUES (11, '2025-07-24 16:57:58', '2025-07-24 16:57:58', 0, NULL, 'SOO17533474775587983', '出库', 14, '基础护理', 'PR001', 'manager', 5, 100.00, 500.00, 1);
INSERT INTO `stock_log` VALUES (12, '2025-07-24 16:57:58', '2025-07-24 16:57:58', 0, NULL, 'SOO17533474775587983', '出库', 15, '工具', '8901', 'manager', 3, 50.00, 150.00, 1);
INSERT INTO `stock_log` VALUES (13, '2025-07-25 16:24:55', '2025-07-25 16:24:55', 0, '正常入库', 'SIO17534318949691073', '入库', 16, '商品A', 'PROD001', 'admin', 100, 10.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (14, '2025-07-27 20:40:44', '2025-07-27 20:40:44', 0, '正常入库', 'SIO17536200437550430', '入库', 1, '商品A', 'PROD001', 'admin', 100, 10.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (15, '2025-07-27 20:40:44', '2025-07-27 20:40:44', 0, '正常入库', 'SIO17536200437550430', '入库', 1, '商品A', 'PROD001', 'admin', 100, 10.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (16, '2025-07-27 21:25:29', '2025-07-27 21:25:29', 0, '正常入库', 'SIO17536227284429937', '入库', 2, '工具', '0001', 'admin', 100, 10.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (17, '2025-07-27 21:25:29', '2025-07-27 21:25:29', 0, '正常入库', 'SIO17536227284429937', '入库', 3, '工具', '0001', 'admin', 100, 10.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (18, '2025-07-27 21:25:29', '2025-07-27 21:25:29', 0, '正常入库', 'SIO17536227284429937', '入库', 4, '服务产品名称', '0002', 'admin', 100, 10.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (19, '2025-07-28 10:11:13', '2025-07-28 10:11:13', 0, NULL, 'SOO17536686724838340', '出库', 2, '工具', '0001', 'admin', 50, 20.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (20, '2025-07-28 10:21:48', '2025-07-28 10:21:48', 0, NULL, 'SOO17536693077288183', '出库', 2, '工具', '0001', 'admin', 50, 20.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (21, '2025-07-28 10:21:48', '2025-07-28 10:21:48', 0, NULL, 'SOO17536693077288183', '出库', 4, '服务产品名称', '0002', 'admin', 50, 20.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (22, '2025-07-28 10:23:11', '2025-07-28 10:23:11', 0, '正常入库', 'SIO17536693910141286', '入库', 1, '基础护理2', 'PROD001', 'admin', 100, 10.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (23, '2025-07-28 10:23:11', '2025-07-28 10:23:11', 0, '正常入库', 'SIO17536693910141286', '入库', 2, '工具', '0001', 'admin', 100, 10.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (24, '2025-07-29 16:07:32', '2025-07-29 16:07:32', 0, '正常入库', 'SIO17537764516653818', '入库', 4, '服务产品名称', '0002', 'admin', 100, 10.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (25, '2025-07-31 22:08:26', '2025-07-31 22:08:26', 0, '', 'SIO17539709054948016', '入库', 1, '基础护理2', 'PROD003', '朱晓明', 300, 100.00, 30000.00, 1);
INSERT INTO `stock_log` VALUES (26, '2025-07-31 22:16:42', '2025-07-31 22:16:42', 0, '', 'SIO17539714016447149', '入库', 1, '基础护理2', 'PROD003', '朱晓明', 1, 100.00, 100.00, 1);
INSERT INTO `stock_log` VALUES (27, '2025-07-31 22:17:26', '2025-07-31 22:17:26', 0, '', 'SIO17539714454610702', '入库', 1, '基础护理2', 'PROD003', '朱晓明', 1, 100.00, 100.00, 1);
INSERT INTO `stock_log` VALUES (28, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 'SIO17539737884882457', '入库', 3, '工具', '0004', '朱晓明', 10, 80.00, 800.00, 1);
INSERT INTO `stock_log` VALUES (29, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 'SIO17539737884882457', '入库', 5, '服务产品名称1', '11111', '朱晓明', 10, 90.00, 900.00, 1);
INSERT INTO `stock_log` VALUES (30, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 'SIO17539737884882457', '入库', 8, '基础护理22', 'PROD002', '朱晓明', 10, 100.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (31, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 'SIO17539737884882457', '入库', 6, '范德萨', '0005', '朱晓明', 10, 88.00, 880.00, 1);
INSERT INTO `stock_log` VALUES (32, '2025-07-31 22:56:29', '2025-07-31 22:56:29', 0, '', 'SIO17539737884882457', '入库', 10, '基础护理', 'D001', '朱晓明', 10, 100.00, 1000.00, 1);
INSERT INTO `stock_log` VALUES (33, '2025-07-31 23:02:31', '2025-07-31 23:02:31', 0, NULL, 'SOO17539741512553302', '出库', 1, '基础护理2', 'PROD003', '朱晓明', 300, 100.00, 30000.00, 1);
INSERT INTO `stock_log` VALUES (34, '2025-07-31 23:02:49', '2025-07-31 23:02:49', 0, NULL, 'SOO17539741692783904', '出库', 1, '基础护理2', 'PROD003', '朱晓明', 2, 100.00, 200.00, 1);
INSERT INTO `stock_log` VALUES (35, '2025-07-31 23:03:14', '2025-07-31 23:03:14', 0, '', 'SIO17539741941372545', '入库', 1, '基础护理2', 'PROD003', '朱晓明', 5, 100.00, 500.00, 1);
INSERT INTO `stock_log` VALUES (36, '2025-07-31 23:03:21', '2025-07-31 23:03:21', 0, '', 'SIO17539742006186105', '入库', 2, '工具2', '0006', '朱晓明', 5, 60.00, 300.00, 1);
INSERT INTO `stock_log` VALUES (37, '2025-07-31 23:03:26', '2025-07-31 23:03:26', 0, '', 'SIO17539742057363780', '入库', 3, '工具', '0004', '朱晓明', 5, 80.00, 400.00, 1);
INSERT INTO `stock_log` VALUES (38, '2025-07-31 23:03:29', '2025-07-31 23:03:29', 0, '', 'SIO17539742088240943', '入库', 6, '范德萨', '0005', '朱晓明', 5, 88.00, 440.00, 1);
INSERT INTO `stock_log` VALUES (39, '2025-07-31 23:03:33', '2025-07-31 23:03:33', 0, '', 'SIO17539742126835321', '入库', 5, '服务产品名称1', '11111', '朱晓明', 5, 90.00, 450.00, 1);
INSERT INTO `stock_log` VALUES (40, '2025-07-31 23:03:40', '2025-07-31 23:03:40', 0, '', 'SIO17539742197366595', '入库', 10, '基础护理', 'D001', '朱晓明', 5, 100.00, 500.00, 1);
INSERT INTO `stock_log` VALUES (41, '2025-07-31 23:06:01', '2025-07-31 23:06:01', 0, NULL, 'SOO17539743613161983', '出库', 6, '范德萨', '0005', '朱晓明', 10, 88.00, 880.00, 1);
INSERT INTO `stock_log` VALUES (42, '2025-07-31 23:06:18', '2025-07-31 23:06:18', 0, NULL, 'SOO17539743776424404', '出库', 6, '范德萨', '0005', '朱晓明', 5, 88.00, 440.00, 1);
INSERT INTO `stock_log` VALUES (43, '2025-08-01 00:03:17', '2025-08-01 00:03:17', 0, NULL, 'SOO17539777968609836', '出库', 8, '基础护理22', 'PROD002', '朱晓明', 5, 100.00, 500.00, 1);
INSERT INTO `stock_log` VALUES (44, '2025-08-01 00:03:51', '2025-08-01 00:03:51', 0, NULL, 'SOO17539778305264406', '出库', 10, '基础护理', 'D001', '朱晓明', 1, 100.00, 100.00, 1);
INSERT INTO `stock_log` VALUES (45, '2025-08-01 00:04:18', '2025-08-01 00:04:18', 0, NULL, 'SOO17539778574625334', '出库', 10, '基础护理', 'D001', '朱晓明', 1, 100.00, 100.00, 1);
INSERT INTO `stock_log` VALUES (46, '2025-08-01 00:09:10', '2025-08-01 00:09:10', 0, '', 'SIO17539781496663606', '入库', 10, '基础护理', 'D001', '朱晓明', 2, 100.00, 200.00, 1);
INSERT INTO `stock_log` VALUES (47, '2025-08-02 13:03:26', '2025-08-02 13:03:26', 0, '', 'SIO17541110056909655', '入库', 26, '玫瑰精油', 'PROD005', '朱晓明', 5, 100.00, 500.00, 1);
INSERT INTO `stock_log` VALUES (48, '2025-08-02 13:03:35', '2025-08-02 13:03:35', 0, '', 'SIO17541110149043789', '入库', 6, '范德萨', '0005', '朱晓明', 5, 88.00, 440.00, 1);
INSERT INTO `stock_log` VALUES (49, '2025-08-02 13:05:02', '2025-08-02 13:05:02', 0, NULL, 'SOO17541111023180276', '出库', 6, '范德萨', '0005', '朱晓明', 5, 88.00, 440.00, 1);
INSERT INTO `stock_log` VALUES (50, '2025-08-02 13:05:08', '2025-08-02 13:05:08', 0, NULL, 'SOO17541111078831551', '出库', 8, '基础护理22', 'PROD002', '朱晓明', 5, 100.00, 500.00, 1);

-- ----------------------------
-- Table structure for stock_out_item
-- ----------------------------
DROP TABLE IF EXISTS `stock_out_item`;
CREATE TABLE `stock_out_item`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注(其他描述)',
  `product_id` bigint NOT NULL COMMENT '商品id',
  `product_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品编码（冗余字段方便展示）',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名称（冗余字段方便展示）',
  `unit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '单位',
  `quantity` int NOT NULL COMMENT '出库数量',
  `price` decimal(10, 2) NOT NULL COMMENT '出库单价',
  `out_order_id` bigint NOT NULL COMMENT '出库单id',
  `out_order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '出库单号',
  `org_id` bigint NOT NULL COMMENT '机构id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '出库明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_out_item
-- ----------------------------
INSERT INTO `stock_out_item` VALUES (3, '2025-07-24 16:52:58', '2025-07-24 16:52:58', 0, '团体培训基础护理', 14, 'PR001', '基础护理', '件', 5, 100.00, 4, '出库17533471780278801', 1);
INSERT INTO `stock_out_item` VALUES (4, '2025-07-24 16:52:58', '2025-07-24 16:52:58', 0, '培训用工具', 15, '8901', '工具', '件', 3, 50.00, 4, '出库17533471780278801', 1);
INSERT INTO `stock_out_item` VALUES (5, '2025-07-24 16:56:49', '2025-07-24 16:56:49', 0, '团体培训基础护理', 14, 'PR001', '基础护理', '件', 5, 100.00, 5, 'SOO17533474086061847', 1);
INSERT INTO `stock_out_item` VALUES (6, '2025-07-24 16:56:49', '2025-07-24 16:56:49', 0, '培训用工具', 15, '8901', '工具', '件', 3, 50.00, 5, 'SOO17533474086061847', 1);
INSERT INTO `stock_out_item` VALUES (7, '2025-07-24 16:57:58', '2025-07-24 16:57:58', 0, '团体培训基础护理', 14, 'PR001', '基础护理', '件', 5, 100.00, 6, 'SOO17533474775587983', 1);
INSERT INTO `stock_out_item` VALUES (8, '2025-07-24 16:57:58', '2025-07-24 16:57:58', 0, '培训用工具', 15, '8901', '工具', '件', 3, 50.00, 6, 'SOO17533474775587983', 1);
INSERT INTO `stock_out_item` VALUES (13, '2025-07-28 10:11:13', '2025-07-28 10:11:13', 0, '正常出库', 2, '0001', '工具', 'piece', 50, 20.00, 10, 'SOO17536686724838340', 1);
INSERT INTO `stock_out_item` VALUES (14, '2025-07-28 10:21:48', '2025-07-28 10:21:48', 0, '正常出库', 2, '0001', '工具', 'piece', 50, 20.00, 13, 'SOO17536693077288183', 1);
INSERT INTO `stock_out_item` VALUES (15, '2025-07-28 10:21:48', '2025-07-28 10:21:48', 0, '测试出库', 4, '0002', '服务产品名称', 'piece', 50, 20.00, 13, 'SOO17536693077288183', 1);
INSERT INTO `stock_out_item` VALUES (16, '2025-07-31 23:02:31', '2025-07-31 23:02:31', 0, '', 1, 'PROD003', '基础护理2', 'piece', 300, 100.00, 14, 'SOO17539741512553302', 1);
INSERT INTO `stock_out_item` VALUES (17, '2025-07-31 23:02:49', '2025-07-31 23:02:49', 0, '', 1, 'PROD003', '基础护理2', 'piece', 2, 100.00, 15, 'SOO17539741692783904', 1);
INSERT INTO `stock_out_item` VALUES (18, '2025-07-31 23:06:01', '2025-07-31 23:06:01', 0, '', 6, '0005', '范德萨', 'box', 10, 88.00, 16, 'SOO17539743613161983', 1);
INSERT INTO `stock_out_item` VALUES (19, '2025-07-31 23:06:18', '2025-07-31 23:06:18', 0, '', 6, '0005', '范德萨', 'box', 5, 88.00, 17, 'SOO17539743776424404', 1);
INSERT INTO `stock_out_item` VALUES (20, '2025-08-01 00:03:17', '2025-08-01 00:03:17', 0, '', 8, 'PROD002', '基础护理22', 'piece', 5, 100.00, 19, 'SOO17539777968609836', 1);
INSERT INTO `stock_out_item` VALUES (21, '2025-08-01 00:03:51', '2025-08-01 00:03:51', 0, '', 10, 'D001', '基础护理', 'piece', 1, 100.00, 20, 'SOO17539778305264406', 1);
INSERT INTO `stock_out_item` VALUES (22, '2025-08-01 00:04:18', '2025-08-01 00:04:18', 0, '', 10, 'D001', '基础护理', 'piece', 1, 100.00, 21, 'SOO17539778574625334', 1);
INSERT INTO `stock_out_item` VALUES (23, '2025-08-02 13:05:02', '2025-08-02 13:05:02', 0, '', 6, '0005', '范德萨', 'box', 5, 88.00, 22, 'SOO17541111023180276', 1);
INSERT INTO `stock_out_item` VALUES (24, '2025-08-02 13:05:08', '2025-08-02 13:05:08', 0, '', 8, 'PROD002', '基础护理22', 'piece', 5, 100.00, 23, 'SOO17541111078831551', 1);

-- ----------------------------
-- Table structure for stock_out_order
-- ----------------------------
DROP TABLE IF EXISTS `stock_out_order`;
CREATE TABLE `stock_out_order`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注(其他描述)',
  `operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作人',
  `order_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '出库单号',
  `total_price` decimal(10, 2) NOT NULL COMMENT '出库总金额',
  `org_id` bigint NOT NULL COMMENT '机构id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '库存出库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_out_order
-- ----------------------------
INSERT INTO `stock_out_order` VALUES (4, '2025-07-24 16:52:58', '2025-07-24 16:52:58', 0, '团体培训服务出库', 'manager', '出库17533471780278801', 650.00, 1);
INSERT INTO `stock_out_order` VALUES (5, '2025-07-24 16:56:49', '2025-07-24 16:56:49', 0, '团体培训服务出库', 'manager', 'SOO17533474086061847', 650.00, 1);
INSERT INTO `stock_out_order` VALUES (6, '2025-07-24 16:57:58', '2025-07-24 16:57:58', 0, '团体培训服务出库', 'manager', 'SOO17533474775587983', 650.00, 1);
INSERT INTO `stock_out_order` VALUES (10, '2025-07-28 10:11:12', '2025-07-28 10:11:12', 0, '销售出库', 'admin', 'SOO17536686724838340', 1000.00, 1);
INSERT INTO `stock_out_order` VALUES (13, '2025-07-28 10:21:48', '2025-07-28 10:21:48', 0, '销售出库', 'admin', 'SOO17536693077288183', 2000.00, 1);
INSERT INTO `stock_out_order` VALUES (14, '2025-07-31 23:02:31', '2025-07-31 23:02:31', 0, '', '朱晓明', 'SOO17539741512553302', 30000.00, 1);
INSERT INTO `stock_out_order` VALUES (15, '2025-07-31 23:02:49', '2025-07-31 23:02:49', 0, '', '朱晓明', 'SOO17539741692783904', 200.00, 1);
INSERT INTO `stock_out_order` VALUES (16, '2025-07-31 23:06:01', '2025-07-31 23:06:01', 0, '', '朱晓明', 'SOO17539743613161983', 880.00, 1);
INSERT INTO `stock_out_order` VALUES (17, '2025-07-31 23:06:18', '2025-07-31 23:06:18', 0, '', '朱晓明', 'SOO17539743776424404', 440.00, 1);
INSERT INTO `stock_out_order` VALUES (19, '2025-08-01 00:03:17', '2025-08-01 00:03:17', 0, '', '朱晓明', 'SOO17539777968609836', 500.00, 1);
INSERT INTO `stock_out_order` VALUES (20, '2025-08-01 00:03:51', '2025-08-01 00:03:51', 0, '', '朱晓明', 'SOO17539778305264406', 100.00, 1);
INSERT INTO `stock_out_order` VALUES (21, '2025-08-01 00:04:17', '2025-08-01 00:04:17', 0, '', '朱晓明', 'SOO17539778574625334', 100.00, 1);
INSERT INTO `stock_out_order` VALUES (22, '2025-08-02 13:05:02', '2025-08-02 13:05:02', 0, '', '朱晓明', 'SOO17541111023180276', 440.00, 1);
INSERT INTO `stock_out_order` VALUES (23, '2025-08-02 13:05:08', '2025-08-02 13:05:08', 0, '', '朱晓明', 'SOO17541111078831551', 500.00, 1);

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `dict_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联字典编码',
  `item_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典项内容',
  `item_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典项标签',
  `sort` int NULL DEFAULT 0 COMMENT '排序权重',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统字典内容表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item` VALUES (1, '2025-07-21 10:33:18', '2025-07-21 10:33:19', 0, NULL, 'gender', '0', '男', 0);
INSERT INTO `sys_dict_item` VALUES (2, '2025-07-21 10:39:31', '2025-07-21 10:39:33', 0, NULL, 'gender', '1', '女', 0);
INSERT INTO `sys_dict_item` VALUES (3, '2025-07-21 10:45:12', '2025-07-21 10:45:13', 0, NULL, 'enable_status', '0', '启用', 0);
INSERT INTO `sys_dict_item` VALUES (4, '2025-07-21 10:46:01', '2025-07-21 10:46:02', 0, NULL, 'enable_status', '1', '禁用', 0);
INSERT INTO `sys_dict_item` VALUES (5, '2025-07-21 11:46:42', '2025-07-21 11:46:42', 0, '', 'bed_status', '0', '空闲中', 0);
INSERT INTO `sys_dict_item` VALUES (6, '2025-07-21 14:02:25', '2025-07-21 14:02:25', 0, '', 'bed_status', '1', '服务中', 0);
INSERT INTO `sys_dict_item` VALUES (7, '2025-07-21 14:02:38', '2025-07-21 14:02:38', 0, '', 'bed_status', '2', '暂停使用', 0);
INSERT INTO `sys_dict_item` VALUES (8, '2025-07-22 18:19:07', '2025-07-22 18:30:59', 0, NULL, 'unit', 'piece', '个', 0);
INSERT INTO `sys_dict_item` VALUES (9, '2025-07-22 18:19:40', '2025-07-22 18:30:59', 0, NULL, 'unit', 'pack', '包', 0);
INSERT INTO `sys_dict_item` VALUES (10, '2025-07-22 18:19:53', '2025-07-22 18:30:59', 0, NULL, 'unit', 'box', '盒', 0);
INSERT INTO `sys_dict_item` VALUES (11, '2025-07-22 18:19:54', '2025-07-22 18:30:59', 0, NULL, 'unit', 'bottle', '瓶', 0);
INSERT INTO `sys_dict_item` VALUES (12, '2025-07-22 18:25:33', '2025-07-22 18:25:34', 0, NULL, 'commission_type', '0', '固定提成', 0);
INSERT INTO `sys_dict_item` VALUES (13, '2025-07-22 18:25:57', '2025-07-22 18:25:59', 0, NULL, 'commission_type', '1', '比例提成', 0);
INSERT INTO `sys_dict_item` VALUES (14, '2025-07-30 00:13:36', '2025-07-30 00:15:07', 0, '', 'department', '管理部', '管理部', 2);
INSERT INTO `sys_dict_item` VALUES (15, '2025-07-30 00:15:23', '2025-07-30 00:15:23', 0, '', 'department', '技师部', '技师部', 0);
INSERT INTO `sys_dict_item` VALUES (16, '2025-07-30 12:49:49', '2025-07-30 12:50:27', 1, '2', 'test', '1', '1', 0);
INSERT INTO `sys_dict_item` VALUES (17, '2025-07-30 13:11:33', '2025-07-30 13:12:21', 1, '', 'test', '555', '55', 0);
INSERT INTO `sys_dict_item` VALUES (18, '2025-07-30 15:21:50', '2025-07-30 15:21:50', 0, '', 'position', '店长', '店长', 0);
INSERT INTO `sys_dict_item` VALUES (19, '2025-07-30 15:22:03', '2025-07-30 15:22:03', 0, '', 'position', '收银员', '收银员', 0);
INSERT INTO `sys_dict_item` VALUES (20, '2025-07-30 15:22:10', '2025-07-30 15:22:10', 0, '', 'position', '采耳师', '采耳师', 0);
INSERT INTO `sys_dict_item` VALUES (21, '2025-07-30 15:22:19', '2025-07-30 15:22:19', 0, '', 'position', '修脚师', '修脚师', 0);
INSERT INTO `sys_dict_item` VALUES (22, '2025-07-31 15:25:38', '2025-07-31 15:25:38', 0, '', 'unit', 'bag', '袋', 0);
INSERT INTO `sys_dict_item` VALUES (23, '2025-08-02 20:48:37', '2025-08-25 18:09:01', 0, '', 'payment_type', '0', '微信支付', 0);
INSERT INTO `sys_dict_item` VALUES (24, '2025-08-02 20:48:54', '2025-08-25 18:09:09', 0, '', 'payment_type', '1', '支付宝支付', 0);
INSERT INTO `sys_dict_item` VALUES (25, '2025-08-02 20:49:06', '2025-08-25 18:09:21', 0, '', 'payment_type', '2', '现金支付', 0);
INSERT INTO `sys_dict_item` VALUES (26, '2025-08-19 17:06:25', '2025-08-19 17:06:25', 0, '', 'ticket_type', '0', '代金券', 0);
INSERT INTO `sys_dict_item` VALUES (27, '2025-08-19 17:06:35', '2025-08-19 17:06:35', 0, '', 'ticket_type', '1', '体验券', 0);
INSERT INTO `sys_dict_item` VALUES (28, '2025-08-21 23:01:17', '2025-08-21 23:01:17', 0, NULL, 'active_type', '0', '赠送储值金', 0);
INSERT INTO `sys_dict_item` VALUES (29, '2025-08-21 23:01:17', '2025-08-21 23:01:17', 0, NULL, 'active_type', '1', '赠送优惠券', 0);
INSERT INTO `sys_dict_item` VALUES (30, '2025-08-21 23:01:17', '2025-08-21 23:01:17', 0, NULL, 'active_type', '2', '赠送储值金+优惠券', 0);
INSERT INTO `sys_dict_item` VALUES (31, '2025-08-22 17:44:04', '2025-08-22 17:44:04', 0, '', 'discount_base', '0', '标准价', 0);
INSERT INTO `sys_dict_item` VALUES (32, '2025-08-22 17:44:17', '2025-08-22 17:44:17', 0, '', 'discount_base', '1', '会员价', 1);
INSERT INTO `sys_dict_item` VALUES (33, '2025-08-22 17:45:45', '2025-08-22 17:45:45', 0, '', 'is_cross_store', '0', '不允许', 0);
INSERT INTO `sys_dict_item` VALUES (34, '2025-08-22 17:45:53', '2025-08-22 17:45:53', 0, '', 'is_cross_store', '1', '允许', 0);
INSERT INTO `sys_dict_item` VALUES (35, '2025-08-25 16:20:13', '2025-08-25 16:20:13', 0, '', 'service_type', '0', '服务产品', 0);
INSERT INTO `sys_dict_item` VALUES (36, '2025-08-25 16:20:21', '2025-08-25 16:20:21', 0, '', 'service_type', '1', '服务项目', 0);
INSERT INTO `sys_dict_item` VALUES (37, '2025-08-25 16:20:47', '2025-08-25 16:20:47', 0, '', 'service_type', '2', '疗程券', 0);
INSERT INTO `sys_dict_item` VALUES (38, '2025-08-25 16:20:57', '2025-08-25 16:20:57', 0, '', 'service_type', '4', '充值', 0);
INSERT INTO `sys_dict_item` VALUES (39, '2025-08-25 16:49:35', '2025-08-25 16:49:35', 0, '', 'item_type', '0', '点钟', 0);
INSERT INTO `sys_dict_item` VALUES (40, '2025-08-25 16:49:41', '2025-08-25 16:49:41', 0, '', 'item_type', '1', '加钟', 0);
INSERT INTO `sys_dict_item` VALUES (41, '2025-08-25 16:49:49', '2025-08-25 16:49:49', 0, '', 'item_type', '2', '轮牌', 0);
INSERT INTO `sys_dict_item` VALUES (42, '2025-08-25 16:49:55', '2025-08-25 16:49:55', 0, '', 'item_type', '3', '其他', 0);
INSERT INTO `sys_dict_item` VALUES (43, '2025-08-28 09:57:52', '2025-08-28 09:57:52', 0, '', 'recharge_status', '0', '充值成功', 0);
INSERT INTO `sys_dict_item` VALUES (44, '2025-08-28 09:58:08', '2025-08-28 09:58:08', 0, '', 'recharge_status', '1', '已冲正', 0);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典名称',
  `dict_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典编码',
  `sort` int NULL DEFAULT 0 COMMENT '排序权重',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '2025-07-21 10:31:16', '2025-07-29 22:33:25', 0, '性别', '性别', 'gender', 1);
INSERT INTO `sys_dict_type` VALUES (2, '2025-07-21 10:31:55', '2025-07-29 22:36:58', 0, '启用禁用状态', '启用状态', 'enable_status', 1);
INSERT INTO `sys_dict_type` VALUES (3, '2025-07-21 11:44:49', '2025-07-22 18:18:59', 0, '床位状态管理', '床位状态', 'bed_status', 0);
INSERT INTO `sys_dict_type` VALUES (4, '2025-07-22 18:18:24', '2025-07-22 18:18:25', 0, '单位管理', '单位', 'unit', 0);
INSERT INTO `sys_dict_type` VALUES (5, '2025-07-22 18:23:53', '2025-07-22 18:23:55', 0, '提成比例类型', '提成比例', 'commission_type', 0);
INSERT INTO `sys_dict_type` VALUES (6, '2025-07-29 22:38:15', '2025-07-29 22:38:15', 0, '部门列表', '部门', 'department', 0);
INSERT INTO `sys_dict_type` VALUES (7, '2025-07-30 12:47:22', '2025-07-30 13:18:55', 1, '', 'test', 'test', 0);
INSERT INTO `sys_dict_type` VALUES (8, '2025-07-30 13:19:46', '2025-07-30 13:19:49', 1, '', '33', '33', 0);
INSERT INTO `sys_dict_type` VALUES (9, '2025-07-30 13:19:58', '2025-07-30 13:20:00', 1, '', '33', '33', 0);
INSERT INTO `sys_dict_type` VALUES (10, '2025-07-30 15:21:21', '2025-07-30 15:21:21', 0, '', '职位', 'position', 0);
INSERT INTO `sys_dict_type` VALUES (11, '2025-08-02 20:48:01', '2025-08-02 20:48:01', 0, '', '支付类型', 'payment_type', 0);
INSERT INTO `sys_dict_type` VALUES (12, '2025-08-19 17:05:49', '2025-08-19 17:05:49', 0, '', '优惠券类型', 'ticket_type', 0);
INSERT INTO `sys_dict_type` VALUES (13, '2025-08-21 23:00:23', '2025-08-21 23:00:25', 0, NULL, '充值活动类型', 'active_type', 1);
INSERT INTO `sys_dict_type` VALUES (14, '2025-08-22 17:43:44', '2025-08-22 17:43:44', 0, '折扣基准', '折扣基准', 'discount_base', 3);
INSERT INTO `sys_dict_type` VALUES (15, '2025-08-22 17:45:10', '2025-08-22 17:45:19', 0, '资产是否允许跨店消费', '是否允许跨店', 'is_cross_store', 3);
INSERT INTO `sys_dict_type` VALUES (16, '2025-08-25 16:19:48', '2025-08-25 16:19:48', 0, '', '业务类型', 'service_type', 4);
INSERT INTO `sys_dict_type` VALUES (17, '2025-08-25 16:49:08', '2025-08-25 16:49:08', 0, '', '上钟类型', 'item_type', 3);
INSERT INTO `sys_dict_type` VALUES (18, '2025-08-28 09:57:19', '2025-08-28 09:57:19', 0, '', '充值状态', 'recharge_status', 10);

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `org_state` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '机构状态(0 正常，1 停用)',
  `org_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '机构名称',
  `org_short_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '机构简称',
  `org_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '机构编号',
  `org_parent` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父级机构',
  `org_property` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '机构性质',
  `org_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '机构类型',
  `org_area` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '行政区域',
  `org_number` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '机构电话',
  `org_leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '机构负责人',
  `org_leader_num` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人电话',
  `org_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '机构信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES (1, '2025-07-16 18:13:19', '2025-08-02 22:09:16', 0, 0, '总店', '总店', '0001', '总部', '实体门店', '自营', '[\"河南省\",\"郑州市\",\"中原区\"]', '15637885669', '丁铭瀚', '15637885669', '中原锦艺城', '总部机构');
INSERT INTO `sys_org` VALUES (2, '2025-07-22 10:59:26', '2025-07-27 21:09:38', 0, 0, '郑州棉纺路店', '郑州棉纺路店', '0985', '郑州区域', '实体门店', '自营', '[\"河南省\",\"郑州市\",\"中原区\"]', '16697771407', '刘文祥', '15136396851', '盛润锦绣城西苑18-154号', '创度YB866');
INSERT INTO `sys_org` VALUES (3, '2025-07-26 00:01:45', '2025-07-26 00:01:45', 0, 0, '郑州锦艺城店', '锦艺城店', '0002', '无', '实体门店', '自营', '[\"河南省\",\"郑州市\",\"中原区\"]', '17513370320', '刘翠', '17513370320', '中原锦艺城', '');

-- ----------------------------
-- Table structure for sys_org_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_org_user`;
CREATE TABLE `sys_org_user`  (
  `org_id` bigint UNSIGNED NOT NULL COMMENT '机构id',
  `usr_id` bigint UNSIGNED NOT NULL COMMENT '用户id',
  PRIMARY KEY (`org_id`, `usr_id`) USING BTREE,
  INDEX `fk_sys_org_user_sys_user_1`(`usr_id` ASC) USING BTREE,
  CONSTRAINT `fk_sys_org_user_sys_org_1` FOREIGN KEY (`org_id`) REFERENCES `sys_org` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_sys_org_user_sys_user_1` FOREIGN KEY (`usr_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '门店用户关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_org_user
-- ----------------------------

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `perm_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名称',
  `perm_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限标识',
  `resource_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资源路径',
  `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组件名称',
  `perm_status` int NOT NULL DEFAULT 0 COMMENT '权限状态（0 正常， 1 停用）',
  `parent_id` bigint UNSIGNED NULL DEFAULT 0 COMMENT '父权限ID',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 96 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1, '2025-07-27 23:05:42', '2025-07-27 23:11:35', 0, '首页', 'home', '/home', 'layout', 0, 0, '');
INSERT INTO `sys_permission` VALUES (2, '2025-07-27 23:05:42', '2025-07-27 23:05:42', 0, '概览', 'dataView', '/dataView', 'DataView', 0, 1, '');
INSERT INTO `sys_permission` VALUES (3, '2025-07-27 23:05:42', '2025-07-27 23:05:42', 0, '房态', 'bedStatus', '/bedStatus', 'BedStatus', 0, 0, '');
INSERT INTO `sys_permission` VALUES (4, '2025-07-27 23:05:42', '2025-07-27 23:05:42', 0, '房态', 'bedStatus', '/bedStatus', 'BedStatus', 0, 3, '');
INSERT INTO `sys_permission` VALUES (5, '2025-07-27 23:05:43', '2025-07-27 23:05:43', 0, '收银', 'saleMain', '/saleMain', 'SaleMain', 0, 0, '');
INSERT INTO `sys_permission` VALUES (6, '2025-07-27 23:05:43', '2025-07-27 23:05:43', 0, '收银', 'saleMain', '/saleMain', 'SaleMain', 0, 5, '');
INSERT INTO `sys_permission` VALUES (7, '2025-07-27 23:05:43', '2025-07-27 23:05:43', 0, '人事', 'staffMain', '/staffMain', 'StaffMain', 0, 0, '');
INSERT INTO `sys_permission` VALUES (8, '2025-07-27 23:05:43', '2025-07-27 23:05:43', 0, '人事', 'staffMain', '/staffMain', 'StaffMain', 0, 7, '');
INSERT INTO `sys_permission` VALUES (9, '2025-07-27 23:05:43', '2025-07-27 23:05:43', 0, '添加员工', 'staffMain:add', '/staffMain/add', 'StaffAdd', 0, 8, '');
INSERT INTO `sys_permission` VALUES (10, '2025-07-27 23:05:44', '2025-07-27 23:05:44', 0, '修改员工', 'staffMain:update', '/staffMain/update', 'StaffUpdate', 0, 8, '');
INSERT INTO `sys_permission` VALUES (11, '2025-07-27 23:05:44', '2025-07-27 23:05:44', 0, '禁用员工', 'staffMain:disabled', '/staffMain/disabled', 'StaffDisabled', 0, 8, '');
INSERT INTO `sys_permission` VALUES (12, '2025-07-27 23:05:44', '2025-07-27 23:05:44', 0, '门店', 'org', '/org', 'Org', 0, 0, '');
INSERT INTO `sys_permission` VALUES (13, '2025-07-27 23:05:44', '2025-07-27 23:05:44', 0, '门店', 'org', '/org', 'Org', 0, 12, '');
INSERT INTO `sys_permission` VALUES (14, '2025-07-27 23:05:44', '2025-07-27 23:05:44', 0, '会员', 'member', '/member', 'Member', 0, 0, '');
INSERT INTO `sys_permission` VALUES (15, '2025-07-27 23:05:44', '2025-07-27 23:05:44', 0, '电子会员卡', 'member:memberCard', '/member/memberCard', 'MemberCard', 0, 14, '[\"会员列表\",\"会员统计\",\"会员活跃分析\",\"资产转移\"]');
INSERT INTO `sys_permission` VALUES (16, '2025-07-27 23:05:45', '2025-07-27 23:05:45', 0, '会员列表', 'member:memberCard:memberList', '/member/memberCard/memberList', 'MemberList', 0, 15, '');
INSERT INTO `sys_permission` VALUES (17, '2025-07-27 23:05:45', '2025-07-27 23:05:45', 0, '添加会员', 'member:memberCard:memberList:add', '/member/memberCard/memberList/add', 'MemberAdd', 0, 16, '');
INSERT INTO `sys_permission` VALUES (18, '2025-07-27 23:05:45', '2025-07-27 23:05:45', 0, '修改会员', 'member:memberCard:memberList:update', '/member/memberCard/memberList/update', 'MemberUpdate', 0, 16, '');
INSERT INTO `sys_permission` VALUES (19, '2025-07-27 23:05:45', '2025-07-27 23:05:45', 0, '禁用会员', 'member:memberCard:memberList:disabled', '/member/memberCard/memberList/disabled', 'MemberDisabled', 0, 16, '');
INSERT INTO `sys_permission` VALUES (20, '2025-07-27 23:05:45', '2025-07-27 23:05:45', 0, '会员统计', 'member:memberCard:memberCount', '/member/memberCard/memberCount', 'MemberCount', 0, 15, '');
INSERT INTO `sys_permission` VALUES (21, '2025-07-27 23:05:46', '2025-07-27 23:05:46', 0, '会员活跃分析', 'member:memberCard:activityAnalysis', '/member/memberCard/activityAnalysis', 'ActivityAnalysis', 0, 15, '');
INSERT INTO `sys_permission` VALUES (22, '2025-07-27 23:05:46', '2025-07-28 14:56:31', 0, '资产转移', 'member:memberCard:assetTransfer', '/member/memberCard/assetTransfer', 'AssetTransfer', 0, 15, '');
INSERT INTO `sys_permission` VALUES (23, '2025-07-27 23:05:46', '2025-07-27 23:05:46', 0, '会员卡充值 ', 'member:memberRecharge', '/member/memberRecharge', 'MemberRecharge', 0, 14, '[\"会员充值\",\"充值记录\",\"充值活动\"]');
INSERT INTO `sys_permission` VALUES (24, '2025-07-27 23:05:46', '2025-07-27 23:05:46', 0, '会员充值', 'member:memberRecharge:recharge', '/member/memberRecharge/recharge', 'Recharge', 0, 23, '');
INSERT INTO `sys_permission` VALUES (25, '2025-07-27 23:05:46', '2025-07-27 23:05:46', 0, '充值记录', 'member:memberRecharge:rechargeRecord', '/member/memberRecharge/rechargeRecord', 'RechargeRecord', 0, 23, '');
INSERT INTO `sys_permission` VALUES (26, '2025-07-27 23:05:46', '2025-07-27 23:05:46', 0, '充值活动', 'member:memberRecharge:rechargeActivity', '/member/memberRecharge/rechargeActivity', 'RechargeActivity', 0, 23, '');
INSERT INTO `sys_permission` VALUES (27, '2025-07-27 23:05:47', '2025-07-27 23:05:47', 0, '添加充值活动', 'member:memberRecharge:rechargeActivity:add', '/member/memberRecharge/rechargeActivity/add', 'ActivityAdd', 0, 26, '');
INSERT INTO `sys_permission` VALUES (28, '2025-07-27 23:05:47', '2025-07-27 23:05:47', 0, '修改充值活动', 'member:memberRecharge:rechargeActivity:update', '/member/memberRecharge/rechargeActivity/update', 'ActivityUpdate', 0, 26, '');
INSERT INTO `sys_permission` VALUES (29, '2025-07-27 23:05:47', '2025-07-27 23:05:47', 0, '禁用充值活动', 'member:memberRecharge:rechargeActivity:disabled', '/member/memberRecharge/rechargeActivity/disabled', 'ActivityDisabled', 0, 26, '');
INSERT INTO `sys_permission` VALUES (30, '2025-07-27 23:05:47', '2025-07-27 23:05:47', 0, '会员优惠券', 'member:memberCoupon', '/member/memberCoupon', 'MemberCoupon', 0, 14, '[\"优惠券管理\",\"优惠券统计\",\"优惠券汇总\"]');
INSERT INTO `sys_permission` VALUES (31, '2025-07-27 23:05:47', '2025-07-27 23:05:47', 0, '优惠券管理', 'member:memberCoupon:couponManager', '/member/memberCoupon/couponManager', 'CouponManager', 0, 30, '');
INSERT INTO `sys_permission` VALUES (32, '2025-07-27 23:05:48', '2025-07-27 23:05:48', 0, '添加优惠券', 'member:memberCoupon:couponManager:add', '/member/memberCoupon/couponManager/add', 'CouponAdd', 0, 31, '');
INSERT INTO `sys_permission` VALUES (33, '2025-07-27 23:05:48', '2025-07-27 23:05:48', 0, '修改优惠券', 'member:memberCoupon:couponManager:update', '/member/memberCoupon/couponManager/update', 'CouponUpdate', 0, 31, '');
INSERT INTO `sys_permission` VALUES (34, '2025-07-27 23:05:48', '2025-07-27 23:05:48', 0, '禁用优惠券', 'member:memberCoupon:couponManager:disabled', '/member/memberCoupon/couponManager/disabled', 'CouponDisabled', 0, 31, '');
INSERT INTO `sys_permission` VALUES (35, '2025-07-27 23:05:48', '2025-07-27 23:05:48', 0, '优惠券统计', 'member:memberCoupon:couponCount', '/member/memberCoupon/couponCount', 'CouponCount', 0, 30, '');
INSERT INTO `sys_permission` VALUES (36, '2025-07-27 23:05:48', '2025-07-27 23:05:48', 0, '优惠券汇总', 'member:memberCoupon:couponOverview', '/member/memberCoupon/couponOverview', 'CouponOverview', 0, 30, '');
INSERT INTO `sys_permission` VALUES (37, '2025-07-27 23:05:48', '2025-07-27 23:05:48', 0, '数据', 'dataGroup', '/dataGroup', 'DataGroup', 0, 0, '');
INSERT INTO `sys_permission` VALUES (38, '2025-07-27 23:05:49', '2025-07-27 23:05:49', 0, '销售数据', 'dataGroup:saleData', '/dataGroup/saleData', 'SaleData', 0, 37, '[\"销售记录\",\"销售汇总\",\"销售明细\",\"跨店消费\"]');
INSERT INTO `sys_permission` VALUES (39, '2025-07-27 23:05:49', '2025-07-27 23:05:49', 0, '销售记录', 'dataGroup:saleData:saleRecord', '/dataGroup/saleData/saleRecord', 'SaleRecord', 0, 38, '');
INSERT INTO `sys_permission` VALUES (40, '2025-07-27 23:05:49', '2025-07-27 23:05:49', 0, '销售明细', 'dataGroup:saleData:saleDetail', '/dataGroup/saleData/saleDetail', 'SaleDetail', 0, 38, '');
INSERT INTO `sys_permission` VALUES (41, '2025-07-27 23:05:49', '2025-07-27 23:05:49', 0, '销售汇总', 'dataGroup:saleData:saleSummary', '/dataGroup/saleData/saleSummary', 'SaleSummary', 0, 38, '');
INSERT INTO `sys_permission` VALUES (42, '2025-07-27 23:05:49', '2025-07-27 23:05:49', 0, '跨店消费', 'dataGroup:saleData:crossStoreConsumption', '/dataGroup/saleData/crossStoreConsumption', 'CrossStoreConsumption', 0, 38, '');
INSERT INTO `sys_permission` VALUES (43, '2025-07-27 23:05:50', '2025-07-27 23:05:50', 0, '人员绩效 ', 'dataGroup:staffPerformance', '/dataGroup/staffPerformance', 'StaffPerformance', 0, 37, '[\"业绩明细\",\"业绩汇总\"]');
INSERT INTO `sys_permission` VALUES (44, '2025-07-27 23:05:50', '2025-07-27 23:05:50', 0, '业绩明细', 'dataGroup:staffPerformance:performanceDetail', '/dataGroup/staffPerformance/performanceDetail', 'PerformanceDetail', 0, 43, '');
INSERT INTO `sys_permission` VALUES (45, '2025-07-27 23:05:50', '2025-07-27 23:05:50', 0, '业绩汇总', 'dataGroup:staffPerformance:performanceOverview', '/dataGroup/staffPerformance/performanceOverview', 'PerformanceOverview', 0, 43, '');
INSERT INTO `sys_permission` VALUES (46, '2025-07-27 23:05:50', '2025-07-27 23:05:50', 0, '设定', 'setGroup', '/setGroup', 'SetGroup', 0, 0, '');
INSERT INTO `sys_permission` VALUES (47, '2025-07-27 23:05:50', '2025-07-27 23:05:50', 0, '品项设定', 'setGroup:psMain', '/setGroup/psMain', 'PsMain', 0, 46, '[\"产品管理\",\"项目管理\",\"套餐管理\",\"充值提成规则\"]');
INSERT INTO `sys_permission` VALUES (48, '2025-07-27 23:05:50', '2025-07-27 23:05:50', 0, '产品管理', 'setGroup:psMain:productManager', '/setGroup/psMain/productManager', 'ProductManager', 0, 47, '');
INSERT INTO `sys_permission` VALUES (49, '2025-07-27 23:05:51', '2025-07-27 23:05:51', 0, '添加产品', 'setGroup:psMain:productManager:add', '/setGroup/psMain/productManager/add', 'ProductAdd', 0, 48, '');
INSERT INTO `sys_permission` VALUES (50, '2025-07-27 23:05:51', '2025-07-27 23:05:51', 0, '修改产品', 'setGroup:psMain:productManager:update', '/setGroup/psMain/productManager/update', 'ProductUpdate', 0, 48, '');
INSERT INTO `sys_permission` VALUES (51, '2025-07-27 23:05:51', '2025-07-27 23:05:51', 0, '禁用产品', 'setGroup:psMain:productManager:disabled', '/setGroup/psMain/productManager/disabled', 'ProductDisabled', 0, 48, '');
INSERT INTO `sys_permission` VALUES (52, '2025-07-27 23:05:51', '2025-07-27 23:05:51', 0, '项目管理', 'setGroup:psMain:serviceItemManager', '/setGroup/psMain/serviceItemManager', 'ServiceItemManager', 0, 47, '');
INSERT INTO `sys_permission` VALUES (53, '2025-07-27 23:05:51', '2025-07-27 23:05:51', 0, '添加项目', 'setGroup:psMain:serviceItemManager:add', '/setGroup/psMain/serviceItemManager/add', 'ServiceItemAdd', 0, 52, '');
INSERT INTO `sys_permission` VALUES (54, '2025-07-27 23:05:52', '2025-07-27 23:05:52', 0, '修改项目', 'setGroup:psMain:serviceItemManager:update', '/setGroup/psMain/serviceItemManager/update', 'ServiceItemUpdate', 0, 52, '');
INSERT INTO `sys_permission` VALUES (55, '2025-07-27 23:05:52', '2025-07-27 23:05:52', 0, '禁用项目', 'setGroup:psMain:serviceItemManager:disabled', '/setGroup/psMain/serviceItemManager/disabled', 'ServiceItemDisabled', 0, 52, '');
INSERT INTO `sys_permission` VALUES (56, '2025-07-27 23:05:52', '2025-07-27 23:05:52', 0, '套餐管理', 'setGroup:psMain:packageManager', '/setGroup/psMain/packageManager', 'PackageManager', 0, 47, '');
INSERT INTO `sys_permission` VALUES (57, '2025-07-27 23:05:52', '2025-07-27 23:05:52', 0, '添加套餐', 'setGroup:psMain:packageManager:add', '/setGroup/psMain/packageManager/add', 'PackageAdd', 0, 56, '');
INSERT INTO `sys_permission` VALUES (58, '2025-07-27 23:05:52', '2025-07-27 23:05:52', 0, '修改套餐', 'setGroup:psMain:packageManager:update', '/setGroup/psMain/packageManager/update', 'PackageUpdate', 0, 56, '');
INSERT INTO `sys_permission` VALUES (59, '2025-07-27 23:05:52', '2025-07-27 23:05:52', 0, '禁用套餐', 'setGroup:psMain:packageManager:disabled', '/setGroup/psMain/packageManager/disabled', 'PackageDisabled', 0, 56, '');
INSERT INTO `sys_permission` VALUES (60, '2025-07-27 23:05:53', '2025-07-27 23:05:53', 0, '充值提成规则', 'setGroup:psMain:rechargeCommission', '/setGroup/psMain/rechargeCommission', 'RechargeCommission', 0, 47, '');
INSERT INTO `sys_permission` VALUES (61, '2025-07-27 23:05:53', '2025-07-27 23:05:53', 0, '添加充值提成规则', 'setGroup:psMain:rechargeCommission:add', '/setGroup/psMain/rechargeCommission/add', 'RechargeCommissionAdd', 0, 60, '');
INSERT INTO `sys_permission` VALUES (62, '2025-07-27 23:05:53', '2025-07-27 23:05:53', 0, '修改充值提成规则', 'setGroup:psMain:rechargeCommission:update', '/setGroup/psMain/rechargeCommission/update', 'RechargeCommissionUpdate', 0, 60, '');
INSERT INTO `sys_permission` VALUES (63, '2025-07-27 23:05:53', '2025-07-27 23:05:53', 0, '禁用充值提成规则', 'setGroup:psMain:rechargeCommission:disabled', '/setGroup/psMain/rechargeCommission/disabled', 'RechargeCommissionDisabled', 0, 60, '');
INSERT INTO `sys_permission` VALUES (64, '2025-07-27 23:05:53', '2025-07-27 23:05:53', 0, '房间设定 ', 'setGroup:roomBed', '/setGroup/roomBed', 'RoomBed', 0, 46, '');
INSERT INTO `sys_permission` VALUES (65, '2025-07-27 23:05:53', '2025-07-27 23:05:53', 0, '添加房间', 'setGroup:roomBed:add', '/setGroup/roomBed/add', 'RoomAdd', 0, 64, '');
INSERT INTO `sys_permission` VALUES (66, '2025-07-27 23:05:54', '2025-07-27 23:05:54', 0, '修改房间', 'setGroup:roomBed:update', '/setGroup/roomBed/update', 'RoomUpdate', 0, 64, '');
INSERT INTO `sys_permission` VALUES (67, '2025-07-27 23:05:54', '2025-07-31 16:48:18', 0, '库存管理', 'setGroup:stock', '/setGroup/stock', 'Stock', 0, 46, '[\"入库\",\"出库\",\"库存流水\"]');
INSERT INTO `sys_permission` VALUES (68, '2025-07-27 23:05:54', '2025-07-31 16:45:06', 0, '入库', 'setGroup:stock:inStock', '/setGroup/stock/inStock', 'InStock', 0, 67, '');
INSERT INTO `sys_permission` VALUES (69, '2025-07-27 23:05:54', '2025-07-31 16:45:46', 0, '出库', 'setGroup:stock:outStock', '/setGroup/stock/outStock', 'OutStock', 0, 67, '');
INSERT INTO `sys_permission` VALUES (70, '2025-07-27 23:05:54', '2025-07-31 16:46:33', 0, '库存流水', 'setGroup:stock:stockLog', '/setGroup/stock/stockLog', 'StockLog', 0, 67, '');
INSERT INTO `sys_permission` VALUES (71, '2025-07-27 23:05:54', '2025-07-27 23:05:54', 0, '系统设置', 'acl', '/acl', 'Acl', 0, 0, '');
INSERT INTO `sys_permission` VALUES (72, '2025-07-27 23:05:55', '2025-07-27 23:05:55', 0, '门店管理', 'acl:orgMgr', '/acl/orgMgr', 'OrgMgr', 0, 71, '');
INSERT INTO `sys_permission` VALUES (73, '2025-07-27 23:05:55', '2025-07-27 23:05:55', 0, '添加门店', 'acl:orgMgr:add', '/acl/orgMgr/add', 'OrgAdd', 0, 72, '');
INSERT INTO `sys_permission` VALUES (74, '2025-07-27 23:05:55', '2025-07-27 23:05:55', 0, '修改门店', 'acl:orgMgr:update', '/acl/orgMgr/update', 'OrgUpdate', 0, 72, '');
INSERT INTO `sys_permission` VALUES (75, '2025-07-27 23:05:55', '2025-07-27 23:05:55', 0, '禁用门店', 'acl:orgMgr:disabled', '/acl/orgMgr/disabled', 'OrgDisabled', 0, 72, '');
INSERT INTO `sys_permission` VALUES (76, '2025-07-27 23:05:55', '2025-07-27 23:05:55', 0, '用户管理', 'acl:user', '/acl/user', 'User', 0, 71, '');
INSERT INTO `sys_permission` VALUES (77, '2025-07-27 23:05:56', '2025-07-27 23:05:56', 0, '添加用户', 'acl:user:add', '/acl/user/add', 'UserAdd', 0, 76, '');
INSERT INTO `sys_permission` VALUES (78, '2025-07-27 23:05:56', '2025-07-27 23:05:56', 0, '修改用户', 'acl:user:update', '/acl/user/update', 'UserUpdate', 0, 76, '');
INSERT INTO `sys_permission` VALUES (79, '2025-07-27 23:05:56', '2025-07-27 23:05:56', 0, '禁用用户', 'acl:user:disabled', '/acl/user/disabled', 'UserDisabled', 0, 76, '');
INSERT INTO `sys_permission` VALUES (80, '2025-07-27 23:05:56', '2025-07-27 23:05:56', 0, '角色管理', 'acl:role', '/acl/role', 'Role', 0, 71, '');
INSERT INTO `sys_permission` VALUES (81, '2025-07-27 23:05:56', '2025-07-27 23:05:56', 0, '添加角色', 'acl:role:add', '/acl/role/add', 'RoleAdd', 0, 80, '');
INSERT INTO `sys_permission` VALUES (82, '2025-07-27 23:05:56', '2025-07-27 23:05:56', 0, '修改角色', 'acl:role:update', '/acl/role/update', 'RoleUpdate', 0, 80, '');
INSERT INTO `sys_permission` VALUES (83, '2025-07-27 23:05:57', '2025-07-27 23:05:57', 0, '禁用角色', 'acl:role:disabled', '/acl/role/disabled', 'RoleDisabled', 0, 80, '');
INSERT INTO `sys_permission` VALUES (84, '2025-07-27 23:05:57', '2025-07-27 23:05:57', 0, '权限分配', 'acl:role:allocated', '/acl/role/allocated', 'RoleAllocated', 0, 80, '');
INSERT INTO `sys_permission` VALUES (85, '2025-07-27 23:05:57', '2025-07-27 23:05:57', 0, '权限管理', 'acl:permission', '/acl/permission', 'Permission', 0, 71, '');
INSERT INTO `sys_permission` VALUES (86, '2025-07-27 23:05:57', '2025-07-27 23:05:57', 0, '添加权限', 'acl:permission:add', '/acl/permission/add', 'PermissionAdd', 0, 85, '');
INSERT INTO `sys_permission` VALUES (87, '2025-07-27 23:05:57', '2025-07-27 23:05:57', 0, '修改权限', 'acl:permission:update', '/acl/permission/update', 'PermissionUpdate', 0, 85, '');
INSERT INTO `sys_permission` VALUES (88, '2025-07-27 23:05:58', '2025-07-27 23:05:58', 0, '禁用权限', 'acl:permission:disabled', '/acl/permission/disabled', 'PermissionDisabled', 0, 85, '');
INSERT INTO `sys_permission` VALUES (89, '2025-07-27 23:05:58', '2025-07-27 23:05:58', 0, '枚举管理', 'acl:enum', '/acl/enum', 'Enum', 0, 71, '');
INSERT INTO `sys_permission` VALUES (90, '2025-07-27 23:05:58', '2025-07-27 23:05:58', 0, '添加枚举', 'acl:enum:add', '/acl/enum/add', 'EnumAdd', 0, 89, '');
INSERT INTO `sys_permission` VALUES (91, '2025-07-27 23:05:58', '2025-07-27 23:05:58', 0, '修改枚举', 'acl:enum:update', '/acl/enum/update', 'EnumUpdate', 0, 89, '');
INSERT INTO `sys_permission` VALUES (92, '2025-07-27 23:05:58', '2025-07-27 23:05:58', 0, '禁用枚举', 'acl:enum:disabled', '/acl/enum/disabled', 'EnumDisabled', 0, 89, '');
INSERT INTO `sys_permission` VALUES (93, '2025-07-27 23:05:58', '2025-07-27 23:05:58', 0, '登录', 'login', '/login', 'login', 0, 0, '');
INSERT INTO `sys_permission` VALUES (94, '2025-07-27 23:05:59', '2025-07-27 23:05:59', 0, '404', '404', '/404', '404', 0, 0, '');
INSERT INTO `sys_permission` VALUES (95, '2025-07-30 10:15:12', '2025-07-30 10:16:11', 1, '方建华', '31', '/proc', 'officia culpa irure', 0, 0, 'Ut fugiat');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态（0 存在，1 删除）',
  `role_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色标识',
  `role_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `role_sort` int NULL DEFAULT 1 COMMENT '显示顺序',
  `role_status` int NULL DEFAULT 0 COMMENT '角色状态（0 启用，1 禁用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '2025-07-13 14:32:48', '2025-07-29 17:06:53', 0, 'ADMIN', '超级管理员', '超级管理员', 0, 0);
INSERT INTO `sys_role` VALUES (2, '2025-07-13 15:25:33', '2025-07-29 16:58:44', 0, 'STORE_MANAGER', '店长', '', 1, 0);
INSERT INTO `sys_role` VALUES (3, '2025-07-24 00:04:40', '2025-07-29 17:06:34', 0, 'CASHIER', '收银员', '', 1, 0);
INSERT INTO `sys_role` VALUES (4, '2025-07-24 00:05:14', '2025-07-28 15:12:50', 0, 'VIP', '会员', '', 0, 1);
INSERT INTO `sys_role` VALUES (5, '2025-07-29 17:06:24', '2025-07-29 17:06:24', 0, 'EMPLOYEE', '员工', '', 1, 0);
INSERT INTO `sys_role` VALUES (6, '2025-07-29 17:07:59', '2025-07-29 17:07:59', 0, 'FINANCE', '财务', '', 0, 0);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `role_id` bigint UNSIGNED NOT NULL COMMENT '角色id',
  `permission_id` bigint UNSIGNED NOT NULL COMMENT '权限id',
  PRIMARY KEY (`role_id`, `permission_id`) USING BTREE,
  INDEX `fk_sys_role_permission_sys_permission_1`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `fk_sys_role_permission_sys_permission_1` FOREIGN KEY (`permission_id`) REFERENCES `sys_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_sys_role_permission_sys_role_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色权限关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (1, 1);
INSERT INTO `sys_role_permission` VALUES (2, 1);
INSERT INTO `sys_role_permission` VALUES (1, 2);
INSERT INTO `sys_role_permission` VALUES (2, 2);
INSERT INTO `sys_role_permission` VALUES (1, 3);
INSERT INTO `sys_role_permission` VALUES (2, 3);
INSERT INTO `sys_role_permission` VALUES (3, 3);
INSERT INTO `sys_role_permission` VALUES (1, 4);
INSERT INTO `sys_role_permission` VALUES (2, 4);
INSERT INTO `sys_role_permission` VALUES (3, 4);
INSERT INTO `sys_role_permission` VALUES (1, 5);
INSERT INTO `sys_role_permission` VALUES (2, 5);
INSERT INTO `sys_role_permission` VALUES (3, 5);
INSERT INTO `sys_role_permission` VALUES (1, 6);
INSERT INTO `sys_role_permission` VALUES (2, 6);
INSERT INTO `sys_role_permission` VALUES (3, 6);
INSERT INTO `sys_role_permission` VALUES (1, 7);
INSERT INTO `sys_role_permission` VALUES (2, 7);
INSERT INTO `sys_role_permission` VALUES (1, 8);
INSERT INTO `sys_role_permission` VALUES (2, 8);
INSERT INTO `sys_role_permission` VALUES (1, 9);
INSERT INTO `sys_role_permission` VALUES (2, 9);
INSERT INTO `sys_role_permission` VALUES (1, 10);
INSERT INTO `sys_role_permission` VALUES (2, 10);
INSERT INTO `sys_role_permission` VALUES (1, 11);
INSERT INTO `sys_role_permission` VALUES (2, 11);
INSERT INTO `sys_role_permission` VALUES (1, 12);
INSERT INTO `sys_role_permission` VALUES (2, 12);
INSERT INTO `sys_role_permission` VALUES (3, 12);
INSERT INTO `sys_role_permission` VALUES (1, 13);
INSERT INTO `sys_role_permission` VALUES (2, 13);
INSERT INTO `sys_role_permission` VALUES (3, 13);
INSERT INTO `sys_role_permission` VALUES (1, 14);
INSERT INTO `sys_role_permission` VALUES (2, 14);
INSERT INTO `sys_role_permission` VALUES (3, 14);
INSERT INTO `sys_role_permission` VALUES (1, 15);
INSERT INTO `sys_role_permission` VALUES (2, 15);
INSERT INTO `sys_role_permission` VALUES (3, 15);
INSERT INTO `sys_role_permission` VALUES (1, 16);
INSERT INTO `sys_role_permission` VALUES (2, 16);
INSERT INTO `sys_role_permission` VALUES (3, 16);
INSERT INTO `sys_role_permission` VALUES (1, 17);
INSERT INTO `sys_role_permission` VALUES (2, 17);
INSERT INTO `sys_role_permission` VALUES (3, 17);
INSERT INTO `sys_role_permission` VALUES (1, 18);
INSERT INTO `sys_role_permission` VALUES (2, 18);
INSERT INTO `sys_role_permission` VALUES (3, 18);
INSERT INTO `sys_role_permission` VALUES (1, 19);
INSERT INTO `sys_role_permission` VALUES (2, 19);
INSERT INTO `sys_role_permission` VALUES (3, 19);
INSERT INTO `sys_role_permission` VALUES (1, 20);
INSERT INTO `sys_role_permission` VALUES (2, 20);
INSERT INTO `sys_role_permission` VALUES (1, 21);
INSERT INTO `sys_role_permission` VALUES (2, 21);
INSERT INTO `sys_role_permission` VALUES (1, 22);
INSERT INTO `sys_role_permission` VALUES (2, 22);
INSERT INTO `sys_role_permission` VALUES (1, 23);
INSERT INTO `sys_role_permission` VALUES (2, 23);
INSERT INTO `sys_role_permission` VALUES (3, 23);
INSERT INTO `sys_role_permission` VALUES (1, 24);
INSERT INTO `sys_role_permission` VALUES (2, 24);
INSERT INTO `sys_role_permission` VALUES (3, 24);
INSERT INTO `sys_role_permission` VALUES (1, 25);
INSERT INTO `sys_role_permission` VALUES (2, 25);
INSERT INTO `sys_role_permission` VALUES (3, 25);
INSERT INTO `sys_role_permission` VALUES (1, 26);
INSERT INTO `sys_role_permission` VALUES (2, 26);
INSERT INTO `sys_role_permission` VALUES (3, 26);
INSERT INTO `sys_role_permission` VALUES (1, 27);
INSERT INTO `sys_role_permission` VALUES (2, 27);
INSERT INTO `sys_role_permission` VALUES (3, 27);
INSERT INTO `sys_role_permission` VALUES (1, 28);
INSERT INTO `sys_role_permission` VALUES (2, 28);
INSERT INTO `sys_role_permission` VALUES (3, 28);
INSERT INTO `sys_role_permission` VALUES (1, 29);
INSERT INTO `sys_role_permission` VALUES (2, 29);
INSERT INTO `sys_role_permission` VALUES (3, 29);
INSERT INTO `sys_role_permission` VALUES (1, 30);
INSERT INTO `sys_role_permission` VALUES (2, 30);
INSERT INTO `sys_role_permission` VALUES (1, 31);
INSERT INTO `sys_role_permission` VALUES (2, 31);
INSERT INTO `sys_role_permission` VALUES (1, 32);
INSERT INTO `sys_role_permission` VALUES (2, 32);
INSERT INTO `sys_role_permission` VALUES (1, 33);
INSERT INTO `sys_role_permission` VALUES (2, 33);
INSERT INTO `sys_role_permission` VALUES (1, 34);
INSERT INTO `sys_role_permission` VALUES (2, 34);
INSERT INTO `sys_role_permission` VALUES (1, 35);
INSERT INTO `sys_role_permission` VALUES (2, 35);
INSERT INTO `sys_role_permission` VALUES (1, 36);
INSERT INTO `sys_role_permission` VALUES (2, 36);
INSERT INTO `sys_role_permission` VALUES (1, 37);
INSERT INTO `sys_role_permission` VALUES (2, 37);
INSERT INTO `sys_role_permission` VALUES (1, 38);
INSERT INTO `sys_role_permission` VALUES (2, 38);
INSERT INTO `sys_role_permission` VALUES (1, 39);
INSERT INTO `sys_role_permission` VALUES (2, 39);
INSERT INTO `sys_role_permission` VALUES (1, 40);
INSERT INTO `sys_role_permission` VALUES (2, 40);
INSERT INTO `sys_role_permission` VALUES (1, 41);
INSERT INTO `sys_role_permission` VALUES (2, 41);
INSERT INTO `sys_role_permission` VALUES (1, 42);
INSERT INTO `sys_role_permission` VALUES (2, 42);
INSERT INTO `sys_role_permission` VALUES (1, 43);
INSERT INTO `sys_role_permission` VALUES (2, 43);
INSERT INTO `sys_role_permission` VALUES (1, 44);
INSERT INTO `sys_role_permission` VALUES (2, 44);
INSERT INTO `sys_role_permission` VALUES (1, 45);
INSERT INTO `sys_role_permission` VALUES (2, 45);
INSERT INTO `sys_role_permission` VALUES (1, 46);
INSERT INTO `sys_role_permission` VALUES (2, 46);
INSERT INTO `sys_role_permission` VALUES (1, 47);
INSERT INTO `sys_role_permission` VALUES (2, 47);
INSERT INTO `sys_role_permission` VALUES (1, 48);
INSERT INTO `sys_role_permission` VALUES (2, 48);
INSERT INTO `sys_role_permission` VALUES (1, 49);
INSERT INTO `sys_role_permission` VALUES (2, 49);
INSERT INTO `sys_role_permission` VALUES (1, 50);
INSERT INTO `sys_role_permission` VALUES (2, 50);
INSERT INTO `sys_role_permission` VALUES (1, 51);
INSERT INTO `sys_role_permission` VALUES (2, 51);
INSERT INTO `sys_role_permission` VALUES (1, 52);
INSERT INTO `sys_role_permission` VALUES (2, 52);
INSERT INTO `sys_role_permission` VALUES (1, 53);
INSERT INTO `sys_role_permission` VALUES (2, 53);
INSERT INTO `sys_role_permission` VALUES (1, 54);
INSERT INTO `sys_role_permission` VALUES (2, 54);
INSERT INTO `sys_role_permission` VALUES (1, 55);
INSERT INTO `sys_role_permission` VALUES (2, 55);
INSERT INTO `sys_role_permission` VALUES (1, 56);
INSERT INTO `sys_role_permission` VALUES (2, 56);
INSERT INTO `sys_role_permission` VALUES (1, 57);
INSERT INTO `sys_role_permission` VALUES (2, 57);
INSERT INTO `sys_role_permission` VALUES (1, 58);
INSERT INTO `sys_role_permission` VALUES (2, 58);
INSERT INTO `sys_role_permission` VALUES (1, 59);
INSERT INTO `sys_role_permission` VALUES (2, 59);
INSERT INTO `sys_role_permission` VALUES (1, 60);
INSERT INTO `sys_role_permission` VALUES (2, 60);
INSERT INTO `sys_role_permission` VALUES (1, 61);
INSERT INTO `sys_role_permission` VALUES (2, 61);
INSERT INTO `sys_role_permission` VALUES (1, 62);
INSERT INTO `sys_role_permission` VALUES (2, 62);
INSERT INTO `sys_role_permission` VALUES (1, 63);
INSERT INTO `sys_role_permission` VALUES (2, 63);
INSERT INTO `sys_role_permission` VALUES (1, 64);
INSERT INTO `sys_role_permission` VALUES (2, 64);
INSERT INTO `sys_role_permission` VALUES (1, 65);
INSERT INTO `sys_role_permission` VALUES (2, 65);
INSERT INTO `sys_role_permission` VALUES (1, 66);
INSERT INTO `sys_role_permission` VALUES (2, 66);
INSERT INTO `sys_role_permission` VALUES (1, 67);
INSERT INTO `sys_role_permission` VALUES (2, 67);
INSERT INTO `sys_role_permission` VALUES (1, 68);
INSERT INTO `sys_role_permission` VALUES (2, 68);
INSERT INTO `sys_role_permission` VALUES (1, 69);
INSERT INTO `sys_role_permission` VALUES (2, 69);
INSERT INTO `sys_role_permission` VALUES (1, 70);
INSERT INTO `sys_role_permission` VALUES (2, 70);
INSERT INTO `sys_role_permission` VALUES (1, 71);
INSERT INTO `sys_role_permission` VALUES (1, 72);
INSERT INTO `sys_role_permission` VALUES (1, 73);
INSERT INTO `sys_role_permission` VALUES (1, 74);
INSERT INTO `sys_role_permission` VALUES (1, 75);
INSERT INTO `sys_role_permission` VALUES (1, 76);
INSERT INTO `sys_role_permission` VALUES (1, 77);
INSERT INTO `sys_role_permission` VALUES (1, 78);
INSERT INTO `sys_role_permission` VALUES (1, 79);
INSERT INTO `sys_role_permission` VALUES (1, 80);
INSERT INTO `sys_role_permission` VALUES (1, 81);
INSERT INTO `sys_role_permission` VALUES (1, 82);
INSERT INTO `sys_role_permission` VALUES (1, 83);
INSERT INTO `sys_role_permission` VALUES (1, 84);
INSERT INTO `sys_role_permission` VALUES (1, 85);
INSERT INTO `sys_role_permission` VALUES (1, 86);
INSERT INTO `sys_role_permission` VALUES (1, 87);
INSERT INTO `sys_role_permission` VALUES (1, 88);
INSERT INTO `sys_role_permission` VALUES (1, 89);
INSERT INTO `sys_role_permission` VALUES (1, 90);
INSERT INTO `sys_role_permission` VALUES (1, 91);
INSERT INTO `sys_role_permission` VALUES (1, 92);
INSERT INTO `sys_role_permission` VALUES (1, 93);
INSERT INTO `sys_role_permission` VALUES (2, 93);
INSERT INTO `sys_role_permission` VALUES (1, 94);
INSERT INTO `sys_role_permission` VALUES (2, 94);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `user_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '编号',
  `user_password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录密码',
  `user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `user_number` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `user_position` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职位',
  `user_sex` tinyint NOT NULL DEFAULT 0 COMMENT '性别（0 男，1 女）',
  `user_birthday` date NULL DEFAULT NULL COMMENT '生日',
  `user_dept` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '部门',
  `user_entry_date` date NULL DEFAULT NULL COMMENT '入职时间',
  `user_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '在职状态',
  `user_id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `user_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '人员地址',
  `user_marry` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `user_edu` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学历状况',
  `user_health` datetime NULL DEFAULT NULL COMMENT '健康证到期',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `org_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '机构id',
  `role_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1006 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户表（员工表）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '2008-07-02 13:28:45', '2025-07-30 16:20:39', 0, 'N15287842664', '123456', '范子异', '17780291195', '技师', 1, '2002-07-01', '销售部', '2021-05-31', '在职', '121143010865901325', '中国深圳龙岗区布吉镇西环路764号34栋', '未知', '中专', '2026-05-01 00:00:00', NULL, 1, 2);
INSERT INTO `sys_user` VALUES (2, '2011-09-08 20:17:04', '2025-07-30 16:20:50', 0, 'N18637905636', '123456', '方睿', '16383008533', '店长', 1, '2002-06-05', '生产部', '2022-05-25', '在职', '617349663322097929', '中国深圳龙岗区布吉镇西环路661号华润大厦13室', '离婚', '本科', '2027-02-18 00:00:00', NULL, 1, 1);
INSERT INTO `sys_user` VALUES (3, '2014-04-10 19:01:11', '2025-07-29 15:03:35', 0, 'N13712240085', '123456', '叶子异', '13378919761', '技师', 0, '2008-06-01', '外销部', '2022-11-16', '在职', '138110260183953689', '中国中山京华商圈华夏街416号21栋', '未婚', '高中', '2027-11-28 12:58:46', NULL, 1, 1);
INSERT INTO `sys_user` VALUES (4, '2007-04-28 16:01:00', '2025-07-29 15:03:36', 0, 'N17730143584', '123456', '杨杰宏', '18466816204', '店长', 1, '2007-12-26', '采购部', '2021-07-02', '在职', '865382725400364299', '中国上海市徐汇区虹桥路934号43楼', '未婚', '初中', '2026-12-25 16:38:15', NULL, 1, 1);
INSERT INTO `sys_user` VALUES (5, '2004-06-01 08:03:10', '2025-07-29 15:03:36', 0, 'N19829147074', '123456', '邹云熙', '14940851972', '技师', 0, '2004-02-22', '法律部', '2018-05-03', '在职', '933203346855454776', '中国深圳龙岗区布吉镇西环路661号华润大厦40室', '已婚', '大专', '2025-01-26 09:13:55', NULL, 1, 1);
INSERT INTO `sys_user` VALUES (6, '2004-08-24 21:52:56', '2025-07-29 15:03:37', 0, 'N15071818806', '123456', '张秀英', '17656833836', '店长', 1, '2002-11-29', '信息技术支持部', '2021-05-29', '在职', '778711697582011731', '中国上海市浦东新区橄榄路869号华润大厦9室', '未婚', '高中', '2028-03-04 07:53:07', NULL, 1, 1);
INSERT INTO `sys_user` VALUES (7, '2000-08-12 23:26:34', '2025-07-30 16:15:32', 0, 'N19391148235', '123456', '钟震南', '15062576728', '技师', 1, '2003-08-30', '行政管理部', '2022-12-06', '在职', '871371477078461200', '中国东莞坑美十五巷261号华润大厦50室', '未婚', '高中', '2026-12-16 01:07:36', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (8, '2014-01-04 00:23:17', '2025-07-30 16:15:32', 0, 'N14180029465', '123456', '邱璐', '15967018211', '经理', 1, '2000-01-21', '工程部', '2019-09-30', '在职', '701554204011926076', '中国深圳福田区景田东一街578号17室', '未知', '大专', '2028-02-19 09:10:48', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (9, '2006-06-30 06:20:06', '2025-07-30 16:29:25', 0, 'N15829803033', '123456', '陆云熙', '17172486374', '技师', 1, '2000-05-08', '物流部', '2023-07-18', '离职', '239188030268570880', '中国上海市闵行区宾川路66号41楼', '未知', '本科', '2026-06-27 00:00:00', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (10, '2000-09-14 22:06:11', '2025-07-30 16:15:32', 0, 'N16289262879', '123456', '吴晓明', '15913255495', '经理', 0, '2009-11-24', '生产部', '2023-06-23', '在职', '023220272970739996', '中国北京市海淀区清河中街68号688号34栋', '已婚', '大专', '2025-02-05 11:01:05', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (11, '2022-04-28 08:48:48', '2025-08-16 21:04:09', 0, 'N15572555269', '123456', '朱晓明', '17586194155', '店长', 1, '2008-05-28', '人力资源部', '2024-09-26', '在职', '689567466650349024', '中国成都市锦江区红星路三段981号40室', '未知', '中专', '2027-02-13 00:00:00', NULL, 1, 1);
INSERT INTO `sys_user` VALUES (12, '2017-11-09 15:35:23', '2025-07-30 16:42:56', 0, 'N13475509405', '123456', '韦秀英', '14931481679', '店长', 0, '2004-05-16', '人力资源部', '2024-07-23', '在职', '275504568763872664', '中国东莞环区南街二巷833号26栋', '未婚', '大专', '2027-07-01 17:15:09', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (13, '2001-02-08 13:45:25', '2025-07-30 16:42:56', 0, 'N16960718809', '123456', '陈岚', '15920931586', '经理', 1, '2005-09-18', '工程部', '2022-08-12', '在职', '152442746577084915', '中国深圳龙岗区布吉镇西环路979号21室', '未婚', '本科', '2027-05-02 10:20:04', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (14, '2020-03-26 05:48:47', '2025-07-30 16:42:56', 0, 'N16452421309', '123456', '苏子异', '18473614608', '技师', 0, '2009-12-27', '生产部', '2019-08-14', '在职', '278963315395070848', '中国北京市西城区复兴门内大街969号12室', '离婚', '初中', '2028-02-20 17:06:19', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (15, '2017-07-22 18:20:26', '2025-07-30 16:42:57', 0, 'N19895189777', '123456', '汤震南', '14436694880', '店长', 1, '2000-06-05', '信息技术支持部', '2022-05-06', '在职', '704674157946342556', '中国广州市海珠区江南西路831号9栋', '离婚', '初中', '2027-12-31 18:52:03', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (16, '2012-11-25 18:29:45', '2025-07-30 16:42:57', 0, 'N17716469680', '123456', '萧云熙', '13157278979', '店长', 0, '2004-01-01', '信息技术支持部', '2018-07-18', '在职', '755204680247078576', '中国北京市西城区西長安街888号4号楼', '离婚', '中专', '2026-10-31 22:19:33', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (17, '2004-06-06 21:47:52', '2025-07-30 16:42:57', 0, 'N15020408083', '123456', '杜震南', '15527067686', '技师', 0, '2005-01-16', '行政管理部', '2024-04-28', '试用期', '478373452290969836', '中国北京市延庆区028县道209号45楼', '未知', '初中', '2027-07-25 00:00:00', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (18, '2022-03-22 14:34:59', '2025-07-30 16:42:57', 0, 'N13087901940', '123456', '龙子异', '14635715907', '店长', 0, '2002-03-20', '市场部', '2019-12-09', '在职', '993613299223799160', '中国成都市锦江区红星路三段602号33楼', '离婚', '本科', '2027-10-03 05:48:36', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (19, '2013-12-16 08:08:10', '2025-07-30 16:42:57', 0, 'N13192117064', '123456', '唐嘉伦', '16522887301', '技师', 1, '2009-10-21', '销售部', '2024-12-18', '停薪留职', '969743504552896001', '中国北京市海淀区清河中街68号963号49栋', '已婚', '高中', '2027-10-03 00:00:00', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (20, '2001-12-27 05:56:29', '2025-07-30 16:42:57', 0, 'N18942790236', '123456', '金震南', '18645552568', '店长', 0, '2005-08-28', '市场部', '2020-06-08', '在职', '964890934942642977', '中国深圳罗湖区蔡屋围深南东路255号19室', '离婚', '高中', '2026-07-01 10:17:58', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (21, '2000-10-13 06:41:07', '2025-07-30 16:42:57', 0, 'N18196185112', '123456', '曹詩涵', '15751102015', '经理', 1, '2001-11-02', '行政管理部', '2024-12-15', '在职', '840802422887754863', '中国北京市延庆区028县道675号22楼', '离婚', '初中', '2025-12-03 20:03:42', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (22, '2021-06-01 22:35:34', '2025-07-30 16:42:57', 0, 'N17513882038', '123456', '钟晓明', '16640513708', '技师', 0, '2006-01-11', '服务支持部', '2023-08-19', '在职', '534748869639244625', '中国上海市黄浦区淮海中路257号17号楼', '未婚', '本科', '2026-03-19 11:41:28', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (23, '2005-01-01 11:17:54', '2025-07-30 16:42:57', 0, 'N13681396239', '123456', '沈岚', '16474782601', '店长', 0, '2002-12-10', '行政管理部', '2018-04-24', '在职', '934752587939639153', '中国北京市延庆区028县道877号29号楼', '已婚', '中专', '2025-01-26 14:27:59', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (24, '2000-11-07 22:40:44', '2025-07-30 16:42:57', 0, 'N13718014479', '123456', '张晓明', '15761228256', '经理', 1, '2001-06-25', '公关部', '2022-03-23', '在职', '180213643489968692', '中国东莞环区南街二巷950号24室', '已婚', '本科', '2025-01-06 08:46:50', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (25, '2011-08-22 05:39:52', '2025-07-30 16:42:57', 0, 'N17091191148', '123456', '邱岚', '19107503228', '经理', 0, '2009-02-26', '服务支持部', '2023-11-12', '在职', '888007379043859989', '中国成都市成华区双庆路532号22室', '离婚', '高中', '2026-10-11 13:49:15', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (26, '2001-05-18 02:59:57', '2025-07-30 16:42:57', 0, 'N15118399936', '123456', '崔子韬', '16356715112', '经理', 1, '2004-02-25', '外销部', '2019-09-16', '在职', '105791599003448693', '中国东莞珊瑚路441号13室', '未婚', '本科', '2027-12-12 04:45:01', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (27, '2024-09-18 12:58:30', '2025-07-30 16:42:57', 0, 'N15072218643', '123456', '李晓明', '16657178094', '经理', 1, '2002-05-17', '公关部', '2021-01-19', '在职', '544840465941545204', '中国北京市西城区复兴门内大街335号40楼', '未婚', '高中', '2027-01-04 04:52:22', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (28, '2022-12-09 07:44:39', '2025-07-30 16:42:57', 0, 'N16263872772', '123456', '于睿', '18410515112', '经理', 1, '2002-04-22', '外销部', '2022-10-19', '在职', '517608552286423907', '中国深圳罗湖区田贝一路179号36楼', '未知', '初中', '2025-10-31 17:15:56', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (29, '2011-05-08 22:40:34', '2025-07-30 16:42:57', 0, 'N14120108098', '123456', '陈璐', '19905462309', '店长', 0, '2008-09-27', '法律部', '2023-08-02', '在职', '551992746384351726', '中国东莞坑美十五巷856号2栋', '未知', '本科', '2026-08-31 10:50:07', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (30, '2012-12-10 06:47:58', '2025-07-30 16:42:57', 0, 'N16398734561', '123456', '沈詩涵', '19704933048', '技师', 1, '2000-08-25', '外销部', '2021-06-24', '在职', '045589333643299445', '中国北京市朝阳区三里屯路514号41室', '未知', '初中', '2028-02-15 08:36:56', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (31, '2001-07-06 12:44:11', '2025-07-30 16:15:34', 0, 'N14163903969', '123456', '马晓明', '16349754372', '经理', 0, '2007-08-13', '会计及金融部', '2024-06-15', '在职', '522001120486135634', '中国北京市朝阳区三里屯路734号34号楼', '离婚', '中专', '2026-01-27 01:28:13', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (32, '2001-06-18 12:04:00', '2025-07-30 16:15:34', 0, 'N19403681571', '123456', '卢詩涵', '16171177415', '技师', 0, '2003-07-08', '会计及金融部', '2024-09-22', '在职', '587519198028271332', '中国深圳罗湖区蔡屋围深南东路305号33号楼', '未婚', '高中', '2027-05-28 20:31:38', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (33, '2012-07-25 08:21:54', '2025-07-30 16:15:34', 0, 'N13906500927', '123456', '邓震南', '18812626225', '技师', 1, '2002-05-27', '工程部', '2020-12-17', '在职', '117571299430190885', '中国广州市天河区天河路566号30室', '未知', '高中', '2028-05-01 16:04:43', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (34, '2010-06-09 09:09:21', '2025-07-30 16:15:34', 0, 'N16519480682', '123456', '董致远', '19080939042', '店长', 0, '2008-03-10', '会计及金融部', '2019-06-09', '在职', '512311052776564583', '中国广州市白云区小坪东路273号华润大厦50室', '离婚', '初中', '2027-02-18 11:14:22', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (35, '2024-05-14 09:48:48', '2025-07-30 16:15:34', 0, 'N16191724723', '123456', '江岚', '16194476718', '经理', 0, '2008-12-06', '会计及金融部', '2024-06-13', '在职', '492626585137069239', '中国深圳福田区景田东一街454号华润大厦47室', '已婚', '中专', '2026-12-14 22:04:07', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (36, '2007-09-05 06:07:59', '2025-07-30 16:15:34', 0, 'N16746343138', '123456', '孙岚', '16830931207', '经理', 0, '2006-02-21', '行政管理部', '2024-07-05', '在职', '386151109179722605', '中国深圳龙岗区学园一巷372号42楼', '未知', '初中', '2026-04-26 16:30:57', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (37, '2000-01-21 04:23:50', '2025-07-30 16:15:34', 0, 'N19237676358', '123456', '吴璐', '16453733736', '技师', 1, '2008-02-21', '法律部', '2019-04-24', '在职', '615399258189664664', '中国广州市越秀区中山二路692号华润大厦16室', '已婚', '初中', '2027-01-27 12:12:43', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (38, '2019-03-07 14:19:38', '2025-07-30 16:15:34', 0, 'N15465811002', '123456', '吕詩涵', '16214933568', '经理', 0, '2001-06-25', '人力资源部', '2019-07-06', '在职', '436052492394314773', '中国北京市西城区复兴门内大街255号36楼', '未婚', '中专', '2027-07-02 05:04:20', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (39, '2021-04-06 18:27:56', '2025-07-30 16:15:34', 0, 'N13662054541', '123456', '许晓明', '13556407205', '店长', 1, '2006-01-05', '采购部', '2021-08-09', '在职', '538835419176362279', '中国广州市越秀区中山二路532号华润大厦34室', '未知', '本科', '2027-10-05 11:25:04', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (40, '2019-01-06 20:54:13', '2025-07-30 16:15:34', 0, 'N19031485081', '123456', '唐岚', '17483163387', '店长', 0, '2008-04-23', '研究及开发部', '2022-02-07', '在职', '478858293627311866', '中国东莞环区南街二巷62号38号楼', '已婚', '初中', '2027-06-15 01:23:56', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (41, '2020-08-27 07:52:14', '2025-07-30 16:15:34', 0, 'N16113924006', '123456', '严子异', '16027006715', '技师', 1, '2005-01-02', '行政管理部', '2021-07-18', '在职', '773716041611724724', '中国成都市成华区双庆路873号华润大厦13室', '已婚', '本科', '2026-10-31 03:27:35', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (42, '2011-06-20 22:10:53', '2025-07-30 16:15:34', 0, 'N15191283158', '123456', '雷宇宁', '19962145294', '店长', 0, '2000-09-26', '会计及金融部', '2018-11-01', '在职', '088420976259842401', '中国成都市成华区玉双路6号558号38楼', '未婚', '高中', '2028-06-06 18:38:12', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (43, '2015-10-31 06:25:02', '2025-07-30 16:15:34', 0, 'N16804232570', '123456', '谭晓明', '15874108288', '技师', 1, '2001-09-10', '人力资源部', '2019-01-18', '在职', '701331722067346207', '中国成都市成华区二仙桥东三路879号45室', '未婚', '初中', '2028-05-02 08:38:07', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (44, '2005-07-14 08:09:56', '2025-07-30 16:15:34', 0, 'N14270759525', '123456', '江致远', '16185912350', '店长', 1, '2001-01-26', '采购部', '2025-04-04', '在职', '847716155481347378', '中国东莞坑美十五巷132号华润大厦21室', '已婚', '大专', '2025-12-10 08:36:46', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (45, '2002-04-05 11:23:55', '2025-07-30 16:15:35', 0, 'N16388682181', '123456', '邱晓明', '16880362532', '经理', 1, '2002-09-10', '工程部', '2020-10-17', '在职', '017474218653416788', '中国深圳罗湖区田贝一路600号11号楼', '已婚', '初中', '2027-04-26 15:12:02', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (46, '2023-01-20 12:32:37', '2025-07-30 16:15:35', 0, 'N17969256355', '123456', '陈云熙', '19210042421', '店长', 0, '2009-01-09', '外销部', '2021-07-01', '在职', '311388151536673405', '中国北京市东城区东单王府井东街824号19室', '未知', '中专', '2026-11-09 07:32:15', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (47, '2011-01-07 07:57:01', '2025-07-30 16:15:35', 0, 'N19047738907', '123456', '蒋晓明', '16795039843', '店长', 0, '2002-04-23', '行政管理部', '2020-06-22', '在职', '953157843519297430', '中国广州市天河区天河路325号38栋', '已婚', '高中', '2027-07-19 18:32:48', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (48, '2013-12-26 03:39:43', '2025-07-30 16:15:35', 0, 'N14617041749', '123456', '范致远', '18969168783', '店长', 1, '2000-11-13', '研究及开发部', '2024-05-13', '在职', '467641486848212175', '中国深圳福田区深南大道498号1栋', '未知', '中专', '2027-06-29 09:38:37', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (49, '2000-09-19 07:36:26', '2025-07-30 16:15:35', 0, 'N14343821574', '123456', '汪子异', '14231264423', '店长', 1, '2008-03-27', '会计及金融部', '2023-09-03', '在职', '056805832411213663', '中国广州市白云区机场路棠苑街五巷47号17号楼', '未婚', '本科', '2025-02-15 23:47:12', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (50, '2007-12-31 20:24:42', '2025-07-30 16:15:35', 0, 'N14371393731', '123456', '张嘉伦', '13344102534', '技师', 1, '2001-04-17', '产品质量部', '2023-05-08', '在职', '553804480355740581', '中国成都市锦江区人民南路四段621号华润大厦25室', '离婚', '大专', '2026-02-10 20:16:50', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (1001, '2025-07-22 14:04:13', '2025-07-30 16:15:35', 0, 'N14371393732', '123456', '六六', '13344445555', '店长', 0, '2025-07-22', '技师部', '2025-07-22', '在职', '467641486848212173', '中国成都市锦江区人民南路四段621号华润大厦25室', '未婚', '本科', '2025-07-22 14:04:02', NULL, 2, 5);
INSERT INTO `sys_user` VALUES (1002, '2025-07-27 15:16:44', '2025-07-30 16:15:35', 0, 'EMP001', 'password123', '张三', '13800138000', '店长', 1, '1990-01-01', '管理部', '2020-01-01', '在职', '110101199001011234', '北京市朝阳区', '已婚', '本科', '2025-12-31 00:00:00', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (1003, '2025-07-27 17:31:17', '2025-07-30 16:15:35', 0, 'EMP002', 'password123', '787878', '13800138000', '店长', 1, '1990-01-01', '管理部', '2020-01-01', '在职', '110101199001011234', '北京市朝阳区', '已婚', '本科', '2025-12-31 00:00:00', NULL, 1, 5);
INSERT INTO `sys_user` VALUES (1004, '2025-07-29 15:39:22', '2025-07-29 15:54:56', 0, 'EMP121', 'password123', '张三', '13800138000', '店长', 1, '1990-01-01', '管理部', '2020-01-01', '在职', '110101199001011234', '北京市朝阳区', '已婚', '本科', '2025-12-31 00:00:00', NULL, 1, 3);
INSERT INTO `sys_user` VALUES (1005, '2025-07-29 15:55:22', '2025-07-29 15:55:22', 0, 'EMP041', 'password123', '张三', '13800138000', '店长', 1, '1990-01-01', '管理部', '2020-01-01', '在职', '110101199001011234', '北京市朝阳区', '已婚', '本科', '2025-12-31 00:00:00', NULL, 1, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户id',
  `role_id` bigint UNSIGNED NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `fk_sys_user_role_sys_role_1`(`role_id` ASC) USING BTREE,
  CONSTRAINT `fk_sys_user_role_sys_role_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_sys_user_role_sys_user_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (2, 1);
INSERT INTO `sys_user_role` VALUES (11, 1);
INSERT INTO `sys_user_role` VALUES (1, 2);

-- ----------------------------
-- Table structure for vip_asset
-- ----------------------------
DROP TABLE IF EXISTS `vip_asset`;
CREATE TABLE `vip_asset`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `asset_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资产编号',
  `asset_balance` decimal(10, 2) NULL DEFAULT NULL COMMENT '余额',
  `asset_type` tinyint NULL DEFAULT NULL COMMENT '资产类型（0 充值，1 赠送）',
  `asset_discount_base` tinyint NULL DEFAULT NULL COMMENT '折扣基础（0 标准价，1 会员价）',
  `asset_discount_rate` int NULL DEFAULT NULL COMMENT '折扣率',
  `asset_is_cross_store` tinyint(1) NULL DEFAULT NULL COMMENT '跨店消费（0 不允许，1 允许）',
  `asset_card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '实体卡号',
  `vip_id` bigint NULL DEFAULT NULL COMMENT '会员id',
  `org_id` bigint NULL DEFAULT NULL COMMENT '门店id',
  `version` int NOT NULL DEFAULT 1 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员资产表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_asset
-- ----------------------------
INSERT INTO `vip_asset` VALUES (1, NULL, NULL, 0, NULL, NULL, 999.99, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1);
INSERT INTO `vip_asset` VALUES (4, '2025-08-25 23:58:11', '2025-08-25 23:58:11', 0, NULL, 'A17561374909893859', 500.00, 0, NULL, 80, 1, NULL, 3, 1, 1);
INSERT INTO `vip_asset` VALUES (5, '2025-08-26 00:08:19', '2025-08-26 00:08:19', 0, NULL, 'A17561380988775628', 500.00, 0, NULL, 80, 1, NULL, 3, 1, 1);
INSERT INTO `vip_asset` VALUES (6, '2025-08-26 00:12:21', '2025-08-26 00:12:21', 0, NULL, 'A17561383408781603', 500.00, 0, 0, 80, 1, NULL, 3, 1, 1);
INSERT INTO `vip_asset` VALUES (9, '2025-08-26 14:30:52', '2025-08-26 14:30:52', 0, NULL, 'A17561898522237448', 1000.00, 0, 1, 80, 1, NULL, 4, 1, 1);
INSERT INTO `vip_asset` VALUES (10, '2025-08-26 14:47:56', '2025-08-26 15:47:56', 0, NULL, 'A17561908755144855', 1000.00, 0, 0, 80, 1, NULL, 13, 1, 1);
INSERT INTO `vip_asset` VALUES (11, '2025-08-26 14:47:56', '2025-08-26 14:47:56', 0, NULL, 'A17561908755916359', 200.00, 1, NULL, NULL, NULL, NULL, 13, 1, 1);
INSERT INTO `vip_asset` VALUES (14, '2025-08-26 15:41:28', '2025-08-26 15:47:45', 0, NULL, 'A17561940881394134', 1000.00, 0, 0, 80, 1, NULL, 17, 1, 1);
INSERT INTO `vip_asset` VALUES (15, '2025-08-26 15:41:28', '2025-08-26 15:41:28', 0, NULL, 'A17561940882064451', 200.00, 1, 0, 80, 1, NULL, 17, 1, 1);
INSERT INTO `vip_asset` VALUES (17, '2025-08-26 16:01:41', '2025-08-26 16:01:41', 0, NULL, 'A17561953009342215', 1000.00, 0, 0, 80, 1, NULL, 17, 1, 1);
INSERT INTO `vip_asset` VALUES (18, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, NULL, 'A17562004049233976', 1000.00, 0, 0, 80, 1, NULL, 17, 1, 1);
INSERT INTO `vip_asset` VALUES (19, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, NULL, 'A17562016786553823', 1000.00, 0, 0, 80, 1, NULL, 17, 1, 1);
INSERT INTO `vip_asset` VALUES (20, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, NULL, 'A17562020537134219', 1000.00, 0, 0, 80, 1, NULL, 17, 1, 1);
INSERT INTO `vip_asset` VALUES (21, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, NULL, 'A17562020537839256', 200.00, 1, 0, 100, 1, NULL, 17, 1, 1);
INSERT INTO `vip_asset` VALUES (22, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, NULL, 'A17564375885085749', 1000.00, 0, 0, 80, 1, NULL, 17, 1, 1);
INSERT INTO `vip_asset` VALUES (23, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, NULL, 'A17564376618805362', 1000.00, 0, 0, 80, 1, NULL, 17, 1, 1);
INSERT INTO `vip_asset` VALUES (24, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, NULL, 'A17564503346242628', 1000.00, 0, 0, 80, 1, NULL, 17, 1, 1);

-- ----------------------------
-- Table structure for vip_info
-- ----------------------------
DROP TABLE IF EXISTS `vip_info`;
CREATE TABLE `vip_info`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `gender` tinyint NULL DEFAULT NULL COMMENT '性别（0 男，1 女）',
  `card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员卡号',
  `identity` tinyint NOT NULL DEFAULT 0 COMMENT '会员身份',
  `phone_number` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话号码',
  `last_consumption_time` date NULL DEFAULT NULL COMMENT '末次消费日期',
  `last_recharge_time` date NULL DEFAULT NULL COMMENT '末次充值时间',
  `balance` decimal(10, 2) NULL DEFAULT NULL COMMENT '店内总余额',
  `birthday` date NULL DEFAULT NULL COMMENT '会员生日',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员地址',
  `pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员密码',
  `org_id` bigint NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1002 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_info
-- ----------------------------
INSERT INTO `vip_info` VALUES (1, '2003-02-22 12:49:54', '2025-07-03 18:28:25', 1, NULL, '駱梓晴', 0, 'CA-FD-4445-Q', 0, '13545581994', '2009-06-19', '2010-11-18', 267.03, '2000-10-28', '中国上海市浦东新区橄榄路839号29室', '123456', 1);
INSERT INTO `vip_info` VALUES (2, '2006-03-18 05:25:09', '2005-10-24 07:53:42', 1, NULL, '徐慧琳', 0, 'DC-DE-4834-V', 0, '14684863000', '2014-06-02', '2002-08-15', 635.99, '2020-12-20', '中国上海市徐汇区虹桥路745号22号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (3, '2018-03-07 15:21:17', '2025-08-02 17:03:43', 0, NULL, '元俊宇', 0, 'FC-CD-3149-L', 0, '18181381423', '2022-06-16', '2007-12-06', 457.40, '2010-07-08', '中国北京市東城区東直門內大街995号36号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (4, '2020-07-17 20:20:43', '2025-08-26 14:30:52', 0, NULL, '李秀英', 0, 'CD-CE-9484-O', 0, '13552515356', '2015-01-17', '2023-12-25', 1000.00, '2011-02-14', '中国深圳罗湖区清水河一路127号华润大厦23室', '123456', 1);
INSERT INTO `vip_info` VALUES (5, '2004-09-09 21:06:22', '2020-11-27 15:21:07', 1, NULL, '胡詠詩', 0, 'CA-DC-6835-M', 0, '16833238723', '2001-07-20', '2000-12-28', 405.39, '2002-05-27', '中国深圳福田区景田东一街802号42栋', '123456', 1);
INSERT INTO `vip_info` VALUES (6, '2008-04-18 06:54:29', '2020-01-26 20:22:48', 0, NULL, '郝杰宏', 1, 'BA-FB-8600-K', 0, '17719861665', '2003-11-10', '2024-04-15', 256.61, '2007-11-02', '中国北京市朝阳区三里屯路204号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (7, '2006-10-10 02:46:48', '2005-12-26 00:22:38', 0, NULL, '雷慧琳', 0, 'CA-DC-7835-O', 0, '16074902677', '2013-03-10', '2024-02-04', 984.89, '2012-10-16', '中国深圳龙岗区布吉镇西环路34号32号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (8, '2020-05-17 01:44:01', '2007-07-24 15:38:22', 0, NULL, '龙睿', 0, 'CF-EC-3936-T', 0, '18847483257', '2010-04-13', '2004-04-10', 398.98, '2021-01-02', '中国北京市东城区东单王府井东街852号27栋', '123456', 1);
INSERT INTO `vip_info` VALUES (9, '2006-04-04 11:41:05', '2002-02-08 03:07:11', 1, NULL, '黄璐', 0, 'AE-DE-1093-S', 0, '19217491313', '2015-08-30', '2019-12-29', 259.13, '2005-04-11', '中国中山京华商圈华夏街323号26楼', '123456', 1);
INSERT INTO `vip_info` VALUES (10, '2012-09-24 23:52:25', '2007-01-26 07:37:48', 1, NULL, '段云熙', 0, 'AF-EC-6456-Y', 0, '16722761432', '2004-06-03', '2003-12-13', 63.13, '2007-05-16', '中国北京市东城区东单王府井东街648号39室', '123456', 1);
INSERT INTO `vip_info` VALUES (11, '2023-03-22 05:28:06', '2013-09-30 20:57:32', 1, NULL, '文麗欣', 0, 'DB-ED-7625-K', 0, '18687761052', '2005-11-16', '2025-03-07', 568.65, '2001-06-09', '中国中山天河区大信商圈大信南路778号10楼', '123456', 1);
INSERT INTO `vip_info` VALUES (12, '2010-02-18 15:41:53', '2019-03-08 06:24:59', 1, NULL, '孙秀英', 1, 'BA-DA-1649-E', 0, '15732437004', '2016-12-12', '2000-12-09', 44.21, '2003-03-21', '中国中山乐丰六路113号35栋', '123456', 1);
INSERT INTO `vip_info` VALUES (13, '2017-04-20 12:51:59', '2025-08-26 14:47:56', 0, NULL, '韦晓明', 1, 'AF-BB-1848-G', 0, '16676896210', '2019-07-27', '2022-01-14', 1200.00, '2015-11-26', '中国北京市延庆区028县道938号华润大厦12室', '123456', 1);
INSERT INTO `vip_info` VALUES (14, '2002-05-22 08:10:29', '2009-01-22 05:38:34', 1, NULL, '尹岚', 1, 'AF-DA-3394-F', 0, '13363886372', '2012-04-22', '2017-05-13', 460.87, '2024-05-17', '中国北京市西城区西長安街302号48栋', '123456', 1);
INSERT INTO `vip_info` VALUES (15, '2022-10-22 01:36:57', '2003-03-11 21:19:01', 1, NULL, '唐慧琳', 0, 'BF-AC-8857-D', 0, '17466655785', '2021-05-30', '2013-05-26', 552.69, '2025-04-16', '中国上海市浦东新区健祥路636号12室', '123456', 1);
INSERT INTO `vip_info` VALUES (16, '2007-01-19 00:30:01', '2020-10-12 04:27:20', 1, NULL, '杨璐', 0, 'DC-CD-0253-J', 0, '16406466732', '2013-11-04', '2010-04-28', 469.36, '2013-02-07', '中国成都市成华区玉双路6号678号2栋', '123456', 1);
INSERT INTO `vip_info` VALUES (17, '2001-12-14 04:04:00', '2025-08-29 14:52:14', 0, NULL, '區家明', 0, 'FD-BE-6193-M', 0, '17909590614', '2023-08-26', '2025-08-29', 8400.00, '2013-10-21', '中国广州市白云区小坪东路532号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (18, '2025-01-09 13:01:23', '2016-09-06 07:57:00', 0, NULL, '任子异', 1, 'DC-AC-3848-D', 0, '14714469607', '2012-03-28', '2021-07-25', 793.74, '2008-09-07', '中国成都市锦江区人民南路四段66号40楼', '123456', 1);
INSERT INTO `vip_info` VALUES (19, '2021-09-09 05:23:19', '2025-03-29 08:19:27', 1, NULL, '贾震南', 1, 'EB-AC-4844-A', 0, '15948115063', '2008-09-01', '2009-08-18', 422.98, '2021-07-14', '中国广州市天河区天河路596号37室', '123456', 1);
INSERT INTO `vip_info` VALUES (20, '2017-12-22 08:08:03', '2006-02-25 16:17:05', 1, NULL, '陶璐', 1, 'EC-FC-6852-M', 0, '16583935959', '2018-12-01', '2008-06-08', 221.40, '2023-04-01', '中国上海市闵行区宾川路265号7栋', '123456', 1);
INSERT INTO `vip_info` VALUES (21, '2001-09-09 20:41:57', '2021-12-29 15:46:14', 1, NULL, '范睿', 1, 'AD-BA-6579-A', 0, '18022467912', '2021-11-24', '2023-09-27', 699.89, '2006-12-19', '中国北京市西城区西長安街148号华润大厦38室', '123456', 1);
INSERT INTO `vip_info` VALUES (22, '2024-04-11 08:28:31', '2015-09-27 16:04:04', 0, NULL, '區青雲', 0, 'BC-EE-4231-L', 0, '17742774394', '2017-04-11', '2017-05-24', 100.80, '2009-10-21', '中国成都市锦江区人民南路四段450号27栋', '123456', 1);
INSERT INTO `vip_info` VALUES (23, '2004-07-04 12:51:04', '2011-12-01 03:15:11', 0, NULL, '元梓晴', 1, 'CD-FD-7091-A', 0, '14456194889', '2024-11-18', '2013-08-07', 926.98, '2011-09-12', '中国上海市浦东新区健祥路353号25号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (24, '2012-08-19 02:03:09', '2018-09-10 05:14:57', 0, NULL, '袁頴思', 1, 'AD-AE-2475-Y', 0, '16332434936', '2011-06-10', '2000-06-20', 980.79, '2006-01-15', '中国成都市锦江区人民南路四段929号24室', '123456', 1);
INSERT INTO `vip_info` VALUES (25, '2015-09-11 03:56:05', '2008-07-03 08:28:47', 0, NULL, '阮國權', 1, 'FC-FB-4223-N', 0, '17408642162', '2005-09-07', '2016-06-01', 496.99, '2007-11-14', '中国上海市黄浦区淮海中路346号37栋', '123456', 1);
INSERT INTO `vip_info` VALUES (26, '2019-09-20 05:26:30', '2006-03-29 18:09:32', 1, NULL, '郭子异', 1, 'CC-EB-6228-O', 0, '16376386483', '2016-11-03', '2010-05-13', 133.18, '2016-11-19', '中国中山乐丰六路74号20号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (27, '2021-08-18 11:45:47', '2015-03-12 04:50:03', 0, NULL, '蘇玲玲', 0, 'BA-DA-1667-R', 0, '15323189218', '2002-08-04', '2012-04-06', 879.03, '2015-10-02', '中国深圳福田区深南大道86号43号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (28, '2011-10-02 06:10:46', '2001-03-13 08:07:37', 1, NULL, '卢宇宁', 1, 'FE-FD-4801-K', 0, '19061277990', '2023-12-25', '2017-01-31', 244.95, '2024-01-02', '中国上海市闵行区宾川路554号42楼', '123456', 1);
INSERT INTO `vip_info` VALUES (29, '2016-12-19 08:04:55', '2022-10-27 17:07:31', 0, NULL, '應祖兒', 1, 'DA-BA-9547-N', 0, '15374756136', '2010-06-21', '2017-06-08', 250.20, '2002-02-17', '中国深圳罗湖区蔡屋围深南东路806号华润大厦25室', '123456', 1);
INSERT INTO `vip_info` VALUES (30, '2018-01-18 01:08:36', '2013-04-25 16:14:25', 1, NULL, '馮明', 0, 'FF-FC-9138-E', 0, '15374972278', '2016-11-20', '2008-02-11', 946.97, '2005-12-22', '中国广州市白云区小坪东路470号华润大厦19室', '123456', 1);
INSERT INTO `vip_info` VALUES (31, '2023-12-08 18:40:55', '2020-08-25 08:27:45', 0, NULL, '邱仲賢', 0, 'CB-BA-0598-R', 0, '19566493378', '2022-01-06', '2018-05-28', 840.56, '2015-02-12', '中国深圳龙岗区布吉镇西环路223号7号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (32, '2002-02-19 03:16:53', '2019-05-31 01:41:25', 0, NULL, '姚富城', 0, 'DE-FE-7590-W', 0, '16610639114', '2014-08-17', '2021-10-26', 12.76, '2002-09-20', '中国广州市海珠区江南西路47号35栋', '123456', 1);
INSERT INTO `vip_info` VALUES (33, '2008-06-05 23:13:10', '2022-02-22 22:26:52', 1, NULL, '溫俊宇', 1, 'FB-DD-9601-V', 0, '18854340266', '2023-11-22', '2021-11-01', 30.04, '2013-12-13', '中国深圳罗湖区蔡屋围深南东路581号22号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (34, '2006-02-20 22:54:48', '2009-07-13 05:41:03', 0, NULL, '武詩涵', 0, 'BB-AB-7509-K', 0, '18615606429', '2008-05-18', '2020-10-21', 845.08, '2008-08-13', '中国成都市成华区玉双路6号611号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (35, '2025-02-06 13:04:39', '2022-04-15 14:16:58', 1, NULL, '許青雲', 0, 'AF-DE-1251-L', 0, '15795968230', '2013-10-11', '2010-09-11', 722.27, '2020-01-09', '中国中山紫马岭商圈中山五路145号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (36, '2015-09-22 12:14:45', '2024-08-19 17:13:53', 1, NULL, '白慧嫻', 0, 'EB-DA-3737-M', 0, '13438215802', '2019-12-14', '2003-12-12', 522.09, '2010-02-15', '中国深圳罗湖区田贝一路750号13号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (37, '2013-12-03 22:11:20', '2004-08-23 05:32:01', 1, NULL, '姜祖兒', 1, 'EC-BC-3237-N', 0, '18733382908', '2023-01-05', '2003-02-17', 411.66, '2021-05-23', '中国深圳罗湖区清水河一路127号华润大厦13室', '123456', 1);
INSERT INTO `vip_info` VALUES (38, '2002-11-10 09:25:48', '2006-11-20 03:40:36', 0, NULL, '吕子异', 1, 'CA-EC-1683-S', 0, '14929261378', '2006-08-28', '2012-03-03', 901.52, '2007-10-24', '中国广州市海珠区江南西路556号14室', '123456', 1);
INSERT INTO `vip_info` VALUES (39, '2000-07-05 22:14:12', '2023-11-02 01:03:31', 1, NULL, '蕭明', 0, 'DF-FE-1486-H', 0, '14320783528', '2007-07-23', '2018-09-03', 713.64, '2008-01-24', '中国北京市西城区复兴门内大街794号11楼', '123456', 1);
INSERT INTO `vip_info` VALUES (40, '2025-02-16 04:01:39', '2020-01-27 23:19:42', 1, NULL, '湯國賢', 0, 'FA-DC-1096-E', 0, '13635308092', '2024-09-07', '2006-01-04', 935.26, '2019-10-05', '中国深圳罗湖区清水河一路343号7栋', '123456', 1);
INSERT INTO `vip_info` VALUES (41, '2003-02-04 23:17:38', '2025-07-12 22:19:05', 0, NULL, '毛云熙', 1, 'AA-FA-4286-K', 0, '13347794862', '2017-06-03', '2016-02-17', 491.14, '2013-02-25', '中国东莞环区南街二巷180号华润大厦22室', '123456', 1);
INSERT INTO `vip_info` VALUES (42, '2007-02-12 20:12:52', '2007-11-26 15:44:46', 0, NULL, '古世榮', 0, 'AC-AA-4788-M', 0, '19067612699', '2021-12-18', '2023-03-15', 35.26, '2003-01-18', '中国北京市房山区岳琉路125号45室', '123456', 1);
INSERT INTO `vip_info` VALUES (43, '2016-06-04 12:15:42', '2024-12-02 08:47:23', 1, NULL, '阮俊宇', 1, 'FC-BC-3585-B', 0, '18056888468', '2011-11-05', '2012-02-11', 760.83, '2015-08-28', '中国深圳龙岗区布吉镇西环路356号8楼', '123456', 1);
INSERT INTO `vip_info` VALUES (44, '2024-05-04 07:58:25', '2008-05-20 07:23:01', 1, NULL, '鄧潤發', 1, 'AE-AB-0753-R', 0, '14661046445', '2001-11-29', '2007-08-04', 456.44, '2022-11-21', '中国东莞珊瑚路510号43栋', '123456', 1);
INSERT INTO `vip_info` VALUES (45, '2009-10-30 00:31:57', '2004-07-13 04:25:02', 1, NULL, '錢曉彤', 0, 'AF-FA-8727-Y', 0, '19371002126', '2022-07-12', '2001-12-20', 445.85, '2022-06-15', '中国深圳罗湖区清水河一路196号22楼', '123456', 1);
INSERT INTO `vip_info` VALUES (46, '2011-04-02 12:01:17', '2003-06-09 01:42:11', 0, NULL, '段云熙', 0, 'CC-AD-8229-F', 0, '16907334634', '2016-12-07', '2019-08-01', 759.30, '2015-03-02', '中国东莞珊瑚路948号35室', '123456', 1);
INSERT INTO `vip_info` VALUES (47, '2021-05-17 15:45:02', '2002-11-30 07:54:45', 1, NULL, '夏宇宁', 1, 'BD-AA-2623-M', 0, '16476879171', '2003-12-12', '2021-10-02', 644.70, '2001-02-24', '中国深圳罗湖区田贝一路973号华润大厦19室', '123456', 1);
INSERT INTO `vip_info` VALUES (48, '2004-06-11 01:23:15', '2008-07-20 05:22:38', 0, NULL, '駱仲賢', 1, 'DD-AF-0915-P', 0, '14927327398', '2017-06-27', '2018-08-26', 203.88, '2012-04-03', '中国深圳龙岗区学园一巷538号2楼', '123456', 1);
INSERT INTO `vip_info` VALUES (49, '2015-04-20 03:05:50', '2014-04-24 03:13:49', 0, NULL, '魏杰宏', 1, 'ED-EF-6953-M', 0, '18309918445', '2021-03-21', '2000-04-20', 925.78, '2025-04-22', '中国深圳龙岗区学园一巷199号50栋', '123456', 1);
INSERT INTO `vip_info` VALUES (50, '2023-05-14 20:36:05', '2011-02-11 19:13:45', 1, NULL, '李晓明', 0, 'BD-FD-4026-C', 0, '18362382620', '2004-12-08', '2010-04-14', 254.32, '2008-04-16', '中国深圳罗湖区田贝一路360号21栋', '123456', 1);
INSERT INTO `vip_info` VALUES (51, '2021-05-20 04:12:50', '2005-03-04 13:33:50', 1, NULL, '苏子异', 1, 'DB-DD-5688-J', 0, '14194071271', '2019-03-27', '2002-11-06', 807.56, '2018-08-02', '中国中山天河区大信商圈大信南路74号华润大厦22室', '123456', 1);
INSERT INTO `vip_info` VALUES (52, '2009-07-13 09:58:19', '2002-08-21 21:36:02', 1, NULL, '樂永權', 1, 'BC-FD-1731-M', 0, '18681701165', '2009-12-08', '2001-11-22', 120.81, '2020-12-22', '中国广州市天河区天河路155号5号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (53, '2011-09-06 09:54:23', '2025-02-04 05:27:22', 0, NULL, '曾詩君', 0, 'EA-EF-4713-U', 0, '15082417256', '2011-05-28', '2020-04-17', 673.47, '2019-03-24', '中国东莞坑美十五巷575号46室', '123456', 1);
INSERT INTO `vip_info` VALUES (54, '2007-03-04 03:12:57', '2012-04-20 22:24:41', 1, NULL, '宋震南', 1, 'AB-BC-2960-J', 0, '17819778326', '2001-05-10', '2008-08-25', 765.55, '2009-10-23', '中国北京市朝阳区三里屯路733号21栋', '123456', 1);
INSERT INTO `vip_info` VALUES (55, '2019-06-15 15:37:51', '2014-02-03 03:18:16', 1, NULL, '徐云熙', 0, 'BE-CC-3320-T', 0, '14226783852', '2005-07-16', '2007-04-12', 91.31, '2019-03-04', '中国北京市延庆区028县道522号4楼', '123456', 1);
INSERT INTO `vip_info` VALUES (56, '2015-10-19 17:01:59', '2004-11-14 06:36:43', 0, NULL, '盧世榮', 0, 'ED-AA-6065-M', 0, '17757215436', '2013-01-30', '2000-11-11', 549.22, '2001-09-10', '中国中山京华商圈华夏街931号21室', '123456', 1);
INSERT INTO `vip_info` VALUES (57, '2002-06-29 07:25:46', '2020-11-19 12:31:25', 1, NULL, '邱致远', 1, 'EF-DE-9548-R', 0, '13175956325', '2002-02-06', '2020-02-05', 298.27, '2010-06-30', '中国中山京华商圈华夏街979号32楼', '123456', 1);
INSERT INTO `vip_info` VALUES (58, '2012-12-09 17:02:07', '2015-02-24 06:32:06', 0, NULL, '戴云熙', 0, 'DA-BB-2968-O', 0, '17267837172', '2024-11-14', '2019-06-19', 188.13, '2000-12-10', '中国深圳福田区深南大道831号30号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (59, '2022-02-05 02:26:26', '2018-06-27 16:07:42', 1, NULL, '陈子异', 1, 'DA-FB-3321-S', 0, '15381260583', '2000-06-01', '2005-12-19', 947.31, '2007-10-22', '中国东莞东泰五街131号50室', '123456', 1);
INSERT INTO `vip_info` VALUES (60, '2014-01-08 22:46:19', '2003-09-12 01:16:25', 0, NULL, '吳慧嫻', 0, 'DB-CF-8537-C', 0, '14864079900', '2017-07-25', '2017-07-19', 716.96, '2019-01-06', '中国北京市西城区复兴门内大街690号15栋', '123456', 1);
INSERT INTO `vip_info` VALUES (61, '2007-12-19 05:08:47', '2025-07-13 22:07:42', 0, NULL, '余子异', 0, 'FD-CB-7382-J', 0, '13666387181', '2001-06-28', '2010-02-16', 521.08, '2011-02-08', '中国成都市成华区玉双路6号842号46楼', '123456', 1);
INSERT INTO `vip_info` VALUES (62, '2016-04-02 03:18:31', '2019-07-22 08:43:56', 1, NULL, '戚慧嫻', 0, 'DD-CD-3621-V', 0, '18157936188', '2000-08-16', '2006-02-04', 136.55, '2022-08-23', '中国东莞坑美十五巷903号41楼', '123456', 1);
INSERT INTO `vip_info` VALUES (63, '2008-06-07 20:29:20', '2000-01-23 15:23:06', 0, NULL, '魏云熙', 1, 'FA-CE-5015-Z', 0, '16240635046', '2001-03-05', '2009-12-28', 728.01, '2002-04-29', '中国上海市闵行区宾川路662号华润大厦9室', '123456', 1);
INSERT INTO `vip_info` VALUES (64, '2007-05-15 13:35:35', '2016-03-16 03:28:22', 1, NULL, '傅頴思', 0, 'FA-EE-0088-X', 0, '15903312278', '2020-01-24', '2016-12-10', 265.59, '2005-11-20', '中国东莞东泰五街840号40号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (65, '2007-01-22 01:53:05', '2010-07-13 12:51:45', 1, NULL, '樊秀文', 0, 'BE-BF-8402-M', 0, '15164401036', '2006-06-05', '2005-07-26', 483.78, '2018-08-17', '中国北京市朝阳区三里屯路685号12号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (66, '2007-10-02 13:41:26', '2006-03-23 04:14:12', 0, NULL, '张杰宏', 1, 'BA-AF-3263-L', 0, '15663073426', '2010-10-27', '2011-11-12', 754.20, '2023-07-04', '中国深圳龙岗区布吉镇西环路392号35栋', '123456', 1);
INSERT INTO `vip_info` VALUES (67, '2001-07-05 14:01:22', '2021-09-02 22:24:21', 1, NULL, '金秀英', 1, 'FF-FC-6085-S', 0, '18551337650', '2019-07-02', '2010-02-04', 575.08, '2000-11-27', '中国成都市锦江区人民南路四段883号华润大厦47室', '123456', 1);
INSERT INTO `vip_info` VALUES (68, '2007-08-05 21:35:11', '2007-08-24 00:41:08', 1, NULL, '韦璐', 1, 'EE-AB-7497-S', 0, '18352816890', '2006-02-01', '2008-04-10', 536.95, '2003-12-16', '中国成都市成华区玉双路6号291号华润大厦25室', '123456', 1);
INSERT INTO `vip_info` VALUES (69, '2010-02-03 15:58:45', '2006-05-10 22:52:42', 0, NULL, '邱震南', 1, 'EA-EE-2021-S', 0, '17421994006', '2001-01-20', '2003-11-06', 3.19, '2002-02-27', '中国成都市锦江区人民南路四段528号23室', '123456', 1);
INSERT INTO `vip_info` VALUES (70, '2012-05-04 20:17:18', '2007-12-12 09:30:44', 0, NULL, '林詩君', 1, 'FA-DE-9999-L', 0, '13465956345', '2024-01-14', '2019-08-14', 645.00, '2025-04-05', '中国上海市黄浦区淮海中路109号32栋', '123456', 1);
INSERT INTO `vip_info` VALUES (71, '2012-08-25 20:03:38', '2024-05-11 05:00:39', 1, NULL, '徐榮發', 0, 'BB-FD-3032-G', 0, '19666891219', '2024-07-18', '2013-10-14', 99.24, '2020-01-07', '中国成都市成华区双庆路563号45号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (72, '2020-03-20 22:20:49', '2020-01-23 15:10:04', 0, NULL, '李俊宇', 1, 'DB-DA-5272-C', 0, '18022821742', '2012-08-24', '2012-05-15', 517.18, '2005-11-17', '中国东莞珊瑚路397号44号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (73, '2011-07-05 13:05:21', '2007-10-14 15:19:44', 1, NULL, '宋宇宁', 0, 'BE-CF-3412-P', 0, '16091620626', '2007-01-07', '2022-04-23', 804.03, '2016-11-29', '中国北京市延庆区028县道921号38号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (74, '2013-10-05 22:58:59', '2017-11-26 09:38:41', 1, NULL, '宣慧儀', 1, 'BB-DB-1528-A', 0, '13257880576', '2013-04-12', '2004-04-17', 435.78, '2004-10-07', '中国深圳福田区深南大道269号17号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (75, '2001-08-20 02:33:39', '2016-04-12 11:37:23', 0, NULL, '樊裕玲', 0, 'EA-EF-8193-Y', 0, '16250880655', '2000-03-26', '2013-06-18', 308.37, '2016-05-02', '中国中山京华商圈华夏街63号39号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (76, '2016-01-03 21:21:41', '2018-09-08 22:47:19', 0, NULL, '常岚', 1, 'DB-BD-0097-Z', 0, '14735774909', '2012-11-19', '2011-01-20', 570.52, '2014-04-25', '中国北京市東城区東直門內大街905号华润大厦5室', '123456', 1);
INSERT INTO `vip_info` VALUES (77, '2010-08-07 14:45:28', '2018-04-21 04:07:14', 1, NULL, '曹梓晴', 1, 'BC-CB-9058-D', 0, '14451802398', '2017-04-21', '2015-09-09', 737.18, '2006-09-11', '中国广州市海珠区江南西路524号华润大厦28室', '123456', 1);
INSERT INTO `vip_info` VALUES (78, '2021-09-04 18:36:00', '2008-11-13 12:03:57', 1, NULL, '马睿', 1, 'BF-FD-1302-S', 0, '14630029814', '2000-09-30', '2024-02-08', 693.24, '2023-08-25', '中国北京市西城区复兴门内大街134号6楼', '123456', 1);
INSERT INTO `vip_info` VALUES (79, '2013-02-02 06:34:30', '2019-07-21 17:56:44', 0, NULL, '鄭潤發', 0, 'CC-AA-7635-X', 0, '15785483011', '2011-11-27', '2017-02-19', 992.86, '2005-05-07', '中国北京市东城区东单王府井东街985号华润大厦11室', '123456', 1);
INSERT INTO `vip_info` VALUES (80, '2002-10-06 15:00:57', '2005-01-21 05:33:39', 0, NULL, '孫小慧', 1, 'BB-DF-1013-X', 0, '14553357723', '2012-07-09', '2016-11-23', 51.00, '2014-12-19', '中国东莞珊瑚路770号5室', '123456', 1);
INSERT INTO `vip_info` VALUES (81, '2011-11-21 10:58:55', '2025-03-02 18:00:39', 0, NULL, '陈晓明', 1, 'DC-AA-6017-V', 0, '15785177796', '2023-09-02', '2022-10-19', 511.91, '2020-11-12', '中国上海市闵行区宾川路893号18号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (82, '2010-12-20 08:00:29', '2017-06-18 07:35:19', 0, NULL, '钟子异', 1, 'EE-BA-5580-P', 0, '16207172207', '2000-07-19', '2000-01-20', 304.59, '2014-11-23', '中国深圳罗湖区田贝一路158号7室', '123456', 1);
INSERT INTO `vip_info` VALUES (83, '2011-03-22 01:14:55', '2012-08-30 05:41:24', 1, NULL, '孙晓明', 1, 'FA-EC-9500-C', 0, '13769671192', '2007-08-31', '2007-09-07', 742.03, '2002-07-05', '中国广州市越秀区中山二路837号36楼', '123456', 1);
INSERT INTO `vip_info` VALUES (84, '2002-02-02 20:08:30', '2018-07-07 03:17:42', 0, NULL, '盧家玲', 1, 'AD-FF-1922-U', 0, '13673387103', '2005-12-05', '2010-10-05', 359.21, '2023-03-09', '中国中山紫马岭商圈中山五路86号10室', '123456', 1);
INSERT INTO `vip_info` VALUES (85, '2014-03-05 04:41:56', '2015-03-20 16:42:22', 1, NULL, '于安琪', 1, 'EC-DE-1044-G', 0, '16210517554', '2006-05-29', '2013-10-01', 426.38, '2000-05-01', '中国深圳龙岗区布吉镇西环路975号43号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (86, '2010-10-01 21:47:01', '2004-03-10 20:24:52', 1, NULL, '鄧家玲', 0, 'CF-CF-6391-T', 0, '14445408311', '2017-09-23', '2021-04-29', 608.05, '2005-07-14', '中国深圳龙岗区学园一巷232号华润大厦24室', '123456', 1);
INSERT INTO `vip_info` VALUES (87, '2012-09-10 13:52:45', '2001-01-04 15:58:25', 0, NULL, '杜慧珊', 1, 'CC-DA-6954-I', 0, '16782192680', '2005-02-20', '2018-11-14', 935.13, '2005-02-06', '中国北京市西城区复兴门内大街813号3室', '123456', 1);
INSERT INTO `vip_info` VALUES (88, '2009-01-26 04:33:04', '2001-11-06 18:16:41', 0, NULL, '余云熙', 1, 'FE-FC-7868-B', 0, '19190552692', '2007-05-20', '2012-03-09', 142.60, '2000-05-14', '中国成都市成华区双庆路327号华润大厦42室', '123456', 1);
INSERT INTO `vip_info` VALUES (89, '2006-05-07 21:22:06', '2008-03-17 07:51:04', 1, NULL, '白惠妹', 0, 'FD-CB-4460-M', 0, '16323871595', '2023-01-09', '2018-12-14', 692.02, '2023-08-20', '中国广州市天河区天河路284号24楼', '123456', 1);
INSERT INTO `vip_info` VALUES (90, '2010-10-30 02:54:57', '2016-03-16 02:54:47', 0, NULL, '陳力申', 0, 'CE-FB-9550-Q', 0, '13508386858', '2004-11-29', '2020-05-03', 768.30, '2019-09-04', '中国中山紫马岭商圈中山五路267号25号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (91, '2014-12-06 05:16:38', '2023-12-07 23:25:05', 0, NULL, '薛安琪', 1, 'EE-BF-7610-R', 0, '14036273097', '2004-12-07', '2025-02-18', 464.09, '2023-08-22', '中国北京市延庆区028县道312号40栋', '123456', 1);
INSERT INTO `vip_info` VALUES (92, '2015-01-09 01:58:05', '2003-05-21 14:16:57', 0, NULL, '郝岚', 1, 'CA-FE-6301-M', 0, '15924733733', '2003-11-02', '2008-11-29', 653.86, '2009-06-26', '中国北京市延庆区028县道45号9栋', '123456', 1);
INSERT INTO `vip_info` VALUES (93, '2003-12-17 18:43:57', '2002-06-05 14:18:58', 0, NULL, '姜志遠', 0, 'BF-EB-1279-A', 0, '19769985777', '2017-11-29', '2006-08-31', 466.98, '2015-12-02', '中国深圳罗湖区清水河一路734号4室', '123456', 1);
INSERT INTO `vip_info` VALUES (94, '2007-09-30 23:53:56', '2006-08-27 19:05:18', 1, NULL, '马宇宁', 1, 'FD-DD-5012-M', 0, '15176583241', '2005-10-22', '2009-07-31', 612.34, '2016-06-30', '中国成都市成华区玉双路6号958号1楼', '123456', 1);
INSERT INTO `vip_info` VALUES (95, '2017-07-18 22:12:54', '2016-04-27 09:29:15', 1, NULL, '胡岚', 0, 'EA-AE-4386-M', 0, '19265356419', '2017-03-18', '2015-11-24', 163.55, '2008-08-06', '中国北京市西城区复兴门内大街384号15栋', '123456', 1);
INSERT INTO `vip_info` VALUES (96, '2004-09-27 06:36:14', '2009-06-11 06:27:39', 0, NULL, '伍慧珊', 0, 'CB-CD-0473-Z', 0, '13735334993', '2013-12-25', '2016-01-14', 12.50, '2002-09-22', '中国上海市浦东新区健祥路61号16室', '123456', 1);
INSERT INTO `vip_info` VALUES (97, '2018-08-30 05:51:31', '2016-10-06 16:55:40', 0, NULL, '夏子韬', 0, 'FE-BF-5153-L', 0, '18061846167', '2003-10-06', '2020-01-03', 550.83, '2005-06-13', '中国中山紫马岭商圈中山五路267号1号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (98, '2017-09-22 01:30:20', '2007-11-22 02:04:26', 0, NULL, '區詩君', 0, 'CB-CC-3512-Y', 0, '16285458103', '2020-02-27', '2010-01-23', 139.03, '2008-12-25', '中国深圳罗湖区清水河一路813号24楼', '123456', 1);
INSERT INTO `vip_info` VALUES (99, '2024-05-26 15:31:23', '2024-07-16 22:30:34', 0, NULL, '邓岚', 0, 'AF-DA-9937-N', 0, '18447028161', '2008-09-14', '2023-01-30', 53.33, '2016-08-29', '中国东莞环区南街二巷574号35楼', '123456', 1);
INSERT INTO `vip_info` VALUES (100, '2020-10-14 19:09:21', '2017-05-06 08:17:04', 1, NULL, '范震南', 1, 'BD-FE-6675-I', 0, '13485391081', '2008-08-31', '2015-08-06', 489.38, '2000-05-27', '中国中山天河区大信商圈大信南路208号6号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (101, '2018-07-25 02:39:03', '2014-03-03 19:06:48', 0, NULL, '駱浩然', 1, 'BB-CA-5604-H', 0, '18343237118', '2005-09-18', '2009-09-09', 481.82, '2005-02-08', '中国深圳罗湖区清水河一路352号17号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (102, '2008-02-11 14:15:15', '2011-12-24 23:33:14', 1, NULL, '郝致远', 0, 'BC-AE-0363-Q', 0, '18326893215', '2000-08-21', '2013-05-15', 872.59, '2002-12-21', '中国上海市黄浦区淮海中路930号28楼', '123456', 1);
INSERT INTO `vip_info` VALUES (103, '2013-06-08 00:00:47', '2011-08-10 10:36:17', 1, NULL, '胡富城', 1, 'CB-FF-2095-B', 0, '18644827829', '2022-11-10', '2022-04-05', 115.36, '2001-04-25', '中国北京市东城区东单王府井东街731号18栋', '123456', 1);
INSERT INTO `vip_info` VALUES (104, '2012-01-11 10:09:43', '2018-08-02 22:08:26', 0, NULL, '程子韬', 0, 'AA-ED-5335-A', 0, '17120133568', '2013-01-15', '2009-02-07', 820.12, '2010-08-15', '中国广州市白云区小坪东路648号华润大厦49室', '123456', 1);
INSERT INTO `vip_info` VALUES (105, '2019-07-12 15:03:53', '2006-11-20 09:13:06', 0, NULL, '駱詠詩', 0, 'BB-CF-2015-Z', 0, '14849691097', '2006-04-30', '2015-04-11', 241.63, '2021-10-28', '中国成都市成华区二仙桥东三路465号23号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (106, '2000-08-19 07:57:51', '2014-11-27 12:58:08', 1, NULL, '梅慧儀', 0, 'EA-FD-0565-C', 0, '15910845430', '2006-01-18', '2025-02-10', 722.94, '2002-03-11', '中国深圳罗湖区蔡屋围深南东路81号华润大厦22室', '123456', 1);
INSERT INTO `vip_info` VALUES (107, '2021-11-17 13:10:33', '2003-08-23 10:47:06', 1, NULL, '邱睿', 1, 'EC-BC-4437-B', 0, '16671439207', '2001-07-27', '2009-02-24', 476.18, '2013-02-18', '中国北京市東城区東直門內大街347号47室', '123456', 1);
INSERT INTO `vip_info` VALUES (108, '2018-05-22 23:15:44', '2011-10-09 16:51:03', 1, NULL, '翁志明', 1, 'EC-DC-5347-L', 0, '19131438942', '2016-12-17', '2020-06-11', 809.04, '2018-12-29', '中国北京市東城区東直門內大街604号44栋', '123456', 1);
INSERT INTO `vip_info` VALUES (109, '2016-06-03 10:39:04', '2001-01-31 17:42:00', 0, NULL, '鐘惠敏', 0, 'DF-EB-7066-A', 0, '16426547465', '2002-02-28', '2005-11-04', 992.81, '2014-01-16', '中国成都市成华区双庆路439号22室', '123456', 1);
INSERT INTO `vip_info` VALUES (110, '2019-02-21 04:26:28', '2015-10-26 11:15:48', 1, NULL, '藍惠妹', 0, 'EB-CD-2408-Q', 0, '17350804811', '2013-08-27', '2023-04-26', 264.70, '2009-01-25', '中国深圳罗湖区田贝一路6号华润大厦48室', '123456', 1);
INSERT INTO `vip_info` VALUES (111, '2025-03-21 16:53:34', '2004-09-13 16:36:24', 1, NULL, '蘇嘉欣', 0, 'CB-BE-9672-H', 0, '17706498866', '2013-11-17', '2013-01-06', 702.81, '2016-05-26', '中国东莞环区南街二巷898号16号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (112, '2009-02-10 04:42:44', '2012-07-29 06:49:31', 0, NULL, '佘思妤', 1, 'DE-CE-4052-O', 0, '15475614146', '2005-01-18', '2011-03-02', 740.71, '2017-03-22', '中国广州市白云区机场路棠苑街五巷964号4号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (113, '2013-11-02 13:26:04', '2014-09-12 06:06:10', 0, NULL, '韦子韬', 0, 'BD-BB-7240-E', 0, '13899608631', '2009-10-02', '2019-10-06', 106.17, '2011-11-17', '中国成都市成华区玉双路6号784号华润大厦39室', '123456', 1);
INSERT INTO `vip_info` VALUES (114, '2001-03-14 09:32:34', '2004-11-14 11:49:59', 0, NULL, '羅志明', 1, 'EE-AC-7607-Q', 0, '13200050414', '2018-04-07', '2007-02-02', 696.15, '2012-11-20', '中国北京市房山区岳琉路853号41室', '123456', 1);
INSERT INTO `vip_info` VALUES (115, '2022-05-07 05:46:25', '2003-09-22 10:27:51', 0, NULL, '戴詩涵', 0, 'AD-CD-1569-Y', 0, '17433381134', '2013-03-30', '2009-08-10', 125.11, '2011-09-07', '中国北京市朝阳区三里屯路644号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (116, '2007-10-05 00:19:53', '2023-11-30 14:23:28', 0, NULL, '呂明', 1, 'EF-FD-0183-P', 0, '15584813272', '2006-02-21', '2022-09-06', 701.74, '2000-12-20', '中国深圳福田区深南大道478号35楼', '123456', 1);
INSERT INTO `vip_info` VALUES (117, '2004-09-24 17:48:30', '2012-05-09 20:33:38', 1, NULL, '苑家玲', 0, 'AC-AC-5754-N', 0, '16707211274', '2015-10-26', '2023-12-26', 574.72, '2002-12-20', '中国北京市东城区东单王府井东街482号华润大厦31室', '123456', 1);
INSERT INTO `vip_info` VALUES (118, '2001-02-23 22:10:45', '2012-09-03 21:12:13', 1, NULL, '汪家文', 0, 'CA-BE-8537-V', 0, '18798536188', '2000-09-21', '2004-03-10', 152.51, '2016-09-29', '中国深圳罗湖区蔡屋围深南东路531号6室', '123456', 1);
INSERT INTO `vip_info` VALUES (119, '2019-12-15 08:53:20', '2024-08-27 14:36:47', 1, NULL, '鄺惠妹', 1, 'BB-EC-7908-K', 0, '13895469451', '2007-08-26', '2009-07-28', 955.27, '2013-08-12', '中国北京市西城区复兴门内大街593号35号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (120, '2023-02-28 11:19:42', '2006-10-19 05:07:06', 1, NULL, '汪國明', 1, 'AF-FC-9219-O', 0, '16851278598', '2022-07-14', '2016-10-25', 716.14, '2022-07-17', '中国北京市东城区东单王府井东街264号21栋', '123456', 1);
INSERT INTO `vip_info` VALUES (121, '2006-03-13 07:17:19', '2001-03-15 03:37:58', 0, NULL, '任嘉伦', 0, 'AC-AE-1013-J', 0, '16221625026', '2025-01-02', '2006-08-12', 294.97, '2011-03-13', '中国广州市海珠区江南西路548号19栋', '123456', 1);
INSERT INTO `vip_info` VALUES (122, '2016-09-19 02:11:48', '2014-09-18 11:56:03', 1, NULL, '成天榮', 0, 'FB-FF-1590-P', 0, '15612833841', '2000-11-23', '2002-04-29', 982.72, '2004-10-05', '中国深圳福田区深南大道838号36室', '123456', 1);
INSERT INTO `vip_info` VALUES (123, '2009-02-09 07:37:56', '2022-12-18 18:16:16', 1, NULL, '卢睿', 1, 'FE-FA-8059-H', 0, '16720987744', '2019-01-13', '2014-02-28', 174.04, '2007-10-17', '中国中山京华商圈华夏街264号华润大厦23室', '123456', 1);
INSERT INTO `vip_info` VALUES (124, '2012-08-08 15:39:54', '2007-09-19 19:15:57', 1, NULL, '马岚', 0, 'DC-FB-4839-F', 0, '17935844883', '2018-09-26', '2021-05-08', 819.57, '2013-06-18', '中国上海市浦东新区健祥路363号19栋', '123456', 1);
INSERT INTO `vip_info` VALUES (125, '2021-05-02 15:59:45', '2001-10-28 23:53:38', 0, NULL, '崔國賢', 1, 'BC-EC-9502-X', 0, '15595633963', '2021-09-30', '2025-06-18', 36.73, '2014-04-06', '中国北京市朝阳区三里屯路997号25号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (126, '2014-09-18 18:41:35', '2012-12-28 14:56:43', 1, NULL, '周子韬', 0, 'FF-FC-9095-M', 0, '14341417998', '2012-11-29', '2021-01-13', 319.26, '2019-10-30', '中国成都市成华区玉双路6号626号39室', '123456', 1);
INSERT INTO `vip_info` VALUES (127, '2012-07-23 17:23:18', '2014-05-31 16:58:28', 0, NULL, '汪宇宁', 0, 'FA-AB-2309-O', 0, '16137679179', '2006-10-22', '2012-12-28', 651.28, '2019-09-29', '中国成都市锦江区红星路三段317号华润大厦6室', '123456', 1);
INSERT INTO `vip_info` VALUES (128, '2002-03-17 17:40:55', '2010-11-08 00:22:40', 1, NULL, '薛浩然', 0, 'AD-FA-3812-M', 0, '14413334633', '2006-01-16', '2022-11-07', 445.11, '2001-01-07', '中国成都市成华区双庆路98号29室', '123456', 1);
INSERT INTO `vip_info` VALUES (129, '2005-06-16 04:19:46', '2021-03-21 09:25:12', 0, NULL, '赵秀英', 1, 'EE-AC-7470-Q', 0, '18107019612', '2024-01-26', '2016-10-17', 303.30, '2012-02-28', '中国中山紫马岭商圈中山五路719号40栋', '123456', 1);
INSERT INTO `vip_info` VALUES (130, '2024-12-04 03:13:33', '2019-10-23 09:34:22', 0, NULL, '鄧家文', 0, 'DA-AD-1754-U', 0, '17055643923', '2020-12-09', '2017-01-09', 995.98, '2006-07-31', '中国上海市黄浦区淮海中路175号48楼', '123456', 1);
INSERT INTO `vip_info` VALUES (131, '2022-07-06 09:41:15', '2007-10-24 17:47:52', 0, NULL, '彭朝偉', 0, 'DE-DA-2903-F', 0, '15319376038', '2022-08-24', '2001-06-07', 797.53, '2005-03-10', '中国深圳龙岗区学园一巷238号8栋', '123456', 1);
INSERT INTO `vip_info` VALUES (132, '2024-01-29 22:25:08', '2009-09-01 11:39:04', 1, NULL, '楊永權', 1, 'EA-FA-2392-J', 0, '17087549951', '2016-04-24', '2008-05-14', 978.52, '2023-05-15', '中国北京市西城区复兴门内大街298号华润大厦47室', '123456', 1);
INSERT INTO `vip_info` VALUES (133, '2020-01-03 17:13:53', '2002-05-01 07:21:32', 1, NULL, '贾杰宏', 1, 'EC-AD-9921-U', 0, '17650553746', '2001-08-24', '2002-08-31', 440.35, '2004-06-25', '中国中山天河区大信商圈大信南路141号50楼', '123456', 1);
INSERT INTO `vip_info` VALUES (134, '2022-10-07 00:04:31', '2007-02-10 15:26:31', 0, NULL, '谢震南', 1, 'AB-FC-4506-Z', 0, '13679536012', '2007-08-25', '2015-12-14', 368.60, '2024-10-29', '中国东莞坑美十五巷986号华润大厦49室', '123456', 1);
INSERT INTO `vip_info` VALUES (135, '2020-04-23 12:58:26', '2017-08-06 12:06:16', 0, NULL, '謝惠妹', 1, 'DE-EF-0316-A', 0, '17724100813', '2009-02-19', '2011-12-12', 6.09, '2003-03-19', '中国广州市越秀区中山二路790号11楼', '123456', 1);
INSERT INTO `vip_info` VALUES (136, '2016-08-30 23:30:44', '2001-02-16 02:44:21', 1, NULL, '孟嘉伦', 1, 'EE-EB-6831-L', 0, '17803903220', '2006-11-13', '2008-09-13', 372.02, '2022-12-26', '中国东莞坑美十五巷901号25楼', '123456', 1);
INSERT INTO `vip_info` VALUES (137, '2016-07-07 08:23:19', '2015-05-17 20:29:57', 1, NULL, '卢睿', 0, 'AC-AC-3738-N', 0, '18363352061', '2012-06-22', '2016-06-28', 957.15, '2022-02-08', '中国成都市成华区玉双路6号470号华润大厦40室', '123456', 1);
INSERT INTO `vip_info` VALUES (138, '2014-11-13 03:01:35', '2022-10-19 13:04:52', 1, NULL, '夏云熙', 0, 'AC-DA-8117-R', 0, '14549708186', '2006-01-23', '2010-07-31', 64.71, '2006-06-18', '中国中山乐丰六路79号20栋', '123456', 1);
INSERT INTO `vip_info` VALUES (139, '2004-05-08 20:10:56', '2006-04-13 12:28:41', 1, NULL, '邱安琪', 1, 'BB-CA-9114-N', 0, '16038005519', '2017-08-14', '2016-01-29', 973.79, '2020-10-08', '中国北京市朝阳区三里屯路838号8号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (140, '2014-04-24 18:21:29', '2003-08-02 09:24:11', 1, NULL, '古家強', 1, 'BE-FA-4386-D', 0, '19201915068', '2023-06-07', '2000-05-23', 153.91, '2016-06-04', '中国深圳龙岗区学园一巷759号华润大厦34室', '123456', 1);
INSERT INTO `vip_info` VALUES (141, '2011-12-16 13:27:49', '2017-08-06 21:56:29', 1, NULL, '任明', 1, 'BD-BC-2815-K', 0, '18468105614', '2013-03-27', '2004-12-02', 167.92, '2022-04-07', '中国上海市闵行区宾川路507号17楼', '123456', 1);
INSERT INTO `vip_info` VALUES (142, '2019-11-06 14:02:27', '2010-07-09 12:20:55', 0, NULL, '郝詩涵', 1, 'BE-BC-6539-L', 0, '14776299359', '2021-09-16', '2018-07-22', 244.80, '2021-07-30', '中国深圳福田区深南大道229号21楼', '123456', 1);
INSERT INTO `vip_info` VALUES (143, '2003-01-12 06:52:42', '2013-10-22 12:06:15', 1, NULL, '容曉彤', 0, 'DB-BB-9977-U', 0, '19330532042', '2002-07-21', '2002-02-01', 910.88, '2005-03-02', '中国上海市浦东新区健祥路430号1号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (144, '2017-01-02 21:00:01', '2004-09-17 02:55:50', 0, NULL, '苏秀英', 1, 'BD-EF-6916-F', 0, '18210553516', '2011-05-22', '2015-03-23', 986.13, '2008-06-05', '中国成都市成华区二仙桥东三路829号华润大厦28室', '123456', 1);
INSERT INTO `vip_info` VALUES (145, '2001-02-25 09:58:21', '2014-10-01 12:38:21', 0, NULL, '成惠妹', 0, 'CB-ED-8007-B', 0, '15584026957', '2021-12-15', '2009-03-01', 244.94, '2006-04-12', '中国深圳罗湖区蔡屋围深南东路676号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (146, '2011-05-06 00:49:50', '2020-10-03 23:05:56', 0, NULL, '彭家玲', 0, 'DF-BC-2024-J', 0, '14242119323', '2019-10-03', '2021-01-12', 818.63, '2023-04-01', '中国北京市延庆区028县道182号33栋', '123456', 1);
INSERT INTO `vip_info` VALUES (147, '2005-07-09 00:43:02', '2005-10-22 11:17:47', 1, NULL, '徐安琪', 0, 'DE-FA-3016-N', 0, '14993730486', '2011-07-15', '2013-07-04', 914.67, '2021-05-13', '中国成都市成华区双庆路783号12室', '123456', 1);
INSERT INTO `vip_info` VALUES (148, '2006-07-25 01:33:56', '2019-05-28 15:48:52', 1, NULL, '郝子异', 0, 'DC-AE-0120-H', 0, '19857046859', '2003-02-14', '2019-04-14', 157.27, '2007-12-31', '中国成都市成华区双庆路548号华润大厦50室', '123456', 1);
INSERT INTO `vip_info` VALUES (149, '2021-01-08 22:08:57', '2010-12-02 04:16:08', 1, NULL, '程震南', 1, 'CB-DF-2048-Z', 0, '16976629266', '2012-03-25', '2023-10-02', 207.48, '2016-05-08', '中国成都市锦江区人民南路四段104号21号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (150, '2022-02-13 15:08:25', '2005-11-30 10:52:17', 0, NULL, '戴子韬', 1, 'FC-AC-0185-I', 0, '15524912061', '2024-05-28', '2001-12-14', 235.80, '2004-03-15', '中国上海市浦东新区橄榄路167号49栋', '123456', 1);
INSERT INTO `vip_info` VALUES (151, '2021-07-28 16:08:17', '2022-02-19 20:38:48', 0, NULL, '谷麗欣', 0, 'BD-BF-5572-W', 0, '14731975275', '2018-07-25', '2011-11-02', 987.17, '2021-12-26', '中国成都市成华区双庆路938号华润大厦7室', '123456', 1);
INSERT INTO `vip_info` VALUES (152, '2012-05-27 19:04:45', '2020-04-09 11:38:06', 0, NULL, '王詩涵', 0, 'AF-BF-1848-K', 0, '18738392673', '2005-11-16', '2002-10-31', 345.84, '2023-03-31', '中国中山天河区大信商圈大信南路458号29楼', '123456', 1);
INSERT INTO `vip_info` VALUES (153, '2023-08-19 17:00:32', '2011-07-09 15:34:19', 0, NULL, '苗惠敏', 1, 'DB-AC-6324-L', 0, '13943680735', '2002-05-31', '2008-07-10', 31.07, '2017-11-07', '中国上海市黄浦区淮海中路760号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (154, '2011-09-24 20:43:14', '2005-08-11 04:57:20', 1, NULL, '朱杰倫', 0, 'CA-DA-1098-O', 0, '19961622821', '2011-07-06', '2015-11-11', 686.64, '2020-08-31', '中国北京市延庆区028县道976号18栋', '123456', 1);
INSERT INTO `vip_info` VALUES (155, '2013-02-19 12:01:06', '2018-12-29 21:15:23', 0, NULL, '白霆鋒', 1, 'AD-BF-0478-A', 0, '15398638125', '2005-01-14', '2001-11-27', 971.08, '2000-10-22', '中国东莞珊瑚路367号9室', '123456', 1);
INSERT INTO `vip_info` VALUES (156, '2008-08-01 05:43:24', '2018-03-23 20:35:26', 1, NULL, '熊嘉伦', 0, 'DE-CA-7663-Z', 0, '17100583934', '2013-08-23', '2005-06-12', 712.71, '2008-06-24', '中国成都市成华区二仙桥东三路222号34楼', '123456', 1);
INSERT INTO `vip_info` VALUES (157, '2022-07-02 00:36:14', '2007-08-14 11:55:22', 0, NULL, '孟安琪', 0, 'DA-EC-3665-I', 0, '13961392491', '2012-10-31', '2000-10-03', 33.62, '2001-07-24', '中国北京市房山区岳琉路458号31室', '123456', 1);
INSERT INTO `vip_info` VALUES (158, '2022-11-27 17:56:53', '2010-02-20 13:39:38', 0, NULL, '顾晓明', 1, 'FF-EB-3902-R', 0, '15121119482', '2007-02-28', '2003-08-02', 938.79, '2019-11-13', '中国上海市黄浦区淮海中路242号36号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (159, '2013-11-07 18:43:15', '2006-06-23 10:03:57', 0, NULL, '郑璐', 0, 'AC-FE-9468-H', 0, '17717205595', '2000-04-19', '2010-03-12', 226.71, '2018-11-22', '中国成都市成华区双庆路134号25号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (160, '2003-09-25 13:12:53', '2018-04-18 19:15:22', 0, NULL, '范安琪', 0, 'FC-BE-2264-T', 0, '13520589615', '2000-04-14', '2019-04-17', 485.98, '2020-01-16', '中国中山京华商圈华夏街90号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (161, '2018-06-11 06:22:11', '2009-08-26 20:48:11', 0, NULL, '郭宇宁', 1, 'ED-CC-2422-N', 0, '17666465299', '2018-04-23', '2004-01-04', 355.68, '2006-05-19', '中国中山乐丰六路465号31栋', '123456', 1);
INSERT INTO `vip_info` VALUES (162, '2015-05-22 06:24:16', '2014-01-16 13:02:27', 0, NULL, '董嘉伦', 1, 'AE-DA-2603-Q', 0, '15034873961', '2001-07-30', '2020-11-08', 324.52, '2016-06-04', '中国上海市闵行区宾川路942号15栋', '123456', 1);
INSERT INTO `vip_info` VALUES (163, '2013-07-14 20:23:42', '2016-05-09 17:53:46', 1, NULL, '袁晓明', 0, 'AF-EE-6854-Q', 0, '13460228354', '2022-03-09', '2016-09-03', 217.77, '2016-06-13', '中国深圳龙岗区学园一巷451号7号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (164, '2000-02-22 17:19:58', '2000-11-30 00:42:15', 1, NULL, '郭家強', 0, 'EE-BB-5060-C', 0, '16420199654', '2017-03-13', '2015-08-28', 768.06, '2022-09-06', '中国北京市房山区岳琉路823号12栋', '123456', 1);
INSERT INTO `vip_info` VALUES (165, '2015-09-08 09:06:50', '2010-05-01 06:58:10', 0, NULL, '戚浩然', 1, 'FE-DE-4714-R', 0, '19793489308', '2022-02-01', '2024-01-11', 279.71, '2001-01-07', '中国北京市朝阳区三里屯路827号38号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (166, '2007-02-21 05:17:23', '2019-03-23 13:38:34', 0, NULL, '湯小慧', 1, 'AB-DD-5938-L', 0, '16632429586', '2021-01-01', '2023-10-28', 0.37, '2017-05-07', '中国广州市越秀区中山二路834号21室', '123456', 1);
INSERT INTO `vip_info` VALUES (167, '2016-02-06 04:42:40', '2013-07-13 05:45:18', 0, NULL, '梅力申', 1, 'FD-EC-2275-A', 0, '16275819636', '2014-03-28', '2010-02-11', 242.78, '2024-02-01', '中国北京市西城区西長安街818号1号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (168, '2022-01-29 22:20:14', '2015-06-06 08:14:05', 0, NULL, '雷榮發', 1, 'AB-CF-7133-P', 0, '17419661428', '2022-06-27', '2015-03-05', 979.76, '2000-12-03', '中国深圳福田区景田东一街262号33楼', '123456', 1);
INSERT INTO `vip_info` VALUES (169, '2009-02-15 09:46:23', '2020-02-15 21:40:04', 0, NULL, '郑子异', 1, 'DC-EC-0837-B', 0, '17363604849', '2011-04-21', '2011-12-26', 78.27, '2024-11-25', '中国上海市徐汇区虹桥路892号17室', '123456', 1);
INSERT INTO `vip_info` VALUES (170, '2019-03-18 05:47:16', '2005-08-30 16:07:23', 0, NULL, '溫明', 0, 'AB-BC-5343-Y', 0, '13938399470', '2000-07-31', '2019-03-31', 673.23, '2014-09-22', '中国中山京华商圈华夏街33号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (171, '2002-10-14 16:26:09', '2017-04-02 02:37:19', 0, NULL, '胡富城', 1, 'FB-AE-0859-H', 0, '19313197852', '2004-06-14', '2022-02-17', 594.82, '2015-12-30', '中国广州市海珠区江南西路426号23室', '123456', 1);
INSERT INTO `vip_info` VALUES (172, '2005-02-07 00:27:50', '2021-06-06 08:50:55', 1, NULL, '許家強', 0, 'EF-FD-7435-V', 0, '18926607301', '2022-04-04', '2011-10-10', 336.72, '2010-03-21', '中国深圳龙岗区布吉镇西环路786号华润大厦49室', '123456', 1);
INSERT INTO `vip_info` VALUES (173, '2015-10-30 08:13:03', '2024-10-18 06:03:28', 0, NULL, '錢曉彤', 1, 'EF-AF-8962-B', 0, '14000498938', '2009-07-04', '2016-06-14', 903.22, '2013-11-25', '中国深圳龙岗区学园一巷572号47室', '123456', 1);
INSERT INTO `vip_info` VALUES (174, '2018-05-18 22:42:03', '2014-09-29 20:54:17', 1, NULL, '史震南', 0, 'EC-AE-1415-K', 0, '15147288824', '2002-05-27', '2004-12-06', 844.53, '2002-12-18', '中国上海市黄浦区淮海中路372号31栋', '123456', 1);
INSERT INTO `vip_info` VALUES (175, '2003-11-11 12:26:47', '2021-10-22 21:23:23', 1, NULL, '林梓晴', 0, 'FA-EA-2361-O', 0, '17689740948', '2014-01-11', '2015-07-25', 49.50, '2009-12-28', '中国成都市成华区玉双路6号255号华润大厦27室', '123456', 1);
INSERT INTO `vip_info` VALUES (176, '2025-01-27 18:30:02', '2024-05-26 03:55:09', 1, NULL, '彭家強', 1, 'EA-AB-3990-N', 0, '19010471543', '2000-01-05', '2018-01-01', 489.46, '2019-01-05', '中国成都市成华区玉双路6号726号17室', '123456', 1);
INSERT INTO `vip_info` VALUES (177, '2021-06-14 16:32:26', '2014-04-25 01:59:41', 0, NULL, '樊安琪', 0, 'CF-FE-6933-E', 0, '13652164683', '2016-06-15', '2020-07-21', 674.62, '2002-08-21', '中国成都市成华区玉双路6号997号华润大厦9室', '123456', 1);
INSERT INTO `vip_info` VALUES (178, '2010-10-06 22:55:51', '2022-12-03 05:29:50', 0, NULL, '戴心穎', 1, 'AC-DE-9016-J', 0, '14698617101', '2012-11-18', '2008-07-06', 4.27, '2017-07-06', '中国深圳龙岗区学园一巷360号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (179, '2001-11-10 00:44:02', '2019-10-23 05:31:43', 1, NULL, '苗家輝', 1, 'AE-DC-9721-R', 0, '19030229555', '2007-12-20', '2015-03-03', 974.82, '2012-02-03', '中国深圳龙岗区学园一巷70号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (180, '2003-07-28 03:46:10', '2018-08-08 20:54:45', 0, NULL, '阎子韬', 1, 'AD-BD-6515-G', 0, '16776985823', '2016-05-21', '2014-01-11', 117.75, '2009-09-19', '中国北京市東城区東直門內大街599号36号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (181, '2011-01-07 10:21:42', '2025-03-09 06:02:12', 0, NULL, '曹子韬', 0, 'CB-CE-6607-B', 0, '16164888345', '2019-02-23', '2008-08-16', 593.62, '2013-03-17', '中国北京市西城区西長安街232号13室', '123456', 1);
INSERT INTO `vip_info` VALUES (182, '2024-01-07 17:30:06', '2015-04-09 01:30:24', 0, NULL, '傅宇宁', 1, 'BC-EB-7017-Y', 0, '19883084901', '2020-04-30', '2007-12-05', 950.20, '2006-11-19', '中国中山紫马岭商圈中山五路95号38室', '123456', 1);
INSERT INTO `vip_info` VALUES (183, '2016-11-20 06:30:32', '2004-05-15 18:24:22', 0, NULL, '田曉彤', 1, 'FA-FC-7726-R', 0, '16167851629', '2023-09-20', '2002-05-21', 893.70, '2004-09-25', '中国东莞东泰五街87号4室', '123456', 1);
INSERT INTO `vip_info` VALUES (184, '2007-08-19 02:02:31', '2017-03-02 02:48:23', 1, NULL, '伍國賢', 1, 'DB-AA-1799-Q', 0, '13753736570', '2020-07-15', '2023-03-06', 728.46, '2011-04-03', '中国上海市闵行区宾川路289号10楼', '123456', 1);
INSERT INTO `vip_info` VALUES (185, '2000-05-02 06:47:23', '2011-05-21 10:45:27', 1, NULL, '湯天榮', 0, 'FD-BD-8250-A', 0, '19202348807', '2001-05-01', '2021-07-04', 784.28, '2005-10-27', '中国东莞东泰五街47号15楼', '123456', 1);
INSERT INTO `vip_info` VALUES (186, '2005-05-11 23:34:53', '2011-08-15 14:45:50', 1, NULL, '唐頴思', 1, 'DC-AD-8497-S', 0, '14931770829', '2001-05-12', '2020-07-13', 190.58, '2003-03-25', '中国深圳罗湖区清水河一路677号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (187, '2023-08-31 18:15:58', '2017-12-17 08:26:40', 0, NULL, '孔云熙', 0, 'EF-BF-5005-F', 0, '17968427577', '2003-08-24', '2010-11-27', 415.04, '2024-11-07', '中国成都市成华区双庆路616号25室', '123456', 1);
INSERT INTO `vip_info` VALUES (188, '2002-04-24 22:37:52', '2002-05-30 02:56:56', 0, NULL, '胡發', 1, 'FE-AB-2195-M', 0, '15488946201', '2002-03-29', '2009-12-05', 609.88, '2010-04-27', '中国成都市成华区玉双路6号930号46栋', '123456', 1);
INSERT INTO `vip_info` VALUES (189, '2020-12-14 05:20:08', '2001-05-23 06:31:29', 0, NULL, '唐詩涵', 1, 'DE-FE-9728-B', 0, '13069722598', '2000-11-10', '2021-09-02', 508.41, '2022-08-07', '中国东莞环区南街二巷916号33号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (190, '2003-04-01 06:17:17', '2004-08-02 17:49:25', 0, NULL, '姚家玲', 1, 'CE-AE-5464-M', 0, '17411968043', '2011-05-19', '2005-07-19', 474.46, '2021-09-14', '中国深圳罗湖区蔡屋围深南东路374号32室', '123456', 1);
INSERT INTO `vip_info` VALUES (191, '2023-11-08 12:01:49', '2011-02-01 04:32:04', 1, NULL, '邵天榮', 0, 'DA-BB-4045-X', 0, '13650950161', '2002-03-27', '2011-05-30', 279.33, '2023-05-04', '中国广州市海珠区江南西路528号21室', '123456', 1);
INSERT INTO `vip_info` VALUES (192, '2012-11-12 17:21:26', '2013-09-27 15:57:37', 0, NULL, '沈晓明', 0, 'EC-AC-5769-U', 0, '15387376207', '2010-11-27', '2007-09-27', 6.91, '2017-10-31', '中国成都市成华区双庆路340号10楼', '123456', 1);
INSERT INTO `vip_info` VALUES (193, '2016-05-13 03:08:45', '2008-12-19 04:08:57', 1, NULL, '鄧國榮', 1, 'BD-CA-6714-V', 0, '16671347896', '2004-01-31', '2023-05-09', 956.21, '2006-10-18', '中国中山京华商圈华夏街65号26栋', '123456', 1);
INSERT INTO `vip_info` VALUES (194, '2009-10-06 02:41:47', '2018-11-23 19:19:28', 0, NULL, '陳詠詩', 1, 'FB-CE-5357-M', 0, '14432190199', '2004-09-07', '2015-06-28', 684.75, '2007-03-02', '中国北京市朝阳区三里屯路285号22号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (195, '2015-11-06 08:07:16', '2012-11-29 01:07:59', 1, NULL, '莫嘉伦', 1, 'DF-CA-3082-N', 0, '16689679945', '2005-04-18', '2020-08-12', 489.88, '2009-10-17', '中国北京市房山区岳琉路248号1号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (196, '2002-12-22 14:08:36', '2002-02-27 01:18:06', 0, NULL, '马嘉伦', 0, 'AB-ED-8648-K', 0, '19937644960', '2010-08-27', '2009-11-07', 839.77, '2015-09-17', '中国深圳福田区深南大道405号10楼', '123456', 1);
INSERT INTO `vip_info` VALUES (197, '2004-09-26 19:09:19', '2024-12-17 19:38:47', 1, NULL, '何晓明', 1, 'FF-DB-7859-E', 0, '18020202380', '2013-01-31', '2021-01-27', 821.30, '2012-03-02', '中国东莞环区南街二巷442号2栋', '123456', 1);
INSERT INTO `vip_info` VALUES (198, '2017-01-02 08:05:26', '2008-11-20 17:23:30', 1, NULL, '汪詩涵', 1, 'ED-ED-0270-S', 0, '19747658556', '2024-08-25', '2019-09-12', 123.61, '2010-02-22', '中国北京市東城区東直門內大街237号17楼', '123456', 1);
INSERT INTO `vip_info` VALUES (199, '2009-12-14 17:28:35', '2003-08-04 04:37:09', 0, NULL, '陳家玲', 0, 'EF-EB-8928-S', 0, '14905011477', '2023-04-20', '2007-08-27', 183.53, '2011-05-19', '中国深圳龙岗区学园一巷204号13栋', '123456', 1);
INSERT INTO `vip_info` VALUES (200, '2003-04-20 12:44:14', '2001-03-12 03:31:28', 0, NULL, '邵仲賢', 1, 'CB-EC-6602-T', 0, '14839129018', '2018-04-17', '2006-12-11', 220.03, '2006-06-26', '中国北京市房山区岳琉路173号19栋', '123456', 1);
INSERT INTO `vip_info` VALUES (201, '2013-04-30 08:02:30', '2001-03-19 23:39:20', 0, NULL, '盧頴璇', 0, 'AF-AF-7425-H', 0, '14306422555', '2002-03-14', '2021-12-25', 487.25, '2002-09-18', '中国深圳福田区深南大道873号华润大厦30室', '123456', 1);
INSERT INTO `vip_info` VALUES (202, '2025-04-01 06:50:04', '2006-02-27 11:55:25', 1, NULL, '江秀英', 0, 'AB-AA-6070-S', 0, '19628786206', '2011-08-04', '2011-04-21', 55.05, '2021-06-11', '中国广州市天河区天河路160号29栋', '123456', 1);
INSERT INTO `vip_info` VALUES (203, '2005-11-16 15:27:00', '2006-09-09 04:23:06', 0, NULL, '白祖兒', 0, 'BB-EC-1232-P', 0, '16064466097', '2006-03-27', '2003-05-04', 759.64, '2017-08-23', '中国东莞东泰五街668号华润大厦35室', '123456', 1);
INSERT INTO `vip_info` VALUES (204, '2000-06-17 14:13:48', '2010-05-30 11:21:44', 1, NULL, '胡震南', 0, 'BB-BC-7966-Z', 0, '19917255634', '2016-06-16', '2023-07-20', 940.81, '2002-09-27', '中国广州市天河区天河路357号华润大厦20室', '123456', 1);
INSERT INTO `vip_info` VALUES (205, '2014-09-03 11:14:21', '2010-02-15 01:14:45', 1, NULL, '袁晓明', 0, 'EE-CF-4200-Y', 0, '17033484860', '2006-09-22', '2008-06-27', 440.95, '2010-11-15', '中国成都市锦江区人民南路四段496号2号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (206, '2012-06-23 09:42:27', '2022-08-24 07:47:49', 1, NULL, '袁子韬', 1, 'EB-DC-8651-B', 0, '17801017834', '2010-01-28', '2002-06-04', 29.56, '2014-11-25', '中国深圳罗湖区田贝一路368号华润大厦43室', '123456', 1);
INSERT INTO `vip_info` VALUES (207, '2005-04-12 14:49:00', '2015-04-21 00:30:40', 0, NULL, '郭安琪', 1, 'AD-DF-8806-F', 0, '16949357653', '2004-10-22', '2015-04-25', 928.61, '2021-06-01', '中国深圳福田区景田东一街931号华润大厦9室', '123456', 1);
INSERT INTO `vip_info` VALUES (208, '2021-08-05 08:08:06', '2010-07-27 16:41:33', 1, NULL, '刘宇宁', 1, 'EB-EA-5891-J', 0, '14603999937', '2003-08-08', '2022-07-24', 180.55, '2005-06-05', '中国上海市闵行区宾川路772号30栋', '123456', 1);
INSERT INTO `vip_info` VALUES (209, '2009-09-02 21:04:02', '2017-07-11 16:10:36', 1, NULL, '高安琪', 1, 'AD-AF-3068-Y', 0, '13313262623', '2012-02-04', '2022-06-25', 78.97, '2006-04-03', '中国北京市西城区西長安街163号5栋', '123456', 1);
INSERT INTO `vip_info` VALUES (210, '2021-02-18 11:40:34', '2009-11-22 12:08:24', 0, NULL, '謝俊宇', 1, 'DB-CC-9499-A', 0, '18011817867', '2009-10-02', '2010-12-07', 364.41, '2007-04-14', '中国成都市成华区二仙桥东三路378号32号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (211, '2017-08-07 04:09:38', '2015-08-06 20:37:26', 0, NULL, '林玲玲', 0, 'AA-CF-6858-B', 0, '17316505538', '2004-06-01', '2010-11-30', 626.66, '2021-04-26', '中国北京市東城区東直門內大街770号23室', '123456', 1);
INSERT INTO `vip_info` VALUES (212, '2001-12-27 05:48:33', '2024-06-19 18:15:28', 0, NULL, '狄志明', 0, 'AE-AF-8866-U', 0, '18551208259', '2006-12-21', '2007-08-19', 680.90, '2017-03-17', '中国中山京华商圈华夏街790号42楼', '123456', 1);
INSERT INTO `vip_info` VALUES (213, '2009-12-12 05:40:39', '2011-12-17 12:25:38', 0, NULL, '丁秀英', 0, 'CF-AB-1302-Q', 0, '18992382937', '2016-07-30', '2018-10-22', 617.39, '2001-10-29', '中国东莞坑美十五巷626号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (214, '2010-06-12 20:05:00', '2024-10-11 09:13:37', 1, NULL, '徐心穎', 1, 'DE-FC-9850-A', 0, '17696668450', '2022-06-26', '2001-12-27', 543.33, '2012-03-03', '中国北京市西城区西長安街407号32栋', '123456', 1);
INSERT INTO `vip_info` VALUES (215, '2010-08-05 22:07:39', '2018-05-04 12:01:45', 1, NULL, '薛國權', 0, 'FC-DA-1804-J', 0, '19788559137', '2025-02-03', '2012-12-27', 885.30, '2006-11-22', '中国深圳罗湖区田贝一路669号50楼', '123456', 1);
INSERT INTO `vip_info` VALUES (216, '2000-05-09 10:36:10', '2014-09-17 21:41:19', 1, NULL, '徐睿', 0, 'BE-FA-5210-Q', 0, '13406335304', '2017-05-28', '2005-01-18', 434.04, '2008-11-17', '中国广州市越秀区中山二路559号华润大厦28室', '123456', 1);
INSERT INTO `vip_info` VALUES (217, '2000-06-22 02:08:54', '2008-02-11 01:12:56', 0, NULL, '萬永發', 0, 'BC-EF-2709-N', 0, '15906772128', '2022-11-13', '2000-10-05', 712.05, '2023-04-03', '中国北京市東城区東直門內大街795号6栋', '123456', 1);
INSERT INTO `vip_info` VALUES (218, '2017-06-29 05:48:19', '2001-09-15 15:25:26', 1, NULL, '汪思妤', 0, 'CE-FF-6179-I', 0, '13636101249', '2014-05-07', '2009-12-23', 206.51, '2014-11-30', '中国成都市成华区二仙桥东三路511号40室', '123456', 1);
INSERT INTO `vip_info` VALUES (219, '2023-09-02 07:58:30', '2004-04-24 18:48:35', 0, NULL, '钟震南', 1, 'DE-EA-3375-W', 0, '16364222839', '2005-12-08', '2002-06-26', 444.60, '2016-10-15', '中国深圳罗湖区蔡屋围深南东路718号4号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (220, '2011-07-12 17:38:37', '2008-10-13 23:49:34', 1, NULL, '谷秀文', 1, 'AD-DB-6958-W', 0, '15310764225', '2017-06-16', '2017-02-09', 563.04, '2000-09-07', '中国北京市朝阳区三里屯路139号35号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (221, '2006-05-14 11:55:15', '2010-12-07 00:59:45', 0, NULL, '羅家強', 0, 'FB-FB-8429-M', 0, '19157666509', '2012-09-05', '2009-10-27', 436.27, '2024-11-06', '中国上海市浦东新区健祥路286号华润大厦26室', '123456', 1);
INSERT INTO `vip_info` VALUES (222, '2008-01-01 04:57:13', '2005-12-30 08:59:50', 0, NULL, '卢詩涵', 1, 'EA-BD-8242-M', 0, '15304332642', '2021-08-26', '2012-11-03', 330.74, '2000-03-22', '中国北京市朝阳区三里屯路616号8楼', '123456', 1);
INSERT INTO `vip_info` VALUES (223, '2012-02-16 00:20:48', '2020-12-24 14:21:06', 0, NULL, '程震南', 1, 'AA-CB-4341-P', 0, '13917896891', '2008-05-30', '2020-06-28', 196.87, '2016-01-02', '中国广州市海珠区江南西路449号37室', '123456', 1);
INSERT INTO `vip_info` VALUES (224, '2021-09-24 12:17:13', '2010-05-17 09:42:32', 0, NULL, '萧岚', 1, 'DD-CE-9558-C', 0, '17126570026', '2005-08-21', '2013-03-19', 432.44, '2011-05-10', '中国中山紫马岭商圈中山五路27号10室', '123456', 1);
INSERT INTO `vip_info` VALUES (225, '2004-05-13 01:31:26', '2013-10-22 09:54:05', 0, NULL, '郝晓明', 0, 'FC-CE-6424-X', 0, '14198677992', '2008-09-29', '2012-12-04', 928.35, '2025-02-13', '中国中山天河区大信商圈大信南路660号华润大厦24室', '123456', 1);
INSERT INTO `vip_info` VALUES (226, '2012-06-17 08:16:26', '2024-11-13 09:24:09', 1, NULL, '顧詠詩', 0, 'BC-EB-2052-W', 0, '15280415414', '2012-09-21', '2011-03-21', 800.48, '2025-05-08', '中国北京市朝阳区三里屯路746号10楼', '123456', 1);
INSERT INTO `vip_info` VALUES (227, '2000-12-21 10:15:44', '2009-11-23 19:21:18', 1, NULL, '胡嘉伦', 1, 'DB-AB-2964-Y', 0, '16221225348', '2017-03-04', '2017-12-23', 897.55, '2002-09-16', '中国成都市成华区双庆路653号47栋', '123456', 1);
INSERT INTO `vip_info` VALUES (228, '2016-05-07 09:27:54', '2009-09-02 12:03:24', 1, NULL, '许晓明', 1, 'EE-EB-3168-A', 0, '19309111146', '2016-03-02', '2020-02-24', 352.13, '2022-11-29', '中国北京市房山区岳琉路96号10号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (229, '2005-11-28 11:10:55', '2013-09-18 18:44:46', 1, NULL, '宋杰宏', 1, 'ED-FB-4198-W', 0, '18075124155', '2014-04-10', '2001-04-08', 592.90, '2013-09-16', '中国上海市徐汇区虹桥路45号18栋', '123456', 1);
INSERT INTO `vip_info` VALUES (230, '2014-03-12 14:25:04', '2000-06-08 16:20:02', 1, NULL, '谷天榮', 1, 'FA-DB-2649-K', 0, '13583455173', '2000-08-28', '2021-01-21', 688.29, '2002-05-03', '中国成都市成华区双庆路803号28栋', '123456', 1);
INSERT INTO `vip_info` VALUES (231, '2015-07-29 11:13:42', '2000-01-16 20:31:56', 1, NULL, '苏震南', 1, 'CF-BF-8182-Z', 0, '18161457800', '2014-10-27', '2002-07-07', 379.69, '2005-08-28', '中国中山乐丰六路71号3室', '123456', 1);
INSERT INTO `vip_info` VALUES (232, '2005-07-27 14:14:15', '2004-01-25 02:20:04', 1, NULL, '钟杰宏', 0, 'DF-FC-8183-E', 0, '18817434664', '2018-10-17', '2025-05-21', 892.97, '2005-11-02', '中国广州市天河区天河路87号2楼', '123456', 1);
INSERT INTO `vip_info` VALUES (233, '2021-02-07 19:24:37', '2023-08-01 21:01:48', 1, NULL, '曹發', 1, 'FE-FC-8958-R', 0, '19175290073', '2014-11-23', '2024-11-28', 127.52, '2022-01-17', '中国深圳龙岗区学园一巷50号43室', '123456', 1);
INSERT INTO `vip_info` VALUES (234, '2024-06-25 13:01:25', '2001-01-21 00:37:12', 1, NULL, '甘慧嫻', 0, 'BA-DA-8876-R', 0, '13933603137', '2000-05-15', '2013-06-10', 943.73, '2021-01-28', '中国广州市白云区机场路棠苑街五巷189号2栋', '123456', 1);
INSERT INTO `vip_info` VALUES (235, '2005-09-16 21:35:50', '2025-02-11 12:13:35', 1, NULL, '郭家強', 1, 'AB-FF-9298-G', 0, '15472172371', '2007-01-31', '2009-06-27', 228.86, '2020-01-26', '中国广州市天河区天河路976号22室', '123456', 1);
INSERT INTO `vip_info` VALUES (236, '2019-07-24 19:05:02', '2017-06-29 10:31:05', 0, NULL, '郝云熙', 0, 'CF-AE-2519-F', 0, '17611856639', '2018-10-19', '2013-01-16', 794.25, '2001-04-16', '中国东莞坑美十五巷357号华润大厦27室', '123456', 1);
INSERT INTO `vip_info` VALUES (237, '2019-08-20 20:20:08', '2008-08-30 19:40:19', 1, NULL, '謝富城', 1, 'AD-FF-1885-J', 0, '17427032218', '2016-08-31', '2003-12-21', 436.39, '2025-02-07', '中国深圳福田区景田东一街205号华润大厦37室', '123456', 1);
INSERT INTO `vip_info` VALUES (238, '2017-07-06 09:23:37', '2018-09-20 21:09:16', 0, NULL, '贾璐', 1, 'BF-FF-2780-B', 0, '14491166082', '2010-05-16', '2021-06-08', 444.18, '2008-12-25', '中国深圳罗湖区清水河一路585号5室', '123456', 1);
INSERT INTO `vip_info` VALUES (239, '2008-01-06 12:35:20', '2010-09-05 14:23:15', 1, NULL, '向震南', 1, 'EB-BE-6877-L', 0, '14596740050', '2010-04-03', '2016-09-12', 547.80, '2009-09-03', '中国北京市房山区岳琉路668号50室', '123456', 1);
INSERT INTO `vip_info` VALUES (240, '2010-12-10 09:42:26', '2024-06-03 21:29:01', 1, NULL, '方詩涵', 1, 'CA-DC-1255-S', 0, '17331120027', '2021-06-01', '2014-09-03', 432.91, '2017-03-10', '中国中山京华商圈华夏街83号2室', '123456', 1);
INSERT INTO `vip_info` VALUES (241, '2013-06-12 00:04:29', '2000-11-15 13:31:17', 0, NULL, '藤梓晴', 0, 'CF-BB-5563-Y', 0, '14581637661', '2021-06-03', '2011-12-30', 862.04, '2010-04-28', '中国成都市锦江区人民南路四段328号华润大厦42室', '123456', 1);
INSERT INTO `vip_info` VALUES (242, '2002-12-01 06:00:05', '2004-04-24 00:38:24', 0, NULL, '毛青雲', 0, 'EE-AD-6559-K', 0, '19517125589', '2024-11-19', '2001-11-09', 487.49, '2002-09-20', '中国中山紫马岭商圈中山五路826号30楼', '123456', 1);
INSERT INTO `vip_info` VALUES (243, '2013-08-03 13:52:05', '2000-04-05 14:16:02', 0, NULL, '王浩然', 1, 'CE-CE-4332-T', 0, '18890386771', '2007-09-03', '2013-04-24', 865.62, '2025-06-19', '中国深圳福田区深南大道441号47室', '123456', 1);
INSERT INTO `vip_info` VALUES (244, '2014-05-16 13:13:25', '2025-01-17 19:21:27', 0, NULL, '姜岚', 0, 'BB-DC-0118-I', 0, '13153134095', '2020-08-27', '2018-12-21', 921.80, '2001-04-11', '中国深圳罗湖区清水河一路79号8楼', '123456', 1);
INSERT INTO `vip_info` VALUES (245, '2009-09-18 10:25:55', '2006-02-09 09:05:43', 1, NULL, '戴朝偉', 0, 'BA-CE-8510-I', 0, '18930278761', '2015-05-05', '2018-01-27', 893.00, '2020-05-01', '中国深圳龙岗区布吉镇西环路16号华润大厦37室', '123456', 1);
INSERT INTO `vip_info` VALUES (246, '2023-12-09 21:24:14', '2003-03-05 06:01:11', 1, NULL, '史秀英', 1, 'CB-DF-2047-R', 0, '15663849377', '2015-09-20', '2023-08-25', 916.27, '2006-05-10', '中国广州市越秀区中山二路529号27楼', '123456', 1);
INSERT INTO `vip_info` VALUES (247, '2010-06-19 08:50:17', '2022-02-27 10:16:07', 1, NULL, '白淑怡', 1, 'EA-AF-3951-Y', 0, '19405829303', '2006-04-23', '2005-10-10', 213.20, '2022-02-09', '中国东莞珊瑚路137号华润大厦34室', '123456', 1);
INSERT INTO `vip_info` VALUES (248, '2002-09-11 00:24:37', '2016-03-01 08:11:12', 1, NULL, '袁秀英', 1, 'DD-EC-0736-K', 0, '19303896372', '2002-03-08', '2018-12-16', 32.49, '2021-12-12', '中国成都市成华区玉双路6号25号2栋', '123456', 1);
INSERT INTO `vip_info` VALUES (249, '2013-11-06 06:39:59', '2022-05-27 04:54:35', 1, NULL, '尹明詩', 1, 'BF-DF-1897-F', 0, '16645449743', '2020-10-23', '2017-12-27', 124.17, '2009-09-11', '中国中山京华商圈华夏街945号26栋', '123456', 1);
INSERT INTO `vip_info` VALUES (250, '2023-04-12 05:55:55', '2016-05-07 16:22:16', 0, NULL, '苗慧琳', 0, 'FC-CF-7312-G', 0, '15698368524', '2019-11-28', '2006-03-20', 981.48, '2005-04-03', '中国深圳福田区深南大道400号28室', '123456', 1);
INSERT INTO `vip_info` VALUES (251, '2019-11-13 14:59:44', '2011-03-02 00:46:17', 0, NULL, '陶安娜', 0, 'AC-FE-6501-Z', 0, '15476784233', '2023-11-01', '2020-06-02', 126.65, '2016-02-18', '中国中山紫马岭商圈中山五路9号6号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (252, '2019-07-25 10:46:20', '2006-09-28 21:09:36', 1, NULL, '成家明', 1, 'AB-BB-1681-B', 0, '18776056758', '2001-10-04', '2010-11-25', 324.46, '2013-05-05', '中国北京市东城区东单王府井东街875号24栋', '123456', 1);
INSERT INTO `vip_info` VALUES (253, '2006-08-26 05:12:24', '2010-04-26 04:22:29', 1, NULL, '谭震南', 0, 'CF-BD-4029-S', 0, '14150892410', '2014-05-15', '2004-07-05', 956.01, '2022-04-14', '中国东莞坑美十五巷753号27号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (254, '2007-01-24 02:41:30', '2000-10-10 06:01:04', 1, NULL, '唐家明', 1, 'BD-EE-4847-R', 0, '13765386622', '2021-05-16', '2017-08-07', 719.24, '2019-03-29', '中国广州市越秀区中山二路977号41号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (255, '2007-03-08 13:32:57', '2015-11-03 23:21:13', 0, NULL, '莫家強', 1, 'FE-DD-3081-M', 0, '17289932264', '2011-04-21', '2018-10-05', 916.98, '2006-04-21', '中国北京市東城区東直門內大街446号30栋', '123456', 1);
INSERT INTO `vip_info` VALUES (256, '2019-09-27 11:36:40', '2019-09-16 09:58:27', 0, NULL, '武震南', 0, 'BF-CF-1577-P', 0, '17308274901', '2013-04-09', '2011-10-04', 783.19, '2023-03-18', '中国成都市成华区玉双路6号726号华润大厦45室', '123456', 1);
INSERT INTO `vip_info` VALUES (257, '2006-10-15 08:04:27', '2002-03-18 07:57:39', 1, NULL, '楊天榮', 0, 'BD-AF-0819-J', 0, '18155343055', '2022-02-19', '2000-08-04', 700.27, '2010-08-26', '中国东莞环区南街二巷518号华润大厦43室', '123456', 1);
INSERT INTO `vip_info` VALUES (258, '2002-08-29 21:01:16', '2020-02-11 22:25:38', 1, NULL, '谢子异', 1, 'CD-EB-0070-E', 0, '17498690842', '2005-04-17', '2023-10-09', 766.38, '2013-08-08', '中国上海市浦东新区健祥路263号1室', '123456', 1);
INSERT INTO `vip_info` VALUES (259, '2009-01-14 22:46:00', '2005-01-25 20:09:57', 0, NULL, '向晓明', 0, 'CD-DA-7253-Y', 0, '19499893176', '2021-05-05', '2018-04-25', 348.53, '2010-10-30', '中国中山乐丰六路646号22室', '123456', 1);
INSERT INTO `vip_info` VALUES (260, '2010-08-30 16:40:08', '2023-04-18 16:12:18', 0, NULL, '程子韬', 1, 'CF-DA-9604-Q', 0, '14645655201', '2007-01-17', '2023-04-17', 51.24, '2018-07-14', '中国上海市徐汇区虹桥路437号华润大厦49室', '123456', 1);
INSERT INTO `vip_info` VALUES (261, '2001-09-26 04:12:30', '2002-01-30 13:07:17', 1, NULL, '江致远', 1, 'ED-AB-1065-W', 0, '15148645627', '2020-02-05', '2016-05-25', 748.12, '2017-04-16', '中国北京市西城区复兴门内大街843号3栋', '123456', 1);
INSERT INTO `vip_info` VALUES (262, '2013-06-17 20:15:39', '2011-08-18 19:19:53', 1, NULL, '何惠妹', 1, 'AF-BA-0986-V', 0, '14574559763', '2018-08-01', '2010-01-11', 630.11, '2008-10-05', '中国北京市东城区东单王府井东街107号华润大厦41室', '123456', 1);
INSERT INTO `vip_info` VALUES (263, '2024-08-20 08:26:40', '2008-05-25 17:43:29', 0, NULL, '曹國明', 0, 'DD-FA-4809-A', 0, '14091249898', '2018-02-27', '2010-12-03', 883.57, '2008-11-15', '中国北京市西城区西長安街572号46室', '123456', 1);
INSERT INTO `vip_info` VALUES (264, '2002-08-02 11:14:12', '2006-08-25 09:22:58', 0, NULL, '高慧儀', 1, 'CA-AD-2496-R', 0, '18818780331', '2022-09-27', '2010-02-16', 903.65, '2008-02-15', '中国成都市成华区玉双路6号222号8栋', '123456', 1);
INSERT INTO `vip_info` VALUES (265, '2016-11-30 20:33:57', '2003-03-23 13:08:10', 0, NULL, '梁震南', 0, 'BD-EF-0069-L', 0, '14943010383', '2022-03-12', '2010-07-07', 682.18, '2022-03-30', '中国深圳福田区景田东一街807号2楼', '123456', 1);
INSERT INTO `vip_info` VALUES (266, '2016-05-28 22:28:36', '2017-05-05 22:59:10', 0, NULL, '王德華', 0, 'BD-FD-1962-N', 0, '15569672199', '2001-11-01', '2003-12-28', 603.37, '2009-01-02', '中国北京市東城区東直門內大街584号华润大厦33室', '123456', 1);
INSERT INTO `vip_info` VALUES (267, '2015-04-07 20:23:24', '2015-05-10 10:52:14', 1, NULL, '邱安娜', 0, 'DE-DB-1187-D', 0, '14531274471', '2021-12-26', '2007-08-29', 665.01, '2011-02-06', '中国上海市闵行区宾川路342号36栋', '123456', 1);
INSERT INTO `vip_info` VALUES (268, '2019-08-04 13:26:00', '2007-12-11 23:11:01', 0, NULL, '謝杰倫', 0, 'FD-BE-1860-W', 0, '13463789810', '2018-12-18', '2016-11-28', 443.92, '2005-03-06', '中国广州市天河区天河路759号华润大厦39室', '123456', 1);
INSERT INTO `vip_info` VALUES (269, '2019-12-23 12:42:46', '2015-02-13 23:45:37', 1, NULL, '秦璐', 1, 'AA-CB-6453-X', 0, '15203754639', '2025-03-30', '2006-11-08', 893.11, '2022-02-13', '中国北京市東城区東直門內大街97号42楼', '123456', 1);
INSERT INTO `vip_info` VALUES (270, '2016-04-27 21:39:30', '2018-07-04 10:11:06', 0, NULL, '沈岚', 1, 'AB-BB-7016-J', 0, '17489087373', '2004-12-04', '2008-12-15', 128.42, '2005-12-04', '中国北京市房山区岳琉路298号31栋', '123456', 1);
INSERT INTO `vip_info` VALUES (271, '2006-09-22 03:33:52', '2014-10-27 18:37:48', 0, NULL, '尹宇宁', 1, 'FC-BB-0600-Q', 0, '16126906115', '2002-07-17', '2014-04-17', 218.45, '2015-01-14', '中国北京市延庆区028县道914号34号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (272, '2000-02-02 01:43:02', '2005-08-07 12:14:27', 1, NULL, '段云熙', 0, 'DD-AC-3690-A', 0, '17807982377', '2021-01-23', '2004-11-18', 298.69, '2023-06-24', '中国深圳罗湖区蔡屋围深南东路768号36栋', '123456', 1);
INSERT INTO `vip_info` VALUES (273, '2014-01-29 20:52:49', '2019-02-09 17:47:45', 1, NULL, '呂心穎', 0, 'EF-BA-2922-B', 0, '18223977836', '2023-05-27', '2019-06-09', 440.45, '2002-06-12', '中国深圳龙岗区布吉镇西环路419号26号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (274, '2002-07-05 15:00:24', '2007-04-21 12:15:45', 1, NULL, '向杰宏', 1, 'AB-BF-5222-Q', 0, '18662742850', '2001-08-03', '2017-05-12', 461.19, '2002-06-01', '中国广州市天河区天河路959号39室', '123456', 1);
INSERT INTO `vip_info` VALUES (275, '2013-02-12 17:20:58', '2010-02-08 04:17:19', 0, NULL, '房裕玲', 1, 'CB-DA-9198-A', 0, '18962007449', '2013-04-16', '2012-07-22', 438.56, '2016-01-28', '中国北京市东城区东单王府井东街103号36楼', '123456', 1);
INSERT INTO `vip_info` VALUES (276, '2011-03-21 10:43:47', '2015-08-03 04:37:04', 0, NULL, '杨岚', 0, 'AF-BE-6647-J', 0, '19137498535', '2003-08-13', '2021-02-04', 510.67, '2017-07-14', '中国中山紫马岭商圈中山五路244号30栋', '123456', 1);
INSERT INTO `vip_info` VALUES (277, '2010-04-28 01:46:11', '2019-07-02 20:15:31', 1, NULL, '程安琪', 1, 'AC-CE-5767-X', 0, '14776822461', '2014-10-28', '2015-05-15', 880.66, '2014-08-06', '中国北京市房山区岳琉路676号18楼', '123456', 1);
INSERT INTO `vip_info` VALUES (278, '2004-03-16 01:30:09', '2010-06-13 00:19:53', 0, NULL, '韓榮發', 1, 'AF-CA-0234-K', 0, '15340107366', '2000-05-12', '2003-02-28', 284.98, '2015-04-03', '中国深圳罗湖区清水河一路688号华润大厦26室', '123456', 1);
INSERT INTO `vip_info` VALUES (279, '2003-09-20 07:31:12', '2013-09-04 10:51:10', 0, NULL, '萬慧琳', 1, 'ED-EB-7269-S', 0, '16856005111', '2015-03-25', '2016-05-14', 432.28, '2020-10-14', '中国中山乐丰六路697号32室', '123456', 1);
INSERT INTO `vip_info` VALUES (280, '2022-11-21 07:22:06', '2025-04-25 21:47:47', 1, NULL, '马杰宏', 1, 'CB-DE-7977-E', 0, '18985218474', '2008-02-05', '2002-10-12', 142.70, '2021-10-04', '中国深圳龙岗区学园一巷168号21号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (281, '2011-11-20 20:41:06', '2001-02-03 05:44:23', 0, NULL, '曹璐', 0, 'ED-BB-9520-V', 0, '18347370006', '2021-08-22', '2021-01-03', 715.84, '2004-05-13', '中国中山天河区大信商圈大信南路60号32号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (282, '2010-10-27 14:55:23', '2021-05-12 21:06:07', 1, NULL, '陆杰宏', 1, 'DD-CE-9263-P', 0, '17423727518', '2018-11-24', '2020-02-27', 864.35, '2018-07-11', '中国中山天河区大信商圈大信南路713号24楼', '123456', 1);
INSERT INTO `vip_info` VALUES (283, '2010-06-16 22:24:36', '2008-02-15 20:47:48', 1, NULL, '戴志遠', 0, 'EA-AF-3695-B', 0, '17627315415', '2000-07-15', '2000-03-01', 926.50, '2019-11-23', '中国上海市黄浦区淮海中路168号37号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (284, '2024-03-07 01:11:34', '2000-06-20 00:38:32', 0, NULL, '邹宇宁', 0, 'BC-CC-6983-O', 0, '19300001407', '2019-08-03', '2003-05-31', 538.28, '2013-03-06', '中国深圳罗湖区清水河一路759号33号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (285, '2008-03-08 17:46:56', '2019-09-28 19:23:03', 1, NULL, '韦致远', 0, 'FC-BE-1744-M', 0, '17335859988', '2015-10-30', '2024-02-26', 763.72, '2000-11-03', '中国上海市闵行区宾川路590号12号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (286, '2006-10-27 12:06:44', '2016-04-24 21:35:37', 0, NULL, '邓秀英', 1, 'AE-DE-4703-H', 0, '19612525887', '2017-12-26', '2003-01-03', 190.21, '2020-01-13', '中国北京市延庆区028县道144号31楼', '123456', 1);
INSERT INTO `vip_info` VALUES (287, '2020-03-19 11:09:28', '2000-05-19 19:55:47', 0, NULL, '阎璐', 1, 'CC-FB-1659-H', 0, '13374412588', '2017-11-02', '2006-12-24', 707.55, '2002-01-10', '中国东莞环区南街二巷318号华润大厦48室', '123456', 1);
INSERT INTO `vip_info` VALUES (288, '2008-04-16 06:47:14', '2021-07-02 11:06:16', 0, NULL, '史安琪', 1, 'AF-FB-9583-Q', 0, '16026683288', '2024-12-01', '2022-12-05', 18.26, '2013-07-31', '中国北京市東城区東直門內大街747号华润大厦39室', '123456', 1);
INSERT INTO `vip_info` VALUES (289, '2010-07-20 09:39:58', '2020-06-21 22:14:10', 1, NULL, '楊國明', 1, 'CE-DC-5131-C', 0, '19655151753', '2025-03-21', '2022-02-03', 457.68, '2005-10-25', '中国北京市东城区东单王府井东街595号45号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (290, '2000-07-18 13:44:41', '2004-10-14 19:01:06', 0, NULL, '薛思妤', 0, 'CD-FB-0192-U', 0, '19179721832', '2018-04-08', '2009-05-13', 893.77, '2003-03-19', '中国深圳罗湖区田贝一路537号33栋', '123456', 1);
INSERT INTO `vip_info` VALUES (291, '2006-10-11 09:30:50', '2024-03-09 10:57:01', 0, NULL, '崔璐', 1, 'AE-AA-7256-M', 0, '14147483597', '2007-11-18', '2011-03-11', 16.74, '2008-07-29', '中国中山京华商圈华夏街828号16楼', '123456', 1);
INSERT INTO `vip_info` VALUES (292, '2023-02-27 22:48:06', '2018-03-14 19:41:07', 0, NULL, '罗子韬', 0, 'EE-DD-3681-S', 0, '15554986790', '2012-05-02', '2015-09-29', 474.46, '2007-10-23', '中国成都市锦江区红星路三段983号17室', '123456', 1);
INSERT INTO `vip_info` VALUES (293, '2007-11-08 02:06:48', '2024-04-16 16:48:04', 1, NULL, '黄詩涵', 0, 'CB-BD-3675-J', 0, '18637075563', '2001-10-15', '2005-07-08', 0.53, '2023-04-05', '中国东莞坑美十五巷37号华润大厦33室', '123456', 1);
INSERT INTO `vip_info` VALUES (294, '2018-11-30 02:04:13', '2000-01-21 15:19:34', 0, NULL, '廖杰倫', 0, 'AD-CD-7393-N', 0, '17916553134', '2021-06-26', '2004-05-03', 858.22, '2007-06-26', '中国东莞珊瑚路858号38室', '123456', 1);
INSERT INTO `vip_info` VALUES (295, '2008-12-23 15:50:14', '2020-07-17 13:59:36', 1, NULL, '薛安琪', 1, 'EF-AB-6308-E', 0, '16050278663', '2004-06-08', '2003-01-18', 774.24, '2018-08-13', '中国上海市黄浦区淮海中路930号23栋', '123456', 1);
INSERT INTO `vip_info` VALUES (296, '2025-02-08 02:00:20', '2018-05-12 22:40:11', 1, NULL, '龙子韬', 1, 'FC-FD-3535-A', 0, '19593429899', '2022-10-30', '2007-10-22', 102.65, '2014-11-27', '中国成都市成华区玉双路6号993号25室', '123456', 1);
INSERT INTO `vip_info` VALUES (297, '2022-08-04 17:58:07', '2020-08-10 19:12:50', 0, NULL, '孙晓明', 0, 'EB-EC-0225-I', 0, '17879264169', '2002-07-18', '2018-02-02', 101.56, '2007-04-10', '中国北京市西城区复兴门内大街409号华润大厦47室', '123456', 1);
INSERT INTO `vip_info` VALUES (298, '2025-01-14 12:21:14', '2023-08-14 09:09:28', 0, NULL, '邵致远', 0, 'CF-CD-1283-E', 0, '19496227664', '2005-05-05', '2015-12-13', 27.24, '2004-02-29', '中国中山乐丰六路187号10号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (299, '2008-05-31 08:45:00', '2017-03-06 15:00:59', 1, NULL, '熊詩涵', 1, 'AB-DD-2659-O', 0, '18679447285', '2010-01-04', '2021-07-28', 732.72, '2014-02-06', '中国深圳龙岗区学园一巷397号20号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (300, '2007-04-30 14:39:15', '2015-01-19 22:16:21', 0, NULL, '田詩涵', 0, 'AD-BF-1636-J', 0, '13755285676', '2024-11-12', '2002-06-23', 395.68, '2019-11-12', '中国北京市朝阳区三里屯路154号24楼', '123456', 1);
INSERT INTO `vip_info` VALUES (301, '2017-11-13 03:09:24', '2011-05-10 14:22:37', 1, NULL, '贾璐', 1, 'DD-FA-2663-R', 0, '14305285618', '2001-02-21', '2004-10-19', 397.56, '2022-04-12', '中国北京市朝阳区三里屯路841号15号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (302, '2024-12-23 06:45:31', '2012-09-16 00:34:45', 1, NULL, '何睿', 0, 'CD-BA-8168-F', 0, '15879437811', '2004-03-12', '2015-04-19', 181.14, '2021-11-08', '中国广州市天河区天河路768号13栋', '123456', 1);
INSERT INTO `vip_info` VALUES (303, '2019-10-15 04:24:32', '2003-04-22 10:35:40', 0, NULL, '赵詩涵', 0, 'EE-DF-1023-Z', 0, '18845279491', '2010-02-13', '2007-11-30', 163.09, '2024-07-23', '中国成都市成华区玉双路6号468号18室', '123456', 1);
INSERT INTO `vip_info` VALUES (304, '2019-09-10 03:33:09', '2011-12-20 15:51:52', 1, NULL, '尹子韬', 1, 'AA-DC-2187-V', 0, '16541105474', '2017-01-22', '2013-08-23', 775.45, '2006-09-03', '中国中山紫马岭商圈中山五路147号15号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (305, '2015-08-18 07:41:59', '2023-11-17 12:47:45', 1, NULL, '蔡詠詩', 1, 'DA-CA-2532-I', 0, '14926562708', '2005-04-13', '2005-02-24', 36.03, '2008-06-15', '中国广州市白云区机场路棠苑街五巷999号40号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (306, '2005-02-25 12:51:42', '2017-12-11 20:32:49', 0, NULL, '陆震南', 0, 'AB-FA-6919-Y', 0, '18880918739', '2016-05-13', '2015-05-01', 456.68, '2005-09-10', '中国北京市东城区东单王府井东街240号华润大厦13室', '123456', 1);
INSERT INTO `vip_info` VALUES (307, '2017-08-21 02:30:48', '2022-12-31 13:13:44', 1, NULL, '邵睿', 0, 'FB-EF-4383-M', 0, '18029668123', '2001-05-25', '2012-07-03', 663.60, '2014-05-09', '中国北京市东城区东单王府井东街770号华润大厦39室', '123456', 1);
INSERT INTO `vip_info` VALUES (308, '2001-09-13 11:37:30', '2017-03-23 22:16:47', 1, NULL, '梁秀英', 0, 'EA-FB-6145-U', 0, '19292230771', '2014-05-19', '2003-08-29', 29.46, '2018-02-17', '中国东莞环区南街二巷14号3号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (309, '2012-04-20 16:00:51', '2022-02-22 13:59:43', 1, NULL, '羅惠妹', 0, 'DB-EE-0199-J', 0, '13706581586', '2024-07-16', '2001-04-22', 287.27, '2007-02-24', '中国成都市成华区二仙桥东三路554号43栋', '123456', 1);
INSERT INTO `vip_info` VALUES (310, '2005-11-02 07:08:17', '2004-02-07 10:52:42', 1, NULL, '狄詠詩', 0, 'CA-CD-3815-V', 0, '15939114265', '2006-02-27', '2000-08-12', 352.71, '2001-05-18', '中国广州市越秀区中山二路923号35楼', '123456', 1);
INSERT INTO `vip_info` VALUES (311, '2011-09-07 07:05:32', '2016-05-25 12:49:01', 0, NULL, '駱家強', 0, 'FC-FE-9380-R', 0, '15687712215', '2024-11-18', '2013-06-18', 675.44, '2022-04-28', '中国上海市闵行区宾川路238号22栋', '123456', 1);
INSERT INTO `vip_info` VALUES (312, '2001-07-25 18:16:29', '2000-09-07 06:46:07', 1, NULL, '马云熙', 1, 'FF-BD-3326-N', 0, '14540867724', '2022-02-28', '2008-03-17', 762.63, '2019-05-08', '中国北京市西城区复兴门内大街446号华润大厦24室', '123456', 1);
INSERT INTO `vip_info` VALUES (313, '2022-12-29 08:59:10', '2009-06-04 14:09:15', 0, NULL, '贾震南', 1, 'AA-BA-0096-E', 0, '18519549431', '2002-05-22', '2020-08-26', 289.93, '2012-08-24', '中国上海市黄浦区淮海中路700号11楼', '123456', 1);
INSERT INTO `vip_info` VALUES (314, '2012-02-23 20:10:09', '2017-05-14 08:14:51', 1, NULL, '钟詩涵', 0, 'CA-CE-2192-Z', 0, '14132184453', '2016-10-14', '2024-11-06', 676.71, '2004-05-22', '中国成都市成华区双庆路871号24室', '123456', 1);
INSERT INTO `vip_info` VALUES (315, '2006-09-09 20:46:01', '2013-12-20 05:48:10', 1, NULL, '郭國明', 0, 'EF-EA-7161-P', 0, '14809426546', '2008-04-19', '2021-09-06', 10.13, '2001-03-14', '中国东莞珊瑚路832号24号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (316, '2018-05-21 03:57:12', '2008-10-09 14:16:14', 0, NULL, '雷宇宁', 0, 'FF-EE-1361-C', 0, '18543051221', '2018-02-17', '2017-08-21', 927.85, '2013-01-30', '中国北京市東城区東直門內大街891号16栋', '123456', 1);
INSERT INTO `vip_info` VALUES (317, '2015-11-28 03:13:00', '2025-02-26 01:20:15', 1, NULL, '任惠妹', 0, 'AC-BA-8741-S', 0, '17824584641', '2008-09-11', '2004-07-10', 512.56, '2019-01-13', '中国东莞东泰五街500号16号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (318, '2006-09-30 19:30:39', '2012-03-04 08:41:15', 0, NULL, '徐杰宏', 0, 'CA-CD-5280-I', 0, '17394798557', '2008-01-01', '2001-11-06', 683.55, '2014-04-22', '中国上海市闵行区宾川路757号3栋', '123456', 1);
INSERT INTO `vip_info` VALUES (319, '2014-10-02 00:37:56', '2016-07-06 22:06:16', 0, NULL, '吳國權', 1, 'DD-FB-7897-I', 0, '19879181734', '2005-06-22', '2007-11-07', 647.11, '2021-03-31', '中国中山乐丰六路692号华润大厦1室', '123456', 1);
INSERT INTO `vip_info` VALUES (320, '2016-09-18 00:20:41', '2011-09-25 06:18:20', 0, NULL, '蘇麗欣', 1, 'DA-AF-5199-G', 0, '18708935221', '2021-07-12', '2023-06-15', 283.92, '2000-08-17', '中国成都市成华区玉双路6号391号华润大厦28室', '123456', 1);
INSERT INTO `vip_info` VALUES (321, '2011-01-09 11:48:50', '2011-05-11 15:53:40', 1, NULL, '孔詩涵', 0, 'BC-AA-2099-W', 0, '17389922968', '2007-10-29', '2017-09-22', 178.38, '2008-07-06', '中国深圳罗湖区田贝一路645号华润大厦11室', '123456', 1);
INSERT INTO `vip_info` VALUES (322, '2010-05-06 03:42:42', '2020-05-16 14:46:23', 1, NULL, '严嘉伦', 0, 'CD-BC-5162-G', 0, '18898305981', '2017-07-31', '2012-05-24', 664.37, '2000-02-19', '中国广州市天河区天河路163号48栋', '123456', 1);
INSERT INTO `vip_info` VALUES (323, '2005-04-18 05:48:15', '2002-01-18 16:36:12', 1, NULL, '贺岚', 0, 'DC-BC-2515-V', 0, '15712559699', '2023-05-15', '2004-09-14', 772.89, '2014-11-13', '中国上海市黄浦区淮海中路230号25室', '123456', 1);
INSERT INTO `vip_info` VALUES (324, '2018-03-01 14:16:24', '2013-02-08 14:17:02', 0, NULL, '沈杰宏', 0, 'EF-FF-1568-J', 0, '16720668376', '2003-01-28', '2018-06-14', 300.83, '2012-03-04', '中国北京市东城区东单王府井东街751号1号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (325, '2012-07-16 14:50:24', '2006-05-20 09:55:52', 1, NULL, '沈致远', 1, 'BD-BD-1180-M', 0, '17960358840', '2021-05-06', '2002-10-02', 579.34, '2003-05-22', '中国中山天河区大信商圈大信南路901号14楼', '123456', 1);
INSERT INTO `vip_info` VALUES (326, '2006-06-29 06:35:27', '2005-12-05 01:01:41', 0, NULL, '崔岚', 0, 'CA-FD-1898-K', 0, '18844465704', '2008-04-02', '2012-06-24', 484.03, '2008-01-17', '中国广州市天河区天河路426号7栋', '123456', 1);
INSERT INTO `vip_info` VALUES (327, '2013-12-08 01:12:24', '2001-06-10 10:02:12', 1, NULL, '唐詩涵', 1, 'CE-BD-1053-B', 0, '18251746097', '2002-01-27', '2016-12-01', 147.58, '2010-12-05', '中国广州市海珠区江南西路980号华润大厦1室', '123456', 1);
INSERT INTO `vip_info` VALUES (328, '2018-11-03 19:22:50', '2019-01-19 03:06:06', 0, NULL, '贾震南', 0, 'ED-DA-5309-G', 0, '16580979747', '2000-11-07', '2013-04-30', 825.08, '2016-11-07', '中国深圳龙岗区布吉镇西环路513号华润大厦5室', '123456', 1);
INSERT INTO `vip_info` VALUES (329, '2002-01-28 12:57:09', '2015-07-27 16:28:09', 1, NULL, '任心穎', 1, 'FC-EA-6158-Y', 0, '16439210065', '2013-01-09', '2010-09-02', 399.39, '2016-07-16', '中国成都市成华区二仙桥东三路391号42号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (330, '2015-10-05 06:20:55', '2007-12-15 05:34:58', 0, NULL, '刘云熙', 0, 'CA-EB-0323-S', 0, '15140349603', '2022-08-10', '2011-10-29', 83.71, '2024-12-18', '中国成都市成华区双庆路275号48楼', '123456', 1);
INSERT INTO `vip_info` VALUES (331, '2000-08-13 02:49:37', '2020-12-25 17:23:49', 1, NULL, '戚明詩', 1, 'DC-CE-3548-Z', 0, '17549034658', '2023-06-23', '2006-06-30', 725.95, '2017-11-09', '中国深圳罗湖区田贝一路200号15栋', '123456', 1);
INSERT INTO `vip_info` VALUES (332, '2001-08-28 20:09:44', '2025-04-26 03:38:49', 0, NULL, '毛發', 0, 'AD-AB-8842-I', 0, '17830629394', '2013-06-21', '2001-02-02', 580.60, '2022-12-22', '中国东莞环区南街二巷633号26栋', '123456', 1);
INSERT INTO `vip_info` VALUES (333, '2025-04-26 14:00:22', '2011-12-05 19:29:55', 1, NULL, '阎杰宏', 0, 'FF-AB-0530-B', 0, '16913967338', '2014-04-29', '2012-11-17', 245.18, '2002-11-01', '中国广州市白云区小坪东路232号5栋', '123456', 1);
INSERT INTO `vip_info` VALUES (334, '2005-10-04 01:13:07', '2013-03-17 09:23:13', 1, NULL, '楊富城', 0, 'DA-BB-3797-D', 0, '16403445049', '2006-06-17', '2015-02-02', 280.87, '2011-03-17', '中国东莞珊瑚路739号37室', '123456', 1);
INSERT INTO `vip_info` VALUES (335, '2017-12-12 09:09:30', '2016-01-12 02:56:57', 0, NULL, '梁璐', 1, 'AF-BB-3983-V', 0, '16803838936', '2018-12-10', '2007-04-29', 136.87, '2002-09-15', '中国中山乐丰六路670号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (336, '2017-02-22 16:44:18', '2014-03-04 12:55:29', 0, NULL, '江子韬', 0, 'EA-AF-5792-L', 0, '16148436933', '2017-04-25', '2004-03-06', 585.70, '2017-01-11', '中国深圳龙岗区布吉镇西环路234号20楼', '123456', 1);
INSERT INTO `vip_info` VALUES (337, '2005-12-25 09:10:37', '2011-02-09 14:08:15', 1, NULL, '邱云熙', 1, 'BA-BC-8372-D', 0, '19845886678', '2022-06-26', '2011-11-19', 389.03, '2024-10-18', '中国北京市延庆区028县道495号30室', '123456', 1);
INSERT INTO `vip_info` VALUES (338, '2006-05-25 08:37:56', '2009-05-26 08:21:10', 0, NULL, '顾宇宁', 0, 'CC-CC-1206-B', 0, '17458590110', '2016-06-14', '2003-01-03', 174.57, '2019-03-20', '中国成都市锦江区人民南路四段187号19栋', '123456', 1);
INSERT INTO `vip_info` VALUES (339, '2025-03-15 06:26:17', '2008-07-09 16:54:20', 0, NULL, '鄧國權', 0, 'FA-FD-9881-Y', 0, '14025841752', '2013-02-19', '2003-01-24', 67.65, '2010-09-30', '中国上海市浦东新区健祥路149号26号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (340, '2009-07-27 10:40:07', '2020-10-26 04:48:52', 0, NULL, '陆子异', 1, 'BF-EA-4951-U', 0, '15251172583', '2017-08-23', '2002-06-28', 952.79, '2005-04-10', '中国成都市成华区二仙桥东三路482号26室', '123456', 1);
INSERT INTO `vip_info` VALUES (341, '2002-08-24 08:45:31', '2000-07-10 21:41:07', 1, NULL, '曾心穎', 1, 'BD-FB-4354-Y', 0, '17099631416', '2021-04-02', '2016-04-06', 284.15, '2007-09-14', '中国广州市白云区小坪东路336号20号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (342, '2023-12-02 10:19:00', '2015-07-07 00:10:22', 0, NULL, '汪潤發', 1, 'CD-DF-6548-W', 0, '16049133797', '2002-02-16', '2012-08-27', 641.27, '2018-10-04', '中国北京市朝阳区三里屯路725号26室', '123456', 1);
INSERT INTO `vip_info` VALUES (343, '2014-06-03 19:59:47', '2019-04-06 21:56:12', 0, NULL, '區青雲', 1, 'EE-DA-4093-H', 0, '15043474520', '2018-02-15', '2002-01-31', 526.38, '2007-10-26', '中国广州市越秀区中山二路118号46楼', '123456', 1);
INSERT INTO `vip_info` VALUES (344, '2003-07-08 12:02:52', '2002-07-01 06:45:30', 0, NULL, '孫思妤', 1, 'CF-BF-4834-K', 0, '15283183154', '2014-01-02', '2004-10-14', 445.34, '2025-04-03', '中国上海市浦东新区橄榄路194号华润大厦24室', '123456', 1);
INSERT INTO `vip_info` VALUES (345, '2023-09-17 16:15:40', '2009-02-25 11:22:17', 0, NULL, '汪璐', 1, 'DC-EC-5798-C', 0, '19722405918', '2025-01-01', '2013-02-13', 0.37, '2012-01-31', '中国北京市延庆区028县道534号华润大厦7室', '123456', 1);
INSERT INTO `vip_info` VALUES (346, '2000-03-15 18:54:27', '2000-07-10 22:38:02', 1, NULL, '陶子异', 1, 'DC-BD-3777-F', 0, '15608111624', '2021-11-14', '2011-03-22', 906.83, '2023-11-28', '中国成都市成华区双庆路700号18室', '123456', 1);
INSERT INTO `vip_info` VALUES (347, '2023-02-06 04:45:45', '2025-02-19 04:38:24', 1, NULL, '常嘉伦', 1, 'AA-CC-2354-L', 0, '14941475649', '2024-02-07', '2017-01-05', 404.10, '2010-03-21', '中国上海市黄浦区淮海中路33号2室', '123456', 1);
INSERT INTO `vip_info` VALUES (348, '2021-09-28 16:03:50', '2007-08-28 21:49:35', 0, NULL, '任安琪', 1, 'FD-DD-5313-Z', 0, '15410926862', '2016-10-25', '2020-03-12', 609.26, '2021-06-24', '中国深圳龙岗区学园一巷914号49室', '123456', 1);
INSERT INTO `vip_info` VALUES (349, '2025-04-22 16:29:07', '2022-01-10 05:21:49', 1, NULL, '常詩涵', 0, 'EC-FD-3048-K', 0, '17988983143', '2010-06-17', '2011-10-12', 785.61, '2019-10-27', '中国北京市西城区复兴门内大街588号华润大厦44室', '123456', 1);
INSERT INTO `vip_info` VALUES (350, '2009-09-16 19:08:01', '2000-05-18 22:15:46', 1, NULL, '任晓明', 0, 'AF-BC-4766-X', 0, '19866025004', '2021-10-27', '2015-05-03', 419.43, '2024-06-11', '中国中山天河区大信商圈大信南路709号华润大厦12室', '123456', 1);
INSERT INTO `vip_info` VALUES (351, '2006-11-25 12:10:55', '2004-10-09 01:10:02', 0, NULL, '余晓明', 1, 'BD-ED-6724-S', 0, '17494086018', '2018-11-22', '2021-10-14', 93.95, '2007-02-05', '中国上海市浦东新区健祥路129号华润大厦50室', '123456', 1);
INSERT INTO `vip_info` VALUES (352, '2001-01-11 03:05:03', '2005-09-26 11:01:36', 0, NULL, '冯子异', 0, 'AC-FA-9726-A', 0, '19735783465', '2022-08-30', '2002-04-23', 198.17, '2012-01-30', '中国深圳福田区深南大道891号6楼', '123456', 1);
INSERT INTO `vip_info` VALUES (353, '2010-03-21 04:13:51', '2018-07-04 13:12:39', 1, NULL, '郭致远', 1, 'EF-DE-2953-A', 0, '17750653088', '2009-09-07', '2023-12-30', 270.42, '2003-04-30', '中国北京市西城区西長安街421号21楼', '123456', 1);
INSERT INTO `vip_info` VALUES (354, '2005-10-02 03:24:18', '2012-12-17 02:54:10', 0, NULL, '蔡秀英', 1, 'CD-DC-8330-X', 0, '16184933323', '2006-03-23', '2022-12-24', 332.06, '2005-09-09', '中国深圳罗湖区田贝一路701号4号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (355, '2025-02-01 10:51:34', '2025-05-30 20:36:39', 1, NULL, '徐梓軒', 1, 'DC-BC-6681-O', 0, '15305631003', '2009-01-23', '2018-11-08', 120.81, '2003-10-07', '中国深圳龙岗区布吉镇西环路280号28楼', '123456', 1);
INSERT INTO `vip_info` VALUES (356, '2020-12-15 04:07:56', '2019-09-03 18:48:14', 0, NULL, '薛惠妹', 1, 'BF-FD-7698-C', 0, '16250615070', '2013-03-09', '2023-09-21', 761.37, '2020-01-28', '中国东莞坑美十五巷777号华润大厦36室', '123456', 1);
INSERT INTO `vip_info` VALUES (357, '2000-07-25 18:50:39', '2020-03-20 20:07:00', 1, NULL, '袁宇宁', 1, 'FC-CD-2093-L', 0, '16753093872', '2012-03-16', '2022-12-13', 470.31, '2001-03-19', '中国中山紫马岭商圈中山五路945号20室', '123456', 1);
INSERT INTO `vip_info` VALUES (358, '2002-01-28 09:37:39', '2017-05-11 00:00:57', 0, NULL, '梁岚', 0, 'AE-CA-4172-S', 0, '15174565640', '2006-10-19', '2016-09-12', 107.89, '2014-08-23', '中国广州市海珠区江南西路988号14栋', '123456', 1);
INSERT INTO `vip_info` VALUES (359, '2017-12-01 21:03:38', '2020-02-14 05:25:25', 1, NULL, '赵安琪', 0, 'CF-AF-6322-T', 0, '14517525097', '2013-02-07', '2008-06-01', 657.03, '2012-02-18', '中国深圳罗湖区清水河一路930号8楼', '123456', 1);
INSERT INTO `vip_info` VALUES (360, '2006-07-21 14:21:44', '2008-09-25 18:32:56', 1, NULL, '傅宇宁', 1, 'FD-EF-8222-Z', 0, '18847211917', '2016-11-26', '2019-03-11', 599.40, '2009-12-14', '中国中山京华商圈华夏街864号38栋', '123456', 1);
INSERT INTO `vip_info` VALUES (361, '2002-08-25 14:54:04', '2014-11-23 22:30:16', 1, NULL, '熊杰宏', 0, 'EF-DD-4888-Q', 0, '17583706306', '2025-04-23', '2013-05-09', 51.59, '2004-03-01', '中国北京市西城区西長安街75号24楼', '123456', 1);
INSERT INTO `vip_info` VALUES (362, '2012-12-10 01:58:07', '2016-07-25 21:31:03', 0, NULL, '于秀英', 0, 'CE-AF-6858-U', 0, '19513019409', '2019-05-13', '2007-07-18', 51.00, '2021-11-29', '中国上海市黄浦区淮海中路252号10室', '123456', 1);
INSERT INTO `vip_info` VALUES (363, '2004-11-25 20:17:20', '2016-09-05 05:37:20', 0, NULL, '陶震南', 1, 'FC-BD-3900-O', 0, '18554517781', '2018-09-09', '2016-05-02', 247.00, '2005-07-13', '中国深圳福田区景田东一街373号37楼', '123456', 1);
INSERT INTO `vip_info` VALUES (364, '2018-02-04 06:47:22', '2000-09-27 17:54:31', 0, NULL, '沈安琪', 1, 'CB-FA-8187-H', 0, '15126062784', '2009-03-23', '2009-04-18', 786.61, '2006-10-21', '中国北京市朝阳区三里屯路609号28号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (365, '2016-05-03 07:06:38', '2000-10-13 07:00:51', 0, NULL, '吕杰宏', 1, 'AB-BA-6712-A', 0, '15597934136', '2006-08-17', '2021-03-14', 444.05, '2015-12-09', '中国北京市西城区西長安街468号41号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (366, '2002-10-25 17:39:25', '2017-09-20 09:52:17', 1, NULL, '孔震南', 1, 'DE-EF-9900-E', 0, '16971914007', '2016-01-17', '2024-10-20', 907.50, '2025-03-08', '中国成都市锦江区红星路三段2号华润大厦6室', '123456', 1);
INSERT INTO `vip_info` VALUES (367, '2005-09-22 08:01:54', '2010-06-16 09:33:22', 1, NULL, '馬祖兒', 1, 'FF-EF-4195-I', 0, '19534731005', '2022-07-22', '2012-12-10', 204.52, '2014-01-20', '中国成都市锦江区人民南路四段935号华润大厦1室', '123456', 1);
INSERT INTO `vip_info` VALUES (368, '2004-07-12 08:45:38', '2005-03-06 05:55:21', 1, NULL, '任仲賢', 1, 'EF-AA-8151-A', 0, '14219455237', '2002-01-11', '2022-02-08', 916.04, '2008-08-19', '中国广州市白云区机场路棠苑街五巷876号华润大厦41室', '123456', 1);
INSERT INTO `vip_info` VALUES (369, '2020-05-24 03:22:46', '2000-11-29 08:02:32', 1, NULL, '廖小慧', 0, 'CF-FC-8192-G', 0, '16893163458', '2000-04-09', '2000-07-11', 144.07, '2025-06-15', '中国中山天河区大信商圈大信南路774号33楼', '123456', 1);
INSERT INTO `vip_info` VALUES (370, '2015-07-26 07:17:03', '2002-06-18 10:02:35', 0, NULL, '罗安琪', 1, 'DF-DB-8055-B', 0, '18036551715', '2023-09-12', '2020-03-16', 41.32, '2022-09-26', '中国深圳福田区景田东一街994号16栋', '123456', 1);
INSERT INTO `vip_info` VALUES (371, '2002-08-14 18:18:38', '2022-03-29 15:49:22', 1, NULL, '廖震南', 1, 'ED-DE-6953-Q', 0, '13674953393', '2011-02-15', '2013-06-18', 819.34, '2025-06-26', '中国上海市徐汇区虹桥路844号华润大厦1室', '123456', 1);
INSERT INTO `vip_info` VALUES (372, '2023-08-13 21:07:08', '2021-11-20 20:51:24', 1, NULL, '謝志明', 1, 'AE-CF-8292-V', 0, '17822628825', '2008-11-11', '2009-11-18', 546.34, '2007-06-28', '中国中山紫马岭商圈中山五路431号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (373, '2021-04-15 23:38:33', '2006-06-21 22:00:47', 0, NULL, '顧祖兒', 1, 'FD-AB-1552-Q', 0, '19802075131', '2017-08-18', '2016-01-15', 104.42, '2006-09-13', '中国广州市越秀区中山二路952号9栋', '123456', 1);
INSERT INTO `vip_info` VALUES (374, '2014-01-27 17:39:35', '2017-02-07 16:40:17', 0, NULL, '尹晓明', 1, 'DB-BF-5691-X', 0, '17239914558', '2000-05-21', '2016-06-16', 506.95, '2016-08-05', '中国深圳罗湖区田贝一路973号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (375, '2016-12-22 04:45:51', '2023-04-16 01:00:38', 1, NULL, '潘岚', 0, 'DC-CA-1275-L', 0, '13961582587', '2021-10-31', '2006-03-13', 91.73, '2001-08-21', '中国东莞东泰五街778号47楼', '123456', 1);
INSERT INTO `vip_info` VALUES (376, '2020-08-13 16:49:59', '2024-09-29 00:45:11', 0, NULL, '陈杰宏', 1, 'BD-CB-2075-J', 0, '16601106023', '2022-02-20', '2002-07-14', 402.62, '2024-01-07', '中国中山天河区大信商圈大信南路225号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (377, '2015-09-09 05:42:59', '2016-06-29 00:55:49', 0, NULL, '官青雲', 0, 'DF-FF-1308-F', 0, '16501996147', '2006-06-11', '2021-12-07', 978.89, '2001-01-31', '中国北京市延庆区028县道254号4号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (378, '2018-01-12 04:01:04', '2006-07-15 04:46:08', 1, NULL, '馬慧珊', 0, 'CC-AC-6948-S', 0, '18789746623', '2017-04-28', '2012-01-14', 169.69, '2007-09-09', '中国深圳罗湖区蔡屋围深南东路66号27楼', '123456', 1);
INSERT INTO `vip_info` VALUES (379, '2014-01-17 21:45:09', '2023-09-21 00:20:53', 1, NULL, '钟子异', 0, 'AA-FE-6711-E', 0, '18788387630', '2001-12-04', '2005-12-19', 463.05, '2022-03-02', '中国北京市朝阳区三里屯路190号41楼', '123456', 1);
INSERT INTO `vip_info` VALUES (380, '2014-05-22 15:18:29', '2014-10-09 07:58:15', 0, NULL, '呂學友', 0, 'CE-ED-6799-F', 0, '13081467715', '2017-11-09', '2009-04-15', 992.69, '2007-05-11', '中国北京市海淀区清河中街68号799号34室', '123456', 1);
INSERT INTO `vip_info` VALUES (381, '2006-05-04 21:04:11', '2025-02-14 04:37:57', 0, NULL, '郝晓明', 0, 'AD-BD-6113-V', 0, '17652598581', '2023-05-26', '2024-05-09', 257.83, '2023-01-04', '中国中山乐丰六路526号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (382, '2025-05-17 15:51:46', '2015-10-14 02:24:41', 1, NULL, '陶安琪', 0, 'EE-BF-2710-M', 0, '19150955584', '2016-01-02', '2009-07-25', 586.21, '2008-07-31', '中国东莞坑美十五巷216号42楼', '123456', 1);
INSERT INTO `vip_info` VALUES (383, '2008-11-20 05:08:51', '2017-11-01 18:43:02', 1, NULL, '王頴璇', 0, 'FA-BA-7910-S', 0, '18128310769', '2012-03-11', '2022-11-01', 863.72, '2018-01-27', '中国中山紫马岭商圈中山五路999号38楼', '123456', 1);
INSERT INTO `vip_info` VALUES (384, '2000-06-08 13:00:05', '2020-10-07 05:47:11', 1, NULL, '向秀文', 1, 'FC-CD-0303-E', 0, '19458780196', '2002-04-26', '2008-03-01', 21.95, '2021-04-22', '中国东莞环区南街二巷261号25栋', '123456', 1);
INSERT INTO `vip_info` VALUES (385, '2006-02-23 19:55:33', '2006-10-27 15:12:49', 1, NULL, '謝祖兒', 0, 'BC-AD-4768-B', 0, '15455214434', '2024-08-26', '2015-08-18', 324.76, '2019-10-23', '中国深圳福田区深南大道354号14号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (386, '2023-01-06 23:49:10', '2018-08-09 11:03:24', 0, NULL, '严子韬', 0, 'DB-AD-2766-W', 0, '15825144060', '2002-05-16', '2018-03-18', 282.48, '2019-11-19', '中国成都市锦江区红星路三段264号32室', '123456', 1);
INSERT INTO `vip_info` VALUES (387, '2009-01-06 01:01:18', '2023-11-11 20:01:55', 0, NULL, '徐云熙', 1, 'BD-ED-9213-Y', 0, '18196834098', '2005-12-05', '2023-02-28', 275.24, '2023-06-03', '中国东莞环区南街二巷810号48楼', '123456', 1);
INSERT INTO `vip_info` VALUES (388, '2024-01-24 06:01:04', '2012-10-24 07:37:56', 1, NULL, '馮富城', 0, 'AA-CC-1728-R', 0, '14618571836', '2025-04-26', '2024-05-10', 135.17, '2007-12-08', '中国广州市越秀区中山二路876号21室', '123456', 1);
INSERT INTO `vip_info` VALUES (389, '2006-05-22 08:59:44', '2025-02-23 19:04:59', 1, NULL, '史杰宏', 1, 'FE-BE-1639-B', 0, '15516593713', '2001-04-23', '2025-01-17', 988.45, '2005-01-21', '中国广州市越秀区中山二路303号16号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (390, '2015-07-06 03:20:22', '2019-12-03 22:34:45', 1, NULL, '謝仲賢', 1, 'AC-CC-2938-O', 0, '17919270828', '2024-01-11', '2007-08-22', 333.01, '2002-10-10', '中国北京市房山区岳琉路888号50楼', '123456', 1);
INSERT INTO `vip_info` VALUES (391, '2008-08-08 13:41:31', '2005-07-06 00:48:51', 0, NULL, '范致远', 1, 'EC-FD-7719-J', 0, '16434806199', '2016-04-10', '2020-12-01', 409.67, '2002-09-27', '中国成都市成华区二仙桥东三路734号27栋', '123456', 1);
INSERT INTO `vip_info` VALUES (392, '2021-12-12 03:15:33', '2024-08-04 02:37:13', 0, NULL, '李晓明', 0, 'BE-DA-1306-A', 0, '13081861101', '2005-09-30', '2012-11-19', 707.31, '2002-10-18', '中国上海市徐汇区虹桥路722号3楼', '123456', 1);
INSERT INTO `vip_info` VALUES (393, '2012-07-22 04:18:33', '2014-06-08 06:22:19', 0, NULL, '邹震南', 1, 'AB-EA-0673-A', 0, '16546833277', '2018-01-25', '2008-07-04', 660.43, '2013-11-25', '中国广州市越秀区中山二路546号11楼', '123456', 1);
INSERT INTO `vip_info` VALUES (394, '2021-05-02 12:19:50', '2003-11-06 18:23:08', 0, NULL, '方子韬', 1, 'DA-BD-1658-N', 0, '13222560476', '2007-10-16', '2018-10-08', 913.99, '2024-11-01', '中国上海市徐汇区虹桥路380号24号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (395, '2002-01-10 15:03:31', '2008-06-06 09:54:32', 0, NULL, '曾睿', 1, 'AA-AD-6267-X', 0, '17857328142', '2002-11-20', '2020-04-02', 869.30, '2023-09-16', '中国成都市锦江区人民南路四段161号34室', '123456', 1);
INSERT INTO `vip_info` VALUES (396, '2019-06-27 14:01:43', '2006-06-08 06:19:25', 0, NULL, '傅云熙', 1, 'AB-DB-6407-F', 0, '19062093146', '2001-10-30', '2005-02-10', 674.99, '2019-09-06', '中国北京市朝阳区三里屯路170号13室', '123456', 1);
INSERT INTO `vip_info` VALUES (397, '2006-10-02 14:11:02', '2025-02-02 17:41:06', 1, NULL, '邱玲玲', 0, 'EF-DF-3381-E', 0, '15665756242', '2002-10-17', '2009-08-18', 412.02, '2006-09-10', '中国深圳福田区深南大道870号华润大厦9室', '123456', 1);
INSERT INTO `vip_info` VALUES (398, '2024-03-04 21:57:06', '2023-05-31 16:05:08', 1, NULL, '彭祖兒', 0, 'AD-EC-9146-Y', 0, '17311403463', '2004-09-23', '2023-04-27', 180.24, '2018-06-13', '中国北京市西城区复兴门内大街172号42号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (399, '2011-05-17 01:14:10', '2018-04-24 14:00:22', 0, NULL, '李杰宏', 1, 'EC-AF-6824-M', 0, '17614034480', '2012-04-24', '2000-09-22', 552.64, '2016-06-16', '中国深圳罗湖区蔡屋围深南东路130号5楼', '123456', 1);
INSERT INTO `vip_info` VALUES (400, '2002-07-20 19:01:41', '2015-09-19 12:14:49', 0, NULL, '白德華', 0, 'FF-FA-5475-M', 0, '15143803266', '2023-01-24', '2023-08-25', 866.27, '2005-05-17', '中国深圳福田区深南大道126号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (401, '2000-04-08 19:32:19', '2023-10-08 01:08:45', 1, NULL, '常安琪', 1, 'EC-EA-7874-O', 0, '15917187630', '2021-08-04', '2025-02-27', 538.36, '2017-12-16', '中国广州市天河区天河路95号4号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (402, '2016-06-03 00:17:29', '2014-09-24 15:16:14', 1, NULL, '曾朝偉', 1, 'CE-DA-8431-N', 0, '18802018332', '2004-06-25', '2011-02-24', 616.85, '2014-03-09', '中国上海市浦东新区橄榄路298号华润大厦12室', '123456', 1);
INSERT INTO `vip_info` VALUES (403, '2022-06-27 20:58:32', '2017-12-25 12:39:17', 1, NULL, '陳慧儀', 0, 'BC-CC-3351-L', 0, '19846200863', '2007-09-08', '2025-03-08', 213.43, '2003-11-03', '中国北京市延庆区028县道439号华润大厦11室', '123456', 1);
INSERT INTO `vip_info` VALUES (404, '2004-03-28 11:17:02', '2005-05-24 01:18:53', 1, NULL, '車世榮', 0, 'EE-AE-6457-T', 0, '19608612624', '2024-08-01', '2006-06-02', 383.96, '2020-06-19', '中国成都市成华区玉双路6号187号28号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (405, '2003-06-04 00:53:34', '2019-10-11 10:17:22', 1, NULL, '藤惠妹', 1, 'BC-DD-2802-H', 0, '15288629588', '2024-01-18', '2004-08-01', 843.70, '2010-07-03', '中国北京市西城区复兴门内大街191号华润大厦28室', '123456', 1);
INSERT INTO `vip_info` VALUES (406, '2023-10-21 15:52:21', '2004-01-16 04:16:29', 0, NULL, '潘云熙', 0, 'AF-CA-3039-C', 0, '18887004148', '2012-10-13', '2019-10-25', 966.23, '2015-03-26', '中国深圳罗湖区蔡屋围深南东路140号40号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (407, '2009-05-05 18:20:59', '2015-05-10 12:17:30', 0, NULL, '蔡致远', 1, 'FD-FB-4849-J', 0, '17112569766', '2020-03-03', '2012-06-02', 812.79, '2008-07-21', '中国上海市浦东新区橄榄路149号华润大厦30室', '123456', 1);
INSERT INTO `vip_info` VALUES (408, '2006-04-30 17:27:56', '2025-04-11 06:36:13', 0, NULL, '黎學友', 1, 'FB-AE-6690-D', 0, '15987850807', '2010-02-05', '2012-11-12', 860.94, '2006-09-17', '中国深圳福田区深南大道205号29栋', '123456', 1);
INSERT INTO `vip_info` VALUES (409, '2011-06-03 12:18:55', '2014-10-05 16:47:00', 0, NULL, '姜岚', 0, 'FB-DD-1338-X', 0, '19514466984', '2016-08-15', '2020-02-11', 680.97, '2000-03-03', '中国北京市海淀区清河中街68号3号27楼', '123456', 1);
INSERT INTO `vip_info` VALUES (410, '2024-07-25 02:12:50', '2018-09-14 19:20:12', 1, NULL, '尹震南', 1, 'CD-DB-5401-C', 0, '16643061631', '2024-08-13', '2005-02-26', 281.59, '2012-02-15', '中国成都市锦江区红星路三段219号45室', '123456', 1);
INSERT INTO `vip_info` VALUES (411, '2009-09-06 23:46:19', '2006-12-19 22:20:32', 1, NULL, '姚德華', 0, 'DE-BD-3975-C', 0, '14026038145', '2018-09-13', '2004-04-11', 771.13, '2021-08-02', '中国深圳龙岗区布吉镇西环路92号42楼', '123456', 1);
INSERT INTO `vip_info` VALUES (412, '2020-08-05 17:52:43', '2012-12-19 09:49:56', 0, NULL, '崔浩然', 0, 'DC-EA-1696-X', 0, '14572121950', '2011-10-06', '2022-08-08', 871.83, '2017-12-14', '中国成都市成华区双庆路721号34号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (413, '2017-11-02 12:38:12', '2020-06-22 17:30:59', 1, NULL, '杨璐', 1, 'AE-CF-5597-N', 0, '16258391645', '2008-04-26', '2006-04-07', 282.47, '2008-11-29', '中国深圳福田区景田东一街760号34栋', '123456', 1);
INSERT INTO `vip_info` VALUES (414, '2010-12-26 03:24:45', '2018-02-07 07:02:18', 0, NULL, '曾志明', 0, 'EC-AD-2205-W', 0, '16445468368', '2016-07-12', '2001-10-25', 789.36, '2021-01-19', '中国中山紫马岭商圈中山五路936号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (415, '2008-03-03 17:21:07', '2002-07-31 12:00:46', 0, NULL, '陶榮發', 0, 'FC-DA-0208-G', 0, '17421726702', '2012-08-19', '2010-03-19', 885.04, '2018-02-01', '中国北京市房山区岳琉路132号16室', '123456', 1);
INSERT INTO `vip_info` VALUES (416, '2013-03-30 00:27:17', '2021-02-22 03:09:51', 0, NULL, '梅杰倫', 1, 'FA-DE-6418-J', 0, '14292874485', '2023-10-15', '2016-07-17', 211.91, '2019-07-05', '中国中山乐丰六路349号华润大厦19室', '123456', 1);
INSERT INTO `vip_info` VALUES (417, '2008-10-27 10:27:33', '2023-10-16 21:27:50', 0, NULL, '湯家玲', 1, 'EF-FE-4230-S', 0, '14838034620', '2005-07-20', '2005-04-11', 571.82, '2004-02-14', '中国东莞坑美十五巷888号华润大厦30室', '123456', 1);
INSERT INTO `vip_info` VALUES (418, '2005-08-16 06:49:01', '2023-09-19 12:21:23', 1, NULL, '沈晓明', 0, 'CB-FD-1291-D', 0, '17396459787', '2006-02-20', '2008-03-30', 338.20, '2017-07-17', '中国广州市海珠区江南西路684号50栋', '123456', 1);
INSERT INTO `vip_info` VALUES (419, '2013-08-07 01:54:03', '2006-08-23 09:26:30', 0, NULL, '方天樂', 1, 'EA-BE-8680-K', 0, '19557002974', '2003-01-04', '2020-12-17', 36.34, '2013-03-03', '中国东莞坑美十五巷130号42室', '123456', 1);
INSERT INTO `vip_info` VALUES (420, '2004-02-03 11:37:35', '2008-02-11 06:19:25', 1, NULL, '江秀英', 1, 'EF-AD-7938-N', 0, '17660203396', '2005-02-07', '2004-04-10', 978.44, '2021-06-01', '中国成都市成华区玉双路6号219号15室', '123456', 1);
INSERT INTO `vip_info` VALUES (421, '2008-09-11 23:47:47', '2002-08-07 12:40:41', 1, NULL, '胡安琪', 1, 'AD-FF-1608-I', 0, '18597416300', '2002-06-08', '2023-04-13', 647.63, '2008-03-18', '中国北京市海淀区清河中街68号923号华润大厦17室', '123456', 1);
INSERT INTO `vip_info` VALUES (422, '2014-07-14 18:14:32', '2008-05-06 22:52:45', 1, NULL, '藤國榮', 0, 'FB-DE-9665-F', 0, '17793776182', '2006-03-29', '2017-02-26', 131.97, '2010-07-23', '中国深圳罗湖区田贝一路41号19号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (423, '2012-09-23 00:46:07', '2018-07-03 07:30:25', 0, NULL, '林明', 0, 'FB-AD-3495-X', 0, '13746890673', '2011-04-04', '2014-03-31', 641.95, '2000-07-27', '中国深圳福田区景田东一街273号华润大厦38室', '123456', 1);
INSERT INTO `vip_info` VALUES (424, '2023-03-15 07:50:33', '2021-12-02 22:16:56', 1, NULL, '姚嘉伦', 1, 'BC-BA-8696-R', 0, '19356662543', '2013-03-14', '2010-04-03', 894.55, '2008-01-12', '中国深圳福田区深南大道480号17号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (425, '2018-08-16 23:28:28', '2005-09-25 14:01:04', 0, NULL, '廖晓明', 0, 'BC-AB-2443-Z', 0, '17984460583', '2001-09-07', '2007-03-05', 629.65, '2017-06-21', '中国广州市白云区小坪东路699号50楼', '123456', 1);
INSERT INTO `vip_info` VALUES (426, '2018-01-21 00:57:31', '2004-11-08 12:28:45', 1, NULL, '萬頴思', 1, 'AE-BC-1624-N', 0, '14559803783', '2019-07-12', '2021-04-03', 636.81, '2009-01-04', '中国广州市天河区天河路933号14室', '123456', 1);
INSERT INTO `vip_info` VALUES (427, '2005-02-07 09:46:57', '2023-03-04 13:05:48', 0, NULL, '顧青雲', 1, 'AD-BF-0823-O', 0, '19335887532', '2015-04-17', '2000-04-04', 919.06, '2020-08-05', '中国上海市浦东新区橄榄路73号27栋', '123456', 1);
INSERT INTO `vip_info` VALUES (428, '2007-01-29 17:28:57', '2001-06-06 02:50:09', 0, NULL, '湯富城', 1, 'AC-FB-8879-S', 0, '19141750203', '2010-04-09', '2022-12-13', 516.08, '2016-11-03', '中国中山紫马岭商圈中山五路256号46栋', '123456', 1);
INSERT INTO `vip_info` VALUES (429, '2022-08-10 08:01:43', '2008-07-21 04:31:16', 0, NULL, '周致远', 1, 'AA-AE-8022-Y', 0, '17476454546', '2011-01-20', '2012-07-06', 931.87, '2008-04-10', '中国深圳罗湖区蔡屋围深南东路449号47楼', '123456', 1);
INSERT INTO `vip_info` VALUES (430, '2004-06-07 16:53:05', '2015-11-08 14:29:29', 0, NULL, '冯晓明', 0, 'EB-CE-1125-G', 0, '18571952951', '2007-06-05', '2014-04-24', 622.19, '2004-11-17', '中国广州市海珠区江南西路786号华润大厦40室', '123456', 1);
INSERT INTO `vip_info` VALUES (431, '2014-12-10 12:45:09', '2000-08-27 19:43:35', 0, NULL, '杜淑怡', 0, 'AD-CB-8945-T', 0, '13609636590', '2015-06-23', '2021-07-07', 381.80, '2021-09-28', '中国东莞珊瑚路288号46室', '123456', 1);
INSERT INTO `vip_info` VALUES (432, '2002-11-14 00:30:47', '2004-01-09 19:21:43', 1, NULL, '顧頴思', 0, 'DE-CF-6213-E', 0, '16066180620', '2009-06-08', '2023-05-31', 857.34, '2012-06-05', '中国深圳龙岗区学园一巷592号23室', '123456', 1);
INSERT INTO `vip_info` VALUES (433, '2014-07-01 22:11:13', '2004-01-06 12:05:15', 0, NULL, '阎璐', 0, 'BB-BB-9786-Q', 0, '17709967341', '2005-09-24', '2014-06-24', 777.22, '2019-11-01', '中国东莞东泰五街145号华润大厦9室', '123456', 1);
INSERT INTO `vip_info` VALUES (434, '2005-08-26 01:42:46', '2009-11-28 04:01:17', 1, NULL, '關頴思', 0, 'BB-BA-9125-N', 0, '16224669880', '2002-06-12', '2011-06-08', 446.95, '2007-04-11', '中国成都市成华区双庆路937号11号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (435, '2009-04-05 02:41:16', '2012-01-25 18:03:22', 1, NULL, '顧世榮', 1, 'FC-DA-7680-I', 0, '16746551825', '2003-05-12', '2010-10-28', 293.78, '2017-03-09', '中国上海市浦东新区橄榄路321号7室', '123456', 1);
INSERT INTO `vip_info` VALUES (436, '2020-06-15 08:52:58', '2011-02-16 00:56:41', 1, NULL, '袁慧琳', 0, 'DB-EF-9501-J', 0, '14346412994', '2002-01-13', '2018-02-22', 197.44, '2017-08-17', '中国北京市朝阳区三里屯路653号华润大厦33室', '123456', 1);
INSERT INTO `vip_info` VALUES (437, '2006-03-17 07:24:06', '2007-06-05 09:09:06', 0, NULL, '阮家明', 0, 'BF-AE-7517-B', 0, '13969997211', '2005-01-09', '2010-02-07', 87.01, '2003-05-21', '中国深圳福田区深南大道558号22栋', '123456', 1);
INSERT INTO `vip_info` VALUES (438, '2011-10-18 03:18:22', '2011-11-10 14:53:06', 1, NULL, '曹宇宁', 0, 'BE-CA-1424-A', 0, '16367007332', '2014-06-12', '2015-03-09', 135.72, '2024-09-23', '中国广州市海珠区江南西路347号10号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (439, '2007-05-22 05:19:28', '2006-01-21 18:35:48', 1, NULL, '汤震南', 0, 'BA-DF-7226-W', 0, '13753630043', '2007-12-14', '2017-06-01', 991.11, '2009-03-04', '中国北京市海淀区清河中街68号861号49楼', '123456', 1);
INSERT INTO `vip_info` VALUES (440, '2006-09-24 17:55:38', '2002-06-01 14:43:08', 0, NULL, '韓惠敏', 0, 'BA-AE-2038-P', 0, '18253952638', '2006-09-16', '2005-04-23', 819.69, '2004-04-24', '中国深圳罗湖区蔡屋围深南东路342号19室', '123456', 1);
INSERT INTO `vip_info` VALUES (441, '2020-01-07 01:03:19', '2004-01-03 08:31:28', 0, NULL, '關俊宇', 1, 'CA-DB-4337-S', 0, '14557970147', '2003-09-30', '2023-01-15', 674.99, '2019-08-05', '中国深圳罗湖区蔡屋围深南东路82号25室', '123456', 1);
INSERT INTO `vip_info` VALUES (442, '2021-02-18 02:54:32', '2004-02-11 01:35:38', 1, NULL, '陶晓明', 0, 'DD-BA-9403-V', 0, '15773373258', '2012-01-17', '2004-12-16', 519.42, '2024-02-09', '中国成都市成华区玉双路6号333号46楼', '123456', 1);
INSERT INTO `vip_info` VALUES (443, '2004-08-29 17:33:30', '2015-08-03 20:12:02', 1, NULL, '韩岚', 1, 'EB-AA-5851-R', 0, '15167688949', '2015-10-09', '2008-08-07', 317.26, '2022-01-23', '中国北京市房山区岳琉路279号18号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (444, '2005-03-17 20:07:01', '2011-05-26 07:34:28', 0, NULL, '藍慧儀', 1, 'BC-EA-7952-Z', 0, '18200504116', '2017-04-21', '2017-11-07', 661.53, '2003-02-04', '中国深圳福田区深南大道809号华润大厦19室', '123456', 1);
INSERT INTO `vip_info` VALUES (445, '2011-01-11 15:26:41', '2012-02-25 04:21:05', 0, NULL, '梁淑怡', 1, 'DE-ED-1066-L', 0, '19296314981', '2003-06-03', '2022-05-06', 502.34, '2011-01-20', '中国北京市西城区复兴门内大街414号27楼', '123456', 1);
INSERT INTO `vip_info` VALUES (446, '2012-04-02 21:29:52', '2024-09-21 00:50:05', 0, NULL, '鄧安琪', 0, 'EA-BD-9972-Q', 0, '14870666710', '2000-09-13', '2020-07-03', 49.71, '2011-02-11', '中国深圳罗湖区清水河一路374号华润大厦8室', '123456', 1);
INSERT INTO `vip_info` VALUES (447, '2014-12-03 17:01:30', '2004-01-31 03:55:58', 0, NULL, '宣詩君', 0, 'EF-CF-6526-V', 0, '19538681909', '2004-04-23', '2009-04-10', 870.54, '2000-09-22', '中国成都市成华区二仙桥东三路102号34室', '123456', 1);
INSERT INTO `vip_info` VALUES (448, '2022-03-16 06:40:27', '2000-04-04 10:31:02', 1, NULL, '蔡致远', 1, 'CA-BD-3702-V', 0, '14460671617', '2012-02-17', '2018-05-28', 101.00, '2004-03-13', '中国上海市浦东新区健祥路960号15号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (449, '2020-07-09 12:13:10', '2007-11-11 22:46:15', 1, NULL, '蔡詠詩', 0, 'ED-DC-8627-N', 0, '15392960587', '2004-12-22', '2025-04-18', 850.58, '2013-12-29', '中国深圳福田区景田东一街742号31楼', '123456', 1);
INSERT INTO `vip_info` VALUES (450, '2022-02-24 13:07:02', '2001-10-05 20:27:22', 0, NULL, '崔潤發', 0, 'AD-BA-6072-T', 0, '18668328114', '2024-11-13', '2015-03-14', 996.63, '2023-06-21', '中国广州市海珠区江南西路89号42号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (451, '2015-12-21 17:24:44', '2003-04-23 06:06:31', 1, NULL, '龚睿', 0, 'FC-ED-9681-J', 0, '19082340371', '2005-07-11', '2020-03-14', 726.68, '2001-05-19', '中国成都市成华区双庆路517号25栋', '123456', 1);
INSERT INTO `vip_info` VALUES (452, '2016-12-23 04:03:28', '2019-01-19 11:44:01', 1, NULL, '應玲玲', 0, 'FB-FC-6021-A', 0, '19639217698', '2023-03-19', '2014-07-05', 730.71, '2023-03-19', '中国深圳罗湖区清水河一路202号50栋', '123456', 1);
INSERT INTO `vip_info` VALUES (453, '2025-03-22 14:04:34', '2014-10-28 07:05:31', 0, NULL, '關國明', 0, 'BF-BF-7151-Z', 0, '16177432812', '2012-08-18', '2025-03-17', 438.60, '2022-06-10', '中国广州市天河区天河路934号华润大厦6室', '123456', 1);
INSERT INTO `vip_info` VALUES (454, '2023-01-31 02:34:43', '2014-03-29 19:15:43', 0, NULL, '莫安琪', 0, 'DF-FE-9113-J', 0, '15071752872', '2006-12-22', '2002-09-02', 669.54, '2002-06-15', '中国广州市白云区小坪东路773号48楼', '123456', 1);
INSERT INTO `vip_info` VALUES (455, '2016-07-19 04:42:00', '2021-12-02 19:22:44', 1, NULL, '韦睿', 1, 'ED-EC-1610-M', 0, '13874703955', '2008-12-04', '2023-09-20', 582.87, '2020-05-16', '中国北京市西城区西長安街201号12栋', '123456', 1);
INSERT INTO `vip_info` VALUES (456, '2013-02-28 18:15:21', '2010-01-26 10:52:32', 0, NULL, '杜仲賢', 0, 'EB-DA-6950-T', 0, '19360415560', '2021-09-22', '2019-11-25', 554.21, '2010-12-02', '中国东莞东泰五街168号17栋', '123456', 1);
INSERT INTO `vip_info` VALUES (457, '2009-04-24 11:39:40', '2020-08-21 09:31:16', 1, NULL, '黄詩涵', 0, 'EF-AB-4782-U', 0, '13744749381', '2001-03-08', '2022-06-25', 597.32, '2011-07-19', '中国北京市房山区岳琉路792号42室', '123456', 1);
INSERT INTO `vip_info` VALUES (458, '2000-07-06 17:30:45', '2011-06-11 00:36:09', 0, NULL, '江岚', 0, 'FD-AE-0736-M', 0, '14470224099', '2024-04-22', '2022-04-14', 946.52, '2005-06-21', '中国深圳福田区景田东一街613号10栋', '123456', 1);
INSERT INTO `vip_info` VALUES (459, '2022-12-06 06:19:29', '2021-12-27 12:14:52', 0, NULL, '樊青雲', 1, 'AB-DA-0855-W', 0, '16485543554', '2018-01-21', '2001-07-25', 599.95, '2009-03-29', '中国东莞环区南街二巷202号21室', '123456', 1);
INSERT INTO `vip_info` VALUES (460, '2001-03-11 05:52:26', '2022-09-29 14:15:53', 1, NULL, '宋安琪', 0, 'FD-EB-7095-P', 0, '13718804219', '2003-12-25', '2025-01-22', 181.88, '2000-11-14', '中国广州市越秀区中山二路71号华润大厦38室', '123456', 1);
INSERT INTO `vip_info` VALUES (461, '2003-11-19 20:22:03', '2019-07-10 15:51:09', 1, NULL, '苗浩然', 0, 'DF-AC-0227-F', 0, '18597531127', '2006-06-22', '2022-11-15', 681.62, '2013-07-26', '中国中山紫马岭商圈中山五路597号19栋', '123456', 1);
INSERT INTO `vip_info` VALUES (462, '2004-09-23 12:56:12', '2024-06-27 13:05:35', 0, NULL, '余晓明', 0, 'DC-FF-5234-U', 0, '18008038444', '2017-12-13', '2020-08-07', 640.59, '2010-12-16', '中国深圳罗湖区清水河一路703号华润大厦7室', '123456', 1);
INSERT INTO `vip_info` VALUES (463, '2009-01-18 08:25:02', '2007-05-18 18:10:45', 0, NULL, '史震南', 0, 'BF-BA-3185-W', 0, '16539757064', '2010-11-29', '2024-12-24', 641.10, '2009-09-20', '中国北京市朝阳区三里屯路291号39楼', '123456', 1);
INSERT INTO `vip_info` VALUES (464, '2000-09-30 02:41:59', '2000-06-13 09:47:33', 1, NULL, '吴致远', 1, 'AE-AC-5919-Q', 0, '16531441785', '2007-09-14', '2024-08-04', 218.30, '2011-08-11', '中国北京市海淀区清河中街68号711号华润大厦37室', '123456', 1);
INSERT INTO `vip_info` VALUES (465, '2016-12-08 20:19:55', '2025-02-24 01:59:11', 1, NULL, '顧思妤', 0, 'EB-BC-9012-N', 0, '15930805181', '2006-07-01', '2007-02-19', 888.93, '2015-01-24', '中国广州市白云区小坪东路3号47号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (466, '2018-06-20 15:34:41', '2016-10-29 22:03:17', 1, NULL, '邵家輝', 0, 'BD-EF-4998-W', 0, '14801380463', '2000-03-04', '2007-04-22', 976.56, '2013-05-23', '中国深圳罗湖区田贝一路745号49号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (467, '2022-02-12 05:43:32', '2009-08-25 18:10:57', 0, NULL, '叶睿', 0, 'EC-AF-6274-L', 0, '16032951431', '2007-11-05', '2024-05-28', 769.22, '2025-02-13', '中国北京市西城区复兴门内大街644号27栋', '123456', 1);
INSERT INTO `vip_info` VALUES (468, '2025-02-06 17:09:27', '2012-10-30 17:44:40', 0, NULL, '严嘉伦', 1, 'DA-BD-0581-V', 0, '16141314078', '2012-01-07', '2001-09-23', 973.87, '2015-07-05', '中国广州市天河区天河路141号38室', '123456', 1);
INSERT INTO `vip_info` VALUES (469, '2002-11-10 02:33:58', '2018-09-28 19:59:03', 1, NULL, '謝永權', 1, 'BA-CF-9804-F', 0, '16875334202', '2023-01-02', '2004-02-09', 611.14, '2023-07-12', '中国成都市成华区双庆路424号5栋', '123456', 1);
INSERT INTO `vip_info` VALUES (470, '2008-10-18 20:57:54', '2012-05-06 01:36:29', 1, NULL, '劉慧琳', 0, 'CB-AC-9331-O', 0, '15048208477', '2024-03-26', '2000-11-09', 413.62, '2002-09-24', '中国东莞坑美十五巷209号41号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (471, '2008-10-23 06:52:55', '2016-02-07 06:01:55', 0, NULL, '冯子韬', 1, 'DA-EE-0302-S', 0, '18574772881', '2012-09-13', '2005-11-17', 20.77, '2006-06-16', '中国广州市白云区小坪东路997号45室', '123456', 1);
INSERT INTO `vip_info` VALUES (472, '2018-08-10 17:26:39', '2003-12-29 20:03:02', 1, NULL, '武睿', 1, 'EA-AD-0478-N', 0, '17845002785', '2003-03-04', '2014-04-28', 680.66, '2005-08-10', '中国北京市西城区西長安街248号8室', '123456', 1);
INSERT INTO `vip_info` VALUES (473, '2006-11-11 06:07:01', '2018-07-28 19:36:10', 1, NULL, '應慧嫻', 1, 'BC-FF-1180-H', 0, '15841826922', '2007-06-20', '2004-07-24', 369.14, '2001-09-20', '中国上海市浦东新区健祥路397号21号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (474, '2020-09-16 05:45:38', '2008-06-08 05:41:38', 1, NULL, '譚世榮', 1, 'FA-CA-3244-T', 0, '13748571841', '2017-12-19', '2010-06-28', 608.06, '2009-03-26', '中国上海市闵行区宾川路463号华润大厦27室', '123456', 1);
INSERT INTO `vip_info` VALUES (475, '2024-02-06 12:38:58', '2016-09-28 00:57:56', 1, NULL, '葉天樂', 0, 'DB-DD-5375-F', 0, '14459997238', '2011-03-26', '2001-04-09', 866.57, '2009-06-21', '中国深圳龙岗区学园一巷885号50栋', '123456', 1);
INSERT INTO `vip_info` VALUES (476, '2009-09-09 12:52:07', '2005-03-22 06:16:09', 0, NULL, '成慧儀', 1, 'DA-DD-5743-P', 0, '15823145367', '2007-12-10', '2003-07-26', 141.48, '2007-01-16', '中国中山天河区大信商圈大信南路110号15栋', '123456', 1);
INSERT INTO `vip_info` VALUES (477, '2001-07-08 10:13:17', '2018-02-01 08:11:26', 1, NULL, '關明', 1, 'FB-FF-9124-B', 0, '19575570013', '2018-09-06', '2011-11-25', 286.18, '2007-11-23', '中国广州市越秀区中山二路635号29室', '123456', 1);
INSERT INTO `vip_info` VALUES (478, '2014-09-01 23:28:56', '2010-12-17 23:44:44', 0, NULL, '刘晓明', 0, 'CD-AA-3770-H', 0, '15551282734', '2024-03-14', '2022-06-29', 311.70, '2000-06-17', '中国上海市徐汇区虹桥路600号48栋', '123456', 1);
INSERT INTO `vip_info` VALUES (479, '2010-11-28 12:02:46', '2004-06-24 14:48:50', 1, NULL, '阎璐', 1, 'DE-BE-3762-M', 0, '17610060616', '2024-06-06', '2016-07-21', 560.25, '2006-08-30', '中国北京市房山区岳琉路952号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (480, '2022-04-04 23:42:13', '2010-09-12 19:27:50', 0, NULL, '范晓明', 1, 'FD-DD-4282-X', 0, '17423452357', '2017-01-13', '2004-02-04', 788.62, '2010-08-24', '中国成都市成华区二仙桥东三路515号47室', '123456', 1);
INSERT INTO `vip_info` VALUES (481, '2000-04-26 17:32:16', '2012-10-19 17:22:55', 0, NULL, '谢秀英', 0, 'FA-DD-7640-I', 0, '15856868246', '2003-11-21', '2011-11-11', 394.04, '2009-04-07', '中国东莞坑美十五巷63号47号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (482, '2022-09-05 10:54:59', '2010-02-17 15:34:11', 1, NULL, '譚家明', 0, 'EF-DA-8570-I', 0, '14766370781', '2004-09-28', '2014-04-05', 316.79, '2015-08-15', '中国成都市成华区二仙桥东三路323号17栋', '123456', 1);
INSERT INTO `vip_info` VALUES (483, '2002-01-20 01:32:23', '2021-02-12 10:28:23', 0, NULL, '佘德華', 0, 'CB-FD-8554-R', 0, '14548888976', '2001-04-17', '2004-05-14', 371.81, '2016-12-04', '中国成都市成华区二仙桥东三路706号40号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (484, '2024-12-23 09:30:52', '2002-01-29 12:27:22', 0, NULL, '古慧嫻', 0, 'EE-AA-7945-S', 0, '17243107783', '2023-08-09', '2019-04-18', 900.97, '2000-02-27', '中国成都市成华区二仙桥东三路147号8楼', '123456', 1);
INSERT INTO `vip_info` VALUES (485, '2020-07-11 18:02:00', '2014-01-18 14:55:00', 0, NULL, '文詩君', 1, 'BD-EC-2071-W', 0, '13963485894', '2001-05-26', '2009-12-30', 143.22, '2011-06-10', '中国东莞环区南街二巷538号39室', '123456', 1);
INSERT INTO `vip_info` VALUES (486, '2020-01-27 13:05:17', '2019-12-16 04:31:43', 1, NULL, '毛國賢', 1, 'CE-AC-6201-C', 0, '13719035290', '2010-06-26', '2015-07-27', 784.26, '2004-04-21', '中国深圳福田区深南大道737号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (487, '2010-02-22 16:07:15', '2001-03-04 19:31:17', 1, NULL, '林裕玲', 1, 'CB-DF-0414-P', 0, '14446219051', '2002-12-03', '2004-09-20', 532.83, '2002-04-28', '中国深圳罗湖区蔡屋围深南东路31号25室', '123456', 1);
INSERT INTO `vip_info` VALUES (488, '2022-06-19 22:34:23', '2005-11-28 21:43:14', 0, NULL, '韓明詩', 1, 'CA-CB-7247-C', 0, '15609772662', '2006-02-15', '2003-01-02', 385.06, '2000-10-13', '中国中山京华商圈华夏街301号23栋', '123456', 1);
INSERT INTO `vip_info` VALUES (489, '2012-01-17 16:09:29', '2020-08-07 18:09:36', 1, NULL, '刘宇宁', 1, 'DB-CC-0796-H', 0, '19576188639', '2017-07-15', '2011-02-07', 989.57, '2017-07-28', '中国北京市西城区西長安街562号10室', '123456', 1);
INSERT INTO `vip_info` VALUES (490, '2010-08-14 05:28:20', '2005-03-07 19:41:39', 1, NULL, '向子韬', 1, 'FF-CD-3558-C', 0, '17350494429', '2007-01-26', '2025-04-28', 122.00, '2022-05-03', '中国深圳罗湖区清水河一路822号华润大厦23室', '123456', 1);
INSERT INTO `vip_info` VALUES (491, '2010-02-23 06:36:06', '2018-12-03 22:57:28', 1, NULL, '楊家輝', 0, 'EE-CE-8310-J', 0, '16009493613', '2005-11-17', '2000-01-07', 180.75, '2011-03-01', '中国深圳福田区景田东一街620号13栋', '123456', 1);
INSERT INTO `vip_info` VALUES (492, '2017-09-10 23:10:37', '2004-03-12 10:21:16', 1, NULL, '邵致远', 1, 'DB-DB-7910-V', 0, '15770439001', '2021-05-10', '2008-07-07', 141.49, '2002-07-22', '中国中山乐丰六路591号50楼', '123456', 1);
INSERT INTO `vip_info` VALUES (493, '2017-04-17 02:39:02', '2012-07-21 12:33:49', 1, NULL, '邵致远', 0, 'CC-AB-0510-Q', 0, '13062315485', '2023-04-12', '2008-10-29', 733.89, '2007-05-07', '中国上海市黄浦区淮海中路243号21号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (494, '2012-11-04 07:46:52', '2007-12-12 15:50:39', 0, NULL, '姚梓晴', 1, 'ED-EF-8699-U', 0, '19982285950', '2006-09-18', '2013-04-16', 821.62, '2021-06-04', '中国深圳福田区深南大道51号15室', '123456', 1);
INSERT INTO `vip_info` VALUES (495, '2001-11-22 22:18:42', '2003-07-02 02:04:47', 0, NULL, '廖子韬', 0, 'AB-CC-4902-H', 0, '14298632136', '2016-10-31', '2014-03-06', 991.60, '2021-05-26', '中国深圳罗湖区蔡屋围深南东路868号华润大厦35室', '123456', 1);
INSERT INTO `vip_info` VALUES (496, '2014-02-11 02:20:46', '2020-04-15 07:13:07', 0, NULL, '田子异', 1, 'FE-FA-6856-N', 0, '15463768946', '2018-03-04', '2022-02-04', 563.89, '2000-12-24', '中国北京市朝阳区三里屯路350号25室', '123456', 1);
INSERT INTO `vip_info` VALUES (497, '2001-03-15 18:05:25', '2020-10-06 06:45:02', 0, NULL, '戴梓軒', 1, 'BD-FB-3068-C', 0, '19957152096', '2006-05-29', '2019-02-23', 884.56, '2016-10-23', '中国北京市朝阳区三里屯路446号20号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (498, '2025-05-16 23:39:00', '2003-07-21 15:30:59', 1, NULL, '严杰宏', 0, 'DC-DA-0227-U', 0, '15448113600', '2013-02-14', '2021-07-12', 101.36, '2013-12-08', '中国中山乐丰六路951号12号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (499, '2010-03-17 16:58:06', '2007-02-24 03:17:09', 0, NULL, '郭惠妹', 0, 'EF-DD-2440-H', 0, '13244993876', '2002-03-10', '2023-03-15', 642.15, '2007-04-23', '中国成都市锦江区红星路三段313号3栋', '123456', 1);
INSERT INTO `vip_info` VALUES (500, '2024-04-19 08:06:00', '2017-07-24 00:12:58', 0, NULL, '莫嘉伦', 0, 'DC-CC-4257-H', 0, '15664313063', '2006-06-08', '2024-07-01', 763.45, '2006-02-07', '中国北京市東城区東直門內大街716号华润大厦31室', '123456', 1);
INSERT INTO `vip_info` VALUES (501, '2022-08-07 11:53:19', '2021-06-16 11:39:43', 0, NULL, '尹頴璇', 1, 'AC-AB-4663-I', 0, '13155987512', '2013-11-27', '2019-10-30', 921.97, '2006-09-07', '中国广州市白云区机场路棠苑街五巷953号华润大厦20室', '123456', 1);
INSERT INTO `vip_info` VALUES (502, '2000-06-19 20:29:38', '2019-01-08 07:09:06', 1, NULL, '許惠敏', 1, 'FC-FA-7126-T', 0, '13038834129', '2007-02-10', '2006-08-30', 705.45, '2000-08-21', '中国上海市徐汇区虹桥路287号华润大厦2室', '123456', 1);
INSERT INTO `vip_info` VALUES (503, '2004-02-21 01:48:14', '2012-09-05 11:52:38', 1, NULL, '傅詩涵', 1, 'CB-CC-0603-I', 0, '19094753387', '2024-06-24', '2021-07-23', 884.19, '2003-12-10', '中国北京市東城区東直門內大街194号华润大厦5室', '123456', 1);
INSERT INTO `vip_info` VALUES (504, '2001-05-29 22:53:38', '2001-04-22 11:13:28', 0, NULL, '翁明詩', 1, 'FC-CB-8470-V', 0, '13722422748', '2001-12-16', '2019-03-24', 735.42, '2000-03-05', '中国北京市房山区岳琉路131号24栋', '123456', 1);
INSERT INTO `vip_info` VALUES (505, '2011-01-21 18:10:01', '2014-03-09 06:03:04', 1, NULL, '姚子异', 1, 'BA-EA-7353-Q', 0, '19540970459', '2018-07-28', '2004-11-11', 192.32, '2002-01-20', '中国东莞东泰五街192号华润大厦46室', '123456', 1);
INSERT INTO `vip_info` VALUES (506, '2017-07-13 19:54:36', '2015-07-20 08:28:49', 1, NULL, '廖岚', 0, 'DE-CB-0199-J', 0, '18365086217', '2022-07-03', '2017-11-05', 927.87, '2023-08-09', '中国东莞坑美十五巷327号10楼', '123456', 1);
INSERT INTO `vip_info` VALUES (507, '2021-09-22 07:24:51', '2006-01-12 14:00:28', 0, NULL, '王詩涵', 0, 'DC-ED-9787-P', 0, '15769500437', '2007-10-25', '2012-09-28', 292.55, '2010-08-03', '中国东莞东泰五街161号45号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (508, '2009-12-11 21:51:28', '2005-11-11 20:49:57', 1, NULL, '萧子韬', 1, 'EE-CE-2753-D', 0, '16057563325', '2000-10-24', '2000-03-07', 200.91, '2013-10-06', '中国广州市海珠区江南西路157号46楼', '123456', 1);
INSERT INTO `vip_info` VALUES (509, '2020-08-07 07:44:35', '2024-05-08 18:38:50', 0, NULL, '姜璐', 1, 'FE-BD-6915-E', 0, '18392913435', '2013-05-28', '2011-04-09', 561.44, '2009-03-14', '中国东莞环区南街二巷762号10室', '123456', 1);
INSERT INTO `vip_info` VALUES (510, '2006-04-21 15:51:14', '2019-12-18 01:20:40', 0, NULL, '宣梓軒', 1, 'CE-DF-6648-N', 0, '19357742214', '2006-06-26', '2013-03-17', 367.25, '2008-04-30', '中国北京市海淀区清河中街68号130号32室', '123456', 1);
INSERT INTO `vip_info` VALUES (511, '2002-07-10 17:18:16', '2006-07-16 01:58:53', 0, NULL, '鄺世榮', 1, 'EF-DE-2108-R', 0, '19836376982', '2013-09-07', '2001-01-11', 119.25, '2017-01-11', '中国深圳龙岗区布吉镇西环路682号33号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (512, '2010-09-06 04:31:30', '2000-12-20 11:53:16', 1, NULL, '鄭明', 1, 'CA-BD-3665-R', 0, '13440086014', '2006-05-05', '2015-02-17', 547.45, '2007-07-13', '中国北京市延庆区028县道149号12号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (513, '2011-10-16 18:54:16', '2013-06-09 15:55:16', 0, NULL, '陆岚', 0, 'AE-FD-1008-B', 0, '14190837498', '2021-05-05', '2018-07-09', 402.70, '2024-08-28', '中国上海市徐汇区虹桥路837号7号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (514, '2018-10-28 03:42:30', '2015-06-04 01:25:45', 0, NULL, '戴國權', 0, 'EF-FD-3087-N', 0, '14751087827', '2010-09-16', '2006-10-16', 230.08, '2020-10-21', '中国中山天河区大信商圈大信南路551号9楼', '123456', 1);
INSERT INTO `vip_info` VALUES (515, '2005-12-14 09:22:26', '2015-07-28 11:30:34', 0, NULL, '伍頴璇', 0, 'EC-DB-3096-Y', 0, '17747534515', '2000-11-23', '2012-08-19', 155.75, '2013-01-04', '中国北京市海淀区清河中街68号188号33楼', '123456', 1);
INSERT INTO `vip_info` VALUES (516, '2022-03-19 18:08:16', '2015-09-22 19:15:50', 0, NULL, '吳永發', 0, 'EE-FD-5619-R', 0, '13300958640', '2024-11-27', '2022-11-20', 856.89, '2010-01-25', '中国上海市闵行区宾川路170号11室', '123456', 1);
INSERT INTO `vip_info` VALUES (517, '2002-03-09 23:24:07', '2019-09-30 09:58:40', 1, NULL, '毛浩然', 1, 'EF-DA-2228-N', 0, '13244785483', '2015-04-18', '2011-06-19', 438.35, '2016-08-31', '中国广州市天河区天河路860号47楼', '123456', 1);
INSERT INTO `vip_info` VALUES (518, '2018-01-12 13:48:11', '2022-05-22 04:37:10', 1, NULL, '汤睿', 1, 'CC-CF-4151-M', 0, '15950137519', '2006-11-10', '2022-01-18', 739.54, '2005-07-20', '中国北京市西城区西長安街350号3号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (519, '2018-02-24 19:27:09', '2022-11-19 13:05:40', 0, NULL, '萬秀文', 0, 'DD-DC-2683-H', 0, '18355267429', '2014-02-15', '2003-11-12', 166.18, '2006-10-28', '中国广州市白云区小坪东路743号16栋', '123456', 1);
INSERT INTO `vip_info` VALUES (520, '2009-11-27 01:03:35', '2010-08-01 18:33:35', 0, NULL, '何青雲', 1, 'AE-AE-3388-K', 0, '14250895296', '2004-06-01', '2007-05-19', 477.98, '2008-10-09', '中国成都市成华区双庆路217号30栋', '123456', 1);
INSERT INTO `vip_info` VALUES (521, '2008-10-26 22:52:05', '2002-12-17 20:03:02', 0, NULL, '徐安琪', 1, 'BD-BE-2361-Z', 0, '16186604840', '2018-08-08', '2004-05-19', 163.54, '2012-09-24', '中国广州市白云区机场路棠苑街五巷621号2楼', '123456', 1);
INSERT INTO `vip_info` VALUES (522, '2017-05-04 19:21:25', '2006-03-21 14:50:33', 1, NULL, '廖思妤', 1, 'BB-CA-7158-F', 0, '14994131503', '2023-03-09', '2004-08-25', 259.08, '2016-06-28', '中国成都市锦江区红星路三段288号23号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (523, '2019-01-22 18:51:17', '2019-02-03 22:25:43', 1, NULL, '楊杰倫', 0, 'EA-BB-8673-K', 0, '19488328696', '2008-01-07', '2002-01-17', 235.47, '2003-05-02', '中国广州市白云区机场路棠苑街五巷63号华润大厦33室', '123456', 1);
INSERT INTO `vip_info` VALUES (524, '2005-12-04 05:52:20', '2022-11-03 19:12:56', 1, NULL, '江青雲', 0, 'AB-BB-5665-F', 0, '18413973497', '2017-04-30', '2004-03-07', 940.65, '2008-11-12', '中国中山乐丰六路976号23号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (525, '2005-03-23 02:41:02', '2018-11-01 16:49:58', 1, NULL, '應慧儀', 1, 'DC-BD-9977-E', 0, '14197785458', '2009-06-28', '2003-07-25', 291.55, '2013-11-09', '中国上海市黄浦区淮海中路999号19室', '123456', 1);
INSERT INTO `vip_info` VALUES (526, '2011-03-14 04:17:34', '2012-12-03 12:05:51', 0, NULL, '周志明', 1, 'FA-BA-2346-L', 0, '14477419769', '2010-01-19', '2008-09-20', 808.78, '2020-04-18', '中国广州市越秀区中山二路715号22楼', '123456', 1);
INSERT INTO `vip_info` VALUES (527, '2007-02-28 18:47:15', '2002-10-31 00:22:35', 1, NULL, '许嘉伦', 0, 'DC-BE-7774-P', 0, '18177611236', '2009-03-06', '2011-11-12', 937.52, '2005-12-28', '中国成都市锦江区红星路三段298号40栋', '123456', 1);
INSERT INTO `vip_info` VALUES (528, '2003-06-08 00:42:27', '2022-11-16 13:47:37', 0, NULL, '戴子韬', 0, 'BB-CD-2791-M', 0, '19141624295', '2025-02-06', '2014-05-27', 644.20, '2004-08-06', '中国北京市延庆区028县道835号32栋', '123456', 1);
INSERT INTO `vip_info` VALUES (529, '2001-07-14 12:11:14', '2001-06-09 20:30:01', 0, NULL, '范睿', 0, 'EB-AC-2213-U', 0, '14278752479', '2014-09-20', '2013-08-21', 37.58, '2018-03-01', '中国中山乐丰六路843号华润大厦13室', '123456', 1);
INSERT INTO `vip_info` VALUES (530, '2015-08-13 20:43:48', '2008-05-04 15:47:22', 0, NULL, '龙云熙', 0, 'CA-BD-2170-K', 0, '16233376665', '2019-08-25', '2010-04-14', 819.96, '2023-04-16', '中国东莞东泰五街190号38栋', '123456', 1);
INSERT INTO `vip_info` VALUES (531, '2014-06-06 05:36:00', '2010-03-19 12:49:47', 0, NULL, '藤榮發', 1, 'AD-FE-2001-U', 0, '19374626832', '2000-03-04', '2012-04-17', 516.11, '2013-05-13', '中国深圳龙岗区布吉镇西环路121号46号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (532, '2001-08-29 09:26:25', '2012-06-11 06:19:15', 1, NULL, '曾震南', 0, 'EF-DD-3408-D', 0, '14022460552', '2012-11-27', '2011-06-15', 5.86, '2000-12-12', '中国上海市闵行区宾川路540号21栋', '123456', 1);
INSERT INTO `vip_info` VALUES (533, '2018-02-23 14:57:29', '2015-06-22 14:18:28', 1, NULL, '马晓明', 0, 'FE-DA-2090-O', 0, '17030539679', '2015-06-05', '2003-04-24', 285.94, '2012-08-31', '中国北京市東城区東直門內大街879号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (534, '2021-08-02 21:27:13', '2010-02-02 19:12:54', 0, NULL, '曹志遠', 1, 'FD-EF-0289-L', 0, '14489303028', '2005-03-31', '2006-05-28', 139.83, '2005-03-09', '中国深圳福田区景田东一街881号33楼', '123456', 1);
INSERT INTO `vip_info` VALUES (535, '2009-07-17 02:25:00', '2008-10-31 21:40:27', 1, NULL, '宋嘉伦', 0, 'AB-EB-2963-J', 0, '15344660076', '2020-08-30', '2008-09-05', 262.09, '2002-03-16', '中国东莞环区南街二巷140号10室', '123456', 1);
INSERT INTO `vip_info` VALUES (536, '2016-12-17 06:28:11', '2005-10-28 05:33:08', 0, NULL, '餘家輝', 0, 'FB-DD-1061-Q', 0, '14831680722', '2020-09-28', '2002-09-19', 238.04, '2014-01-31', '中国东莞珊瑚路575号华润大厦40室', '123456', 1);
INSERT INTO `vip_info` VALUES (537, '2002-11-17 02:13:05', '2022-05-06 08:23:03', 0, NULL, '任璐', 1, 'ED-DB-1523-A', 0, '18908208090', '2016-04-04', '2001-10-21', 774.18, '2014-05-06', '中国深圳龙岗区布吉镇西环路538号6楼', '123456', 1);
INSERT INTO `vip_info` VALUES (538, '2003-02-07 07:38:40', '2006-12-26 10:12:28', 0, NULL, '段詩涵', 0, 'BB-BD-9890-D', 0, '16678678705', '2016-12-16', '2020-09-13', 829.06, '2021-04-21', '中国北京市西城区复兴门内大街832号36室', '123456', 1);
INSERT INTO `vip_info` VALUES (539, '2000-11-27 11:50:32', '2015-12-15 14:30:28', 0, NULL, '曾岚', 0, 'BA-BC-4722-D', 0, '16530151347', '2023-12-18', '2005-09-07', 690.01, '2008-05-12', '中国上海市闵行区宾川路575号28号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (540, '2018-11-02 05:29:35', '2002-04-04 02:22:46', 1, NULL, '張心穎', 1, 'CA-BC-0272-B', 0, '15240251598', '2013-10-30', '2010-05-12', 363.77, '2012-04-10', '中国上海市浦东新区健祥路624号25栋', '123456', 1);
INSERT INTO `vip_info` VALUES (541, '2021-01-23 22:54:56', '2021-07-17 05:59:26', 1, NULL, '曾祖兒', 0, 'DF-FD-2123-L', 0, '13376252115', '2020-09-27', '2009-05-02', 231.54, '2020-06-01', '中国成都市成华区二仙桥东三路97号41楼', '123456', 1);
INSERT INTO `vip_info` VALUES (542, '2013-11-01 15:31:44', '2015-04-03 08:21:41', 1, NULL, '钱安琪', 0, 'FB-AE-9656-I', 0, '16915823170', '2017-01-26', '2007-04-26', 988.04, '2021-05-15', '中国东莞环区南街二巷90号33栋', '123456', 1);
INSERT INTO `vip_info` VALUES (543, '2006-04-30 21:06:45', '2005-06-11 11:07:10', 1, NULL, '苏子韬', 1, 'BE-DE-6795-K', 0, '16194931902', '2007-03-03', '2005-05-30', 401.57, '2013-05-24', '中国上海市浦东新区橄榄路495号2楼', '123456', 1);
INSERT INTO `vip_info` VALUES (544, '2016-07-08 09:10:59', '2005-07-15 07:12:09', 0, NULL, '邵詩君', 1, 'FB-FD-5312-E', 0, '15590987791', '2013-10-07', '2016-10-14', 372.36, '2005-12-12', '中国中山天河区大信商圈大信南路881号1楼', '123456', 1);
INSERT INTO `vip_info` VALUES (545, '2024-02-25 19:44:15', '2013-03-12 08:19:19', 1, NULL, '陈睿', 0, 'AC-AB-1333-R', 0, '19228086073', '2005-10-05', '2018-10-24', 546.99, '2006-05-22', '中国中山京华商圈华夏街332号45号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (546, '2020-07-11 10:35:39', '2006-03-30 03:05:30', 1, NULL, '汤致远', 0, 'FF-BB-0109-X', 0, '19027942848', '2016-11-30', '2005-03-15', 71.42, '2011-12-28', '中国深圳罗湖区蔡屋围深南东路889号华润大厦38室', '123456', 1);
INSERT INTO `vip_info` VALUES (547, '2008-02-25 04:33:52', '2013-12-19 02:04:13', 0, NULL, '錢頴璇', 0, 'BF-FE-9794-R', 0, '18958600723', '2013-02-15', '2018-11-14', 373.32, '2014-10-25', '中国北京市朝阳区三里屯路83号35号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (548, '2020-11-18 23:59:58', '2023-02-07 09:34:03', 1, NULL, '許惠敏', 1, 'BF-FE-9805-G', 0, '14680526460', '2003-05-25', '2002-05-29', 424.14, '2015-01-05', '中国北京市西城区复兴门内大街341号13栋', '123456', 1);
INSERT INTO `vip_info` VALUES (549, '2001-03-05 14:14:13', '2017-11-06 21:46:42', 0, NULL, '谷榮發', 1, 'DB-BF-2026-Z', 0, '17921194391', '2023-03-30', '2014-03-14', 411.34, '2015-07-15', '中国深圳福田区深南大道615号3室', '123456', 1);
INSERT INTO `vip_info` VALUES (550, '2005-08-11 18:22:59', '2011-02-20 11:00:43', 1, NULL, '萧嘉伦', 1, 'FF-BC-4639-H', 0, '15400905151', '2021-11-28', '2001-03-26', 193.97, '2023-08-10', '中国东莞珊瑚路259号43楼', '123456', 1);
INSERT INTO `vip_info` VALUES (551, '2007-01-28 13:30:30', '2017-10-19 18:29:10', 0, NULL, '田霆鋒', 1, 'AE-FB-5093-V', 0, '13352655528', '2020-10-21', '2015-12-13', 657.75, '2023-07-20', '中国北京市東城区東直門內大街152号22号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (552, '2022-08-26 11:05:11', '2007-06-15 06:30:49', 1, NULL, '蔣德華', 0, 'EF-CD-8764-I', 0, '13101900849', '2024-05-04', '2014-01-11', 185.32, '2021-12-11', '中国北京市西城区复兴门内大街280号华润大厦50室', '123456', 1);
INSERT INTO `vip_info` VALUES (553, '2003-09-26 02:02:30', '2004-07-28 09:27:52', 0, NULL, '藍詠詩', 0, 'EA-FD-5860-Z', 0, '15748904007', '2018-05-10', '2010-01-13', 416.67, '2004-08-03', '中国北京市東城区東直門內大街824号27室', '123456', 1);
INSERT INTO `vip_info` VALUES (554, '2000-01-03 14:06:29', '2002-05-28 17:53:27', 0, NULL, '佘慧珊', 1, 'BB-BC-9146-R', 0, '19691354193', '2000-04-28', '2001-02-08', 909.92, '2021-09-12', '中国北京市西城区西長安街153号32号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (555, '2020-02-14 07:55:18', '2020-02-11 05:30:44', 1, NULL, '葉世榮', 0, 'FB-AE-9648-Y', 0, '16375663146', '2019-01-30', '2005-12-13', 418.36, '2024-01-05', '中国广州市海珠区江南西路452号33栋', '123456', 1);
INSERT INTO `vip_info` VALUES (556, '2001-04-06 14:38:46', '2015-11-09 06:54:14', 0, NULL, '钱云熙', 0, 'DE-FE-4060-T', 0, '19718698759', '2015-05-31', '2012-07-18', 179.46, '2022-10-14', '中国北京市西城区西長安街531号15号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (557, '2018-02-16 18:31:53', '2014-08-17 19:12:18', 0, NULL, '元學友', 1, 'DC-FD-1946-B', 0, '16779196027', '2012-01-11', '2003-06-02', 778.20, '2024-06-27', '中国成都市锦江区红星路三段968号22号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (558, '2011-07-26 15:10:02', '2006-11-27 11:59:43', 0, NULL, '张秀英', 0, 'EC-DF-0226-I', 0, '17648788635', '2010-06-14', '2010-04-28', 513.91, '2006-02-17', '中国广州市白云区机场路棠苑街五巷492号华润大厦7室', '123456', 1);
INSERT INTO `vip_info` VALUES (559, '2011-06-11 08:44:12', '2007-06-23 05:52:24', 0, NULL, '古志遠', 0, 'CC-BB-9717-R', 0, '13704985147', '2001-11-22', '2023-05-11', 172.70, '2005-02-16', '中国东莞环区南街二巷435号21室', '123456', 1);
INSERT INTO `vip_info` VALUES (560, '2021-11-29 11:13:26', '2019-01-21 16:34:15', 0, NULL, '邱思妤', 1, 'DA-BC-0679-C', 0, '14763211814', '2012-12-20', '2015-07-10', 981.32, '2003-07-15', '中国广州市白云区小坪东路691号16号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (561, '2003-10-28 02:30:37', '2013-05-18 02:06:48', 1, NULL, '朱子韬', 0, 'AF-DA-4608-G', 0, '17460613942', '2017-01-06', '2024-12-25', 904.92, '2013-04-27', '中国上海市闵行区宾川路606号44室', '123456', 1);
INSERT INTO `vip_info` VALUES (562, '2016-08-16 00:33:55', '2004-01-23 03:59:38', 0, NULL, '薛睿', 1, 'DC-FE-6980-F', 0, '17604052142', '2023-11-10', '2021-09-08', 75.77, '2003-09-24', '中国北京市海淀区清河中街68号757号8栋', '123456', 1);
INSERT INTO `vip_info` VALUES (563, '2012-01-05 01:16:03', '2014-09-24 06:34:56', 1, NULL, '曹睿', 1, 'BB-AA-6330-C', 0, '16084239686', '2024-05-11', '2023-11-12', 330.38, '2019-01-15', '中国上海市黄浦区淮海中路950号39室', '123456', 1);
INSERT INTO `vip_info` VALUES (564, '2002-07-26 05:01:19', '2005-01-18 18:36:42', 0, NULL, '熊震南', 0, 'DE-CF-2446-L', 0, '14666168392', '2005-12-05', '2006-10-27', 341.25, '2006-09-29', '中国深圳龙岗区布吉镇西环路115号华润大厦12室', '123456', 1);
INSERT INTO `vip_info` VALUES (565, '2011-01-24 20:59:43', '2014-04-29 21:42:36', 1, NULL, '熊岚', 0, 'AD-EC-5827-N', 0, '18784451668', '2003-10-23', '2006-12-01', 596.56, '2008-08-20', '中国北京市海淀区清河中街68号806号1室', '123456', 1);
INSERT INTO `vip_info` VALUES (566, '2006-05-03 18:19:50', '2015-02-14 12:51:21', 1, NULL, '曹致远', 1, 'DA-AC-5611-V', 0, '19181147952', '2011-12-31', '2007-07-06', 770.96, '2019-08-11', '中国北京市房山区岳琉路422号31栋', '123456', 1);
INSERT INTO `vip_info` VALUES (567, '2000-09-05 03:10:35', '2023-10-13 02:46:44', 1, NULL, '戴子韬', 0, 'DA-EC-0028-Q', 0, '14047623345', '2005-12-30', '2024-07-15', 692.11, '2001-05-14', '中国成都市成华区二仙桥东三路491号30楼', '123456', 1);
INSERT INTO `vip_info` VALUES (568, '2000-07-14 06:03:53', '2021-11-02 21:41:43', 0, NULL, '顾子异', 0, 'DE-AD-0304-O', 0, '15991939342', '2014-01-06', '2014-11-22', 421.33, '2008-06-18', '中国成都市成华区玉双路6号140号47楼', '123456', 1);
INSERT INTO `vip_info` VALUES (569, '2016-11-16 12:54:39', '2012-06-10 06:59:14', 1, NULL, '孔震南', 0, 'DF-EE-4895-W', 0, '18217925906', '2011-06-05', '2012-08-16', 45.92, '2002-04-19', '中国北京市东城区东单王府井东街40号30栋', '123456', 1);
INSERT INTO `vip_info` VALUES (570, '2022-08-17 07:53:22', '2018-07-10 08:37:07', 1, NULL, '魏子异', 1, 'CD-DE-6624-H', 0, '16516784612', '2020-01-12', '2004-02-09', 165.41, '2012-09-03', '中国中山紫马岭商圈中山五路645号30栋', '123456', 1);
INSERT INTO `vip_info` VALUES (571, '2018-04-08 03:47:44', '2018-08-28 06:14:03', 0, NULL, '袁宇宁', 0, 'BE-CE-8738-B', 0, '14834145272', '2004-09-16', '2021-03-29', 222.31, '2002-07-08', '中国北京市朝阳区三里屯路409号42栋', '123456', 1);
INSERT INTO `vip_info` VALUES (572, '2015-11-12 04:35:11', '2001-09-22 13:25:14', 0, NULL, '秦晓明', 1, 'BC-EA-5119-K', 0, '18751239891', '2008-02-21', '2019-10-22', 111.31, '2006-11-12', '中国中山乐丰六路988号14栋', '123456', 1);
INSERT INTO `vip_info` VALUES (573, '2018-06-09 19:46:19', '2024-04-03 16:47:51', 1, NULL, '姚宇宁', 0, 'EB-AD-8857-I', 0, '19917492095', '2022-12-20', '2011-07-16', 768.79, '2021-09-08', '中国北京市西城区西長安街281号16楼', '123456', 1);
INSERT INTO `vip_info` VALUES (574, '2000-03-09 04:21:48', '2017-11-07 12:02:07', 1, NULL, '曾慧琳', 1, 'AE-DA-9100-F', 0, '14626355688', '2010-03-04', '2008-07-28', 889.06, '2025-01-20', '中国中山京华商圈华夏街669号28号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (575, '2007-04-06 20:45:20', '2003-04-27 07:22:17', 0, NULL, '陆秀英', 1, 'CD-FB-6595-X', 0, '13018518700', '2005-08-04', '2013-09-14', 221.67, '2002-06-10', '中国深圳罗湖区蔡屋围深南东路27号30室', '123456', 1);
INSERT INTO `vip_info` VALUES (576, '2011-07-10 15:43:00', '2008-12-03 13:32:50', 1, NULL, '容國明', 0, 'ED-DE-5234-J', 0, '16255118471', '2002-07-17', '2007-07-17', 322.80, '2010-05-23', '中国北京市西城区西長安街468号26楼', '123456', 1);
INSERT INTO `vip_info` VALUES (577, '2015-11-09 05:01:36', '2010-12-14 23:43:35', 0, NULL, '阎嘉伦', 0, 'FE-BB-3879-R', 0, '15229684644', '2013-11-29', '2021-05-11', 297.06, '2012-06-03', '中国北京市西城区西長安街410号20号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (578, '2011-07-05 18:36:46', '2013-06-07 09:20:01', 0, NULL, '许詩涵', 1, 'FC-DA-3362-I', 0, '17983602195', '2019-12-17', '2000-09-09', 649.83, '2021-01-16', '中国深圳罗湖区清水河一路439号32楼', '123456', 1);
INSERT INTO `vip_info` VALUES (579, '2009-12-15 19:56:35', '2001-06-22 19:57:07', 1, NULL, '朱震南', 1, 'BA-FB-1220-W', 0, '17437790442', '2004-02-22', '2023-04-11', 706.66, '2016-04-05', '中国深圳罗湖区田贝一路980号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (580, '2024-03-22 19:54:22', '2012-05-31 01:58:44', 0, NULL, '彭詩涵', 0, 'BE-BB-7907-K', 0, '15835630519', '2003-12-06', '2021-06-23', 243.40, '2012-04-21', '中国北京市东城区东单王府井东街255号37栋', '123456', 1);
INSERT INTO `vip_info` VALUES (581, '2013-02-12 18:31:07', '2005-01-11 12:48:51', 0, NULL, '邵晓明', 1, 'DD-CF-1823-J', 0, '14609817909', '2021-09-14', '2006-09-29', 825.34, '2002-10-19', '中国深圳罗湖区蔡屋围深南东路677号10室', '123456', 1);
INSERT INTO `vip_info` VALUES (582, '2010-11-01 04:01:27', '2010-08-15 06:45:37', 0, NULL, '魏震南', 0, 'AE-BD-1058-D', 0, '13613689699', '2021-07-26', '2024-05-16', 63.32, '2005-12-17', '中国北京市西城区复兴门内大街818号47楼', '123456', 1);
INSERT INTO `vip_info` VALUES (583, '2013-12-21 11:34:04', '2017-07-07 01:11:40', 1, NULL, '車永權', 0, 'CE-DD-9418-H', 0, '15312494826', '2020-02-14', '2002-08-03', 154.58, '2014-04-05', '中国北京市朝阳区三里屯路262号33栋', '123456', 1);
INSERT INTO `vip_info` VALUES (584, '2020-05-20 12:33:25', '2016-04-17 06:13:06', 0, NULL, '洪梓晴', 1, 'EA-BB-8186-V', 0, '13846759024', '2014-09-09', '2016-02-12', 879.03, '2024-04-05', '中国东莞东泰五街122号23室', '123456', 1);
INSERT INTO `vip_info` VALUES (585, '2012-05-24 01:16:34', '2013-06-17 21:58:18', 1, NULL, '向晓明', 0, 'BD-ED-6406-M', 0, '17496207823', '2016-07-16', '2016-01-30', 86.86, '2022-04-13', '中国广州市越秀区中山二路455号50号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (586, '2019-06-14 13:26:10', '2012-09-11 10:10:33', 1, NULL, '曹子异', 1, 'FB-ED-7181-H', 0, '14672784523', '2003-12-15', '2005-10-15', 514.99, '2004-07-10', '中国上海市浦东新区健祥路992号23栋', '123456', 1);
INSERT INTO `vip_info` VALUES (587, '2024-06-19 06:21:55', '2018-12-02 23:45:08', 0, NULL, '鄭麗欣', 1, 'FE-CD-6602-I', 0, '13907368557', '2017-08-31', '2007-09-12', 367.23, '2019-07-08', '中国东莞珊瑚路909号18栋', '123456', 1);
INSERT INTO `vip_info` VALUES (588, '2008-02-20 22:05:20', '2001-04-10 23:02:10', 0, NULL, '郑嘉伦', 0, 'AB-EE-3390-M', 0, '18176214526', '2019-10-26', '2023-12-27', 899.26, '2009-05-21', '中国东莞东泰五街167号40号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (589, '2002-01-21 01:38:47', '2007-06-17 13:15:27', 1, NULL, '曾玲玲', 1, 'FB-BE-4280-F', 0, '17769948719', '2018-01-22', '2004-04-21', 625.45, '2011-08-07', '中国深圳福田区景田东一街529号36楼', '123456', 1);
INSERT INTO `vip_info` VALUES (590, '2023-10-15 15:02:20', '2006-01-05 06:00:41', 1, NULL, '蔣志明', 0, 'EB-FC-4999-S', 0, '15724315216', '2018-11-25', '2025-01-05', 845.17, '2015-10-11', '中国广州市越秀区中山二路477号华润大厦4室', '123456', 1);
INSERT INTO `vip_info` VALUES (591, '2002-06-03 03:06:16', '2019-08-01 11:30:48', 0, NULL, '熊安琪', 1, 'CF-EB-0538-V', 0, '17744991763', '2018-08-27', '2009-06-22', 218.91, '2016-09-02', '中国深圳罗湖区清水河一路177号29楼', '123456', 1);
INSERT INTO `vip_info` VALUES (592, '2013-05-13 06:15:51', '2022-09-28 12:27:05', 1, NULL, '盧安琪', 0, 'FC-EB-6035-S', 0, '14053420355', '2017-05-01', '2014-05-01', 734.60, '2012-05-24', '中国成都市成华区玉双路6号835号4楼', '123456', 1);
INSERT INTO `vip_info` VALUES (593, '2021-10-07 16:19:28', '2002-09-29 18:41:31', 1, NULL, '曹嘉伦', 1, 'DB-BD-6031-O', 0, '16791030932', '2017-06-12', '2018-12-08', 856.83, '2006-07-01', '中国北京市東城区東直門內大街832号37楼', '123456', 1);
INSERT INTO `vip_info` VALUES (594, '2000-03-10 01:52:15', '2003-08-04 14:27:15', 0, NULL, '莫霆鋒', 1, 'DD-BC-9463-K', 0, '13287762669', '2013-05-14', '2015-01-26', 146.43, '2022-11-22', '中国成都市锦江区人民南路四段682号11号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (595, '2020-10-21 17:06:11', '2009-01-23 01:02:16', 0, NULL, '曹秀英', 0, 'DB-DF-0805-W', 0, '16621610201', '2014-05-04', '2005-08-29', 163.23, '2000-05-28', '中国东莞东泰五街414号9楼', '123456', 1);
INSERT INTO `vip_info` VALUES (596, '2021-12-10 00:00:31', '2007-02-05 18:51:28', 0, NULL, '吳力申', 0, 'AB-EB-5066-W', 0, '17248355005', '2018-10-18', '2024-01-18', 757.51, '2001-09-01', '中国成都市成华区二仙桥东三路169号50号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (597, '2012-06-22 09:16:18', '2007-12-05 06:50:28', 1, NULL, '蕭天樂', 0, 'AB-ED-8222-I', 0, '19965550303', '2021-10-21', '2016-12-05', 83.97, '2003-02-20', '中国北京市朝阳区三里屯路87号28栋', '123456', 1);
INSERT INTO `vip_info` VALUES (598, '2005-11-25 03:06:11', '2014-09-07 01:40:26', 0, NULL, '梁璐', 1, 'BF-DE-7722-X', 0, '13616480035', '2013-07-08', '2025-04-26', 167.04, '2001-12-27', '中国成都市锦江区人民南路四段310号40室', '123456', 1);
INSERT INTO `vip_info` VALUES (599, '2023-08-15 12:33:28', '2015-12-19 10:56:58', 0, NULL, '朱云熙', 0, 'BF-FB-7169-D', 0, '16843295015', '2009-10-16', '2017-05-25', 854.09, '2004-10-05', '中国东莞坑美十五巷266号44室', '123456', 1);
INSERT INTO `vip_info` VALUES (600, '2015-10-30 08:02:21', '2023-12-27 15:03:33', 0, NULL, '蘇志明', 1, 'EB-DC-9938-F', 0, '18260710357', '2006-01-29', '2016-08-24', 370.32, '2000-04-06', '中国深圳龙岗区学园一巷695号49室', '123456', 1);
INSERT INTO `vip_info` VALUES (601, '2014-11-14 09:20:19', '2020-01-23 14:10:22', 1, NULL, '胡晓明', 0, 'FB-DB-9275-X', 0, '13120379896', '2010-10-16', '2017-10-14', 980.78, '2003-08-02', '中国深圳罗湖区清水河一路795号华润大厦29室', '123456', 1);
INSERT INTO `vip_info` VALUES (602, '2014-09-13 21:49:18', '2016-10-26 09:35:43', 0, NULL, '姜惠敏', 0, 'DD-BA-6742-W', 0, '19668651306', '2021-03-13', '2009-09-22', 749.06, '2021-11-07', '中国深圳罗湖区田贝一路321号华润大厦6室', '123456', 1);
INSERT INTO `vip_info` VALUES (603, '2003-09-09 12:18:38', '2010-01-24 07:43:08', 0, NULL, '潘杰宏', 1, 'BC-BE-3926-Y', 0, '14793700516', '2022-04-13', '2004-08-01', 995.93, '2008-08-04', '中国上海市徐汇区虹桥路182号38栋', '123456', 1);
INSERT INTO `vip_info` VALUES (604, '2014-10-03 01:37:36', '2018-10-18 22:20:21', 1, NULL, '薛宇宁', 0, 'CE-BF-4577-N', 0, '17708637483', '2007-01-08', '2015-01-01', 797.43, '2017-01-07', '中国北京市朝阳区三里屯路760号4楼', '123456', 1);
INSERT INTO `vip_info` VALUES (605, '2008-01-13 09:44:30', '2001-10-28 02:10:46', 1, NULL, '應國權', 1, 'CB-AB-9025-K', 0, '13455459820', '2013-06-02', '2025-02-17', 545.19, '2000-08-25', '中国东莞坑美十五巷377号华润大厦40室', '123456', 1);
INSERT INTO `vip_info` VALUES (606, '2008-06-14 08:33:54', '2020-06-03 18:09:27', 0, NULL, '區國權', 1, 'FF-FA-5747-J', 0, '17699702386', '2002-01-23', '2004-03-17', 614.72, '2015-10-23', '中国东莞坑美十五巷525号42楼', '123456', 1);
INSERT INTO `vip_info` VALUES (607, '2023-08-17 08:42:49', '2008-04-02 17:33:15', 1, NULL, '鄺志遠', 0, 'BB-DF-1623-M', 0, '16415217518', '2021-10-10', '2024-05-10', 306.07, '2005-09-07', '中国成都市成华区二仙桥东三路492号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (608, '2024-07-05 01:04:36', '2001-05-29 14:51:48', 0, NULL, '曹志遠', 1, 'EE-BF-2464-S', 0, '13704567381', '2020-12-23', '2021-05-01', 702.57, '2017-10-11', '中国广州市海珠区江南西路491号49号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (609, '2011-01-23 07:28:12', '2019-03-23 19:20:59', 1, NULL, '洪家輝', 1, 'EC-FC-9477-S', 0, '15728503145', '2010-02-15', '2008-12-09', 509.96, '2022-02-21', '中国上海市黄浦区淮海中路543号18室', '123456', 1);
INSERT INTO `vip_info` VALUES (610, '2019-11-26 14:04:00', '2001-08-05 07:08:43', 1, NULL, '成淑怡', 0, 'BA-CF-0077-S', 0, '18176045765', '2020-11-04', '2017-07-01', 879.91, '2001-07-26', '中国北京市延庆区028县道829号41栋', '123456', 1);
INSERT INTO `vip_info` VALUES (611, '2014-11-14 07:22:17', '2018-01-21 04:04:57', 1, NULL, '溫俊宇', 1, 'CA-FF-7385-C', 0, '17374236057', '2024-05-06', '2024-04-27', 56.73, '2009-07-09', '中国北京市海淀区清河中街68号423号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (612, '2005-09-07 09:04:36', '2005-01-11 20:42:31', 0, NULL, '任睿', 0, 'EB-FE-9706-W', 0, '15127770841', '2018-03-05', '2005-10-24', 26.65, '2013-07-14', '中国上海市闵行区宾川路289号36号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (613, '2024-02-22 08:39:13', '2015-05-31 18:46:45', 1, NULL, '许震南', 0, 'CD-DF-9937-C', 0, '15250788763', '2014-09-18', '2024-11-13', 144.61, '2022-03-07', '中国北京市房山区岳琉路137号华润大厦8室', '123456', 1);
INSERT INTO `vip_info` VALUES (614, '2002-12-11 09:54:53', '2012-03-29 18:09:31', 1, NULL, '贾嘉伦', 1, 'BF-EF-0073-Y', 0, '13029959533', '2021-03-17', '2018-11-22', 532.94, '2021-10-19', '中国成都市锦江区红星路三段50号32楼', '123456', 1);
INSERT INTO `vip_info` VALUES (615, '2007-07-27 17:48:38', '2013-06-25 06:08:43', 1, NULL, '向岚', 1, 'BF-DA-0425-P', 0, '17191336381', '2023-10-17', '2022-08-31', 81.57, '2023-03-28', '中国深圳龙岗区学园一巷421号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (616, '2016-06-29 18:49:52', '2020-02-15 19:52:16', 1, NULL, '张云熙', 1, 'FD-CD-8365-D', 0, '13100115698', '2002-04-04', '2024-03-23', 438.05, '2003-05-06', '中国北京市朝阳区三里屯路475号华润大厦45室', '123456', 1);
INSERT INTO `vip_info` VALUES (617, '2016-11-19 07:28:46', '2024-03-26 15:44:42', 1, NULL, '林富城', 1, 'FC-AB-9547-I', 0, '16766997313', '2000-08-22', '2013-11-15', 660.02, '2024-05-06', '中国中山天河区大信商圈大信南路584号26楼', '123456', 1);
INSERT INTO `vip_info` VALUES (618, '2005-07-13 07:51:09', '2024-05-19 06:43:31', 1, NULL, '廖俊宇', 0, 'CE-AA-6387-X', 0, '15422712482', '2018-04-25', '2016-05-19', 872.85, '2014-10-25', '中国上海市徐汇区虹桥路748号26室', '123456', 1);
INSERT INTO `vip_info` VALUES (619, '2014-08-28 08:33:18', '2000-03-23 19:22:12', 0, NULL, '孙子异', 1, 'CE-CF-7686-O', 0, '14732089798', '2018-05-15', '2021-05-06', 499.78, '2018-02-01', '中国北京市西城区西長安街454号7栋', '123456', 1);
INSERT INTO `vip_info` VALUES (620, '2021-05-01 09:02:48', '2016-01-15 10:22:06', 0, NULL, '阎子异', 0, 'EA-DF-9979-T', 0, '16489983769', '2006-08-18', '2016-11-09', 121.45, '2015-12-05', '中国深圳罗湖区田贝一路559号9室', '123456', 1);
INSERT INTO `vip_info` VALUES (621, '2019-02-16 02:01:34', '2022-10-10 03:30:00', 1, NULL, '马嘉伦', 1, 'FD-BF-4476-R', 0, '14194994302', '2009-04-20', '2020-02-24', 279.30, '2022-01-30', '中国东莞坑美十五巷596号华润大厦39室', '123456', 1);
INSERT INTO `vip_info` VALUES (622, '2021-05-16 02:59:23', '2008-05-02 09:26:17', 0, NULL, '吴詩涵', 1, 'DA-BD-7479-X', 0, '16849653336', '2000-11-21', '2004-12-02', 661.20, '2003-07-31', '中国成都市成华区二仙桥东三路158号47栋', '123456', 1);
INSERT INTO `vip_info` VALUES (623, '2002-10-17 23:34:20', '2020-10-17 13:29:29', 1, NULL, '傅宇宁', 0, 'BC-DC-4905-Z', 0, '15696018178', '2005-07-31', '2008-07-14', 219.34, '2011-12-15', '中国深圳罗湖区蔡屋围深南东路850号华润大厦45室', '123456', 1);
INSERT INTO `vip_info` VALUES (624, '2013-05-18 05:37:55', '2007-03-15 11:52:35', 0, NULL, '贺子异', 0, 'EB-ED-3480-F', 0, '16068787941', '2019-06-21', '2016-12-23', 486.90, '2014-10-14', '中国北京市西城区西長安街369号华润大厦1室', '123456', 1);
INSERT INTO `vip_info` VALUES (625, '2017-05-09 16:43:51', '2004-08-17 16:42:41', 0, NULL, '邵子韬', 0, 'CF-DC-9299-T', 0, '13484960447', '2006-02-22', '2015-01-12', 613.95, '2001-10-05', '中国中山天河区大信商圈大信南路901号15室', '123456', 1);
INSERT INTO `vip_info` VALUES (626, '2025-01-13 09:18:11', '2010-03-31 02:36:38', 0, NULL, '林子异', 1, 'EE-DF-2715-S', 0, '15385406332', '2011-09-27', '2006-06-30', 762.78, '2009-06-01', '中国中山京华商圈华夏街883号6栋', '123456', 1);
INSERT INTO `vip_info` VALUES (627, '2018-06-29 00:21:12', '2024-05-21 16:30:20', 0, NULL, '王致远', 0, 'BB-FB-7239-G', 0, '13406925894', '2023-09-15', '2022-10-30', 742.67, '2006-01-29', '中国深圳罗湖区清水河一路966号华润大厦36室', '123456', 1);
INSERT INTO `vip_info` VALUES (628, '2017-12-31 08:51:44', '2008-04-09 13:04:29', 1, NULL, '郭浩然', 1, 'AF-AC-3781-S', 0, '17059031926', '2001-09-02', '2016-12-16', 255.67, '2018-10-18', '中国上海市闵行区宾川路392号华润大厦15室', '123456', 1);
INSERT INTO `vip_info` VALUES (629, '2016-08-19 00:49:57', '2004-09-14 10:10:23', 1, NULL, '鄭安娜', 1, 'CE-EB-1661-M', 0, '19380825648', '2021-06-06', '2007-02-17', 43.29, '2018-11-30', '中国上海市浦东新区健祥路969号34室', '123456', 1);
INSERT INTO `vip_info` VALUES (630, '2021-06-15 12:24:26', '2007-03-24 11:58:48', 1, NULL, '蒋宇宁', 0, 'CD-BC-3245-K', 0, '15683536240', '2005-09-14', '2012-11-04', 789.55, '2002-07-04', '中国成都市成华区二仙桥东三路647号20栋', '123456', 1);
INSERT INTO `vip_info` VALUES (631, '2001-01-13 01:04:05', '2011-09-21 12:26:14', 1, NULL, '高晓明', 0, 'EC-AF-8587-F', 0, '16772917900', '2017-05-14', '2020-08-20', 560.20, '2017-05-09', '中国深圳福田区深南大道384号11室', '123456', 1);
INSERT INTO `vip_info` VALUES (632, '2020-01-05 20:47:39', '2004-09-24 10:57:17', 1, NULL, '陶思妤', 1, 'EA-DF-3121-F', 0, '13933569470', '2008-06-12', '2011-12-03', 693.46, '2018-08-17', '中国深圳福田区景田东一街290号华润大厦29室', '123456', 1);
INSERT INTO `vip_info` VALUES (633, '2016-05-11 21:48:16', '2008-03-01 07:01:16', 0, NULL, '邵秀英', 1, 'EA-BC-3137-H', 0, '15787445286', '2010-11-29', '2022-12-30', 820.94, '2023-05-08', '中国上海市浦东新区健祥路234号38室', '123456', 1);
INSERT INTO `vip_info` VALUES (634, '2016-10-12 03:04:14', '2007-11-20 01:21:07', 0, NULL, '许璐', 0, 'CC-EB-4769-I', 0, '19939235080', '2013-11-27', '2008-09-17', 246.60, '2012-01-25', '中国北京市延庆区028县道770号22室', '123456', 1);
INSERT INTO `vip_info` VALUES (635, '2009-10-07 10:02:58', '2007-08-16 22:51:31', 0, NULL, '萬嘉欣', 0, 'CE-FA-0381-Y', 0, '19970399708', '2013-03-18', '2003-11-30', 452.47, '2006-05-09', '中国深圳罗湖区清水河一路768号6栋', '123456', 1);
INSERT INTO `vip_info` VALUES (636, '2017-01-03 05:40:56', '2020-11-29 10:34:14', 0, NULL, '陆嘉伦', 1, 'DE-BD-4878-Q', 0, '14038199535', '2001-01-03', '2017-10-03', 299.84, '2004-10-20', '中国上海市浦东新区健祥路94号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (637, '2006-04-17 03:33:48', '2009-04-29 16:59:04', 0, NULL, '成明', 0, 'DC-AE-6782-W', 0, '14624176491', '2017-05-10', '2003-02-02', 386.62, '2016-12-10', '中国东莞东泰五街260号26栋', '123456', 1);
INSERT INTO `vip_info` VALUES (638, '2022-01-17 21:46:09', '2008-07-27 09:42:34', 0, NULL, '戴詩涵', 0, 'DB-EF-1663-P', 0, '14707432520', '2025-02-07', '2016-08-15', 445.71, '2019-10-31', '中国广州市越秀区中山二路220号华润大厦49室', '123456', 1);
INSERT INTO `vip_info` VALUES (639, '2014-09-11 08:56:38', '2004-02-10 16:19:46', 1, NULL, '湯惠妹', 0, 'AB-BB-1308-Z', 0, '17651817291', '2006-12-31', '2015-04-05', 815.51, '2015-12-17', '中国成都市成华区双庆路856号华润大厦47室', '123456', 1);
INSERT INTO `vip_info` VALUES (640, '2018-03-12 01:40:24', '2009-05-01 11:26:03', 1, NULL, '梁霆鋒', 1, 'BE-FE-2721-D', 0, '17825748027', '2001-01-03', '2007-05-03', 188.69, '2011-07-29', '中国深圳罗湖区田贝一路588号30室', '123456', 1);
INSERT INTO `vip_info` VALUES (641, '2008-08-07 16:06:22', '2005-03-19 10:05:43', 1, NULL, '林玲玲', 0, 'ED-DD-2471-L', 0, '19921169160', '2021-02-08', '2003-06-10', 858.70, '2009-06-28', '中国广州市越秀区中山二路88号华润大厦20室', '123456', 1);
INSERT INTO `vip_info` VALUES (642, '2024-08-15 13:59:07', '2018-11-22 22:09:03', 0, NULL, '譚玲玲', 1, 'FC-AF-8596-E', 0, '13944780036', '2004-03-12', '2012-04-27', 357.00, '2019-10-22', '中国东莞环区南街二巷984号26室', '123456', 1);
INSERT INTO `vip_info` VALUES (643, '2000-09-27 18:16:02', '2004-07-12 08:08:43', 0, NULL, '任嘉伦', 0, 'DF-DA-6829-I', 0, '15620403049', '2023-08-14', '2018-01-22', 585.73, '2006-08-28', '中国上海市浦东新区健祥路323号46楼', '123456', 1);
INSERT INTO `vip_info` VALUES (644, '2006-10-02 18:48:34', '2014-06-15 13:48:38', 1, NULL, '房秀文', 0, 'FA-FB-4911-N', 0, '17755520433', '2013-11-19', '2015-09-12', 654.48, '2007-11-11', '中国上海市黄浦区淮海中路26号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (645, '2022-07-06 15:56:26', '2004-05-08 08:27:53', 0, NULL, '姜致远', 1, 'CD-CB-8157-N', 0, '18208861929', '2003-07-24', '2010-06-18', 273.02, '2000-07-30', '中国广州市越秀区中山二路513号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (646, '2024-10-13 07:01:02', '2000-06-09 12:37:10', 1, NULL, '常子异', 0, 'AB-DA-7703-E', 0, '13344466222', '2019-10-04', '2003-06-24', 799.82, '2024-01-20', '中国北京市房山区岳琉路796号华润大厦5室', '123456', 1);
INSERT INTO `vip_info` VALUES (647, '2017-01-31 13:39:09', '2008-05-05 09:03:03', 1, NULL, '罗嘉伦', 1, 'FB-CF-3044-B', 0, '18753120256', '2013-03-11', '2013-07-11', 333.09, '2014-07-31', '中国北京市朝阳区三里屯路53号17室', '123456', 1);
INSERT INTO `vip_info` VALUES (648, '2010-12-30 02:42:39', '2010-11-17 00:39:46', 1, NULL, '余安琪', 1, 'EB-DC-0817-X', 0, '19710904078', '2003-01-12', '2005-07-20', 407.63, '2009-06-24', '中国东莞坑美十五巷411号7栋', '123456', 1);
INSERT INTO `vip_info` VALUES (649, '2023-06-12 20:01:48', '2004-06-20 16:02:24', 0, NULL, '谢岚', 0, 'DF-BB-1570-U', 0, '19661631566', '2020-11-12', '2003-03-18', 617.97, '2008-08-16', '中国广州市白云区小坪东路866号48号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (650, '2007-07-19 18:53:12', '2017-03-08 08:24:03', 0, NULL, '雷晓明', 0, 'AC-AD-4263-G', 0, '14801842707', '2011-09-28', '2018-06-02', 481.71, '2018-02-01', '中国成都市成华区玉双路6号88号9栋', '123456', 1);
INSERT INTO `vip_info` VALUES (651, '2008-03-22 11:51:16', '2017-09-13 18:16:07', 1, NULL, '盧志遠', 1, 'DF-FF-9964-S', 0, '15221982699', '2013-07-09', '2021-01-13', 722.70, '2005-08-14', '中国东莞坑美十五巷554号华润大厦18室', '123456', 1);
INSERT INTO `vip_info` VALUES (652, '2024-10-13 11:57:06', '2003-07-19 22:34:46', 0, NULL, '黄詩涵', 1, 'BA-BB-4340-W', 0, '13089960795', '2016-07-07', '2021-07-15', 34.98, '2010-02-02', '中国中山天河区大信商圈大信南路445号26室', '123456', 1);
INSERT INTO `vip_info` VALUES (653, '2000-12-05 02:47:41', '2013-07-04 11:44:35', 1, NULL, '于睿', 0, 'EF-BF-0245-E', 0, '15037406782', '2010-01-21', '2023-12-23', 50.20, '2003-02-02', '中国东莞东泰五街372号24号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (654, '2005-08-08 17:17:18', '2007-07-06 02:45:42', 0, NULL, '沈秀英', 0, 'DE-FC-2277-X', 0, '18500949866', '2001-02-05', '2009-11-16', 275.77, '2006-01-17', '中国中山紫马岭商圈中山五路530号28号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (655, '2014-01-15 06:18:52', '2003-02-01 03:03:43', 0, NULL, '藤安琪', 0, 'DF-AF-7182-B', 0, '17096534012', '2010-03-21', '2024-02-25', 183.64, '2014-01-05', '中国成都市成华区二仙桥东三路845号4栋', '123456', 1);
INSERT INTO `vip_info` VALUES (656, '2025-05-15 10:46:35', '2012-07-22 21:27:37', 0, NULL, '孫德華', 0, 'DD-ED-5361-X', 0, '15363788372', '2014-12-04', '2019-08-19', 882.80, '2020-08-26', '中国东莞珊瑚路683号30楼', '123456', 1);
INSERT INTO `vip_info` VALUES (657, '2003-04-09 00:01:23', '2023-09-16 08:42:25', 1, NULL, '黎國榮', 1, 'FB-AC-7172-O', 0, '14901998836', '2004-10-11', '2002-04-10', 350.25, '2014-07-20', '中国北京市西城区西長安街616号46栋', '123456', 1);
INSERT INTO `vip_info` VALUES (658, '2024-10-31 04:24:47', '2003-02-04 07:42:48', 0, NULL, '刘晓明', 1, 'EE-FE-9152-X', 0, '18453568241', '2012-01-27', '2023-08-04', 20.23, '2022-11-15', '中国北京市东城区东单王府井东街37号33楼', '123456', 1);
INSERT INTO `vip_info` VALUES (659, '2006-06-24 07:56:41', '2019-03-31 19:16:42', 1, NULL, '戴宇宁', 0, 'AA-BB-3237-A', 0, '13142363898', '2010-09-12', '2025-04-20', 112.94, '2001-11-26', '中国上海市浦东新区健祥路653号45栋', '123456', 1);
INSERT INTO `vip_info` VALUES (660, '2017-08-31 00:53:44', '2022-06-16 17:47:18', 1, NULL, '崔志遠', 1, 'EF-FF-8641-L', 0, '19965493083', '2024-02-09', '2004-05-22', 627.80, '2003-04-22', '中国成都市成华区玉双路6号491号26室', '123456', 1);
INSERT INTO `vip_info` VALUES (661, '2022-10-12 15:17:08', '2007-02-17 18:58:40', 0, NULL, '孟子韬', 1, 'BB-FC-6719-V', 0, '13658449492', '2002-01-11', '2008-05-06', 567.93, '2008-01-11', '中国广州市越秀区中山二路87号10楼', '123456', 1);
INSERT INTO `vip_info` VALUES (662, '2009-02-01 06:12:25', '2013-07-10 21:07:13', 1, NULL, '董子韬', 1, 'DC-FB-9028-M', 0, '13161179176', '2010-05-19', '2006-02-27', 133.89, '2007-06-22', '中国北京市东城区东单王府井东街795号47栋', '123456', 1);
INSERT INTO `vip_info` VALUES (663, '2000-11-28 17:09:18', '2017-11-11 01:30:37', 0, NULL, '毛慧敏', 0, 'AE-AC-5568-I', 0, '17760716488', '2000-03-01', '2020-12-22', 678.93, '2013-08-18', '中国成都市成华区玉双路6号271号8栋', '123456', 1);
INSERT INTO `vip_info` VALUES (664, '2009-03-18 11:22:56', '2004-12-23 05:25:57', 0, NULL, '钟詩涵', 1, 'FE-DD-3651-I', 0, '15111334644', '2003-12-11', '2009-02-02', 393.20, '2020-10-27', '中国成都市成华区玉双路6号798号36楼', '123456', 1);
INSERT INTO `vip_info` VALUES (665, '2000-07-04 12:13:07', '2013-08-30 07:43:18', 0, NULL, '郭淑怡', 0, 'ED-AD-0037-N', 0, '15749299664', '2016-12-25', '2016-07-15', 577.31, '2013-02-06', '中国东莞坑美十五巷102号37号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (666, '2015-09-17 09:24:58', '2012-01-15 23:52:22', 1, NULL, '田岚', 1, 'CA-AB-3201-M', 0, '13712939481', '2013-07-14', '2016-12-13', 967.12, '2005-02-05', '中国东莞珊瑚路784号22楼', '123456', 1);
INSERT INTO `vip_info` VALUES (667, '2025-06-13 04:54:08', '2023-06-16 19:48:13', 1, NULL, '郭浩然', 1, 'FC-AB-2887-C', 0, '18957274303', '2008-08-20', '2003-09-13', 878.52, '2022-05-18', '中国北京市西城区西長安街973号49室', '123456', 1);
INSERT INTO `vip_info` VALUES (668, '2009-05-29 00:40:00', '2006-03-05 10:19:12', 0, NULL, '杨云熙', 1, 'AD-DA-1807-O', 0, '13104884985', '2014-03-27', '2004-08-20', 678.63, '2013-02-02', '中国成都市成华区二仙桥东三路163号14楼', '123456', 1);
INSERT INTO `vip_info` VALUES (669, '2005-02-23 16:58:28', '2000-08-26 06:44:45', 1, NULL, '贺詩涵', 0, 'BF-BE-9050-A', 0, '19805728028', '2009-01-27', '2013-09-28', 737.26, '2023-06-07', '中国北京市东城区东单王府井东街324号5栋', '123456', 1);
INSERT INTO `vip_info` VALUES (670, '2018-10-17 13:38:53', '2006-05-31 05:18:01', 1, NULL, '谷惠敏', 1, 'DB-EA-0910-G', 0, '15041638828', '2023-07-16', '2001-03-02', 842.66, '2006-01-12', '中国北京市東城区東直門內大街460号华润大厦12室', '123456', 1);
INSERT INTO `vip_info` VALUES (671, '2014-12-17 18:17:11', '2009-01-15 12:44:13', 0, NULL, '駱浩然', 1, 'CD-BF-4483-X', 0, '19307131256', '2012-04-25', '2009-07-21', 733.03, '2015-07-03', '中国上海市徐汇区虹桥路972号2楼', '123456', 1);
INSERT INTO `vip_info` VALUES (672, '2003-04-02 08:21:19', '2010-07-08 18:53:09', 1, NULL, '韦子韬', 0, 'BB-EB-8923-J', 0, '14374082293', '2020-04-26', '2023-05-25', 583.35, '2003-03-26', '中国广州市白云区小坪东路757号37栋', '123456', 1);
INSERT INTO `vip_info` VALUES (673, '2015-05-18 00:33:18', '2021-09-12 18:12:52', 1, NULL, '程嘉伦', 0, 'AF-EF-3266-A', 0, '18535452105', '2024-09-22', '2011-11-08', 53.69, '2016-10-16', '中国深圳罗湖区田贝一路347号10栋', '123456', 1);
INSERT INTO `vip_info` VALUES (674, '2012-06-09 01:30:32', '2002-05-21 04:24:42', 0, NULL, '鄭秀文', 0, 'BB-AB-7205-Q', 0, '17337980261', '2006-01-12', '2007-05-09', 67.08, '2009-10-09', '中国北京市海淀区清河中街68号857号44室', '123456', 1);
INSERT INTO `vip_info` VALUES (675, '2008-04-27 12:30:46', '2000-06-01 08:57:59', 1, NULL, '袁晓明', 0, 'EF-EB-6253-W', 0, '15807954091', '2009-12-02', '2024-06-24', 314.31, '2021-08-10', '中国成都市锦江区人民南路四段3号31号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (676, '2015-09-02 07:53:09', '2015-05-14 23:13:29', 0, NULL, '伍曉彤', 1, 'BE-AF-2276-B', 0, '16533108150', '2024-08-13', '2010-05-07', 784.96, '2001-03-08', '中国广州市海珠区江南西路968号43号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (677, '2016-12-25 17:06:46', '2009-11-16 00:07:27', 0, NULL, '汤璐', 1, 'ED-BD-9560-A', 0, '14499816601', '2013-12-25', '2020-07-14', 970.74, '2013-06-10', '中国北京市海淀区清河中街68号41号10号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (678, '2020-04-14 15:54:37', '2000-09-27 07:00:55', 1, NULL, '曾岚', 0, 'CC-EA-7202-Z', 0, '17794114967', '2019-04-18', '2011-02-25', 458.74, '2015-10-24', '中国北京市延庆区028县道974号华润大厦33室', '123456', 1);
INSERT INTO `vip_info` VALUES (679, '2006-08-06 14:01:45', '2010-05-28 01:53:28', 1, NULL, '姚梓晴', 1, 'AF-BF-2851-O', 0, '17925217828', '2023-03-25', '2011-04-01', 330.35, '2023-02-10', '中国东莞珊瑚路959号47号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (680, '2006-05-09 05:14:11', '2012-03-24 04:47:12', 1, NULL, '毛學友', 1, 'CE-ED-8060-B', 0, '14014989521', '2021-03-28', '2010-09-26', 271.41, '2002-08-14', '中国东莞东泰五街312号18栋', '123456', 1);
INSERT INTO `vip_info` VALUES (681, '2000-10-07 08:25:01', '2016-09-23 11:33:37', 0, NULL, '莫慧嫻', 0, 'AF-CD-3456-X', 0, '17780851677', '2015-08-25', '2005-05-14', 930.51, '2021-08-29', '中国成都市锦江区红星路三段245号华润大厦43室', '123456', 1);
INSERT INTO `vip_info` VALUES (682, '2024-08-30 02:17:36', '2015-04-27 11:15:27', 0, NULL, '劉秀文', 0, 'BB-EE-6015-J', 0, '16847446707', '2016-08-05', '2011-04-18', 139.36, '2021-09-25', '中国中山紫马岭商圈中山五路332号37栋', '123456', 1);
INSERT INTO `vip_info` VALUES (683, '2015-09-06 17:55:34', '2016-08-27 08:36:47', 1, NULL, '邱岚', 1, 'FB-AA-2996-R', 0, '18370419313', '2013-09-07', '2020-12-12', 624.52, '2018-11-15', '中国深圳龙岗区布吉镇西环路378号15号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (684, '2016-07-08 15:49:05', '2001-07-29 04:54:09', 0, NULL, '夏子异', 0, 'BB-BF-4213-L', 0, '19573164024', '2010-01-23', '2013-10-15', 133.83, '2024-05-16', '中国中山紫马岭商圈中山五路430号13楼', '123456', 1);
INSERT INTO `vip_info` VALUES (685, '2012-05-25 20:14:24', '2014-03-23 11:17:42', 0, NULL, '董震南', 0, 'EC-AF-5939-P', 0, '15613691868', '2018-02-17', '2005-01-19', 975.65, '2007-01-30', '中国北京市东城区东单王府井东街944号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (686, '2002-04-03 06:25:41', '2017-09-07 14:53:26', 0, NULL, '马云熙', 1, 'BD-EC-6985-G', 0, '14680299283', '2013-02-07', '2005-08-02', 827.90, '2016-09-17', '中国成都市锦江区红星路三段151号38楼', '123456', 1);
INSERT INTO `vip_info` VALUES (687, '2024-12-13 22:59:02', '2004-10-30 00:18:59', 0, NULL, '余宇宁', 0, 'CA-EE-5333-B', 0, '18998942143', '2017-11-08', '2013-11-23', 592.82, '2016-11-26', '中国广州市越秀区中山二路125号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (688, '2006-02-17 12:29:38', '2005-04-06 14:57:08', 0, NULL, '邱榮發', 1, 'FB-FB-3120-H', 0, '15056886883', '2001-12-17', '2013-05-17', 298.63, '2009-05-26', '中国深圳福田区景田东一街493号华润大厦45室', '123456', 1);
INSERT INTO `vip_info` VALUES (689, '2000-11-23 18:32:51', '2005-11-09 01:34:12', 0, NULL, '黎子韬', 1, 'AD-EA-0383-G', 0, '18948249866', '2002-07-29', '2014-04-04', 112.15, '2021-08-02', '中国东莞珊瑚路762号24楼', '123456', 1);
INSERT INTO `vip_info` VALUES (690, '2006-05-17 20:49:43', '2011-12-15 08:38:26', 1, NULL, '钟嘉伦', 1, 'DC-AA-2513-J', 0, '17336576805', '2013-05-18', '2014-02-15', 75.60, '2001-06-20', '中国深圳龙岗区布吉镇西环路55号43楼', '123456', 1);
INSERT INTO `vip_info` VALUES (691, '2007-09-30 04:53:00', '2020-03-01 11:50:04', 1, NULL, '孔安琪', 1, 'BE-BC-8686-E', 0, '13237297842', '2010-02-01', '2017-04-24', 653.37, '2006-12-30', '中国中山乐丰六路112号7楼', '123456', 1);
INSERT INTO `vip_info` VALUES (692, '2011-07-12 18:46:41', '2005-12-23 16:25:02', 0, NULL, '鄧天樂', 1, 'FF-EA-8194-J', 0, '18429373499', '2012-05-19', '2019-01-16', 361.37, '2009-01-26', '中国上海市闵行区宾川路893号华润大厦14室', '123456', 1);
INSERT INTO `vip_info` VALUES (693, '2018-06-09 03:33:05', '2015-11-13 00:57:07', 1, NULL, '秦子异', 1, 'CB-DE-8327-J', 0, '18262749578', '2006-01-30', '2002-11-20', 430.86, '2005-11-11', '中国北京市西城区复兴门内大街28号21号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (694, '2005-02-28 19:57:09', '2002-12-26 00:18:19', 0, NULL, '薛宇宁', 0, 'EA-AA-3447-X', 0, '19858183474', '2012-11-09', '2010-08-19', 681.42, '2018-08-12', '中国东莞珊瑚路84号20室', '123456', 1);
INSERT INTO `vip_info` VALUES (695, '2006-08-19 17:42:36', '2020-04-02 04:37:54', 0, NULL, '傅志遠', 1, 'FD-BB-2568-A', 0, '14190259571', '2002-11-16', '2023-09-16', 938.35, '2012-05-20', '中国北京市延庆区028县道863号华润大厦22室', '123456', 1);
INSERT INTO `vip_info` VALUES (696, '2022-03-15 11:54:55', '2016-09-12 00:05:19', 1, NULL, '元慧琳', 1, 'EC-BA-4429-L', 0, '15445198502', '2025-04-20', '2009-01-03', 274.87, '2019-11-22', '中国广州市天河区天河路279号2号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (697, '2009-03-07 16:24:58', '2016-07-21 17:30:10', 1, NULL, '萧璐', 1, 'CE-EA-0365-O', 0, '13054151875', '2021-03-11', '2017-01-15', 966.76, '2003-02-07', '中国北京市延庆区028县道436号42号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (698, '2003-10-09 20:17:08', '2005-07-21 07:50:38', 0, NULL, '马璐', 1, 'AB-FC-9463-L', 0, '17482949928', '2010-04-29', '2017-09-30', 859.83, '2005-02-26', '中国广州市天河区天河路100号13栋', '123456', 1);
INSERT INTO `vip_info` VALUES (699, '2004-02-16 09:20:44', '2015-05-11 13:43:01', 1, NULL, '马宇宁', 0, 'CC-ED-8141-S', 0, '13981714024', '2010-04-04', '2002-08-26', 530.65, '2007-12-06', '中国成都市成华区玉双路6号76号42栋', '123456', 1);
INSERT INTO `vip_info` VALUES (700, '2002-01-18 02:29:26', '2002-10-20 20:03:40', 1, NULL, '車嘉欣', 1, 'BC-FB-9249-F', 0, '16013217942', '2006-09-06', '2020-08-20', 946.06, '2019-07-03', '中国上海市黄浦区淮海中路669号7楼', '123456', 1);
INSERT INTO `vip_info` VALUES (701, '2024-11-13 15:08:59', '2017-08-17 08:10:33', 0, NULL, '邓杰宏', 0, 'EC-DD-9303-V', 0, '14710461657', '2000-11-14', '2003-05-13', 613.75, '2010-04-11', '中国深圳龙岗区布吉镇西环路344号10栋', '123456', 1);
INSERT INTO `vip_info` VALUES (702, '2001-02-28 05:31:26', '2020-01-01 08:58:50', 0, NULL, '汪子韬', 0, 'BF-EF-3119-Q', 0, '19724310692', '2023-01-30', '2001-01-25', 536.33, '2010-10-19', '中国深圳罗湖区清水河一路642号34室', '123456', 1);
INSERT INTO `vip_info` VALUES (703, '2008-06-03 20:49:28', '2002-01-28 18:48:24', 0, NULL, '文慧珊', 0, 'CC-AA-5497-R', 0, '19417901060', '2015-04-02', '2018-08-13', 865.71, '2022-05-09', '中国广州市白云区小坪东路30号41号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (704, '2002-05-19 11:38:02', '2023-09-25 16:46:59', 1, NULL, '冯宇宁', 0, 'CA-FC-3042-S', 0, '17936260346', '2014-10-30', '2001-06-19', 278.84, '2002-07-25', '中国东莞珊瑚路134号24楼', '123456', 1);
INSERT INTO `vip_info` VALUES (705, '2004-06-14 08:14:19', '2011-03-13 17:20:59', 1, NULL, '蕭安娜', 0, 'FE-BE-2265-U', 0, '16771152313', '2007-08-29', '2023-11-05', 564.26, '2012-07-15', '中国广州市天河区天河路758号43楼', '123456', 1);
INSERT INTO `vip_info` VALUES (706, '2002-10-19 04:28:40', '2015-06-29 01:36:46', 0, NULL, '高安娜', 1, 'BE-AD-5674-W', 0, '14300712129', '2006-10-03', '2000-02-11', 539.44, '2016-10-29', '中国北京市东城区东单王府井东街573号21室', '123456', 1);
INSERT INTO `vip_info` VALUES (707, '2015-11-12 03:14:06', '2022-07-02 04:08:32', 1, NULL, '郭璐', 1, 'AA-EC-6198-L', 0, '17909438631', '2000-05-18', '2015-08-31', 119.59, '2008-05-15', '中国中山天河区大信商圈大信南路123号40室', '123456', 1);
INSERT INTO `vip_info` VALUES (708, '2019-08-19 07:47:34', '2016-06-21 23:26:17', 0, NULL, '龚睿', 1, 'FD-EB-7857-Z', 0, '16129872353', '2013-12-22', '2022-04-24', 743.98, '2021-06-28', '中国中山京华商圈华夏街832号11室', '123456', 1);
INSERT INTO `vip_info` VALUES (709, '2011-11-16 14:48:39', '2013-10-20 20:17:59', 0, NULL, '張慧嫻', 0, 'DF-DF-5284-S', 0, '19741776206', '2017-12-18', '2010-11-28', 988.43, '2012-07-17', '中国成都市成华区双庆路445号24号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (710, '2013-08-26 06:42:17', '2002-09-24 16:11:35', 0, NULL, '戴玲玲', 1, 'EF-CC-6665-H', 0, '15853972764', '2022-10-06', '2024-06-19', 890.90, '2018-02-28', '中国北京市房山区岳琉路385号华润大厦4室', '123456', 1);
INSERT INTO `vip_info` VALUES (711, '2004-09-07 03:47:09', '2007-09-20 00:47:15', 1, NULL, '胡惠妹', 1, 'DD-AE-1752-U', 0, '14296076538', '2007-09-03', '2004-11-18', 213.57, '2002-12-07', '中国成都市成华区双庆路216号32室', '123456', 1);
INSERT INTO `vip_info` VALUES (712, '2024-03-18 11:18:21', '2013-10-03 00:52:09', 0, NULL, '溫學友', 0, 'DE-FF-6267-U', 0, '19651455619', '2023-11-14', '2007-05-21', 350.42, '2019-04-27', '中国广州市海珠区江南西路185号35楼', '123456', 1);
INSERT INTO `vip_info` VALUES (713, '2023-06-05 02:48:22', '2024-12-29 22:21:58', 1, NULL, '龚詩涵', 1, 'EF-AB-8041-F', 0, '19140941811', '2005-10-12', '2005-01-19', 16.43, '2015-06-12', '中国广州市天河区天河路437号15栋', '123456', 1);
INSERT INTO `vip_info` VALUES (714, '2012-10-04 02:54:35', '2006-05-25 16:33:02', 1, NULL, '陈岚', 1, 'CC-FF-5054-Y', 0, '16308620092', '2011-02-09', '2005-03-09', 503.15, '2019-02-01', '中国北京市西城区西長安街854号48楼', '123456', 1);
INSERT INTO `vip_info` VALUES (715, '2016-12-31 15:25:47', '2009-03-18 06:23:18', 0, NULL, '邱梓晴', 0, 'FA-EC-1043-S', 0, '17705413992', '2003-05-27', '2017-03-23', 440.30, '2014-06-02', '中国北京市朝阳区三里屯路367号25楼', '123456', 1);
INSERT INTO `vip_info` VALUES (716, '2003-09-09 01:18:50', '2001-07-01 19:00:37', 1, NULL, '熊杰宏', 0, 'DE-DD-2778-C', 0, '13368472549', '2010-11-05', '2024-01-08', 558.98, '2011-08-01', '中国广州市天河区天河路43号31楼', '123456', 1);
INSERT INTO `vip_info` VALUES (717, '2000-11-25 19:04:32', '2017-09-28 04:22:38', 1, NULL, '萬國權', 0, 'ED-CA-8450-G', 0, '18128922846', '2024-09-11', '2004-02-05', 879.86, '2010-08-13', '中国广州市白云区小坪东路30号华润大厦50室', '123456', 1);
INSERT INTO `vip_info` VALUES (718, '2006-05-07 08:20:33', '2001-08-11 12:50:47', 0, NULL, '周晓明', 0, 'FC-DF-2211-D', 0, '17094064290', '2005-03-16', '2023-11-14', 188.96, '2011-05-25', '中国中山乐丰六路295号44号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (719, '2005-06-06 07:33:00', '2009-06-15 22:43:42', 0, NULL, '金嘉伦', 1, 'CE-BA-1792-F', 0, '13827466656', '2018-07-24', '2004-04-25', 474.06, '2017-04-27', '中国北京市房山区岳琉路665号14栋', '123456', 1);
INSERT INTO `vip_info` VALUES (720, '2007-08-07 09:13:37', '2011-08-12 20:04:55', 1, NULL, '田宇宁', 0, 'FC-CA-8405-J', 0, '13172706822', '2008-03-03', '2013-12-30', 875.44, '2018-04-23', '中国广州市天河区天河路775号华润大厦20室', '123456', 1);
INSERT INTO `vip_info` VALUES (721, '2024-05-19 06:27:17', '2009-10-09 08:21:01', 0, NULL, '吳家強', 1, 'CD-BC-8047-V', 0, '14973489181', '2016-05-19', '2014-04-21', 831.56, '2024-03-16', '中国广州市白云区小坪东路608号48号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (722, '2004-03-28 13:19:48', '2011-01-09 04:38:10', 1, NULL, '藍惠敏', 1, 'DC-DF-1850-B', 0, '16759040313', '2008-01-19', '2010-04-30', 610.31, '2012-01-22', '中国北京市海淀区清河中街68号116号16室', '123456', 1);
INSERT INTO `vip_info` VALUES (723, '2009-07-19 02:12:48', '2017-10-16 17:26:12', 1, NULL, '陈震南', 1, 'ED-DF-9602-E', 0, '18110843455', '2012-10-19', '2016-01-06', 109.93, '2006-04-02', '中国东莞东泰五街573号39楼', '123456', 1);
INSERT INTO `vip_info` VALUES (724, '2009-09-17 04:25:51', '2009-07-03 02:12:25', 1, NULL, '贾子韬', 0, 'DD-CB-2182-L', 0, '14667189009', '2023-11-13', '2000-01-18', 13.06, '2020-09-08', '中国中山紫马岭商圈中山五路829号39号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (725, '2016-01-02 21:31:54', '2019-08-02 13:34:39', 0, NULL, '樂家強', 0, 'AA-EC-4574-Y', 0, '15078583454', '2021-12-11', '2003-07-22', 655.85, '2018-09-16', '中国深圳罗湖区清水河一路964号35栋', '123456', 1);
INSERT INTO `vip_info` VALUES (726, '2011-02-15 04:05:33', '2004-06-29 23:35:25', 0, NULL, '黎國賢', 1, 'DD-DD-1086-C', 0, '17508878138', '2012-03-17', '2011-01-25', 789.47, '2010-08-04', '中国中山乐丰六路675号8楼', '123456', 1);
INSERT INTO `vip_info` VALUES (727, '2018-03-24 08:49:44', '2013-04-05 02:12:25', 0, NULL, '莫力申', 0, 'FD-FE-2148-X', 0, '17317500442', '2008-12-26', '2003-06-05', 779.42, '2011-02-22', '中国上海市浦东新区橄榄路5号18室', '123456', 1);
INSERT INTO `vip_info` VALUES (728, '2014-12-11 01:40:54', '2000-04-15 06:02:31', 0, NULL, '张岚', 1, 'EA-AB-9242-Y', 0, '17323777145', '2024-05-23', '2019-05-11', 236.39, '2012-07-12', '中国东莞坑美十五巷419号华润大厦8室', '123456', 1);
INSERT INTO `vip_info` VALUES (729, '2022-11-22 22:58:50', '2012-12-19 08:32:50', 0, NULL, '谭岚', 1, 'AD-CE-2337-L', 0, '13344937826', '2019-11-21', '2009-12-04', 396.55, '2022-08-30', '中国广州市白云区机场路棠苑街五巷411号16楼', '123456', 1);
INSERT INTO `vip_info` VALUES (730, '2000-06-01 14:23:03', '2025-06-10 19:38:53', 0, NULL, '范秀英', 0, 'BF-FC-9121-X', 0, '14156346459', '2008-12-30', '2023-02-04', 427.61, '2022-05-27', '中国广州市天河区天河路196号32楼', '123456', 1);
INSERT INTO `vip_info` VALUES (731, '2010-11-18 03:03:27', '2009-01-02 16:00:36', 1, NULL, '卢宇宁', 0, 'BE-CE-8314-Z', 0, '18297885570', '2000-05-06', '2023-09-17', 614.60, '2003-11-12', '中国北京市延庆区028县道433号10号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (732, '2001-06-30 19:20:24', '2020-12-31 11:44:32', 0, NULL, '鄺國賢', 0, 'EC-AC-2500-F', 0, '17812720219', '2018-11-27', '2011-03-20', 133.46, '2010-02-23', '中国广州市海珠区江南西路643号45楼', '123456', 1);
INSERT INTO `vip_info` VALUES (733, '2011-12-08 01:31:51', '2004-10-22 14:11:19', 0, NULL, '陳曉彤', 1, 'AC-DB-0572-G', 0, '19472505437', '2006-11-04', '2020-01-31', 76.24, '2003-02-04', '中国北京市海淀区清河中街68号680号25室', '123456', 1);
INSERT INTO `vip_info` VALUES (734, '2012-08-12 23:02:47', '2006-12-24 15:23:29', 0, NULL, '梅小慧', 0, 'BD-EC-3895-T', 0, '16079223697', '2013-06-15', '2006-12-25', 539.34, '2010-11-28', '中国广州市白云区机场路棠苑街五巷312号9楼', '123456', 1);
INSERT INTO `vip_info` VALUES (735, '2016-07-06 23:35:36', '2016-04-04 14:09:02', 0, NULL, '樊德華', 1, 'FC-CF-0050-S', 0, '16539621706', '2021-01-14', '2011-12-06', 873.73, '2008-01-07', '中国深圳福田区深南大道636号15号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (736, '2021-05-03 00:50:00', '2004-03-10 22:54:26', 0, NULL, '謝家強', 1, 'CA-AB-1342-V', 0, '19408127656', '2012-02-15', '2003-06-11', 871.67, '2006-08-21', '中国深圳福田区深南大道716号21室', '123456', 1);
INSERT INTO `vip_info` VALUES (737, '2015-08-16 01:34:30', '2020-09-21 21:42:44', 0, NULL, '尹慧敏', 0, 'DC-DD-1873-Y', 0, '14356003229', '2009-02-22', '2019-05-08', 516.90, '2006-04-09', '中国东莞东泰五街470号25室', '123456', 1);
INSERT INTO `vip_info` VALUES (738, '2015-07-16 00:03:14', '2000-07-16 05:39:16', 0, NULL, '邵致远', 1, 'EF-BD-9391-Y', 0, '19720636930', '2007-12-26', '2024-12-03', 123.96, '2009-09-27', '中国深圳罗湖区清水河一路275号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (739, '2001-04-03 13:56:08', '2012-11-17 18:56:41', 0, NULL, '罗云熙', 1, 'FA-CB-8054-E', 0, '13567300293', '2017-05-18', '2011-12-27', 22.90, '2018-01-02', '中国上海市徐汇区虹桥路39号16栋', '123456', 1);
INSERT INTO `vip_info` VALUES (740, '2018-07-13 08:32:31', '2010-03-02 22:40:11', 0, NULL, '夏震南', 1, 'BB-EF-8298-Q', 0, '13940630003', '2006-06-01', '2019-01-25', 405.67, '2002-04-05', '中国成都市成华区双庆路652号25栋', '123456', 1);
INSERT INTO `vip_info` VALUES (741, '2000-09-03 15:37:55', '2018-06-20 18:40:00', 1, NULL, '宋嘉伦', 0, 'CA-ED-8989-Y', 0, '16658449768', '2000-05-22', '2022-02-09', 762.29, '2000-02-07', '中国北京市延庆区028县道110号29号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (742, '2008-02-25 20:37:08', '2020-10-24 10:12:32', 0, NULL, '宣潤發', 1, 'ED-DF-7918-Z', 0, '18848395925', '2019-08-30', '2022-03-17', 293.60, '2020-07-13', '中国广州市白云区机场路棠苑街五巷385号29栋', '123456', 1);
INSERT INTO `vip_info` VALUES (743, '2021-11-14 19:39:55', '2000-02-29 02:03:03', 0, NULL, '餘天榮', 0, 'FA-AC-5288-K', 0, '18531636795', '2016-07-09', '2005-10-29', 472.94, '2006-06-19', '中国北京市朝阳区三里屯路802号24栋', '123456', 1);
INSERT INTO `vip_info` VALUES (744, '2007-11-09 19:36:08', '2008-06-16 18:53:56', 0, NULL, '杨晓明', 0, 'AF-DA-1150-C', 0, '19158970169', '2013-04-25', '2015-08-25', 857.84, '2021-08-08', '中国深圳龙岗区布吉镇西环路67号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (745, '2022-04-17 22:58:49', '2023-03-11 22:41:51', 1, NULL, '刘杰宏', 1, 'AA-DC-8265-A', 0, '18958795384', '2007-01-07', '2018-05-09', 858.40, '2012-01-17', '中国东莞环区南街二巷204号47栋', '123456', 1);
INSERT INTO `vip_info` VALUES (746, '2013-06-11 22:29:33', '2012-07-31 11:13:38', 0, NULL, '宣惠敏', 0, 'AA-BD-6158-P', 0, '16672581460', '2016-02-25', '2023-12-28', 311.26, '2008-06-07', '中国成都市成华区双庆路591号31栋', '123456', 1);
INSERT INTO `vip_info` VALUES (747, '2014-10-14 23:48:56', '2021-06-16 07:37:56', 1, NULL, '汪德華', 0, 'DA-CA-9917-G', 0, '15541947197', '2005-12-11', '2022-11-20', 752.78, '2010-12-26', '中国广州市白云区机场路棠苑街五巷490号41栋', '123456', 1);
INSERT INTO `vip_info` VALUES (748, '2022-06-11 13:02:19', '2024-03-03 00:23:42', 1, NULL, '廖裕玲', 0, 'FC-DA-2600-L', 0, '13711706473', '2015-05-25', '2007-08-19', 509.54, '2014-02-21', '中国北京市海淀区清河中街68号395号28栋', '123456', 1);
INSERT INTO `vip_info` VALUES (749, '2010-04-29 17:46:53', '2003-02-07 17:23:15', 1, NULL, '陶震南', 1, 'BC-FA-9306-U', 0, '19315137429', '2020-05-19', '2023-07-18', 222.46, '2005-05-17', '中国北京市朝阳区三里屯路863号12楼', '123456', 1);
INSERT INTO `vip_info` VALUES (750, '2021-04-15 17:54:14', '2023-02-20 15:51:14', 0, NULL, '江家強', 1, 'ED-AB-0522-I', 0, '14441953213', '2018-05-16', '2003-05-11', 414.06, '2011-08-07', '中国东莞坑美十五巷954号华润大厦33室', '123456', 1);
INSERT INTO `vip_info` VALUES (751, '2012-12-17 17:20:24', '2000-09-01 00:15:01', 0, NULL, '叶嘉伦', 1, 'BF-CB-5706-R', 0, '16090669679', '2010-01-04', '2002-10-27', 513.79, '2004-10-20', '中国北京市東城区東直門內大街421号17室', '123456', 1);
INSERT INTO `vip_info` VALUES (752, '2007-02-19 20:46:04', '2009-04-27 21:52:44', 1, NULL, '黎安琪', 0, 'AD-FF-8296-C', 0, '19156730300', '2013-10-26', '2019-08-21', 759.48, '2016-02-19', '中国东莞坑美十五巷318号16楼', '123456', 1);
INSERT INTO `vip_info` VALUES (753, '2024-08-15 00:25:47', '2021-05-03 10:47:55', 1, NULL, '方慧琳', 0, 'EA-CC-6644-C', 0, '19895951096', '2017-04-09', '2006-02-13', 245.19, '2018-02-24', '中国成都市锦江区人民南路四段769号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (754, '2013-10-19 19:50:30', '2020-01-26 02:37:02', 0, NULL, '唐家文', 0, 'AC-BC-2390-T', 0, '17212899061', '2018-05-20', '2018-07-20', 525.11, '2013-05-31', '中国北京市东城区东单王府井东街56号30楼', '123456', 1);
INSERT INTO `vip_info` VALUES (755, '2016-02-01 21:09:23', '2002-04-04 13:46:30', 1, NULL, '谭嘉伦', 1, 'AC-DD-2218-B', 0, '13763155785', '2006-02-12', '2006-08-28', 575.05, '2001-04-10', '中国深圳福田区景田东一街393号11楼', '123456', 1);
INSERT INTO `vip_info` VALUES (756, '2023-01-20 23:06:48', '2017-01-26 05:00:20', 0, NULL, '關志明', 1, 'CC-EF-8212-N', 0, '15108589347', '2021-07-22', '2010-12-02', 118.66, '2004-06-30', '中国深圳福田区深南大道991号29楼', '123456', 1);
INSERT INTO `vip_info` VALUES (757, '2013-01-18 14:37:16', '2019-02-28 12:43:38', 1, NULL, '孙子异', 0, 'CE-AA-3087-V', 0, '13447968573', '2005-10-21', '2000-07-12', 846.84, '2021-12-14', '中国北京市西城区复兴门内大街963号43楼', '123456', 1);
INSERT INTO `vip_info` VALUES (758, '2017-02-04 22:02:39', '2001-08-16 02:17:54', 1, NULL, '于震南', 1, 'DE-BE-6506-U', 0, '15847498411', '2001-05-03', '2023-07-10', 405.10, '2001-03-25', '中国成都市成华区玉双路6号167号41栋', '123456', 1);
INSERT INTO `vip_info` VALUES (759, '2005-02-15 17:13:42', '2008-03-04 21:53:51', 1, NULL, '傅安琪', 1, 'BC-FD-0851-I', 0, '19431580520', '2013-12-10', '2005-11-09', 386.46, '2000-10-30', '中国广州市天河区天河路346号7号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (760, '2004-04-16 18:56:00', '2020-07-09 11:39:03', 1, NULL, '尹震南', 1, 'BA-EF-4251-E', 0, '16742991798', '2016-02-29', '2006-08-25', 866.48, '2004-07-07', '中国中山紫马岭商圈中山五路263号华润大厦44室', '123456', 1);
INSERT INTO `vip_info` VALUES (761, '2016-06-03 10:06:41', '2003-10-22 17:04:21', 1, NULL, '孫慧儀', 1, 'EB-FF-8531-Q', 0, '16595212078', '2000-10-02', '2004-09-20', 569.35, '2024-10-08', '中国广州市越秀区中山二路12号13号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (762, '2000-04-25 13:09:39', '2013-04-23 22:17:09', 1, NULL, '孔睿', 0, 'DD-AC-7391-Y', 0, '14296030198', '2012-04-12', '2008-12-17', 277.38, '2001-07-01', '中国深圳罗湖区田贝一路369号16室', '123456', 1);
INSERT INTO `vip_info` VALUES (763, '2013-11-15 01:23:15', '2005-06-11 01:40:18', 1, NULL, '朱安琪', 1, 'DB-EB-6112-B', 0, '17785445681', '2022-08-28', '2007-02-12', 703.27, '2022-02-28', '中国成都市成华区二仙桥东三路393号3号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (764, '2009-05-03 04:57:27', '2002-08-01 08:42:15', 1, NULL, '崔嘉欣', 0, 'BC-AE-0767-Y', 0, '13505863651', '2017-12-17', '2017-01-18', 364.08, '2003-09-29', '中国北京市延庆区028县道50号24栋', '123456', 1);
INSERT INTO `vip_info` VALUES (765, '2017-02-02 22:45:47', '2019-04-10 05:41:31', 0, NULL, '應浩然', 1, 'ED-ED-8926-J', 0, '16805679213', '2016-07-18', '2000-10-15', 586.81, '2008-06-27', '中国上海市闵行区宾川路81号15号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (766, '2009-10-19 04:40:24', '2009-07-30 18:25:01', 1, NULL, '魏睿', 0, 'ED-BB-6173-Y', 0, '14114534678', '2024-01-12', '2016-03-27', 793.35, '2017-02-26', '中国北京市西城区西長安街322号30栋', '123456', 1);
INSERT INTO `vip_info` VALUES (767, '2015-12-31 06:03:59', '2004-03-28 17:55:02', 1, NULL, '龙秀英', 1, 'AA-AC-5588-V', 0, '15610075093', '2004-01-07', '2018-10-08', 712.75, '2021-03-27', '中国中山天河区大信商圈大信南路151号19号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (768, '2025-01-08 23:30:18', '2016-09-18 12:37:02', 1, NULL, '江家文', 1, 'AF-DF-4072-P', 0, '18682390469', '2022-02-26', '2017-05-25', 970.28, '2001-03-08', '中国成都市成华区二仙桥东三路231号36室', '123456', 1);
INSERT INTO `vip_info` VALUES (769, '2000-05-25 04:39:19', '2019-10-10 23:00:58', 0, NULL, '谢杰宏', 1, 'EB-DE-0564-U', 0, '13709177149', '2013-10-07', '2024-10-12', 615.62, '2006-06-03', '中国中山紫马岭商圈中山五路644号华润大厦49室', '123456', 1);
INSERT INTO `vip_info` VALUES (770, '2009-12-03 19:55:18', '2015-03-26 21:16:22', 1, NULL, '元慧儀', 0, 'EE-EC-1637-I', 0, '13601368045', '2022-02-05', '2017-01-08', 328.20, '2014-09-17', '中国上海市徐汇区虹桥路55号24室', '123456', 1);
INSERT INTO `vip_info` VALUES (771, '2013-12-08 19:28:15', '2021-03-26 07:31:03', 1, NULL, '袁嘉伦', 0, 'ED-DE-6286-P', 0, '19657237360', '2004-01-13', '2002-09-09', 351.90, '2014-06-14', '中国中山京华商圈华夏街588号3室', '123456', 1);
INSERT INTO `vip_info` VALUES (772, '2005-10-05 18:14:30', '2000-11-20 17:58:41', 1, NULL, '傅宇宁', 0, 'ED-CD-3427-N', 0, '16917475115', '2021-01-16', '2007-07-16', 511.96, '2021-11-26', '中国北京市朝阳区三里屯路844号35室', '123456', 1);
INSERT INTO `vip_info` VALUES (773, '2016-03-24 17:15:44', '2009-07-13 04:26:52', 1, NULL, '张杰宏', 0, 'EE-CE-1181-W', 0, '14028154992', '2023-09-06', '2001-11-22', 92.19, '2001-04-12', '中国深圳罗湖区蔡屋围深南东路407号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (774, '2010-12-17 13:41:49', '2017-01-01 00:28:03', 0, NULL, '李心穎', 0, 'AD-CB-3705-Z', 0, '13196291857', '2011-08-19', '2007-12-18', 796.51, '2007-03-20', '中国深圳龙岗区布吉镇西环路13号27号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (775, '2022-09-30 11:04:07', '2016-09-25 20:46:07', 1, NULL, '溫麗欣', 1, 'FF-FC-4025-R', 0, '14967730933', '2016-04-26', '2019-09-06', 602.99, '2001-07-08', '中国上海市浦东新区橄榄路764号43号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (776, '2007-05-21 20:24:02', '2011-06-14 21:31:07', 1, NULL, '史子异', 1, 'CD-CF-7714-P', 0, '14609942914', '2024-10-06', '2024-01-04', 568.54, '2025-01-14', '中国中山天河区大信商圈大信南路503号1号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (777, '2004-07-09 03:40:02', '2013-08-09 22:10:55', 1, NULL, '薛璐', 0, 'BB-BB-7385-W', 0, '14005590427', '2008-10-02', '2011-08-11', 848.94, '2011-01-04', '中国北京市朝阳区三里屯路343号40栋', '123456', 1);
INSERT INTO `vip_info` VALUES (778, '2004-11-06 00:19:37', '2023-04-10 22:55:16', 0, NULL, '梅小慧', 0, 'BD-CE-1563-C', 0, '15773248962', '2018-12-07', '2023-11-24', 209.98, '2017-09-26', '中国上海市徐汇区虹桥路256号40栋', '123456', 1);
INSERT INTO `vip_info` VALUES (779, '2009-04-06 18:55:57', '2021-06-06 01:30:26', 1, NULL, '宣玲玲', 1, 'AD-FF-3655-D', 0, '16605529766', '2016-02-08', '2009-07-24', 290.49, '2003-04-19', '中国上海市浦东新区健祥路777号华润大厦3室', '123456', 1);
INSERT INTO `vip_info` VALUES (780, '2013-06-09 08:43:08', '2024-05-01 04:42:57', 1, NULL, '萧杰宏', 1, 'FA-DF-0187-H', 0, '14541002012', '2005-07-16', '2000-10-03', 996.79, '2006-06-03', '中国深圳福田区深南大道397号8号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (781, '2000-12-21 10:10:00', '2002-06-15 10:57:55', 1, NULL, '方詠詩', 0, 'BA-DD-2827-O', 0, '19586195967', '2015-04-30', '2010-09-20', 355.48, '2018-11-24', '中国北京市東城区東直門內大街841号13楼', '123456', 1);
INSERT INTO `vip_info` VALUES (782, '2011-08-13 17:16:58', '2001-01-24 02:46:10', 0, NULL, '林淑怡', 0, 'BD-EB-8179-E', 0, '15193670351', '2009-08-11', '2007-05-28', 301.39, '2005-09-27', '中国深圳福田区深南大道545号31楼', '123456', 1);
INSERT INTO `vip_info` VALUES (783, '2021-02-13 09:18:32', '2003-07-16 23:26:51', 0, NULL, '元俊宇', 1, 'FD-FA-9995-M', 0, '19447767128', '2023-05-21', '2006-04-21', 848.31, '2011-10-31', '中国中山乐丰六路154号44栋', '123456', 1);
INSERT INTO `vip_info` VALUES (784, '2017-12-25 12:10:33', '2024-05-15 18:11:28', 0, NULL, '尹璐', 1, 'DC-BF-2199-I', 0, '17347954052', '2019-03-24', '2021-09-10', 84.39, '2011-11-07', '中国中山紫马岭商圈中山五路763号5号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (785, '2014-06-18 01:14:49', '2011-10-10 19:10:23', 0, NULL, '邱致远', 1, 'EF-FD-6829-X', 0, '17019438819', '2004-05-08', '2022-03-23', 945.50, '2011-02-25', '中国成都市成华区玉双路6号223号7号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (786, '2022-10-02 10:26:02', '2023-01-31 09:34:30', 0, NULL, '傅杰宏', 0, 'FF-EA-3565-V', 0, '13107624636', '2002-02-28', '2005-02-20', 219.54, '2024-02-24', '中国北京市西城区复兴门内大街406号2号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (787, '2007-09-12 08:36:21', '2006-05-24 19:21:17', 0, NULL, '高發', 1, 'DA-DA-2737-X', 0, '14904956049', '2011-07-02', '2013-06-20', 93.73, '2004-07-26', '中国深圳龙岗区布吉镇西环路812号14室', '123456', 1);
INSERT INTO `vip_info` VALUES (788, '2020-12-28 08:33:16', '2023-04-04 19:53:49', 0, NULL, '邓岚', 0, 'CF-BB-5755-U', 0, '18892555528', '2021-03-23', '2020-03-25', 153.65, '2017-07-03', '中国深圳福田区深南大道434号42号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (789, '2013-09-04 13:27:35', '2014-11-14 14:34:26', 0, NULL, '苗家強', 0, 'DA-CA-0864-B', 0, '14843905069', '2013-07-19', '2016-06-20', 140.61, '2019-02-08', '中国东莞东泰五街335号25栋', '123456', 1);
INSERT INTO `vip_info` VALUES (790, '2010-08-31 03:59:33', '2007-07-17 16:32:45', 0, NULL, '阮頴璇', 1, 'AF-DE-6330-F', 0, '15248148348', '2018-07-26', '2001-10-03', 560.27, '2024-12-27', '中国广州市海珠区江南西路595号31室', '123456', 1);
INSERT INTO `vip_info` VALUES (791, '2016-03-30 23:36:18', '2020-10-19 02:48:34', 0, NULL, '侯致远', 0, 'FC-BA-2746-N', 0, '19516908052', '2005-08-22', '2004-12-03', 75.79, '2010-06-19', '中国北京市西城区复兴门内大街952号2号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (792, '2016-03-26 09:25:44', '2016-12-26 10:14:26', 0, NULL, '邱宇宁', 1, 'AC-CD-6800-X', 0, '13143744636', '2016-02-15', '2020-12-19', 445.08, '2007-05-31', '中国深圳福田区景田东一街301号35栋', '123456', 1);
INSERT INTO `vip_info` VALUES (793, '2003-07-26 15:07:27', '2017-10-20 18:55:12', 1, NULL, '周慧儀', 0, 'BE-EF-4549-C', 0, '19039833391', '2012-03-11', '2011-07-14', 729.24, '2009-06-04', '中国东莞坑美十五巷342号24室', '123456', 1);
INSERT INTO `vip_info` VALUES (794, '2025-05-10 10:03:53', '2003-02-21 00:43:59', 1, NULL, '马宇宁', 0, 'EC-CB-1133-A', 0, '19935831125', '2003-12-17', '2010-04-22', 454.16, '2006-11-11', '中国上海市闵行区宾川路316号43栋', '123456', 1);
INSERT INTO `vip_info` VALUES (795, '2000-10-06 13:05:36', '2022-07-28 11:26:02', 1, NULL, '呂發', 0, 'ED-DA-7031-W', 0, '15322944355', '2025-01-08', '2011-05-25', 698.21, '2007-10-16', '中国北京市东城区东单王府井东街420号20楼', '123456', 1);
INSERT INTO `vip_info` VALUES (796, '2019-06-11 15:28:57', '2012-12-13 05:48:06', 1, NULL, '贾詩涵', 0, 'BA-BC-7426-L', 0, '13515866943', '2016-01-09', '2023-11-12', 269.11, '2015-08-14', '中国上海市浦东新区橄榄路42号10号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (797, '2011-02-04 12:04:41', '2013-04-03 09:01:59', 0, NULL, '向杰宏', 1, 'AE-DB-8369-Z', 0, '17438616391', '2022-03-04', '2021-12-08', 490.93, '2003-08-13', '中国深圳罗湖区清水河一路92号华润大厦11室', '123456', 1);
INSERT INTO `vip_info` VALUES (798, '2016-04-11 04:48:47', '2023-08-25 14:26:46', 1, NULL, '唐杰宏', 0, 'FB-BA-6943-V', 0, '15146949513', '2011-10-02', '2012-11-24', 352.40, '2014-04-04', '中国东莞环区南街二巷247号5栋', '123456', 1);
INSERT INTO `vip_info` VALUES (799, '2010-03-16 00:55:09', '2017-12-26 19:03:38', 1, NULL, '翁仲賢', 1, 'EF-EA-0651-A', 0, '18407925933', '2019-07-12', '2002-02-17', 768.30, '2024-08-02', '中国东莞东泰五街311号44室', '123456', 1);
INSERT INTO `vip_info` VALUES (800, '2009-05-14 04:06:45', '2023-02-18 21:46:14', 0, NULL, '翁慧琳', 1, 'FE-ED-8672-F', 0, '18373362519', '2024-04-21', '2019-07-08', 831.58, '2011-03-28', '中国广州市白云区机场路棠苑街五巷914号华润大厦36室', '123456', 1);
INSERT INTO `vip_info` VALUES (801, '2012-09-23 23:29:47', '2016-07-28 07:30:14', 0, NULL, '秦宇宁', 0, 'FB-EC-1709-N', 0, '16918520128', '2016-03-14', '2022-01-07', 63.72, '2007-09-21', '中国中山乐丰六路298号23室', '123456', 1);
INSERT INTO `vip_info` VALUES (802, '2009-09-19 06:37:52', '2000-01-12 07:09:23', 1, NULL, '邓璐', 0, 'CE-FE-4484-Q', 0, '17474127009', '2016-10-29', '2015-05-12', 987.33, '2000-07-04', '中国上海市黄浦区淮海中路438号5室', '123456', 1);
INSERT INTO `vip_info` VALUES (803, '2018-03-01 02:20:40', '2020-04-12 20:22:56', 0, NULL, '马秀英', 1, 'FD-BE-6361-Q', 0, '17815220847', '2017-05-07', '2016-10-31', 697.18, '2021-05-19', '中国成都市成华区二仙桥东三路996号50楼', '123456', 1);
INSERT INTO `vip_info` VALUES (804, '2007-06-17 00:53:37', '2003-01-02 05:16:25', 0, NULL, '官慧珊', 1, 'ED-ED-2851-O', 0, '19449593176', '2007-08-28', '2008-12-16', 34.46, '2007-12-30', '中国深圳罗湖区蔡屋围深南东路4号15室', '123456', 1);
INSERT INTO `vip_info` VALUES (805, '2023-12-14 04:17:34', '2016-01-06 14:24:43', 0, NULL, '王安琪', 1, 'AD-AC-2626-P', 0, '17640461484', '2003-01-22', '2010-06-29', 587.32, '2007-11-20', '中国广州市白云区机场路棠苑街五巷602号46号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (806, '2012-08-13 20:37:22', '2001-09-30 02:53:01', 0, NULL, '邵國榮', 1, 'AA-CB-8960-O', 0, '15619743813', '2005-01-14', '2003-12-20', 814.46, '2019-05-24', '中国成都市锦江区人民南路四段193号华润大厦44室', '123456', 1);
INSERT INTO `vip_info` VALUES (807, '2004-09-09 04:28:48', '2016-05-06 11:12:09', 0, NULL, '呂曉彤', 1, 'BE-AA-3403-Y', 0, '19647914854', '2009-12-14', '2019-05-09', 827.02, '2017-08-31', '中国深圳罗湖区田贝一路280号14号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (808, '2008-10-15 13:19:34', '2020-10-18 00:22:29', 1, NULL, '區浩然', 0, 'ED-CE-4924-O', 0, '19624815381', '2006-09-09', '2008-01-21', 787.77, '2015-10-30', '中国上海市浦东新区橄榄路71号21栋', '123456', 1);
INSERT INTO `vip_info` VALUES (809, '2022-03-23 04:54:42', '2016-02-02 02:36:53', 1, NULL, '袁睿', 0, 'AE-BB-3954-U', 0, '18894597605', '2021-11-16', '2000-09-12', 275.89, '2020-07-09', '中国中山天河区大信商圈大信南路781号47栋', '123456', 1);
INSERT INTO `vip_info` VALUES (810, '2014-03-24 09:41:47', '2023-12-21 15:18:47', 1, NULL, '谢詩涵', 1, 'DD-CF-2426-W', 0, '18845210149', '2004-08-01', '2021-07-10', 809.40, '2024-01-29', '中国深圳罗湖区田贝一路751号20楼', '123456', 1);
INSERT INTO `vip_info` VALUES (811, '2023-12-13 09:52:45', '2014-07-15 00:46:20', 0, NULL, '顾嘉伦', 1, 'EE-AE-2377-Q', 0, '16340022465', '2018-07-29', '2023-04-14', 348.58, '2019-12-21', '中国深圳龙岗区学园一巷978号华润大厦45室', '123456', 1);
INSERT INTO `vip_info` VALUES (812, '2016-06-15 07:37:48', '2024-10-27 04:08:36', 0, NULL, '伍玲玲', 0, 'DD-BE-3399-E', 0, '13172822569', '2009-03-17', '2015-12-19', 39.63, '2017-11-14', '中国东莞坑美十五巷289号43栋', '123456', 1);
INSERT INTO `vip_info` VALUES (813, '2014-10-11 14:00:47', '2006-11-04 10:22:53', 1, NULL, '常璐', 0, 'CE-AD-8830-I', 0, '14032002661', '2000-12-25', '2019-04-03', 48.26, '2008-07-22', '中国北京市房山区岳琉路111号18楼', '123456', 1);
INSERT INTO `vip_info` VALUES (814, '2010-03-01 17:16:24', '2009-07-05 08:41:52', 1, NULL, '钟岚', 1, 'CD-EC-5796-H', 0, '17365562010', '2006-08-14', '2006-06-08', 483.80, '2020-05-18', '中国北京市海淀区清河中街68号982号48室', '123456', 1);
INSERT INTO `vip_info` VALUES (815, '2020-11-06 08:22:39', '2022-12-22 23:37:10', 0, NULL, '方子异', 0, 'DD-CF-3546-N', 0, '15266425869', '2017-04-03', '2023-01-11', 445.53, '2022-01-02', '中国上海市徐汇区虹桥路321号9号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (816, '2018-09-27 20:10:01', '2011-04-03 06:56:23', 1, NULL, '翁家玲', 1, 'EC-EC-2067-O', 0, '14731380375', '2014-11-29', '2016-05-11', 553.49, '2013-10-12', '中国深圳罗湖区清水河一路473号14楼', '123456', 1);
INSERT INTO `vip_info` VALUES (817, '2022-02-09 20:25:27', '2008-06-20 16:13:06', 1, NULL, '戚家強', 1, 'BA-EF-8025-M', 0, '17611197868', '2024-08-08', '2009-02-12', 482.29, '2001-10-13', '中国上海市闵行区宾川路565号华润大厦42室', '123456', 1);
INSERT INTO `vip_info` VALUES (818, '2002-09-05 23:42:16', '2009-01-15 15:11:07', 1, NULL, '薛淑怡', 1, 'FE-AC-1295-K', 0, '14535753179', '2002-11-07', '2006-02-22', 501.51, '2003-12-11', '中国中山天河区大信商圈大信南路284号华润大厦45室', '123456', 1);
INSERT INTO `vip_info` VALUES (819, '2018-09-18 00:51:14', '2018-08-22 22:23:20', 1, NULL, '刘璐', 1, 'AB-DA-5619-I', 0, '15203812832', '2025-05-30', '2014-12-16', 621.94, '2008-02-24', '中国北京市延庆区028县道271号华润大厦50室', '123456', 1);
INSERT INTO `vip_info` VALUES (820, '2017-08-16 16:15:42', '2025-04-14 20:00:23', 0, NULL, '廖明', 0, 'AB-DB-2624-F', 0, '18776435500', '2017-09-07', '2015-01-19', 314.96, '2003-09-06', '中国深圳福田区深南大道740号19栋', '123456', 1);
INSERT INTO `vip_info` VALUES (821, '2018-07-03 01:46:39', '2024-05-14 07:47:53', 1, NULL, '宣德華', 0, 'EF-DF-8506-W', 0, '13349044563', '2017-12-26', '2011-04-25', 418.84, '2018-02-10', '中国深圳罗湖区清水河一路898号31室', '123456', 1);
INSERT INTO `vip_info` VALUES (822, '2015-01-07 20:46:40', '2000-01-01 13:34:15', 1, NULL, '萧震南', 0, 'EB-CA-4708-R', 0, '15502330228', '2012-05-03', '2008-08-29', 321.48, '2001-05-22', '中国深圳福田区景田东一街693号43栋', '123456', 1);
INSERT INTO `vip_info` VALUES (823, '2023-02-05 23:56:10', '2011-09-24 19:05:31', 0, NULL, '羅志明', 0, 'DB-EC-9858-U', 0, '15064897765', '2005-01-24', '2019-12-09', 43.39, '2007-09-12', '中国上海市浦东新区橄榄路575号31号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (824, '2015-11-08 04:05:12', '2001-11-04 06:36:31', 1, NULL, '胡慧嫻', 1, 'DA-BC-4794-J', 0, '14476976530', '2016-02-03', '2012-06-04', 315.99, '2017-12-12', '中国成都市成华区二仙桥东三路567号华润大厦45室', '123456', 1);
INSERT INTO `vip_info` VALUES (825, '2013-02-08 17:36:47', '2012-04-02 15:22:26', 0, NULL, '梅思妤', 1, 'CA-FC-5787-P', 0, '19661288343', '2007-08-08', '2011-08-07', 682.86, '2015-10-28', '中国中山京华商圈华夏街396号6号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (826, '2012-12-17 15:50:41', '2014-05-28 06:36:54', 0, NULL, '唐安琪', 0, 'BB-AB-3434-B', 0, '14597791904', '2001-02-04', '2016-04-26', 740.83, '2012-04-03', '中国深圳福田区深南大道768号46栋', '123456', 1);
INSERT INTO `vip_info` VALUES (827, '2014-02-06 16:04:21', '2001-08-28 05:35:58', 0, NULL, '黎玲玲', 1, 'EA-CB-6254-B', 0, '18956370194', '2008-11-30', '2019-10-27', 632.50, '2014-06-27', '中国深圳福田区景田东一街884号1室', '123456', 1);
INSERT INTO `vip_info` VALUES (828, '2015-09-19 02:49:48', '2012-08-20 01:41:46', 1, NULL, '樊慧琳', 1, 'EA-EA-6525-K', 0, '14318470571', '2024-07-14', '2007-09-23', 261.38, '2014-07-01', '中国上海市黄浦区淮海中路502号华润大厦23室', '123456', 1);
INSERT INTO `vip_info` VALUES (829, '2014-02-12 13:49:19', '2013-07-01 18:36:42', 1, NULL, '常子韬', 1, 'BE-AA-4365-R', 0, '18758028850', '2007-02-17', '2019-04-17', 465.24, '2010-04-13', '中国中山紫马岭商圈中山五路525号华润大厦22室', '123456', 1);
INSERT INTO `vip_info` VALUES (830, '2018-10-09 04:19:19', '2013-11-29 07:46:01', 1, NULL, '唐子异', 1, 'FA-CE-2030-Z', 0, '13886433060', '2010-02-04', '2001-10-21', 172.41, '2005-03-14', '中国东莞东泰五街724号33室', '123456', 1);
INSERT INTO `vip_info` VALUES (831, '2008-07-24 00:27:59', '2000-03-16 13:27:10', 1, NULL, '贾嘉伦', 0, 'FD-DD-5001-D', 0, '14724820279', '2022-01-31', '2016-11-09', 69.84, '2011-01-26', '中国深圳龙岗区布吉镇西环路53号13楼', '123456', 1);
INSERT INTO `vip_info` VALUES (832, '2016-09-07 05:01:12', '2001-11-30 13:20:58', 1, NULL, '唐宇宁', 1, 'AB-BC-9665-C', 0, '16562319362', '2008-05-21', '2012-02-09', 806.93, '2021-04-21', '中国上海市浦东新区橄榄路84号华润大厦45室', '123456', 1);
INSERT INTO `vip_info` VALUES (833, '2015-08-16 04:45:36', '2020-08-09 16:46:35', 1, NULL, '餘俊宇', 1, 'EA-ED-6332-C', 0, '19273357647', '2000-09-03', '2009-07-26', 168.31, '2023-07-22', '中国中山京华商圈华夏街3号41楼', '123456', 1);
INSERT INTO `vip_info` VALUES (834, '2017-05-04 13:44:41', '2014-07-12 20:51:21', 0, NULL, '許世榮', 0, 'CD-EE-1061-N', 0, '13830411824', '2015-12-14', '2009-09-29', 650.76, '2000-10-22', '中国成都市成华区双庆路305号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (835, '2002-06-26 03:36:59', '2023-03-21 19:02:18', 1, NULL, '蔡睿', 1, 'FC-DD-6381-A', 0, '18767612270', '2004-10-01', '2009-04-14', 393.26, '2011-11-24', '中国广州市越秀区中山二路796号3号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (836, '2008-08-14 14:42:35', '2021-06-25 01:26:44', 1, NULL, '余睿', 0, 'EE-AC-5409-M', 0, '19751077344', '2016-08-20', '2013-12-03', 142.45, '2014-04-17', '中国上海市闵行区宾川路872号29号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (837, '2006-11-05 17:00:58', '2015-09-12 16:57:39', 0, NULL, '陆安琪', 0, 'DC-FB-4954-C', 0, '17765960080', '2015-04-12', '2003-09-07', 166.95, '2008-10-23', '中国深圳龙岗区布吉镇西环路354号8栋', '123456', 1);
INSERT INTO `vip_info` VALUES (838, '2013-06-13 17:22:43', '2018-08-02 05:11:20', 0, NULL, '姚國明', 0, 'DB-DE-4273-C', 0, '15130613653', '2015-08-28', '2015-02-18', 295.68, '2002-07-21', '中国上海市徐汇区虹桥路104号11楼', '123456', 1);
INSERT INTO `vip_info` VALUES (839, '2012-09-20 12:50:29', '2005-04-08 01:09:23', 1, NULL, '武璐', 1, 'DA-FE-3627-Q', 0, '18826415648', '2017-07-20', '2024-10-05', 424.43, '2024-10-22', '中国北京市朝阳区三里屯路942号华润大厦29室', '123456', 1);
INSERT INTO `vip_info` VALUES (840, '2014-03-26 15:14:22', '2018-08-10 04:17:30', 0, NULL, '黎云熙', 1, 'CE-FD-6763-M', 0, '14607206275', '2001-04-24', '2012-10-26', 479.75, '2009-01-15', '中国深圳龙岗区布吉镇西环路720号42号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (841, '2016-12-09 09:41:49', '2009-05-25 02:29:14', 1, NULL, '郭宇宁', 1, 'CB-AF-1825-X', 0, '16423159920', '2017-03-27', '2007-02-07', 611.98, '2013-11-25', '中国广州市海珠区江南西路872号37号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (842, '2010-03-23 08:58:18', '2010-06-27 21:34:16', 0, NULL, '高震南', 0, 'EB-AB-6533-D', 0, '19398876473', '2023-10-10', '2015-06-17', 671.95, '2022-09-13', '中国北京市房山区岳琉路642号8栋', '123456', 1);
INSERT INTO `vip_info` VALUES (843, '2012-06-19 19:05:47', '2008-12-25 23:34:17', 1, NULL, '樂杰倫', 0, 'ED-FA-7766-R', 0, '18313825266', '2025-05-12', '2011-04-21', 363.02, '2009-09-13', '中国广州市白云区小坪东路794号华润大厦47室', '123456', 1);
INSERT INTO `vip_info` VALUES (844, '2017-08-19 13:04:31', '2003-06-29 00:15:02', 1, NULL, '毛慧珊', 0, 'CD-CE-0237-V', 0, '19680882868', '2024-08-01', '2007-04-14', 143.16, '2006-03-07', '中国中山京华商圈华夏街425号10号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (845, '2017-10-02 02:36:00', '2023-12-16 22:18:39', 1, NULL, '阎宇宁', 0, 'AC-AB-8140-M', 0, '13520907429', '2019-01-20', '2013-11-07', 539.83, '2006-10-06', '中国上海市闵行区宾川路686号29楼', '123456', 1);
INSERT INTO `vip_info` VALUES (846, '2018-10-19 07:18:15', '2024-06-25 10:44:23', 0, NULL, '黎世榮', 1, 'CE-CF-2489-T', 0, '14577964865', '2009-04-24', '2019-03-07', 556.46, '2010-09-18', '中国北京市西城区复兴门内大街427号38号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (847, '2004-06-27 00:47:57', '2000-03-15 09:37:14', 1, NULL, '李睿', 1, 'DD-FB-6945-P', 0, '18129063943', '2001-02-26', '2012-09-30', 17.81, '2016-01-21', '中国广州市越秀区中山二路692号7楼', '123456', 1);
INSERT INTO `vip_info` VALUES (848, '2019-07-05 16:23:09', '2005-07-07 18:14:10', 0, NULL, '范晓明', 0, 'AB-FE-0033-W', 0, '15183349275', '2005-01-08', '2012-01-29', 771.42, '2015-03-08', '中国北京市海淀区清河中街68号193号华润大厦45室', '123456', 1);
INSERT INTO `vip_info` VALUES (849, '2017-08-14 23:28:02', '2023-09-03 06:14:26', 0, NULL, '邵永發', 1, 'BD-CF-0241-E', 0, '15173462028', '2016-05-20', '2017-02-04', 558.88, '2016-08-25', '中国北京市朝阳区三里屯路704号15栋', '123456', 1);
INSERT INTO `vip_info` VALUES (850, '2010-08-30 16:43:20', '2016-06-16 03:01:28', 1, NULL, '黎詩涵', 1, 'CC-EA-2746-G', 0, '18576412494', '2020-01-29', '2007-10-11', 414.68, '2013-05-16', '中国北京市海淀区清河中街68号791号34室', '123456', 1);
INSERT INTO `vip_info` VALUES (851, '2016-10-14 18:03:59', '2006-12-10 01:27:03', 0, NULL, '彭子异', 0, 'FD-EF-2426-E', 0, '17515593588', '2019-06-26', '2000-06-15', 390.10, '2024-02-25', '中国北京市东城区东单王府井东街367号11楼', '123456', 1);
INSERT INTO `vip_info` VALUES (852, '2012-02-16 00:46:57', '2020-09-23 07:58:27', 1, NULL, '陶子异', 0, 'FE-AE-5074-C', 0, '13490365575', '2003-09-21', '2005-08-09', 259.50, '2023-08-13', '中国中山京华商圈华夏街548号华润大厦49室', '123456', 1);
INSERT INTO `vip_info` VALUES (853, '2002-12-05 02:59:22', '2003-01-21 04:42:02', 1, NULL, '許曉彤', 1, 'DF-AC-8981-Q', 0, '18347628129', '2002-04-12', '2007-11-17', 7.18, '2007-10-15', '中国上海市浦东新区健祥路142号40室', '123456', 1);
INSERT INTO `vip_info` VALUES (854, '2000-04-21 12:57:37', '2016-12-08 08:08:10', 0, NULL, '田惠妹', 1, 'ED-CE-5524-G', 0, '19216161473', '2022-11-10', '2004-09-08', 253.82, '2002-04-20', '中国上海市浦东新区橄榄路232号17室', '123456', 1);
INSERT INTO `vip_info` VALUES (855, '2022-03-13 02:24:09', '2008-12-14 10:28:46', 1, NULL, '古慧琳', 0, 'DA-BF-9238-S', 0, '17441438882', '2009-04-10', '2017-12-27', 831.99, '2016-05-21', '中国东莞环区南街二巷689号华润大厦39室', '123456', 1);
INSERT INTO `vip_info` VALUES (856, '2024-05-13 15:08:35', '2022-02-17 17:44:53', 0, NULL, '高云熙', 0, 'FA-CE-4212-U', 0, '17945557195', '2013-04-27', '2004-08-29', 541.50, '2004-01-31', '中国深圳罗湖区蔡屋围深南东路884号32楼', '123456', 1);
INSERT INTO `vip_info` VALUES (857, '2009-08-22 02:41:20', '2017-10-07 09:36:39', 1, NULL, '吕秀英', 0, 'EE-DC-5930-B', 0, '18834272155', '2012-04-15', '2020-01-25', 337.00, '2001-03-22', '中国广州市越秀区中山二路367号30栋', '123456', 1);
INSERT INTO `vip_info` VALUES (858, '2022-07-04 21:54:38', '2015-05-02 10:16:16', 1, NULL, '李天榮', 1, 'FA-FD-0858-J', 0, '19366105296', '2000-02-08', '2023-10-08', 429.01, '2007-01-05', '中国北京市西城区复兴门内大街375号20栋', '123456', 1);
INSERT INTO `vip_info` VALUES (859, '2001-03-01 12:41:06', '2019-03-04 16:00:24', 0, NULL, '汤嘉伦', 0, 'FF-EA-1417-E', 0, '18411742818', '2013-05-25', '2006-02-28', 459.61, '2024-02-26', '中国深圳龙岗区学园一巷962号39楼', '123456', 1);
INSERT INTO `vip_info` VALUES (860, '2007-02-07 03:27:15', '2013-04-13 04:59:20', 1, NULL, '廖志明', 0, 'FF-CA-0507-H', 0, '17462150413', '2009-07-28', '2020-10-24', 927.23, '2005-03-17', '中国广州市白云区小坪东路340号13楼', '123456', 1);
INSERT INTO `vip_info` VALUES (861, '2022-12-05 18:20:00', '2002-12-16 17:04:52', 0, NULL, '陶德華', 0, 'AF-CF-2281-L', 0, '17834698566', '2024-11-28', '2022-12-16', 449.63, '2004-01-05', '中国北京市延庆区028县道409号42室', '123456', 1);
INSERT INTO `vip_info` VALUES (862, '2018-03-15 02:13:34', '2019-06-14 03:18:23', 1, NULL, '唐秀英', 1, 'FF-BA-7140-T', 0, '18346541373', '2008-12-03', '2018-10-09', 577.46, '2016-05-28', '中国广州市白云区机场路棠苑街五巷779号38室', '123456', 1);
INSERT INTO `vip_info` VALUES (863, '2016-09-18 05:18:18', '2010-10-06 23:46:38', 0, NULL, '古杰倫', 1, 'CB-DC-5530-X', 0, '18579107913', '2006-06-01', '2004-04-04', 157.63, '2000-02-12', '中国深圳龙岗区学园一巷641号42楼', '123456', 1);
INSERT INTO `vip_info` VALUES (864, '2008-03-08 07:58:47', '2013-11-14 06:47:27', 1, NULL, '韓杰倫', 1, 'BE-BD-9112-N', 0, '17607548830', '2018-10-04', '2009-01-27', 225.55, '2004-09-18', '中国中山紫马岭商圈中山五路868号华润大厦47室', '123456', 1);
INSERT INTO `vip_info` VALUES (865, '2005-03-15 15:55:10', '2002-11-07 08:03:00', 0, NULL, '宋安琪', 0, 'EC-DC-2767-Q', 0, '14748866738', '2010-08-31', '2023-05-03', 436.38, '2022-06-13', '中国深圳罗湖区清水河一路791号45楼', '123456', 1);
INSERT INTO `vip_info` VALUES (866, '2023-11-28 12:40:33', '2009-08-06 14:09:14', 1, NULL, '邱潤發', 1, 'BB-DE-4307-H', 0, '13618935795', '2020-10-04', '2021-04-10', 553.35, '2021-02-24', '中国东莞坑美十五巷621号1楼', '123456', 1);
INSERT INTO `vip_info` VALUES (867, '2008-10-12 11:54:44', '2021-07-07 09:15:18', 1, NULL, '汪詩君', 0, 'BB-DD-6943-F', 0, '17903597080', '2024-10-31', '2024-12-14', 2.13, '2018-09-08', '中国东莞环区南街二巷528号45楼', '123456', 1);
INSERT INTO `vip_info` VALUES (868, '2013-05-03 15:00:02', '2020-12-01 18:46:44', 1, NULL, '莫致远', 1, 'BD-DB-4871-M', 0, '15089424175', '2002-02-28', '2002-01-21', 704.88, '2004-01-23', '中国广州市白云区小坪东路125号12楼', '123456', 1);
INSERT INTO `vip_info` VALUES (869, '2008-11-13 21:01:57', '2001-09-09 13:03:00', 1, NULL, '傅嘉伦', 0, 'AE-FF-2873-I', 0, '18816117850', '2018-07-11', '2007-08-17', 714.35, '2009-08-16', '中国成都市锦江区人民南路四段938号37楼', '123456', 1);
INSERT INTO `vip_info` VALUES (870, '2014-12-05 10:47:46', '2021-04-17 09:13:57', 0, NULL, '杨睿', 0, 'ED-FF-2334-Z', 0, '19229513146', '2011-05-03', '2006-11-18', 570.57, '2013-10-13', '中国广州市越秀区中山二路763号29室', '123456', 1);
INSERT INTO `vip_info` VALUES (871, '2024-09-20 17:21:52', '2007-09-25 22:52:53', 0, NULL, '林家文', 0, 'AC-DB-8773-M', 0, '15881917018', '2015-12-26', '2006-01-30', 175.57, '2003-05-10', '中国成都市成华区双庆路802号47栋', '123456', 1);
INSERT INTO `vip_info` VALUES (872, '2000-06-04 03:56:48', '2025-06-08 10:58:31', 1, NULL, '龚杰宏', 0, 'BE-CD-4787-R', 0, '18620856227', '2018-05-10', '2015-06-09', 824.37, '2022-06-06', '中国上海市浦东新区健祥路613号1号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (873, '2020-11-01 19:28:11', '2003-09-19 21:20:34', 1, NULL, '杨璐', 1, 'EE-BE-3607-R', 0, '19182160879', '2017-10-28', '2003-09-30', 176.48, '2014-01-12', '中国深圳福田区深南大道643号37室', '123456', 1);
INSERT INTO `vip_info` VALUES (874, '2001-12-09 12:42:48', '2013-08-05 20:06:26', 1, NULL, '苑惠敏', 0, 'BA-ED-3569-V', 0, '14709619413', '2005-07-11', '2005-04-19', 483.03, '2017-04-29', '中国中山天河区大信商圈大信南路842号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (875, '2005-03-03 22:01:30', '2005-04-16 05:40:18', 1, NULL, '钟岚', 0, 'BD-FA-2806-J', 0, '13163686847', '2009-07-25', '2013-03-23', 299.23, '2010-10-27', '中国深圳罗湖区清水河一路576号37室', '123456', 1);
INSERT INTO `vip_info` VALUES (876, '2016-10-16 19:47:27', '2019-09-23 07:27:05', 0, NULL, '戴致远', 1, 'DE-FD-5338-P', 0, '18457503162', '2004-03-28', '2024-01-03', 528.41, '2000-06-17', '中国东莞环区南街二巷293号5栋', '123456', 1);
INSERT INTO `vip_info` VALUES (877, '2015-08-24 15:11:44', '2005-04-16 12:01:43', 0, NULL, '萧宇宁', 0, 'FC-EF-7045-S', 0, '19248476482', '2011-01-16', '2001-02-07', 779.27, '2001-03-02', '中国成都市成华区二仙桥东三路83号46栋', '123456', 1);
INSERT INTO `vip_info` VALUES (878, '2016-03-15 23:38:46', '2006-01-22 13:12:42', 0, NULL, '梁志遠', 0, 'EE-FD-7914-L', 0, '13277757007', '2011-10-27', '2006-11-29', 811.75, '2019-06-09', '中国中山乐丰六路231号7号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (879, '2023-06-26 21:00:01', '2006-11-24 03:00:37', 0, NULL, '溫玲玲', 1, 'AF-CC-3944-U', 0, '17470160408', '2015-03-15', '2004-06-03', 940.88, '2010-02-02', '中国深圳龙岗区布吉镇西环路148号29室', '123456', 1);
INSERT INTO `vip_info` VALUES (880, '2019-03-03 02:13:39', '2018-05-01 13:43:21', 1, NULL, '阎震南', 1, 'BC-EF-9938-F', 0, '13889151529', '2021-03-11', '2001-04-10', 884.95, '2000-01-21', '中国深圳福田区深南大道543号6楼', '123456', 1);
INSERT INTO `vip_info` VALUES (881, '2011-09-02 14:01:08', '2016-01-11 17:45:51', 0, NULL, '谢子异', 1, 'BB-FF-2813-D', 0, '13728614740', '2013-01-22', '2023-12-17', 99.02, '2024-10-28', '中国深圳罗湖区清水河一路370号21室', '123456', 1);
INSERT INTO `vip_info` VALUES (882, '2016-07-15 21:12:15', '2023-05-10 20:12:56', 0, NULL, '孫志明', 1, 'AB-DE-8917-N', 0, '15091091058', '2002-04-11', '2003-01-17', 184.69, '2010-09-05', '中国成都市锦江区红星路三段239号23栋', '123456', 1);
INSERT INTO `vip_info` VALUES (883, '2017-08-10 04:30:42', '2021-01-17 19:41:26', 1, NULL, '劉霆鋒', 0, 'AD-CE-3715-W', 0, '19070487984', '2008-06-04', '2004-07-21', 54.17, '2009-07-09', '中国深圳福田区深南大道669号华润大厦20室', '123456', 1);
INSERT INTO `vip_info` VALUES (884, '2005-07-01 13:57:21', '2009-11-01 05:02:33', 0, NULL, '樊慧儀', 1, 'CA-DC-0956-U', 0, '18538423561', '2012-10-13', '2019-10-16', 788.62, '2015-07-11', '中国上海市闵行区宾川路886号22栋', '123456', 1);
INSERT INTO `vip_info` VALUES (885, '2019-11-02 13:05:13', '2008-07-02 11:59:07', 1, NULL, '龚嘉伦', 0, 'CC-EF-0105-M', 0, '17716616161', '2014-12-05', '2006-08-22', 602.72, '2013-07-01', '中国北京市房山区岳琉路478号27栋', '123456', 1);
INSERT INTO `vip_info` VALUES (886, '2002-06-21 05:02:19', '2024-01-31 06:44:21', 1, NULL, '钱杰宏', 0, 'EE-FA-2176-X', 0, '14195032715', '2002-11-11', '2014-02-22', 353.33, '2016-02-14', '中国东莞环区南街二巷723号4号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (887, '2019-09-19 01:16:08', '2025-01-06 20:17:26', 0, NULL, '尹璐', 0, 'FD-FE-8386-D', 0, '18052229183', '2021-09-15', '2002-06-15', 473.87, '2003-10-13', '中国深圳龙岗区布吉镇西环路291号15栋', '123456', 1);
INSERT INTO `vip_info` VALUES (888, '2018-10-08 05:50:43', '2015-11-24 13:51:46', 1, NULL, '譚曉彤', 0, 'BC-DA-8456-S', 0, '17922022668', '2001-04-23', '2015-06-24', 759.25, '2004-07-30', '中国深圳龙岗区学园一巷447号华润大厦1室', '123456', 1);
INSERT INTO `vip_info` VALUES (889, '2009-02-23 07:05:55', '2015-04-15 14:47:53', 1, NULL, '韦子异', 1, 'FF-DD-5297-L', 0, '19833915740', '2024-05-14', '2013-09-06', 509.42, '2008-11-07', '中国上海市闵行区宾川路440号华润大厦37室', '123456', 1);
INSERT INTO `vip_info` VALUES (890, '2017-04-15 10:04:02', '2022-09-20 20:53:02', 0, NULL, '汪睿', 1, 'FA-BF-1318-S', 0, '13325598759', '2004-10-04', '2014-10-24', 53.40, '2007-02-14', '中国广州市越秀区中山二路611号华润大厦15室', '123456', 1);
INSERT INTO `vip_info` VALUES (891, '2021-08-23 10:26:56', '2017-11-14 16:06:11', 0, NULL, '朱致远', 1, 'AD-FB-4269-G', 0, '17775480306', '2001-08-09', '2013-02-12', 895.48, '2000-06-24', '中国北京市东城区东单王府井东街958号8栋', '123456', 1);
INSERT INTO `vip_info` VALUES (892, '2014-01-22 11:45:47', '2018-06-18 01:07:54', 0, NULL, '容國榮', 0, 'FB-EE-3542-O', 0, '15549057750', '2020-09-12', '2016-01-13', 225.37, '2014-05-25', '中国北京市房山区岳琉路685号10号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (893, '2015-09-18 21:17:54', '2024-03-25 14:46:14', 1, NULL, '徐晓明', 0, 'AE-BF-8987-M', 0, '16121182310', '2004-02-29', '2014-12-23', 376.29, '2022-04-25', '中国广州市天河区天河路347号40室', '123456', 1);
INSERT INTO `vip_info` VALUES (894, '2016-01-31 23:54:58', '2010-06-30 23:57:20', 1, NULL, '唐宇宁', 0, 'BB-CF-1444-Z', 0, '14224890558', '2007-02-22', '2002-05-04', 956.12, '2017-10-26', '中国东莞坑美十五巷531号华润大厦24室', '123456', 1);
INSERT INTO `vip_info` VALUES (895, '2021-06-04 10:50:15', '2011-12-16 11:02:53', 1, NULL, '顧國權', 0, 'AB-DA-1810-D', 0, '16723466827', '2007-01-12', '2011-02-07', 629.80, '2001-06-23', '中国北京市海淀区清河中街68号40号20号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (896, '2024-05-23 16:04:15', '2013-02-26 11:40:05', 0, NULL, '韩嘉伦', 1, 'EF-FC-3558-X', 0, '19233298916', '2022-09-27', '2000-05-20', 282.42, '2014-12-25', '中国深圳罗湖区清水河一路764号华润大厦6室', '123456', 1);
INSERT INTO `vip_info` VALUES (897, '2013-11-16 04:04:37', '2004-04-30 01:16:57', 1, NULL, '何璐', 1, 'BC-EE-5302-N', 0, '14080573966', '2004-09-16', '2018-03-07', 921.21, '2006-12-26', '中国中山紫马岭商圈中山五路507号14室', '123456', 1);
INSERT INTO `vip_info` VALUES (898, '2020-11-11 04:20:46', '2021-07-06 09:24:29', 1, NULL, '羅永發', 0, 'CB-CE-5602-L', 0, '16663800076', '2009-08-18', '2011-04-20', 427.94, '2003-11-08', '中国北京市延庆区028县道2号39室', '123456', 1);
INSERT INTO `vip_info` VALUES (899, '2009-06-19 04:50:19', '2008-02-06 02:21:41', 0, NULL, '陆秀英', 1, 'FF-AB-9984-S', 0, '15507195554', '2017-04-29', '2004-03-01', 199.45, '2016-06-15', '中国深圳龙岗区布吉镇西环路898号35栋', '123456', 1);
INSERT INTO `vip_info` VALUES (900, '2005-08-08 21:20:04', '2018-11-20 05:07:37', 1, NULL, '翁慧琳', 1, 'AB-CF-1612-T', 0, '19442847536', '2023-04-19', '2017-02-21', 860.60, '2020-02-19', '中国深圳龙岗区学园一巷354号华润大厦28室', '123456', 1);
INSERT INTO `vip_info` VALUES (901, '2022-05-12 21:57:12', '2013-10-25 05:08:43', 1, NULL, '毛青雲', 1, 'CB-AB-0885-M', 0, '16128083227', '2023-12-19', '2014-12-29', 205.90, '2003-09-12', '中国成都市成华区二仙桥东三路211号32室', '123456', 1);
INSERT INTO `vip_info` VALUES (902, '2014-06-16 02:45:07', '2002-07-21 23:14:43', 0, NULL, '姚明', 0, 'EF-CF-4944-S', 0, '18280709023', '2003-08-19', '2002-11-05', 768.50, '2003-09-09', '中国东莞环区南街二巷247号1栋', '123456', 1);
INSERT INTO `vip_info` VALUES (903, '2021-12-08 09:38:12', '2010-08-07 18:02:41', 0, NULL, '戴岚', 1, 'DB-AE-9651-S', 0, '17123256321', '2007-05-19', '2023-02-28', 891.77, '2017-06-05', '中国广州市海珠区江南西路768号37楼', '123456', 1);
INSERT INTO `vip_info` VALUES (904, '2019-07-11 16:38:52', '2014-08-28 08:16:26', 1, NULL, '薛杰宏', 1, 'BC-AB-6108-K', 0, '16559243119', '2010-04-15', '2015-11-18', 650.54, '2016-12-30', '中国广州市天河区天河路923号13楼', '123456', 1);
INSERT INTO `vip_info` VALUES (905, '2008-06-18 09:41:01', '2004-01-08 04:19:06', 0, NULL, '袁頴璇', 1, 'AB-EB-0355-H', 0, '16613078299', '2008-11-30', '2013-11-04', 777.43, '2002-10-17', '中国北京市东城区东单王府井东街730号39栋', '123456', 1);
INSERT INTO `vip_info` VALUES (906, '2017-11-08 07:55:59', '2014-03-28 13:49:59', 1, NULL, '錢力申', 0, 'DE-FD-8183-Y', 0, '14922358522', '2022-08-06', '2017-01-23', 189.69, '2011-06-24', '中国北京市延庆区028县道759号华润大厦48室', '123456', 1);
INSERT INTO `vip_info` VALUES (907, '2015-01-23 14:53:21', '2024-04-20 04:18:17', 0, NULL, '麥家玲', 0, 'DE-FB-1000-P', 0, '18017440548', '2012-02-15', '2008-05-14', 137.30, '2001-11-14', '中国深圳罗湖区田贝一路634号9栋', '123456', 1);
INSERT INTO `vip_info` VALUES (908, '2010-05-15 23:50:36', '2009-09-16 01:29:07', 0, NULL, '呂詠詩', 0, 'EC-BF-3212-I', 0, '16193271923', '2011-06-14', '2009-07-05', 369.43, '2004-02-03', '中国中山天河区大信商圈大信南路334号34室', '123456', 1);
INSERT INTO `vip_info` VALUES (909, '2010-11-21 23:04:08', '2018-07-04 11:19:12', 0, NULL, '許國明', 0, 'FD-FB-7052-N', 0, '15454193499', '2002-11-25', '2006-01-15', 677.50, '2023-07-03', '中国北京市房山区岳琉路976号华润大厦1室', '123456', 1);
INSERT INTO `vip_info` VALUES (910, '2018-07-22 15:20:15', '2001-02-20 23:48:55', 0, NULL, '盧頴思', 0, 'CA-DA-2007-Z', 0, '16778052809', '2015-08-20', '2004-07-16', 765.31, '2006-07-08', '中国北京市朝阳区三里屯路894号华润大厦2室', '123456', 1);
INSERT INTO `vip_info` VALUES (911, '2009-10-19 20:26:41', '2004-05-24 03:58:34', 0, NULL, '劉永發', 0, 'DF-BF-3515-R', 0, '17966949496', '2023-11-05', '2013-04-03', 37.82, '2011-09-05', '中国成都市成华区二仙桥东三路645号24室', '123456', 1);
INSERT INTO `vip_info` VALUES (912, '2006-06-15 18:26:09', '2013-02-17 15:34:49', 1, NULL, '贾晓明', 0, 'CA-AC-3907-K', 0, '18163723675', '2014-09-13', '2013-07-26', 491.85, '2018-09-27', '中国东莞坑美十五巷596号28号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (913, '2004-12-03 20:17:22', '2001-09-11 11:30:32', 1, NULL, '史云熙', 0, 'BD-AB-7084-S', 0, '15640063569', '2006-06-17', '2001-08-03', 595.85, '2011-06-07', '中国成都市锦江区人民南路四段760号8室', '123456', 1);
INSERT INTO `vip_info` VALUES (914, '2012-12-27 03:03:22', '2020-08-30 18:40:45', 0, NULL, '卢睿', 0, 'FC-AB-3933-K', 0, '19065414854', '2010-08-09', '2019-09-05', 483.11, '2018-12-16', '中国成都市成华区玉双路6号861号32楼', '123456', 1);
INSERT INTO `vip_info` VALUES (915, '2002-05-26 08:39:17', '2015-03-14 08:23:09', 0, NULL, '區秀文', 0, 'BE-AB-9977-X', 0, '14925684020', '2012-07-11', '2015-02-23', 395.31, '2007-10-01', '中国深圳福田区景田东一街243号19栋', '123456', 1);
INSERT INTO `vip_info` VALUES (916, '2017-09-22 23:16:46', '2015-01-23 23:49:33', 1, NULL, '常云熙', 0, 'ED-EB-0136-F', 0, '14443605141', '2015-07-31', '2001-08-25', 728.48, '2015-10-17', '中国东莞环区南街二巷290号12室', '123456', 1);
INSERT INTO `vip_info` VALUES (917, '2007-02-10 05:14:52', '2000-05-02 03:13:41', 1, NULL, '薛致远', 1, 'BB-BF-8714-Z', 0, '18740805719', '2002-09-24', '2004-07-17', 680.87, '2025-06-20', '中国广州市天河区天河路810号46栋', '123456', 1);
INSERT INTO `vip_info` VALUES (918, '2010-01-12 19:52:44', '2007-02-25 23:39:33', 1, NULL, '汪致远', 1, 'FD-FA-8772-K', 0, '18030127205', '2021-10-28', '2002-10-15', 945.08, '2002-12-18', '中国东莞坑美十五巷234号40号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (919, '2009-08-17 06:13:12', '2009-11-13 11:37:32', 0, NULL, '邵慧敏', 0, 'DC-BF-1340-W', 0, '13793661210', '2022-08-20', '2009-12-15', 834.91, '2003-06-02', '中国北京市海淀区清河中街68号857号33楼', '123456', 1);
INSERT INTO `vip_info` VALUES (920, '2024-05-09 11:06:33', '2020-01-25 22:20:42', 0, NULL, '鄺力申', 0, 'CB-BA-5551-L', 0, '13766333757', '2013-05-17', '2014-06-28', 851.75, '2010-08-02', '中国成都市成华区二仙桥东三路486号47号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (921, '2004-03-14 20:53:39', '2010-01-10 18:32:23', 0, NULL, '謝力申', 1, 'DD-CA-4367-J', 0, '13575359808', '2013-05-08', '2019-11-28', 783.80, '2006-09-24', '中国成都市锦江区红星路三段248号46号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (922, '2018-01-24 07:33:07', '2015-05-24 18:57:47', 1, NULL, '餘家明', 1, 'BF-AD-4534-R', 0, '18670599675', '2003-06-25', '2024-10-01', 772.22, '2000-12-28', '中国北京市西城区西長安街540号3室', '123456', 1);
INSERT INTO `vip_info` VALUES (923, '2017-08-03 22:33:18', '2014-07-01 07:13:54', 0, NULL, '杜家明', 0, 'FE-EB-4166-F', 0, '13916267594', '2012-08-10', '2016-10-12', 473.76, '2019-05-08', '中国北京市西城区西長安街56号39室', '123456', 1);
INSERT INTO `vip_info` VALUES (924, '2009-04-26 02:48:20', '2025-02-20 16:48:18', 0, NULL, '秦子韬', 1, 'DC-AF-3967-H', 0, '13109925584', '2007-09-24', '2011-03-23', 242.55, '2025-02-22', '中国深圳龙岗区布吉镇西环路113号36楼', '123456', 1);
INSERT INTO `vip_info` VALUES (925, '2000-12-01 05:53:34', '2012-06-10 07:47:32', 0, NULL, '田岚', 1, 'BC-CE-1001-O', 0, '17191181875', '2001-04-30', '2017-11-11', 868.54, '2005-06-24', '中国广州市白云区小坪东路599号24楼', '123456', 1);
INSERT INTO `vip_info` VALUES (926, '2017-03-26 21:42:47', '2010-02-19 09:30:13', 0, NULL, '廖頴璇', 1, 'AA-DE-2722-Z', 0, '14755296724', '2016-02-10', '2024-08-10', 520.17, '2024-11-03', '中国北京市海淀区清河中街68号396号45楼', '123456', 1);
INSERT INTO `vip_info` VALUES (927, '2015-02-05 01:35:37', '2015-06-06 16:05:16', 1, NULL, '苏嘉伦', 1, 'AF-CD-9270-F', 0, '13996875889', '2018-12-23', '2011-05-15', 549.67, '2004-07-03', '中国北京市東城区東直門內大街929号16栋', '123456', 1);
INSERT INTO `vip_info` VALUES (928, '2007-11-05 04:12:25', '2011-04-02 15:02:53', 0, NULL, '戴安琪', 0, 'BC-BD-0837-U', 0, '19834343856', '2001-12-20', '2015-09-30', 143.40, '2006-05-24', '中国广州市海珠区江南西路31号5栋', '123456', 1);
INSERT INTO `vip_info` VALUES (929, '2025-06-03 09:22:06', '2023-12-07 05:41:52', 1, NULL, '韦云熙', 1, 'DE-DE-2189-F', 0, '15729641931', '2003-11-04', '2002-05-20', 772.04, '2007-03-15', '中国成都市锦江区红星路三段772号39室', '123456', 1);
INSERT INTO `vip_info` VALUES (930, '2001-03-30 16:45:27', '2013-01-20 22:09:31', 1, NULL, '阎安琪', 1, 'AA-FB-9425-M', 0, '16620749199', '2017-04-16', '2008-10-16', 799.20, '2020-03-21', '中国上海市浦东新区健祥路265号20号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (931, '2011-09-28 09:29:03', '2006-06-04 21:40:24', 0, NULL, '汪家強', 0, 'FE-DC-9533-F', 0, '15784726505', '2006-03-26', '2019-06-10', 933.22, '2018-06-20', '中国北京市朝阳区三里屯路328号华润大厦40室', '123456', 1);
INSERT INTO `vip_info` VALUES (932, '2015-05-13 07:09:52', '2023-08-24 16:55:47', 1, NULL, '邱國權', 0, 'BC-CF-6376-O', 0, '17195909900', '2009-02-20', '2015-08-27', 365.98, '2015-03-19', '中国深圳罗湖区田贝一路453号18号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (933, '2021-02-03 18:14:09', '2009-04-03 01:42:47', 0, NULL, '曹致远', 0, 'CA-DC-0000-J', 0, '16081866355', '2002-07-17', '2009-08-26', 611.85, '2023-01-16', '中国中山紫马岭商圈中山五路900号28楼', '123456', 1);
INSERT INTO `vip_info` VALUES (934, '2021-05-13 02:00:50', '2014-08-17 14:42:29', 1, NULL, '孙岚', 1, 'DF-FC-3522-A', 0, '16676326080', '2016-06-24', '2009-08-01', 212.49, '2003-03-12', '中国北京市海淀区清河中街68号168号18室', '123456', 1);
INSERT INTO `vip_info` VALUES (935, '2009-03-10 02:37:25', '2012-03-14 18:21:54', 0, NULL, '藍秀文', 1, 'AB-CC-5512-Y', 0, '14947985920', '2000-05-09', '2001-12-22', 927.23, '2006-08-30', '中国深圳罗湖区蔡屋围深南东路804号4室', '123456', 1);
INSERT INTO `vip_info` VALUES (936, '2002-05-31 15:20:25', '2007-06-17 03:06:01', 1, NULL, '邹子韬', 0, 'DC-DB-1200-W', 0, '17203164573', '2010-03-02', '2006-05-24', 168.88, '2021-03-30', '中国中山紫马岭商圈中山五路719号31栋', '123456', 1);
INSERT INTO `vip_info` VALUES (937, '2015-02-05 14:37:50', '2001-09-16 22:36:04', 1, NULL, '姜嘉伦', 0, 'AB-CA-0918-C', 0, '13679742810', '2022-02-02', '2020-08-18', 796.09, '2025-01-21', '中国中山京华商圈华夏街463号25号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (938, '2017-04-14 03:26:46', '2004-08-15 11:47:59', 1, NULL, '丁晓明', 1, 'DE-EA-8359-P', 0, '17374478105', '2008-01-26', '2003-07-19', 176.19, '2017-08-14', '中国深圳罗湖区清水河一路500号48室', '123456', 1);
INSERT INTO `vip_info` VALUES (939, '2017-03-14 00:16:33', '2006-09-13 09:11:43', 0, NULL, '傅天樂', 1, 'CE-BB-7464-O', 0, '17470018056', '2016-09-28', '2018-12-06', 644.31, '2023-01-02', '中国广州市白云区小坪东路85号2号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (940, '2001-03-18 03:26:03', '2025-05-28 01:39:21', 0, NULL, '彭宇宁', 1, 'FE-AD-1010-D', 0, '14513373997', '2001-01-08', '2002-05-04', 211.22, '2008-07-09', '中国深圳龙岗区布吉镇西环路210号华润大厦47室', '123456', 1);
INSERT INTO `vip_info` VALUES (941, '2008-05-16 23:24:37', '2007-11-05 13:45:48', 1, NULL, '郭詩涵', 0, 'FA-DF-6520-N', 0, '18302059173', '2013-04-19', '2002-10-17', 467.87, '2004-04-04', '中国上海市浦东新区健祥路11号30楼', '123456', 1);
INSERT INTO `vip_info` VALUES (942, '2005-01-08 00:13:42', '2018-01-04 02:49:32', 1, NULL, '陶詩涵', 1, 'CF-CE-0791-D', 0, '14265970259', '2011-05-28', '2022-01-01', 588.10, '2008-12-26', '中国深圳罗湖区清水河一路635号33室', '123456', 1);
INSERT INTO `vip_info` VALUES (943, '2018-01-20 08:39:24', '2001-05-17 04:26:00', 0, NULL, '雷國明', 1, 'AE-FC-0167-M', 0, '16605923857', '2024-05-10', '2010-06-03', 738.93, '2000-09-08', '中国北京市西城区复兴门内大街241号48室', '123456', 1);
INSERT INTO `vip_info` VALUES (944, '2022-09-24 21:13:56', '2025-02-15 22:37:58', 0, NULL, '马晓明', 0, 'CD-AA-2361-B', 0, '16222436551', '2020-06-17', '2000-03-16', 292.89, '2019-11-29', '中国成都市成华区玉双路6号207号25栋', '123456', 1);
INSERT INTO `vip_info` VALUES (945, '2004-04-21 18:08:18', '2007-03-10 08:47:38', 1, NULL, '唐嘉伦', 1, 'CD-FD-1942-W', 0, '13740857314', '2000-05-15', '2001-05-28', 393.11, '2012-06-05', '中国北京市東城区東直門內大街522号华润大厦47室', '123456', 1);
INSERT INTO `vip_info` VALUES (946, '2002-09-02 06:43:16', '2018-04-04 09:57:08', 1, NULL, '黎永權', 1, 'CD-DA-6959-L', 0, '17584300578', '2008-08-20', '2021-08-12', 478.35, '2005-11-29', '中国上海市浦东新区橄榄路211号36栋', '123456', 1);
INSERT INTO `vip_info` VALUES (947, '2022-10-03 03:15:49', '2009-05-26 12:39:40', 0, NULL, '钟杰宏', 1, 'EE-BD-2670-C', 0, '16811408743', '2006-01-21', '2013-05-15', 255.11, '2016-12-25', '中国东莞环区南街二巷479号17楼', '123456', 1);
INSERT INTO `vip_info` VALUES (948, '2011-08-01 20:08:55', '2023-09-24 12:59:02', 1, NULL, '戴致远', 0, 'FF-DA-1044-U', 0, '18172030868', '2008-04-08', '2014-04-14', 514.03, '2000-08-31', '中国上海市浦东新区健祥路692号32楼', '123456', 1);
INSERT INTO `vip_info` VALUES (949, '2012-10-19 03:14:16', '2001-12-03 07:14:51', 0, NULL, '蔡子异', 1, 'CB-BB-3782-Y', 0, '18438142682', '2023-12-17', '2010-09-26', 708.69, '2020-04-01', '中国东莞环区南街二巷906号16号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (950, '2015-12-20 20:40:51', '2016-12-21 00:10:33', 0, NULL, '葉祖兒', 0, 'FD-AB-6114-S', 0, '13485298956', '2016-05-01', '2023-11-06', 435.51, '2003-05-31', '中国深圳罗湖区清水河一路933号9栋', '123456', 1);
INSERT INTO `vip_info` VALUES (951, '2001-12-22 20:51:35', '2004-06-06 22:32:17', 1, NULL, '高惠敏', 0, 'AD-AC-3850-G', 0, '18959451823', '2023-06-23', '2016-12-29', 845.47, '2018-09-14', '中国上海市黄浦区淮海中路150号华润大厦35室', '123456', 1);
INSERT INTO `vip_info` VALUES (952, '2007-03-11 00:40:13', '2010-12-18 18:59:37', 0, NULL, '車慧儀', 0, 'AB-AE-3856-G', 0, '18065167090', '2004-09-30', '2021-06-04', 950.23, '2018-08-02', '中国成都市锦江区红星路三段43号44号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (953, '2017-05-04 10:00:48', '2004-12-25 01:09:42', 1, NULL, '杨秀英', 0, 'CE-DD-2648-J', 0, '19729129218', '2020-06-04', '2006-07-02', 60.49, '2018-09-17', '中国广州市白云区机场路棠苑街五巷877号35号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (954, '2003-11-17 20:02:16', '2009-03-14 07:56:59', 0, NULL, '戴志遠', 0, 'DD-BF-6327-W', 0, '13050734175', '2017-08-27', '2001-02-10', 230.58, '2006-07-08', '中国北京市西城区西長安街926号16栋', '123456', 1);
INSERT INTO `vip_info` VALUES (955, '2022-11-07 18:43:46', '2008-07-09 16:00:47', 1, NULL, '蔣國榮', 0, 'DC-ED-9603-T', 0, '17175728071', '2025-01-30', '2024-08-17', 471.26, '2005-07-25', '中国广州市白云区机场路棠苑街五巷853号华润大厦23室', '123456', 1);
INSERT INTO `vip_info` VALUES (956, '2022-01-18 01:47:00', '2003-06-16 18:17:06', 1, NULL, '戚霆鋒', 0, 'CA-AA-1788-I', 0, '18781247909', '2003-06-23', '2014-07-13', 825.71, '2020-04-29', '中国成都市锦江区红星路三段96号18室', '123456', 1);
INSERT INTO `vip_info` VALUES (957, '2001-02-06 00:10:08', '2019-06-04 06:42:41', 0, NULL, '钱致远', 1, 'EC-BD-7976-L', 0, '15994535809', '2019-06-24', '2004-01-24', 884.30, '2021-02-02', '中国成都市成华区玉双路6号287号11号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (958, '2013-04-26 02:14:07', '2001-06-08 04:06:51', 0, NULL, '朱嘉伦', 0, 'AC-EF-0876-Q', 0, '14250580680', '2015-02-26', '2000-04-20', 992.72, '2020-01-20', '中国东莞坑美十五巷58号12栋', '123456', 1);
INSERT INTO `vip_info` VALUES (959, '2018-05-30 16:29:07', '2007-09-28 19:59:02', 0, NULL, '任致远', 0, 'EA-BE-2950-Q', 0, '15554954868', '2014-03-05', '2014-09-11', 556.14, '2012-06-20', '中国北京市东城区东单王府井东街153号19楼', '123456', 1);
INSERT INTO `vip_info` VALUES (960, '2013-06-21 03:57:35', '2000-08-18 13:06:18', 1, NULL, '朱晓明', 1, 'EE-BE-9018-I', 0, '15119519934', '2005-12-22', '2000-03-05', 180.66, '2017-06-11', '中国成都市锦江区人民南路四段697号2楼', '123456', 1);
INSERT INTO `vip_info` VALUES (961, '2009-07-11 00:18:40', '2022-12-05 20:27:59', 1, NULL, '曹志明', 1, 'CA-BB-3087-L', 0, '18772952284', '2006-11-10', '2004-02-18', 192.05, '2008-04-29', '中国中山京华商圈华夏街376号8栋', '123456', 1);
INSERT INTO `vip_info` VALUES (962, '2004-09-03 17:06:27', '2024-03-27 01:26:22', 1, NULL, '杜杰倫', 1, 'AE-AB-9017-V', 0, '15713737589', '2014-05-17', '2022-11-03', 905.00, '2000-03-08', '中国北京市西城区西長安街360号29号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (963, '2016-11-07 20:31:19', '2015-01-17 16:52:28', 0, NULL, '胡頴璇', 1, 'BC-BD-8502-W', 0, '14311210030', '2018-07-29', '2010-03-26', 98.49, '2002-06-04', '中国中山乐丰六路66号10栋', '123456', 1);
INSERT INTO `vip_info` VALUES (964, '2019-06-22 14:43:01', '2006-03-17 09:11:47', 1, NULL, '汪致远', 1, 'FE-CD-6312-N', 0, '13967422947', '2013-08-28', '2018-08-28', 327.19, '2023-02-25', '中国深圳福田区景田东一街494号17楼', '123456', 1);
INSERT INTO `vip_info` VALUES (965, '2018-05-05 23:05:05', '2023-06-17 15:26:13', 0, NULL, '區梓軒', 0, 'CD-DF-8467-L', 0, '14364271708', '2004-10-20', '2016-02-23', 670.20, '2000-12-18', '中国成都市锦江区人民南路四段913号2楼', '123456', 1);
INSERT INTO `vip_info` VALUES (966, '2017-10-27 09:22:26', '2003-11-03 04:35:15', 0, NULL, '吳麗欣', 1, 'FE-BB-8553-B', 0, '15307739310', '2001-08-15', '2024-09-22', 199.03, '2004-03-18', '中国东莞珊瑚路239号34号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (967, '2019-04-02 14:21:42', '2022-10-21 20:39:18', 1, NULL, '姜學友', 0, 'AE-AC-0092-I', 0, '19127804857', '2023-05-21', '2014-11-29', 211.26, '2016-11-14', '中国中山京华商圈华夏街614号3楼', '123456', 1);
INSERT INTO `vip_info` VALUES (968, '2008-07-28 14:05:43', '2021-01-20 07:04:17', 1, NULL, '于子韬', 0, 'BB-DD-3540-C', 0, '16563628333', '2015-05-25', '2001-04-26', 97.46, '2014-03-03', '中国成都市成华区双庆路993号25楼', '123456', 1);
INSERT INTO `vip_info` VALUES (969, '2000-10-27 00:48:43', '2023-10-21 04:46:51', 0, NULL, '田安琪', 1, 'FB-FA-9841-Y', 0, '18825011371', '2005-07-06', '2012-11-24', 504.79, '2003-01-18', '中国中山天河区大信商圈大信南路482号22楼', '123456', 1);
INSERT INTO `vip_info` VALUES (970, '2021-08-13 23:41:35', '2023-11-05 00:56:30', 0, NULL, '鄭慧敏', 0, 'EB-EE-2286-R', 0, '16254215163', '2009-03-25', '2021-01-15', 667.30, '2019-07-14', '中国上海市浦东新区健祥路264号34号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (971, '2011-08-03 14:40:55', '2006-05-28 07:19:19', 1, NULL, '卢嘉伦', 1, 'EB-AC-4886-V', 0, '17321158509', '2016-12-09', '2007-03-06', 642.68, '2013-01-22', '中国成都市成华区玉双路6号95号38栋', '123456', 1);
INSERT INTO `vip_info` VALUES (972, '2016-07-27 02:23:42', '2007-01-12 01:55:21', 1, NULL, '梅詠詩', 1, 'BF-BE-1149-V', 0, '17176558559', '2003-06-04', '2024-12-14', 628.21, '2006-01-04', '中国东莞珊瑚路277号华润大厦9室', '123456', 1);
INSERT INTO `vip_info` VALUES (973, '2003-10-17 00:30:59', '2002-04-12 02:13:37', 0, NULL, '石震南', 0, 'AC-BF-1836-R', 0, '19929954471', '2000-03-10', '2003-06-14', 831.65, '2015-07-24', '中国东莞东泰五街240号华润大厦39室', '123456', 1);
INSERT INTO `vip_info` VALUES (974, '2017-07-23 21:49:49', '2023-04-23 06:36:30', 1, NULL, '方志遠', 1, 'CD-BD-0372-I', 0, '13017816983', '2011-03-01', '2013-12-04', 106.68, '2006-05-29', '中国上海市浦东新区橄榄路158号42室', '123456', 1);
INSERT INTO `vip_info` VALUES (975, '2023-09-14 05:11:19', '2020-08-11 14:56:10', 1, NULL, '毛秀英', 1, 'BB-ED-0598-P', 0, '13675859175', '2023-05-21', '2010-07-29', 860.64, '2019-11-08', '中国东莞珊瑚路81号34室', '123456', 1);
INSERT INTO `vip_info` VALUES (976, '2002-07-05 04:04:04', '2002-12-17 08:45:52', 1, NULL, '卢璐', 0, 'DE-CF-7691-S', 0, '18344807666', '2007-04-10', '2014-10-17', 882.25, '2016-01-16', '中国东莞东泰五街363号47室', '123456', 1);
INSERT INTO `vip_info` VALUES (977, '2019-11-19 09:49:09', '2013-04-23 20:22:13', 0, NULL, '莫家玲', 1, 'DC-ED-3420-S', 0, '15198455481', '2024-05-09', '2004-04-25', 928.16, '2016-03-14', '中国广州市白云区机场路棠苑街五巷213号华润大厦10室', '123456', 1);
INSERT INTO `vip_info` VALUES (978, '2008-08-18 07:54:52', '2007-01-13 17:53:36', 1, NULL, '戚梓軒', 1, 'EC-EE-5791-L', 0, '16731876656', '2020-07-21', '2002-06-14', 928.58, '2009-04-16', '中国广州市天河区天河路419号20号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (979, '2005-06-01 00:50:50', '2000-09-26 13:10:18', 1, NULL, '湯嘉欣', 1, 'ED-AC-5432-Q', 0, '18614382503', '2008-12-01', '2014-01-27', 672.05, '2007-01-05', '中国中山乐丰六路401号28号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (980, '2004-05-16 08:39:37', '2025-01-16 07:34:50', 0, NULL, '田子异', 1, 'AD-BE-7854-S', 0, '16224640577', '2006-02-19', '2017-10-16', 719.88, '2000-05-26', '中国北京市房山区岳琉路535号14楼', '123456', 1);
INSERT INTO `vip_info` VALUES (981, '2010-06-26 17:30:45', '2006-10-30 09:45:12', 0, NULL, '姚國榮', 0, 'EB-EE-0378-H', 0, '16523692685', '2000-12-03', '2001-10-29', 973.77, '2023-09-10', '中国成都市锦江区红星路三段438号10号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (982, '2016-10-03 19:28:40', '2014-07-20 21:54:42', 0, NULL, '蕭仲賢', 1, 'FA-AC-7687-T', 0, '13073814218', '2018-03-22', '2005-03-02', 350.75, '2025-01-09', '中国北京市海淀区清河中街68号735号11室', '123456', 1);
INSERT INTO `vip_info` VALUES (983, '2013-01-02 07:15:46', '2004-02-04 13:49:42', 1, NULL, '曾睿', 0, 'DC-ED-7627-O', 0, '18194831533', '2006-08-06', '2008-01-17', 826.67, '2002-11-12', '中国东莞坑美十五巷416号36楼', '123456', 1);
INSERT INTO `vip_info` VALUES (984, '2010-11-24 18:08:53', '2014-06-23 07:24:11', 1, NULL, '胡秀英', 1, 'FE-FC-6226-F', 0, '13265091242', '2018-06-17', '2004-06-09', 24.91, '2006-02-27', '中国北京市西城区复兴门内大街332号32号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (985, '2023-08-09 06:55:19', '2013-06-18 23:09:05', 0, NULL, '徐玲玲', 1, 'EC-DC-4923-L', 0, '16616197773', '2005-09-21', '2017-09-22', 554.36, '2001-04-17', '中国广州市越秀区中山二路8号华润大厦6室', '123456', 1);
INSERT INTO `vip_info` VALUES (986, '2012-02-05 11:52:19', '2004-03-01 18:58:56', 0, NULL, '蔣玲玲', 1, 'DD-BC-2881-H', 0, '15141029400', '2007-03-13', '2002-01-09', 435.07, '2001-01-19', '中国东莞环区南街二巷141号7栋', '123456', 1);
INSERT INTO `vip_info` VALUES (987, '2018-08-04 01:06:51', '2001-11-28 22:22:05', 0, NULL, '邱天樂', 0, 'BE-DB-6559-V', 0, '17200663134', '2001-07-21', '2015-09-07', 796.60, '2004-12-08', '中国成都市成华区二仙桥东三路356号30号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (988, '2020-07-04 03:26:49', '2004-01-20 13:15:00', 0, NULL, '陈岚', 1, 'EC-EF-2772-V', 0, '18381307283', '2022-06-02', '2022-01-27', 469.78, '2000-04-28', '中国深圳福田区景田东一街831号6室', '123456', 1);
INSERT INTO `vip_info` VALUES (989, '2002-11-10 09:02:59', '2017-11-05 23:46:39', 0, NULL, '郭致远', 0, 'DE-DD-8747-V', 0, '15099046942', '2018-09-10', '2014-05-15', 390.69, '2016-10-15', '中国东莞环区南街二巷692号24楼', '123456', 1);
INSERT INTO `vip_info` VALUES (990, '2010-05-31 13:08:10', '2001-02-02 01:28:31', 0, NULL, '翁永發', 0, 'AA-BE-8164-U', 0, '18613036484', '2013-01-04', '2010-07-01', 241.05, '2005-01-02', '中国中山天河区大信商圈大信南路222号23栋', '123456', 1);
INSERT INTO `vip_info` VALUES (991, '2010-12-26 20:07:10', '2006-04-12 14:57:43', 0, NULL, '罗璐', 1, 'BA-EC-7409-R', 0, '18973581769', '2008-08-16', '2025-01-16', 735.72, '2006-11-17', '中国深圳龙岗区布吉镇西环路313号19号楼', '123456', 1);
INSERT INTO `vip_info` VALUES (992, '2014-02-26 21:46:25', '2006-04-06 09:25:14', 0, NULL, '陳世榮', 0, 'FD-AB-4601-Y', 0, '17744737144', '2025-03-27', '2007-05-31', 127.12, '2021-10-14', '中国北京市朝阳区三里屯路134号40栋', '123456', 1);
INSERT INTO `vip_info` VALUES (993, '2015-03-30 17:33:57', '2020-11-13 19:49:57', 1, NULL, '戴志遠', 0, 'CD-BA-4668-O', 0, '16277321655', '2002-11-23', '2014-11-16', 921.64, '2004-12-07', '中国上海市黄浦区淮海中路90号8楼', '123456', 1);
INSERT INTO `vip_info` VALUES (994, '2017-08-24 19:29:04', '2015-03-01 17:55:58', 1, NULL, '贾晓明', 1, 'FD-DA-6670-E', 0, '14333133208', '2023-10-12', '2014-02-07', 335.53, '2000-03-09', '中国成都市成华区二仙桥东三路866号42栋', '123456', 1);
INSERT INTO `vip_info` VALUES (995, '2013-04-16 21:53:30', '2002-08-01 04:45:13', 0, NULL, '林安琪', 0, 'BA-FD-6065-X', 0, '19459470802', '2006-01-13', '2000-04-30', 914.18, '2002-05-07', '中国成都市锦江区红星路三段264号45栋', '123456', 1);
INSERT INTO `vip_info` VALUES (996, '2009-11-20 23:53:57', '2009-08-20 14:14:50', 0, NULL, '吳國榮', 0, 'CF-DB-6890-H', 0, '14069578361', '2007-12-10', '2003-11-11', 435.15, '2004-02-10', '中国深圳罗湖区清水河一路785号华润大厦27室', '123456', 1);
INSERT INTO `vip_info` VALUES (997, '2020-08-01 13:29:31', '2009-10-24 01:47:39', 1, NULL, '黃發', 0, 'FC-EA-1595-Q', 0, '15366144703', '2000-03-23', '2014-09-01', 815.45, '2000-05-03', '中国中山京华商圈华夏街486号17室', '123456', 1);
INSERT INTO `vip_info` VALUES (998, '2013-03-24 09:31:52', '2003-01-04 13:33:04', 1, NULL, '朱心穎', 1, 'EE-AF-2799-G', 0, '13672774936', '2010-05-05', '2000-01-04', 148.64, '2002-05-20', '中国北京市東城区東直門內大街205号26楼', '123456', 1);
INSERT INTO `vip_info` VALUES (999, '2022-05-03 12:49:07', '2021-11-24 12:46:36', 0, NULL, '陆睿', 1, 'CD-BF-1637-Q', 0, '19867199547', '2013-02-17', '2016-02-04', 446.10, '2003-05-04', '中国深圳龙岗区学园一巷876号华润大厦15室', '123456', 1);
INSERT INTO `vip_info` VALUES (1000, '2024-12-31 00:57:43', '2001-10-21 20:12:42', 1, NULL, '胡家輝', 0, 'CB-BA-9002-K', 0, '19818232019', '2006-09-11', '2007-07-28', 877.86, '2017-12-15', '中国成都市锦江区红星路三段503号10室', '123456', 1);
INSERT INTO `vip_info` VALUES (1001, '2025-07-31 17:53:50', '2025-07-31 17:53:50', 0, 'sed', '糜梓晨', 1, 'aaddccgg\'', 96, '23678905443', NULL, NULL, NULL, '1977-11-15', '湖南省 济码市 鄯善县 盍路34264号 65号门牌', '123456', 1);

-- ----------------------------
-- Table structure for vip_info_ticket
-- ----------------------------
DROP TABLE IF EXISTS `vip_info_ticket`;
CREATE TABLE `vip_info_ticket`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `vip_info_id` bigint NOT NULL COMMENT '会员id',
  `vip_ticket_id` bigint NULL DEFAULT NULL COMMENT '优惠券id',
  `ticket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '代金券名称',
  `vip_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '领取人名称',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用状态',
  `claim_time` date NULL DEFAULT NULL COMMENT '领取时间',
  `expiry_date` date NULL DEFAULT NULL COMMENT '到期时间',
  `ticket_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '优惠券码',
  `vip_phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '领取人手机号',
  `vip_card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '领取人卡号',
  `org_id` bigint NULL DEFAULT NULL COMMENT '机构id',
  `active_id` int NULL DEFAULT NULL COMMENT '活动id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员信息与优惠券关联表（优惠券明细）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_info_ticket
-- ----------------------------
INSERT INTO `vip_info_ticket` VALUES (1, '2025-08-26 16:01:41', '2025-08-29 11:04:14', 0, NULL, 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (2, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (3, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (4, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (5, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (6, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (7, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (8, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (9, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (10, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (11, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (12, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (13, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (14, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (15, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (16, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (17, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (18, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (19, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (20, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (21, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (22, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564376619918861', '17909590614', 'FD-BE-6193-M', NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (23, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564376619928720', '17909590614', 'FD-BE-6193-M', NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (24, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564376619927308', '17909590614', 'FD-BE-6193-M', NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (25, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564376619921490', '17909590614', 'FD-BE-6193-M', NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (26, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564376619927925', '17909590614', 'FD-BE-6193-M', NULL, NULL);
INSERT INTO `vip_info_ticket` VALUES (27, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564503347321267', '17909590614', 'FD-BE-6193-M', 1, 2);
INSERT INTO `vip_info_ticket` VALUES (28, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564503347334373', '17909590614', 'FD-BE-6193-M', 1, 2);
INSERT INTO `vip_info_ticket` VALUES (29, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564503347339962', '17909590614', 'FD-BE-6193-M', 1, 2);
INSERT INTO `vip_info_ticket` VALUES (30, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564503347334038', '17909590614', 'FD-BE-6193-M', 1, 2);
INSERT INTO `vip_info_ticket` VALUES (31, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, '充值活动赠送', 17, 2, '99元项目任选', '區家明', '未使用', '2025-08-29', NULL, 'T17564503347331029', '17909590614', 'FD-BE-6193-M', 1, 2);

-- ----------------------------
-- Table structure for vip_recharge_active
-- ----------------------------
DROP TABLE IF EXISTS `vip_recharge_active`;
CREATE TABLE `vip_recharge_active`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `active_status` tinyint NULL DEFAULT 0 COMMENT '充值活动状态（0 启用，1 禁用）',
  `active_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '活动名称',
  `active_begin_time` date NULL DEFAULT NULL COMMENT '开始时间',
  `active_final_time` date NULL DEFAULT NULL COMMENT '结束时间',
  `active_type` tinyint NOT NULL COMMENT '活动类型',
  `active_capital` decimal(10, 2) NULL DEFAULT NULL COMMENT '充值本金',
  `active_discount` int NULL DEFAULT NULL COMMENT '消费折扣百分比',
  `active_base` tinyint NULL DEFAULT NULL COMMENT '折扣基础（0 标准价，1 会员价）',
  `is_cross_store` tinyint NULL DEFAULT NULL COMMENT '是否允许跨店结算（0 不允许，1 允许）',
  `present_value` decimal(10, 2) NULL DEFAULT NULL COMMENT '赠送金额',
  `present_discount_is_same` tinyint NULL DEFAULT NULL COMMENT '折扣是否同本金（0 不同，1 同）',
  `present_discount` int NULL DEFAULT NULL COMMENT '赠送金-消费折扣百分比',
  `present_base` tinyint NULL DEFAULT NULL COMMENT '赠送金-折扣基础（0 标准价，1 会员价）',
  `present_is_cross_store` tinyint NULL DEFAULT NULL COMMENT '赠送金-允许跨店结算（0 不允许，1 允许）',
  `org_id` bigint NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '充值活动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_recharge_active
-- ----------------------------
INSERT INTO `vip_recharge_active` VALUES (1, '2025-08-21 22:39:36', '2025-08-26 14:53:57', 0, '充值1000送200，可跨店消费', 0, '充1000送200', '2025-02-17', '2026-08-29', 0, 1000.00, 80, 0, 1, 200.00, 1, 80, 0, 1, 1);
INSERT INTO `vip_recharge_active` VALUES (2, '2025-08-21 22:49:56', '2025-08-26 14:46:28', 0, '充1000送5次99元项目体验券', 0, '充1000送5次99元项目', '2025-02-17', '2026-08-29', 1, 1000.00, 80, 0, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `vip_recharge_active` VALUES (3, '2025-08-21 23:05:07', '2025-08-21 23:05:07', 0, '充1000送200元+5次99元项目', 0, '充1000送200元+5次99元项目', '2025-02-17', '2026-08-29', 2, 1000.00, 80, 0, 1, 200.00, 0, 100, 0, 1, 1);

-- ----------------------------
-- Table structure for vip_recharge_active_ticket
-- ----------------------------
DROP TABLE IF EXISTS `vip_recharge_active_ticket`;
CREATE TABLE `vip_recharge_active_ticket`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `ticket_id` bigint NULL DEFAULT NULL COMMENT '优惠券id',
  `ticket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '优惠券名称',
  `active_id` bigint NULL DEFAULT NULL COMMENT '充值活动id',
  `number` int NULL DEFAULT NULL COMMENT '优惠券数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '充值活动与优惠券关联表\r\n' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_recharge_active_ticket
-- ----------------------------
INSERT INTO `vip_recharge_active_ticket` VALUES (1, '2025-08-21 22:49:56', '2025-08-21 22:49:56', 0, NULL, 2, '99元项目任选', 2, 5);
INSERT INTO `vip_recharge_active_ticket` VALUES (2, '2025-08-21 23:05:07', '2025-08-21 23:05:07', 0, NULL, 2, '99元项目任选', 3, 5);

-- ----------------------------
-- Table structure for vip_recharge_history
-- ----------------------------
DROP TABLE IF EXISTS `vip_recharge_history`;
CREATE TABLE `vip_recharge_history`  (
  `id` bigint(20) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `history_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '充值单号',
  `recharge_value` decimal(10, 2) NULL DEFAULT NULL COMMENT '充值金额',
  `recharge_status` tinyint NULL DEFAULT NULL COMMENT '充值状态（0 充值成功，1 已冲正）',
  `recharge_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '充值类型（0 门店充值，1 手动赠送）',
  `recharge_time` datetime NOT NULL COMMENT '充值时间',
  `vip_id` bigint NULL DEFAULT NULL COMMENT '关联充值会员id',
  `vip_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `vip_phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员电话号',
  `vip_card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员卡号',
  `activity_id` bigint NULL DEFAULT NULL COMMENT '关联充值活动id',
  `active_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '充值活动名称',
  `asset_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '本金资产编号',
  `present_value` decimal(10, 2) NULL DEFAULT NULL COMMENT '赠送金额',
  `present_asset_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '赠送资产编号',
  `ticket_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '赠券信息',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作员名称',
  `user_id` bigint NULL DEFAULT NULL COMMENT '操作员id',
  `org_id` bigint NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '充值记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_recharge_history
-- ----------------------------
INSERT INTO `vip_recharge_history` VALUES (00000000000000000003, '2025-08-25 23:58:11', '2025-08-25 23:58:11', 0, NULL, 'H17561374909895727', 500.00, 0, '门店充值', '2025-08-25 23:58:11', 3, '元俊宇', '18181381423', 'FC-CD-3149-L', NULL, NULL, 'A17561374909893859', NULL, NULL, NULL, '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000004, '2025-08-26 00:10:01', '2025-08-26 00:10:01', 0, NULL, 'H17561380555682946', 500.00, 0, '门店充值', '2025-08-26 00:07:36', 3, '元俊宇', '18181381423', 'FC-CD-3149-L', NULL, NULL, 'A17561380988775628', NULL, NULL, NULL, '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000005, '2025-08-26 00:12:51', '2025-08-26 00:12:51', 0, NULL, 'H17561383334800658', 500.00, 0, '门店充值', '2025-08-26 00:12:13', 3, '元俊宇', '18181381423', 'FC-CD-3149-L', NULL, NULL, 'A17561383408781603', NULL, NULL, NULL, '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000006, '2025-08-26 14:30:52', '2025-08-26 14:30:52', 0, NULL, 'H17561898522238524', 1000.00, 0, '门店充值', '2025-08-26 14:30:52', 4, '李秀英', '13552515356', 'CD-CE-9484-O', 1, '充1000送200', 'A17561898522237448', NULL, NULL, NULL, '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000007, '2025-08-26 14:47:56', '2025-08-26 14:47:56', 0, NULL, 'H17561908755124136', 1000.00, 0, '门店充值', '2025-08-26 14:47:56', 13, '韦晓明', '16676896210', 'AF-BB-1848-G', 1, '充1000送200', 'A17561908755144855', 200.00, 'A17561908755916359', '', '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000009, '2025-08-26 15:41:28', '2025-08-26 15:41:28', 0, NULL, 'H17561940881394219', 1000.00, 0, '门店充值', '2025-08-26 15:41:28', 17, '區家明', '17909590614', 'FD-BE-6193-M', 1, '充1000送200', 'A17561940881394134', 200.00, 'A17561940882064451', NULL, '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000010, '2025-08-26 16:01:41', '2025-08-26 16:01:41', 0, NULL, 'H17561953009314387', 1000.00, 0, '门店充值', '2025-08-26 16:01:41', 17, '區家明', '17909590614', 'FD-BE-6193-M', 2, '充1000送5次99元项目', 'A17561953009342215', NULL, NULL, '99元项目任选(5)张\n', '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000011, '2025-08-26 17:26:45', '2025-08-26 17:26:45', 0, NULL, 'H17562004049215416', 1000.00, 0, '门店充值', '2025-08-26 17:26:45', 17, '區家明', '17909590614', 'FD-BE-6193-M', 2, '充1000送5次99元项目', 'A17562004049233976', NULL, NULL, '99元项目任选(5张)\n', '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000012, '2025-08-26 17:47:59', '2025-08-26 17:47:59', 0, NULL, 'H17562016786556535', 1000.00, 0, '门店充值', '2025-08-26 17:47:59', 17, '區家明', '17909590614', 'FD-BE-6193-M', 2, '充1000送5次99元项目', 'A17562016786553823', NULL, NULL, '99元项目任选(5张)\n', '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000013, '2025-08-26 17:54:14', '2025-08-26 17:54:14', 0, NULL, 'H17562020537136683', 1000.00, 0, '门店充值', '2025-08-26 17:54:14', 17, '區家明', '17909590614', 'FD-BE-6193-M', 3, '充1000送200元+5次99元项目', 'A17562020537134219', 200.00, 'A17562020537839256', '99元项目任选(5张)\n', '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000014, '2025-08-29 11:19:49', '2025-08-29 11:19:49', 0, NULL, 'H17564375885058808', 1000.00, 0, '门店充值', '2025-08-29 11:19:49', 17, '區家明', '17909590614', 'FD-BE-6193-M', 2, '充1000送5次99元项目', 'A17564375885085749', NULL, NULL, '99元项目任选(5张)\n', '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000015, '2025-08-29 11:21:02', '2025-08-29 11:21:02', 0, NULL, 'H17564376618793709', 1000.00, 0, '门店充值', '2025-08-29 11:21:02', 17, '區家明', '17909590614', 'FD-BE-6193-M', 2, '充1000送5次99元项目', 'A17564376618805362', NULL, NULL, '99元项目任选(5张)\n', '杨杰宏', 4, 1);
INSERT INTO `vip_recharge_history` VALUES (00000000000000000016, '2025-08-29 14:52:15', '2025-08-29 14:52:15', 0, NULL, 'H17564503346202507', 1000.00, 0, '门店充值', '2025-08-29 14:52:15', 17, '區家明', '17909590614', 'FD-BE-6193-M', 2, '充1000送5次99元项目', 'A17564503346242628', NULL, NULL, '99元项目任选(5张)\n', '杨杰宏', 4, 1);

-- ----------------------------
-- Table structure for vip_recharge_user
-- ----------------------------
DROP TABLE IF EXISTS `vip_recharge_user`;
CREATE TABLE `vip_recharge_user`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `recharge_id` bigint NULL DEFAULT NULL COMMENT '收入记录id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '操作员id',
  `commission` decimal(10, 2) NULL DEFAULT NULL COMMENT '充值业绩',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '员工充值提成关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_recharge_user
-- ----------------------------

-- ----------------------------
-- Table structure for vip_ticket
-- ----------------------------
DROP TABLE IF EXISTS `vip_ticket`;
CREATE TABLE `vip_ticket`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0 存在，1 删除)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `ticket_status` tinyint NULL DEFAULT 0 COMMENT '优惠券状态（0 启用，1 禁用）',
  `ticket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '优惠券名称',
  `ticket_type` tinyint NULL DEFAULT NULL COMMENT '优惠券类型',
  `ticket_effective_time` int NULL DEFAULT NULL COMMENT '有效天数（-1 代表无限期）',
  `ticket_full_payment` decimal(10, 2) NULL DEFAULT NULL COMMENT '限额满多少元可用',
  `ticket_value` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠券面值',
  `org_id` bigint NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员优惠券' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_ticket
-- ----------------------------
INSERT INTO `vip_ticket` VALUES (1, '2025-08-19 22:24:45', '2025-08-19 23:17:50', 0, NULL, 1, '88元代金券', 0, -1, 0.00, 88.00, 1);
INSERT INTO `vip_ticket` VALUES (2, '2025-08-19 22:24:53', '2025-08-19 22:53:41', 0, NULL, 0, '99元项目任选', 1, -1, NULL, NULL, 1);
INSERT INTO `vip_ticket` VALUES (3, '2025-08-19 22:44:09', '2025-08-19 23:26:49', 0, '199元内项目任选', 0, '199元项目任选', 1, -1, NULL, NULL, 1);

-- ----------------------------
-- Table structure for vip_ticket_detail
-- ----------------------------
DROP TABLE IF EXISTS `vip_ticket_detail`;
CREATE TABLE `vip_ticket_detail`  (
  `ticket_id` bigint NOT NULL COMMENT '优惠券id',
  `server_item_id` bigint NOT NULL COMMENT '服务项目id',
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '体验券详情' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vip_ticket_detail
-- ----------------------------
INSERT INTO `vip_ticket_detail` VALUES (2, 1, 1);
INSERT INTO `vip_ticket_detail` VALUES (2, 2, 2);
INSERT INTO `vip_ticket_detail` VALUES (3, 1, 6);
INSERT INTO `vip_ticket_detail` VALUES (3, 2, 7);

SET FOREIGN_KEY_CHECKS = 1;
