# 手写单号功能设计

## 背景

订单结算时，店员需要一个手写单号字段来记录纸质单据上的编号，方便后续与纸质单据对账。

## 需求

| 项目 | 决定 |
|------|------|
| 输入时机 | 结算时输入，必填 |
| 校验规则 | 无唯一性校验，纯文本无格式限制 |
| 展示位置 | 订单列表和订单详情中展示 |
| 字段命名 | `manualOrderNo` |
| 可修改性 | 结算后仍可修改 |

## 方案

在 `order_info` 表直接新增 `manual_order_no` 字段，不建独立扩展表。理由：仅一个字段，直接加主表最简单高效。

## 数据库变更

在 `order_info` 表新增列：

```sql
ALTER TABLE order_info ADD COLUMN manual_order_no VARCHAR(100) DEFAULT NULL COMMENT '手写单号';
```

- 类型 `VARCHAR(100)`，容纳各种手写编号
- 允许 NULL（未结算订单没有手写单号）
- 不建索引（仅展示用途，无需按手写单号检索）

## 后端改动

### Entity 层

`OrderInfoEntity` 新增字段：
```java
private String manualOrderNo;
```

### DTO 层

`OrderSettleDTO`（结算请求）新增字段：
```java
@NotBlank(message = "手写单号不能为空")
private String manualOrderNo;
```

### Service 层

`settleOrder()` 方法中，结算时将 `manualOrderNo` 写入订单记录。

### VO 层

`OrderInfoVO` 新增 `manualOrderNo` 字段，在订单列表和详情中返回。

## API 接口

### 1. 结算接口（已有，需修改）

`PUT /order/settle-order`

请求体 `OrderSettleDTO` 新增 `manualOrderNo` 字段（必填）。

### 2. 修改手写单号（新增）

`PUT /order/update-manual-order-no`

请求参数：
- `orderId`（Long，必填）— 订单 ID
- `manualOrderNo`（String，必填）— 新的手写单号

业务规则：
- 仅允许订单状态为已结算(2)、已对单(5)时修改
- 其他状态返回错误提示

## 改动文件清单

| 文件 | 改动类型 |
|------|---------|
| SQL 迁移脚本 `V1.0.X__add_manual_order_no.sql` | 新增 |
| `OrderInfoEntity` | 新增字段 |
| `OrderSettleDTO` | 新增字段 + @NotBlank 校验 |
| `OrderInfoVO` | 新增字段 |
| `OrderInfoServiceImpl` | 结算逻辑补充写入 manualOrderNo |
| `OrderController` | 新增 `update-manual-order-no` 接口 |
