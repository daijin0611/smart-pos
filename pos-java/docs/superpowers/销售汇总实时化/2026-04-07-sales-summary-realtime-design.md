# 销售数据汇总实时计算改造

## 背景

当前销售汇总通过定时任务每天12点从原始表聚合写入 `order_sales_summary` 汇总表，查询时直接读取汇总表。存在问题：数据不实时，需等待定时任务执行。

## 目标

将销售汇总改为查询时实时计算，移除汇总表和定时任务，同时将充值统计字段与支付枚举对齐。

## 改动范围

### 1. 移除汇总表相关

- **删除** `OrderSalesSummary` 实体类
- **删除** `OrderSalesSummaryMapper` 接口及 XML
- **删除** `ScheduledTaskService` 整个类（仅含销售统计定时任务）
- **Service 接口** `OrderSalesSummaryService` 不再继承 `IService<OrderSalesSummary>`，保留 `getOrderSummaries()` 方法，移除 `executeSummaries()`
- **Service 实现** 不再继承 `ServiceImpl`，改为直接实现接口

### 2. PaymentTypeEnum 标签修改

`pos-common/src/main/java/org/haut/common/enums/PaymentTypeEnum.java`

```
QR("0", "扫码") → QR("0", "收款码")
```

### 3. OrderSummaryVO 字段变更

**移除** 3 个旧充值字段：`wechatRecharge`、`cashRecharge`、`otherRecharge`

**新增** 5 个充值字段（与支付枚举一致，排除会员卡）：

| 字段 | 类型 | 说明 | 对应枚举 |
|------|------|------|---------|
| `qrRecharge` | BigDecimal | 收款码充值 | QR(0) |
| `cashRecharge` | BigDecimal | 现金充值 | CASH(1) |
| `posRecharge` | BigDecimal | POS充值 | POS(2) |
| `douyinRecharge` | BigDecimal | 抖音充值 | DOUYIN(3) |
| `meituanRecharge` | BigDecimal | 美团充值 | MEITUAN(4) |

### 4. 实时计算逻辑（getOrderSummaries）

**输入**：`OrderSummaryQuery`（date 日期范围、orgIds 门店列表）

**步骤**：

1. 解析查询条件，解析 orgIds（通过 `SysOrgUserService.resolveOrgIds`）
2. 查询原始数据（3 次查询）：
   - `order_info`：日期范围内、orgId 匹配、orderStatus 为 SETTLED 或 RECONCILED
   - `order_detail`：日期范围内、orgId 匹配
   - `payment_detail`：日期范围内、orgId 匹配、paymentStatus 为 PAID
3. 按 `(orgId, toLocalDate(createTime))` 分组聚合：
   - **营业额** = SUM(order.totalAmount) + SUM(recharge payment.totalAmount)
   - **实收** = SUM(order.actualAmount) + SUM(recharge payment.totalAmount)
   - **单次数量** = COUNT(order)
   - **人次** = COUNT(order_detail)
   - **项目数** = SUM(order_detail.quantity)
   - **支付金额**：按 paymentType 分组求和，仅 activeType=CONSUMER
     - qrPayment / cashPayment / posPayment / douyinPayment / meituanPayment / memberCardPayment
   - **充值金额**：按 paymentType 分组求和，仅 activeType=RECHARGER，排除 paymentType=5(会员卡)
     - qrRecharge / cashRecharge / posRecharge / douyinRecharge / meituanRecharge
4. 批量填充门店信息（orgName、orgCode）
5. 返回按日期排序的结果列表

### 5. 不改动的文件

- `OrderDataController` — API 接口签名不变
- `OrderSummaryQuery` — 查询条件不变

## 数据库

汇总表 `order_sales_summary` 不再使用，后续可通过迁移脚本删除。本次不改表结构。
