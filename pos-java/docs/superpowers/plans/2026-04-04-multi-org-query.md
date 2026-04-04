# 多门店查询改造 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为6个业务查询模块添加多门店过滤支持，前端可传 orgIds 指定查询范围，不传则自动获取用户关联门店。

**Architecture:** 在 SysOrgUserService 中新增公共方法 resolveOrgIds，统一处理"前端传了就用，没传就从用户关联门店取"的逻辑。6个模块的 Query 类统一添加 `List<Long> orgIds` 字段，Service 层调用公共方法，SQL/lambdaQuery 改为 IN 过滤。VO 响应中补充 orgName、orgCode 字段。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus 3.5.11

---

### Task 1: 公共方法 — SysOrgUserService.resolveOrgIds

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/system/service/SysOrgUserService.java`
- Modify: `pos-server/src/main/java/org/haut/server/system/service/impl/SysOrgUserServiceImpl.java`

- [ ] **Step 1: SysOrgUserService 接口添加方法声明**

在 `SysOrgUserService.java` 末尾 `}` 前添加：

```java
/**
 * 解析查询门店ID列表。
 * 若 queryOrgIds 非空则直接返回，否则自动查询用户关联门店（主门店+额外关联门店）。
 */
List<Long> resolveOrgIds(Long userId, Long primaryOrgId, List<Long> queryOrgIds);
```

- [ ] **Step 2: SysOrgUserServiceImpl 实现**

在 `SysOrgUserServiceImpl.java` 末尾 `}` 前添加：

```java
@Override
public List<Long> resolveOrgIds(Long userId, Long primaryOrgId, List<Long> queryOrgIds) {
    if (queryOrgIds != null && !queryOrgIds.isEmpty()) {
        return queryOrgIds;
    }
    List<Long> extraOrgIds = getOrgIdsByUserId(userId);
    List<Long> result = new java.util.ArrayList<>();
    result.add(primaryOrgId);
    result.addAll(extraOrgIds);
    return result;
}
```

- [ ] **Step 3: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/system/service/SysOrgUserService.java pos-server/src/main/java/org/haut/server/system/service/impl/SysOrgUserServiceImpl.java
git commit -m "feat(system): SysOrgUserService添加resolveOrgIds公共方法"
```

---

### Task 2: 充值记录模块改造

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/query/vip/RechargeHistoryQuery.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/vip/RechargeHistoryVO.java`
- Modify: `pos-server/src/main/java/org/haut/server/vip/mapper/VipRechargeHistoryMapper.java`
- Modify: `pos-server/src/main/resources/mapper/vip/VipRechargeHistoryMapper.xml`
- Modify: `pos-server/src/main/java/org/haut/server/vip/service/impl/VipRechargeHistoryServiceImpl.java`

- [ ] **Step 1: RechargeHistoryQuery 添加 orgIds 字段**

在 `RechargeHistoryQuery.java` 的 `pageSize` 字段后添加：

```java
@Schema(description = "门店ID列表，不传则查全部关联门店")
private List<Long> orgIds;
```

需要添加 `import java.util.List;`

- [ ] **Step 2: RechargeHistoryVO 添加 orgName、orgCode 字段**

在 `RechargeHistoryVO.java` 的 `orgId` 字段后添加：

```java
/**
 * 门店名称
 */
private String orgName;

/**
 * 门店编码
 */
private String orgCode;
```

- [ ] **Step 3: VipRechargeHistoryMapper 方法签名改 orgIds**

将 `VipRechargeHistoryMapper.java` 的 `getList` 方法签名从：

```java
IPage<RechargeHistoryVO> getList(Page<RechargeHistoryVO> page, @Param("query") RechargeHistoryQuery query, @Param("orgId") Long orgId);
```

改为：

```java
IPage<RechargeHistoryVO> getList(Page<RechargeHistoryVO> page, @Param("query") RechargeHistoryQuery query, @Param("orgIds") List<Long> orgIds);
```

需要添加 `import java.util.List;`

- [ ] **Step 4: VipRechargeHistoryMapper.xml SQL 改 IN 过滤**

将 XML 中（约104行）的：

```xml
AND vrh.org_id = #{orgId}
```

改为：

```xml
<if test="orgIds != null and !orgIds.isEmpty()">
    AND vrh.org_id IN
    <foreach collection="orgIds" item="id" open="(" separator="," close=")">
        #{id}
    </foreach>
</if>
```

同时在 SELECT 中添加门店字段。将 `vrh.org_id,` 后的 `pd.payment_type,` 前插入：

```sql
so.org_name,
so.org_code,
```

在 `FROM vip_recharge_history vrh` 后添加 JOIN：

```sql
LEFT JOIN sys_org so ON so.id = vrh.org_id
```

在 resultMap `RechargeHistoryVO` 中（`orgId` 的 result 之后）添加：

```xml
<result property="orgName" column="org_name" />
<result property="orgCode" column="org_code" />
```

- [ ] **Step 5: VipRechargeHistoryServiceImpl 改用 resolveOrgIds + 批量填充**

将 `getList` 方法从：

```java
@Override
public PageDTO<RechargeHistoryVO> getList(RechargeHistoryQuery query) {
    AuthInfoDTO auth = AuthContextHolder.getAuth();
    Page<RechargeHistoryVO> page = new Page<>(query.getPageNum(), query.getPageSize());
    IPage<RechargeHistoryVO> result = this.baseMapper.getList(page, query, auth.getOrgId());
    return PageDTO.create(result);
}
```

改为：

```java
@Override
public PageDTO<RechargeHistoryVO> getList(RechargeHistoryQuery query) {
    AuthInfoDTO auth = AuthContextHolder.getAuth();
    List<Long> orgIds = sysOrgUserService.resolveOrgIds(auth.getUserId(), auth.getOrgId(), query.getOrgIds());
    Page<RechargeHistoryVO> page = new Page<>(query.getPageNum(), query.getPageSize());
    IPage<RechargeHistoryVO> result = this.baseMapper.getList(page, query, orgIds);
    return PageDTO.create(result);
}
```

需要在类中注入 `SysOrgUserService`：

```java
private final SysOrgUserService sysOrgUserService;
```

需要添加 `import org.haut.server.system.service.SysOrgUserService;` 和 `import java.util.List;`。

- [ ] **Step 6: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/query/vip/RechargeHistoryQuery.java pos-common/src/main/java/org/haut/common/domain/vo/vip/RechargeHistoryVO.java pos-server/src/main/java/org/haut/server/vip/mapper/VipRechargeHistoryMapper.java pos-server/src/main/resources/mapper/vip/VipRechargeHistoryMapper.xml pos-server/src/main/java/org/haut/server/vip/service/impl/VipRechargeHistoryServiceImpl.java
git commit -m "feat(vip): 充值记录查询支持多门店过滤"
```

---

### Task 3: 销售记录模块改造

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/query/order/OrderPageQuery.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderInfoVO.java`
- Modify: `pos-server/src/main/resources/mapper/order/OrderInfoMapper.xml`
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java`

- [ ] **Step 1: OrderPageQuery 改 orgId 为 orgIds**

将 `OrderPageQuery.java` 中的：

```java
@Schema(description = "机构ID", hidden = true)
private Long orgId;
```

改为：

```java
@Schema(description = "门店ID列表，不传则查全部关联门店")
private List<Long> orgIds;
```

需要添加 `import java.util.List;`，移除不再需要的 `import jakarta.validation.constraints.NotNull;`（检查其他字段是否还用 @NotNull，pageNum 和 pageSize 仍在用所以保留）。

- [ ] **Step 2: OrderInfoVO 添加 orgName、orgCode 字段**

在 `OrderInfoVO.java` 的 `orgId` 字段后添加：

```java
@Schema(description = "门店名称")
private String orgName;

@Schema(description = "门店编码")
private String orgCode;
```

- [ ] **Step 3: OrderInfoMapper.xml SQL 改 IN 过滤**

将 `pageQueryCondition` SQL 片段中（约268行）的：

```xml
AND oi.org_id = #{query.orgId}
```

改为：

```xml
<if test="query.orgIds != null and !query.orgIds.isEmpty()">
    AND oi.org_id IN
    <foreach collection="query.orgIds" item="id" open="(" separator="," close=")">
        #{id}
    </foreach>
</if>
```

同理，将 `queryCondition` SQL 片段中（约74-76行）的：

```xml
<if test="query.orgId != null">
    AND org_id = #{query.orgId}
</if>
```

改为：

```xml
<if test="query.orgIds != null and !query.orgIds.isEmpty()">
    AND org_id IN
    <foreach collection="query.orgIds" item="id" open="(" separator="," close=")">
        #{id}
    </foreach>
</if>
```

- [ ] **Step 4: OrderInfoServiceImpl 改用 resolveOrgIds + 批量填充门店**

将 `pageQuery` 方法中的：

```java
AuthInfoDTO auth = AuthContextHolder.getAuth();
query.setOrgId(auth.getOrgId());
```

改为：

```java
AuthInfoDTO auth = AuthContextHolder.getAuth();
List<Long> orgIds = sysOrgUserService.resolveOrgIds(auth.getUserId(), auth.getOrgId(), query.getOrgIds());
query.setOrgIds(orgIds);
```

在方法返回前（`return PageDTO.create(result, OrderInfoVO.class);` 之前），添加门店信息批量填充：

```java
// 批量填充门店信息
if (!records.isEmpty()) {
    Set<Long> allOrgIds = records.stream().map(OrderInfoVO::getOrgId).filter(Objects::nonNull).collect(Collectors.toSet());
    if (!allOrgIds.isEmpty()) {
        Map<Long, OrgSimpleVO> orgMap = sysOrgService.getOrgSimpleMapByIds(allOrgIds);
        records.forEach(vo -> {
            OrgSimpleVO org = orgMap.get(vo.getOrgId());
            if (org != null) {
                vo.setOrgName(org.getOrgName());
                vo.setOrgCode(org.getOrgCode());
            }
        });
    }
}
```

需要在类中注入 `SysOrgUserService` 和 `SysOrgService`，添加 import：

```java
import org.haut.server.system.service.SysOrgUserService;
import org.haut.server.system.service.SysOrgService;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import java.util.Set;
import java.util.Map;
import java.util.Objects;
```

并添加字段：

```java
private final SysOrgUserService sysOrgUserService;
private final SysOrgService sysOrgService;
```

- [ ] **Step 5: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/query/order/OrderPageQuery.java pos-common/src/main/java/org/haut/common/domain/vo/order/OrderInfoVO.java pos-server/src/main/resources/mapper/order/OrderInfoMapper.xml pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java
git commit -m "feat(order): 销售记录查询支持多门店过滤"
```

---

### Task 4: 销售汇总模块改造

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/query/order/OrderSummaryQuery.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java`
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java`

- [ ] **Step 1: OrderSummaryQuery 添加 orgIds 字段**

在 `OrderSummaryQuery.java` 的 `date` 字段后添加：

```java
@Schema(description = "门店ID列表，不传则查全部关联门店")
private List<Long> orgIds;
```

需要添加 `import java.util.List;`（已有则跳过）。

- [ ] **Step 2: OrderSummaryVO 添加 orgName、orgCode 字段**

在 `OrderSummaryVO.java` 的 `orgId` 字段后添加：

```java
/**
 * 门店名称
 */
private String orgName;

/**
 * 门店编码
 */
private String orgCode;
```

- [ ] **Step 3: OrderSalesSummaryServiceImpl 改用 resolveOrgIds + IN 过滤**

将 `getOrderSummaries` 方法从：

```java
@Override
public List<OrderSummaryVO> getOrderSummaries(OrderSummaryQuery query) {
    AuthInfoDTO auth = AuthContextHolder.getAuth();
    LocalDate[] date = query.getDate();
    if (date == null) {
        date = new LocalDate[]{LocalDate.now(), LocalDate.now()};
    }
    List<OrderSalesSummary> summaries = lambdaQuery().eq(OrderSalesSummary::getOrgId, auth.getOrgId())
            .between(OrderSalesSummary::getStatsDate, date[0], date[1])
            .list();
    
    // 转换为VO对象
    return orderSalesSummaryConvert.toVOList(summaries);
}
```

改为：

```java
@Override
public List<OrderSummaryVO> getOrderSummaries(OrderSummaryQuery query) {
    AuthInfoDTO auth = AuthContextHolder.getAuth();
    List<Long> orgIds = sysOrgUserService.resolveOrgIds(auth.getUserId(), auth.getOrgId(), query.getOrgIds());
    LocalDate[] date = query.getDate();
    if (date == null) {
        date = new LocalDate[]{LocalDate.now(), LocalDate.now()};
    }
    List<OrderSalesSummary> summaries = lambdaQuery()
            .in(OrderSalesSummary::getOrgId, orgIds)
            .between(OrderSalesSummary::getStatsDate, date[0], date[1])
            .list();

    List<OrderSummaryVO> voList = orderSalesSummaryConvert.toVOList(summaries);

    // 批量填充门店信息
    if (!voList.isEmpty()) {
        Map<Long, OrgSimpleVO> orgMap = sysOrgService.getOrgSimpleMapByIds(
                voList.stream().map(OrderSummaryVO::getOrgId).collect(Collectors.toSet()));
        voList.forEach(vo -> {
            OrgSimpleVO org = orgMap.get(vo.getOrgId());
            if (org != null) {
                vo.setOrgName(org.getOrgName());
                vo.setOrgCode(org.getOrgCode());
            }
        });
    }
    return voList;
}
```

需要在类中注入 `SysOrgUserService`。当前类使用 `@AllArgsConstructor`，只需添加字段即可：

```java
private final SysOrgUserService sysOrgUserService;
```

需要添加 import：

```java
import org.haut.server.system.service.SysOrgUserService;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import java.util.Map;
import java.util.stream.Collectors;
```

- [ ] **Step 4: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/query/order/OrderSummaryQuery.java pos-common/src/main/java/org/haut/common/domain/vo/order/OrderSummaryVO.java pos-server/src/main/java/org/haut/server/order/service/impl/OrderSalesSummaryServiceImpl.java
git commit -m "feat(order): 销售汇总查询支持多门店过滤"
```

---

### Task 5: 销售明细模块改造

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/query/order/OrderDetailPageQuery.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderDetailVO.java`
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailServiceImpl.java`

- [ ] **Step 1: OrderDetailPageQuery 添加 orgIds 字段**

在 `OrderDetailPageQuery.java` 末尾 `}` 前添加：

```java
@Schema(description = "门店ID列表，不传则查全部关联门店")
private List<Long> orgIds;
```

需要添加 `import java.util.List;`。

- [ ] **Step 2: OrderDetailVO 添加 orgId、orgName、orgCode 字段**

在 `OrderDetailVO.java` 的 `orderStatus` 字段后添加：

```java
@Schema(description = "门店ID")
private Long orgId;

@Schema(description = "门店名称")
private String orgName;

@Schema(description = "门店编码")
private String orgCode;
```

- [ ] **Step 3: OrderDetailServiceImpl 改用 resolveOrgIds + IN 过滤 + 填充门店**

将 `pageQuery` 方法从：

```java
@Override
public PageDTO<OrderDetailVO> pageQuery(OrderDetailPageQuery query) {
    AuthInfoDTO auth = AuthContextHolder.getAuth();
    Page<OrderDetailEntity> page = new Page<>(query.getPageNum(), query.getPageSize());
    LocalDate[] date = query.getDate();

    this.lambdaQuery().eq(query.getUserId() != null, OrderDetailEntity::getUserId, query.getUserId())
            .eq(StringUtils.isNotBlank(query.getBusinessCode()), OrderDetailEntity::getBusinessCode, query.getBusinessCode())
            .eq(OrderDetailEntity::getOrderStatus, OrderStatusEnum.SETTLED.getCode())
            .between(date != null && date.length >= 2 && date[0] != null && date[1] != null, 
                    OrderDetailEntity::getCreateTime, date != null && date.length >= 2 ? date[0] : null,
                    date != null && date.length >= 2 ? date[1] : null)
            .eq(OrderDetailEntity::getOrgId, auth.getOrgId())
            .orderByDesc(OrderDetailEntity::getSettledTime)
            .page(page);
    return PageDTO.create(page, OrderDetailVO.class);
}
```

改为：

```java
@Override
public PageDTO<OrderDetailVO> pageQuery(OrderDetailPageQuery query) {
    AuthInfoDTO auth = AuthContextHolder.getAuth();
    List<Long> orgIds = sysOrgUserService.resolveOrgIds(auth.getUserId(), auth.getOrgId(), query.getOrgIds());
    Page<OrderDetailEntity> page = new Page<>(query.getPageNum(), query.getPageSize());
    LocalDate[] date = query.getDate();

    this.lambdaQuery().eq(query.getUserId() != null, OrderDetailEntity::getUserId, query.getUserId())
            .eq(StringUtils.isNotBlank(query.getBusinessCode()), OrderDetailEntity::getBusinessCode, query.getBusinessCode())
            .eq(OrderDetailEntity::getOrderStatus, OrderStatusEnum.SETTLED.getCode())
            .between(date != null && date.length >= 2 && date[0] != null && date[1] != null,
                    OrderDetailEntity::getCreateTime, date != null && date.length >= 2 ? date[0] : null,
                    date != null && date.length >= 2 ? date[1] : null)
            .in(OrderDetailEntity::getOrgId, orgIds)
            .orderByDesc(OrderDetailEntity::getSettledTime)
            .page(page);

    PageDTO<OrderDetailVO> result = PageDTO.create(page, OrderDetailVO.class);

    // 批量填充门店信息
    List<OrderDetailVO> records = result.getRecords();
    if (records != null && !records.isEmpty()) {
        Set<Long> allOrgIds = page.getRecords().stream()
                .map(OrderDetailEntity::getOrgId).filter(Objects::nonNull).collect(Collectors.toSet());
        if (!allOrgIds.isEmpty()) {
            Map<Long, OrgSimpleVO> orgMap = sysOrgService.getOrgSimpleMapByIds(allOrgIds);
            records.forEach(vo -> {
                OrgSimpleVO org = orgMap.get(page.getRecords().stream()
                        .filter(e -> e.getId().equals(vo.getId())).findFirst()
                        .map(OrderDetailEntity::getOrgId).orElse(null));
                if (org != null) {
                    vo.setOrgId(org.getId());
                    vo.setOrgName(org.getOrgName());
                    vo.setOrgCode(org.getOrgCode());
                }
            });
        }
    }
    return result;
}
```

需要在类中注入 `SysOrgUserService` 和 `SysOrgService`：

```java
private final SysOrgUserService sysOrgUserService;
private final SysOrgService sysOrgService;
```

需要添加 import：

```java
import org.haut.server.system.service.SysOrgUserService;
import org.haut.server.system.service.SysOrgService;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;
```

- [ ] **Step 4: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/query/order/OrderDetailPageQuery.java pos-common/src/main/java/org/haut/common/domain/vo/order/OrderDetailVO.java pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailServiceImpl.java
git commit -m "feat(order): 销售明细查询支持多门店过滤"
```

---

### Task 6: 绩效明细模块改造

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/query/kpi/KpiListQuery.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/kpi/KpiListVO.java`
- Modify: `pos-server/src/main/resources/mapper/kpi/KpiDetailMapper.xml`
- Modify: `pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java`

- [ ] **Step 1: KpiListQuery 改 orgId 为 orgIds**

将 `KpiListQuery.java` 中的：

```java
@Schema(description = "机构ID", hidden = true)
private Long orgId;
```

改为：

```java
@Schema(description = "门店ID列表，不传则查全部关联门店")
private List<Long> orgIds;
```

需要添加 `import java.util.List;`，移除不再需要的 `import lombok.EqualsAndHashCode;`（如无其他地方使用）。

- [ ] **Step 2: KpiListVO 添加 orgId、orgCode 字段**

将 `KpiListVO.java` 中的 `orgName` 保留，在其后添加：

```java
@Schema(description = "门店ID")
private Long orgId;

@Schema(description = "门店编码")
private String orgCode;
```

- [ ] **Step 3: KpiDetailMapper.xml selectKpiList SQL 改 IN 过滤 + 添加字段**

将 `selectKpiList` 中（约27-29行）的：

```xml
<if test="query.orgId != null">
    AND kd.org_id = #{query.orgId}
</if>
```

改为：

```xml
<if test="query.orgIds != null and !query.orgIds.isEmpty()">
    AND kd.org_id IN
    <foreach collection="query.orgIds" item="id" open="(" separator="," close=")">
        #{id}
    </foreach>
</if>
```

在 SELECT 中 `so.org_name` 后添加：

```sql
, so.id AS orgId
, so.org_code AS orgCode
```

- [ ] **Step 4: KpiDetailServiceImpl getKpiList 改用 resolveOrgIds**

将 `getKpiList` 方法中的：

```java
AuthInfoDTO auth = AuthContextHolder.getAuth();
query.setOrgId(auth.getOrgId());
```

改为：

```java
AuthInfoDTO auth = AuthContextHolder.getAuth();
List<Long> orgIds = sysOrgUserService.resolveOrgIds(auth.getUserId(), auth.getOrgId(), query.getOrgIds());
query.setOrgIds(orgIds);
```

需要在类中注入 `SysOrgUserService`：

```java
private final SysOrgUserService sysOrgUserService;
```

需要添加 `import org.haut.server.system.service.SysOrgUserService;` 和 `import java.util.List;`。

- [ ] **Step 5: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/query/kpi/KpiListQuery.java pos-common/src/main/java/org/haut/common/domain/vo/kpi/KpiListVO.java pos-server/src/main/resources/mapper/kpi/KpiDetailMapper.xml pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java
git commit -m "feat(kpi): 绩效明细查询支持多门店过滤"
```

---

### Task 7: 绩效汇总模块改造

**Files:**
- Modify: `pos-common/src/main/java/org/haut/common/domain/query/kpi/KpiSummaryQuery.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/kpi/KpiSummaryVO.java`
- Modify: `pos-server/src/main/resources/mapper/kpi/KpiDetailMapper.xml`
- Modify: `pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java`

- [ ] **Step 1: KpiSummaryQuery 改 orgId 为 orgIds**

将 `KpiSummaryQuery.java` 中的：

```java
@Schema(description = "机构ID", hidden = true)
private Long orgId;
```

改为：

```java
@Schema(description = "门店ID列表，不传则查全部关联门店")
private List<Long> orgIds;
```

需要添加 `import java.util.List;`。

- [ ] **Step 2: KpiSummaryVO 添加 orgCode 字段**

在 `KpiSummaryVO.java` 的 `orgName` 字段后添加：

```java
@Schema(description = "门店编码")
private String orgCode;
```

- [ ] **Step 3: KpiDetailMapper.xml selectKpiSummary SQL 改 IN 过滤 + 添加字段**

将 `selectKpiSummary` 中（约84-86行）的：

```xml
<if test="orgId != null">
    AND kd.org_id = #{orgId}
</if>
```

改为：

```xml
<if test="orgIds != null and !orgIds.isEmpty()">
    AND kd.org_id IN
    <foreach collection="orgIds" item="id" open="(" separator="," close=")">
        #{id}
    </foreach>
</if>
```

在 SELECT 中 `so.org_name AS orgName,` 后添加：

```sql
so.org_code AS orgCode,
```

- [ ] **Step 4: KpiDetailServiceImpl getKpiSummary 改用 resolveOrgIds**

将 `getKpiSummary` 方法中的：

```java
AuthInfoDTO auth = AuthContextHolder.getAuth();
kpiListQuery.setOrgId(auth.getOrgId());
```

改为：

```java
AuthInfoDTO auth = AuthContextHolder.getAuth();
List<Long> orgIds = sysOrgUserService.resolveOrgIds(auth.getUserId(), auth.getOrgId(), kpiListQuery.getOrgIds());
kpiListQuery.setOrgIds(orgIds);
```

同时需要修改 Mapper 接口方法签名。查看 `KpiDetailMapper.java`，确认 `selectKpiSummary` 的参数绑定方式。当前使用 `@Param` 绑定了各个字段（orgId 等），改为 orgIds 后需要确保 XML 中的参数引用正确。

当前 `selectKpiSummary` 方法签名大约为：

```java
List<KpiSummaryVO> selectKpiSummary(KpiSummaryQuery query);
```

因为参数是整个 query 对象，XML 中的 `orgId`/`orgIds` 直接引用 query 对象的字段。需要确认 XML 的参数引用——当前 XML 中直接用 `orgId` 而非 `query.orgId`，说明参数可能是通过 `@Param` 逐个传递或者 query 对象属性被直接解构。实际需要检查 KpiDetailMapper.java 的 `selectKpiSummary` 方法签名。

如果当前 XML 中使用 `#{orgId}` 直接引用（非 `#{query.orgId}`），则需要把 `selectKpiSummary` 的参数保持为 query 对象，XML 改为 `#{orgIds}` 对应 query 中的 `orgIds` 字段即可。

- [ ] **Step 5: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/domain/query/kpi/KpiSummaryQuery.java pos-common/src/main/java/org/haut/common/domain/vo/kpi/KpiSummaryVO.java pos-server/src/main/resources/mapper/kpi/KpiDetailMapper.xml pos-server/src/main/java/org/haut/server/kpi/service/impl/KpiDetailServiceImpl.java
git commit -m "feat(kpi): 绩效汇总查询支持多门店过滤"
```

---

### Task 8: 编译验证

- [ ] **Step 1: 全量编译**

```bash
cd /d/Codes/pos/pos-java && mvn clean compile -DskipTests
```

Expected: BUILD SUCCESS

- [ ] **Step 2: 修复编译错误（如有）**

根据编译输出修复遗漏的 import 或类型不匹配问题。
