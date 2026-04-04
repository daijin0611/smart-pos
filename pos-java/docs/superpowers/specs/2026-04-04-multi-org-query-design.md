# 多门店查询改造设计

## 需求

为6个业务查询模块添加多门店过滤支持，替代现有的单门店（登录门店）过滤。

**规则**：
- 前端传了 `orgIds` → 直接用这些 ID 做 IN 过滤
- 前端没传 `orgIds` → 自动获取当前用户关联的所有门店ID（主门店 + SysOrgUser 关联门店）做 IN 过滤

## 改动范围

### 公共方法（SysOrgUserService）

在 `SysOrgUserService` 接口和 `SysOrgUserServiceImpl` 中新增方法：

```java
/**
 * 获取用户关联的门店ID列表（主门店 + 额外关联门店）。
 * 若 queryOrgIds 非空则直接返回，否则自动查询用户关联门店。
 */
List<Long> resolveOrgIds(Long userId, Long primaryOrgId, List<Long> queryOrgIds);
```

实现逻辑：
1. 若 `queryOrgIds` 非空非空 → 直接返回
2. 否则合并主门店 `primaryOrgId` + `getOrgIdsByUserId(userId)` 返回

### 6个模块改动

每个模块改3处：Query 类加字段、Service 层调用公共方法、Mapper/XML 改 IN 过滤。

| 模块 | Query 类 | Service 类 | Mapper/XML |
|------|----------|-----------|------------|
| 充值记录 | `RechargeHistoryQuery` 加 `List<Long> orgIds` | `VipRechargeHistoryServiceImpl` | `VipRechargeHistoryMapper.xml` |
| 销售记录 | `OrderPageQuery` 改 `orgId` 为 `List<Long> orgIds` | `OrderInfoServiceImpl` | `OrderInfoMapper.xml` |
| 销售汇总 | `OrderSummaryQuery` 加 `List<Long> orgIds` | `OrderSalesSummaryServiceImpl` | 无 XML，lambdaQuery 改 IN |
| 销售明细 | `OrderDetailPageQuery` 加 `List<Long> orgIds` | `OrderDetailServiceImpl` | 无 XML，lambdaQuery 改 IN |
| 绩效明细 | `KpiListQuery` 改 `orgId` 为 `List<Long> orgIds` | `KpiDetailServiceImpl` | `KpiDetailMapper.xml` |
| 绩效汇总 | `KpiSummaryQuery` 改 `orgId` 为 `List<Long> orgIds` | `KpiDetailServiceImpl` | `KpiDetailMapper.xml` |

### Query 类字段统一格式

```java
@Schema(description = "门店ID列表，不传则查全部关联门店")
private List<Long> orgIds;
```

已有的单值 `orgId` 字段（如 OrderPageQuery、KpiListQuery、KpiSummaryQuery）替换为 `List<Long> orgIds`。

### Service 层统一调用模式

```java
List<Long> orgIds = sysOrgUserService.resolveOrgIds(
    auth.getUserId(), auth.getOrgId(), query.getOrgIds());
query.setOrgIds(orgIds);
```

### SQL 改动

`org_id = #{orgId}` → `<if test="query.orgIds != null and !query.orgIds.isEmpty()">AND org_id IN (...)</if>`
