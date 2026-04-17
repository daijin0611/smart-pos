# 订单项目计时功能实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 POS 系统的订单服务项目添加计时功能，支持手动开始/暂停/恢复/停止，到期自动结束和到期前提醒。

**Architecture:** 在 order_detail 表增加计时字段，通过 Spring Scheduled Task 定时扫描到期条件。计时 API 放在独立的 OrderTimerController 中，Service 层在 OrderDetailService 中扩展。

**Tech Stack:** Java 17, Spring Boot 3.5.0, MyBatis-Plus 3.5.11, MySQL, Spring Scheduling

---

## File Structure

### 新增文件
- `sql/V1.0.15__add_order_detail_timer_fields.sql` — 数据库迁移脚本
- `pos-common/src/main/java/org/haut/common/enums/TimerStatusEnum.java` — 计时状态枚举
- `pos-server/src/main/java/org/haut/server/order/task/TimerScheduleTask.java` — 计时定时任务
- `pos-web/src/main/java/org/haut/controller/order/OrderTimerController.java` — 计时 API 控制器

### 修改文件
- `pos-server/src/main/java/org/haut/server/order/entity/OrderDetailEntity.java` — 增加计时字段
- `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderDetailVO.java` — VO 增加计时字段
- `pos-server/src/main/java/org/haut/server/order/service/OrderDetailService.java` — 增加计时方法接口
- `pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailServiceImpl.java` — 实现计时方法
- `pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java` — 结算/取消时联动结束计时

---

### Task 1: 数据库迁移脚本

**Files:**
- Create: `sql/V1.0.15__add_order_detail_timer_fields.sql`

- [ ] **Step 1: 创建迁移脚本**

```sql
-- V1.0.15__add_order_detail_timer_fields.sql
ALTER TABLE order_detail
    ADD COLUMN timer_status TINYINT DEFAULT 0 COMMENT '计时状态：0未开始,1进行中,2已暂停,3已结束',
    ADD COLUMN timer_start_time DATETIME DEFAULT NULL COMMENT '计时开始时间',
    ADD COLUMN timer_end_time DATETIME DEFAULT NULL COMMENT '预计结束时间',
    ADD COLUMN timer_paused_duration INT DEFAULT 0 COMMENT '累计暂停时长(秒)',
    ADD COLUMN timer_last_pause_time DATETIME DEFAULT NULL COMMENT '最近暂停开始时间',
    ADD COLUMN actual_duration INT DEFAULT NULL COMMENT '实际服务时长(秒)',
    ADD COLUMN timer_warned TINYINT DEFAULT 0 COMMENT '是否已发送到期提醒';
```

- [ ] **Step 2: 在测试环境执行迁移**

Run:
```bash
mysql -h 82.156.232.52 -P 123456 -u pos-test --default-character-set=utf8mb4 pos < sql/V1.0.15__add_order_detail_timer_fields.sql
```

- [ ] **Step 3: Commit**

```bash
git add sql/V1.0.15__add_order_detail_timer_fields.sql
git commit -m "feat(order): 添加订单明细计时字段迁移脚本"
```

---

### Task 2: 计时状态枚举 + Entity 字段

**Files:**
- Create: `pos-common/src/main/java/org/haut/common/enums/TimerStatusEnum.java`
- Modify: `pos-server/src/main/java/org/haut/server/order/entity/OrderDetailEntity.java`
- Modify: `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderDetailVO.java`

- [ ] **Step 1: 创建 TimerStatusEnum**

```java
package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 计时状态枚举
 */
@Getter
@AllArgsConstructor
public enum TimerStatusEnum {
    NOT_STARTED(0, "未开始"),
    RUNNING(1, "进行中"),
    PAUSED(2, "已暂停"),
    FINISHED(3, "已结束");

    private final Integer code;
    private final String message;

    public static TimerStatusEnum getByCode(Integer code) {
        for (TimerStatusEnum value : TimerStatusEnum.values()) {
            if (value.code.equals(code)) {
                return value;
            }
        }
        return null;
    }
}
```

- [ ] **Step 2: 在 OrderDetailEntity 中增加计时字段**

在 `pos-server/src/main/java/org/haut/server/order/entity/OrderDetailEntity.java` 的 `orgId` 字段之后添加：

```java
    /**
     * 计时状态（0未开始,1进行中,2已暂停,3已结束）
     */
    @Schema(description = "计时状态（0未开始,1进行中,2已暂停,3已结束）")
    private Integer timerStatus;

    /**
     * 计时开始时间
     */
    @Schema(description = "计时开始时间")
    private Date timerStartTime;

    /**
     * 预计结束时间
     */
    @Schema(description = "预计结束时间")
    private Date timerEndTime;

    /**
     * 累计暂停时长（秒）
     */
    @Schema(description = "累计暂停时长(秒)")
    private Integer timerPausedDuration;

    /**
     * 最近一次暂停开始时间
     */
    @Schema(description = "最近暂停开始时间")
    private Date timerLastPauseTime;

    /**
     * 实际服务时长（秒）
     */
    @Schema(description = "实际服务时长(秒)")
    private Integer actualDuration;

    /**
     * 是否已发送到期提醒
     */
    @Schema(description = "是否已发送到期提醒")
    private Integer timerWarned;
```

- [ ] **Step 3: 在 OrderDetailVO 中增加计时字段**

在 `pos-common/src/main/java/org/haut/common/domain/vo/order/OrderDetailVO.java` 中增加相同的计时字段（复制 Entity 中的计时字段，包含 @Schema 注解）。

- [ ] **Step 4: Commit**

```bash
git add pos-common/src/main/java/org/haut/common/enums/TimerStatusEnum.java pos-server/src/main/java/org/haut/server/order/entity/OrderDetailEntity.java pos-common/src/main/java/org/haut/common/domain/vo/order/OrderDetailVO.java
git commit -m "feat(order): 添加计时状态枚举和实体字段"
```

---

### Task 3: Service 层计时方法

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/OrderDetailService.java`
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailServiceImpl.java`

- [ ] **Step 1: 在 OrderDetailService 接口中增加计时方法**

```java
    /**
     * 开始计时
     * @param detailId 订单明细ID
     */
    void startTimer(Long detailId);

    /**
     * 暂停计时
     * @param detailId 订单明细ID
     */
    void pauseTimer(Long detailId);

    /**
     * 恢复计时
     * @param detailId 订单明细ID
     */
    void resumeTimer(Long detailId);

    /**
     * 手动停止计时
     * @param detailId 订单明细ID
     */
    void stopTimer(Long detailId);

    /**
     * 结束指定订单下所有未结束的计时
     * @param orderId 订单ID
     */
    void stopAllTimersByOrderId(Long orderId);
```

- [ ] **Step 2: 在 OrderDetailServiceImpl 中实现 startTimer**

在 `OrderDetailServiceImpl` 中注入 `OrderInfoMapper`（已存在）。添加方法：

```java
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startTimer(Long detailId) {
        OrderDetailEntity detail = this.getById(detailId);
        if (detail == null) {
            throw new BusinessException("订单明细不存在");
        }

        // 校验计时状态
        if (detail.getTimerStatus() != null && !TimerStatusEnum.NOT_STARTED.getCode().equals(detail.getTimerStatus())) {
            throw new BusinessException("当前状态不允许开始计时");
        }

        // 校验订单状态
        OrderInfoEntity order = orderInfoMapper.selectById(detail.getOrderId());
        if (order == null || !OrderStatusEnum.UNSETTLED.getCode().equals(order.getOrderStatus())) {
            throw new BusinessException("订单已结算或已取消，无法开始计时");
        }

        // 只有服务类型（detailType=1）才需要计时
        if (!ServiceTypeEnum.SERVER.getValue().equals(detail.getDetailType())) {
            throw new BusinessException("仅服务项目支持计时");
        }

        // 获取服务项目标准时长
        ServerItem serverItem = serverItemService.getById(detail.getBid());
        if (serverItem == null || serverItem.getServerTime() == null || serverItem.getServerTime() <= 0) {
            throw new BusinessException("服务项目未配置服务时长");
        }

        Date now = new Date();
        long endTimeMs = now.getTime() + (long) serverItem.getServerTime() * 60 * 1000;

        detail.setTimerStatus(TimerStatusEnum.RUNNING.getCode());
        detail.setTimerStartTime(now);
        detail.setTimerEndTime(new Date(endTimeMs));
        detail.setTimerPausedDuration(0);
        detail.setTimerWarned(0);
        this.updateById(detail);

        log.info("开始计时，明细ID：{}，服务时长：{}分钟，预计结束：{}", detailId, serverItem.getServerTime(), new Date(endTimeMs));
    }
```

- [ ] **Step 3: 实现 pauseTimer**

```java
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void pauseTimer(Long detailId) {
        OrderDetailEntity detail = this.getById(detailId);
        if (detail == null) {
            throw new BusinessException("订单明细不存在");
        }

        if (!TimerStatusEnum.RUNNING.getCode().equals(detail.getTimerStatus())) {
            throw new BusinessException("当前状态不允许暂停");
        }

        detail.setTimerStatus(TimerStatusEnum.PAUSED.getCode());
        detail.setTimerLastPauseTime(new Date());
        this.updateById(detail);

        log.info("暂停计时，明细ID：{}", detailId);
    }
```

- [ ] **Step 4: 实现 resumeTimer**

```java
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void resumeTimer(Long detailId) {
        OrderDetailEntity detail = this.getById(detailId);
        if (detail == null) {
            throw new BusinessException("订单明细不存在");
        }

        if (!TimerStatusEnum.PAUSED.getCode().equals(detail.getTimerStatus())) {
            throw new BusinessException("当前状态不允许恢复");
        }

        Date now = new Date();
        // 计算本次暂停时长（秒）
        long pauseDurationSec = (now.getTime() - detail.getTimerLastPauseTime().getTime()) / 1000;
        int totalPaused = (detail.getTimerPausedDuration() != null ? detail.getTimerPausedDuration() : 0) + (int) pauseDurationSec;

        // 延长预计结束时间
        long newEndTimeMs = detail.getTimerEndTime().getTime() + pauseDurationSec * 1000;

        detail.setTimerStatus(TimerStatusEnum.RUNNING.getCode());
        detail.setTimerPausedDuration(totalPaused);
        detail.setTimerLastPauseTime(null);
        detail.setTimerEndTime(new Date(newEndTimeMs));
        this.updateById(detail);

        log.info("恢复计时，明细ID：{}，本次暂停{}秒，累计暂停{}秒", detailId, pauseDurationSec, totalPaused);
    }
```

- [ ] **Step 5: 实现 stopTimer**

```java
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void stopTimer(Long detailId) {
        OrderDetailEntity detail = this.getById(detailId);
        if (detail == null) {
            throw new BusinessException("订单明细不存在");
        }

        if (!TimerStatusEnum.RUNNING.getCode().equals(detail.getTimerStatus())
                && !TimerStatusEnum.PAUSED.getCode().equals(detail.getTimerStatus())) {
            throw new BusinessException("当前状态不允许停止");
        }

        Date now = new Date();
        int totalPaused = detail.getTimerPausedDuration() != null ? detail.getTimerPausedDuration() : 0;

        // 如果处于暂停状态，加上本次暂停时长
        if (TimerStatusEnum.PAUSED.getCode().equals(detail.getTimerStatus()) && detail.getTimerLastPauseTime() != null) {
            totalPaused += (int) ((now.getTime() - detail.getTimerLastPauseTime().getTime()) / 1000);
        }

        int actualDuration = (int) ((now.getTime() - detail.getTimerStartTime().getTime()) / 1000) - totalPaused;

        detail.setTimerStatus(TimerStatusEnum.FINISHED.getCode());
        detail.setTimerPausedDuration(totalPaused);
        detail.setTimerLastPauseTime(null);
        detail.setActualDuration(Math.max(actualDuration, 0));
        detail.setTimerEndTime(now);
        this.updateById(detail);

        log.info("停止计时，明细ID：{}，实际服务时长：{}秒", detailId, actualDuration);
    }
```

- [ ] **Step 6: 实现 stopAllTimersByOrderId**

```java
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void stopAllTimersByOrderId(Long orderId) {
        List<OrderDetailEntity> details = this.lambdaQuery()
                .eq(OrderDetailEntity::getOrderId, orderId)
                .in(OrderDetailEntity::getTimerStatus,
                        TimerStatusEnum.RUNNING.getCode(), TimerStatusEnum.PAUSED.getCode())
                .list();

        if (details.isEmpty()) {
            return;
        }

        Date now = new Date();
        for (OrderDetailEntity detail : details) {
            int totalPaused = detail.getTimerPausedDuration() != null ? detail.getTimerPausedDuration() : 0;

            if (TimerStatusEnum.PAUSED.getCode().equals(detail.getTimerStatus()) && detail.getTimerLastPauseTime() != null) {
                totalPaused += (int) ((now.getTime() - detail.getTimerLastPauseTime().getTime()) / 1000);
            }

            int actualDuration = detail.getTimerStartTime() != null
                    ? (int) ((now.getTime() - detail.getTimerStartTime().getTime()) / 1000) - totalPaused
                    : 0;

            detail.setTimerStatus(TimerStatusEnum.FINISHED.getCode());
            detail.setTimerPausedDuration(totalPaused);
            detail.setTimerLastPauseTime(null);
            detail.setActualDuration(Math.max(actualDuration, 0));
            detail.setTimerEndTime(now);
        }

        this.updateBatchById(details);
        log.info("批量停止计时，订单ID：{}，停止{}个计时", orderId, details.size());
    }
```

- [ ] **Step 7: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/OrderDetailService.java pos-server/src/main/java/org/haut/server/order/service/impl/OrderDetailServiceImpl.java
git commit -m "feat(order): 实现订单明细计时Service方法"
```

---

### Task 4: 结算/取消联动

**Files:**
- Modify: `pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java`

- [ ] **Step 1: 在 OrderInfoServiceImpl 中注入 OrderDetailService**

OrderInfoServiceImpl 已通过构造器注入了其他服务。如果 `orderDetailService` 尚未注入，在成员变量区域添加：

```java
private final OrderDetailService orderDetailService;
```

（注意：检查是否已存在此注入，避免重复。如果 OrderInfoServiceImpl 已经注入了 OrderDetailService，则跳过此步骤。）

- [ ] **Step 2: 在 settleOrder 方法中添加计时联动**

在 `settleOrder` 方法中，更新床位状态为空闲之后（`roomBedService.lambdaUpdate()...` 之后），添加：

```java
        // 结束所有未结束的计时
        orderDetailService.stopAllTimersByOrderId(order.getId());
```

- [ ] **Step 3: 在 cancelOrder 方法中添加计时联动**

在 `cancelOrder` 方法中，更新床位状态为空闲之后，添加同样的调用：

```java
        // 结束所有未结束的计时
        orderDetailService.stopAllTimersByOrderId(orderId);
```

- [ ] **Step 4: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/service/impl/OrderInfoServiceImpl.java
git commit -m "feat(order): 结算和取消订单时联动停止计时"
```

---

### Task 5: Controller 层

**Files:**
- Create: `pos-web/src/main/java/org/haut/controller/order/OrderTimerController.java`

- [ ] **Step 1: 创建 OrderTimerController**

```java
package org.haut.controller.order;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.order.service.OrderDetailService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 订单计时控制器
 */
@Slf4j
@RestController
@RequestMapping("/order/detail/timer")
@RequiredArgsConstructor
@Validated
@Tag(name = "订单计时", description = "订单服务项目计时相关接口")
public class OrderTimerController {

    private final OrderDetailService orderDetailService;

    @PostMapping("/start/{detailId}")
    @Operation(summary = "开始计时", description = "手动开始订单服务项目的计时")
    public JsonVO<String> startTimer(@PathVariable Long detailId) {
        log.info("开始计时，明细ID：{}", detailId);
        orderDetailService.startTimer(detailId);
        return JsonVO.success("计时已开始");
    }

    @PostMapping("/pause/{detailId}")
    @Operation(summary = "暂停计时", description = "暂停订单服务项目的计时")
    public JsonVO<String> pauseTimer(@PathVariable Long detailId) {
        log.info("暂停计时，明细ID：{}", detailId);
        orderDetailService.pauseTimer(detailId);
        return JsonVO.success("计时已暂停");
    }

    @PostMapping("/resume/{detailId}")
    @Operation(summary = "恢复计时", description = "恢复订单服务项目的计时")
    public JsonVO<String> resumeTimer(@PathVariable Long detailId) {
        log.info("恢复计时，明细ID：{}", detailId);
        orderDetailService.resumeTimer(detailId);
        return JsonVO.success("计时已恢复");
    }

    @PostMapping("/stop/{detailId}")
    @Operation(summary = "手动停止计时", description = "手动停止订单服务项目的计时")
    public JsonVO<String> stopTimer(@PathVariable Long detailId) {
        log.info("手动停止计时，明细ID：{}", detailId);
        orderDetailService.stopTimer(detailId);
        return JsonVO.success("计时已停止");
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add pos-web/src/main/java/org/haut/controller/order/OrderTimerController.java
git commit -m "feat(order): 添加订单计时API控制器"
```

---

### Task 6: 定时任务

**Files:**
- Create: `pos-server/src/main/java/org/haut/server/order/task/TimerScheduleTask.java`

- [ ] **Step 1: 创建 TimerScheduleTask**

```java
package org.haut.server.order.task;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.enums.TimerStatusEnum;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.service.OrderDetailService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

/**
 * 订单计时定时任务
 * 每30秒扫描一次，处理到期自动结束和到期前5分钟提醒
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class TimerScheduleTask {

    private final OrderDetailService orderDetailService;

    /**
     * 到期自动结束计时
     * 每30秒扫描 timer_status=1 且 timer_end_time <= NOW() 的记录
     */
    @Scheduled(fixedRate = 30000)
    public void expireTimers() {
        Date now = new Date();

        List<OrderDetailEntity> expired = orderDetailService.lambdaQuery()
                .eq(OrderDetailEntity::getTimerStatus, TimerStatusEnum.RUNNING.getCode())
                .le(OrderDetailEntity::getTimerEndTime, now)
                .list();

        if (expired.isEmpty()) {
            return;
        }

        for (OrderDetailEntity detail : expired) {
            int actualDuration = (int) ((now.getTime() - detail.getTimerStartTime().getTime()) / 1000)
                    - (detail.getTimerPausedDuration() != null ? detail.getTimerPausedDuration() : 0);

            detail.setTimerStatus(TimerStatusEnum.FINISHED.getCode());
            detail.setActualDuration(Math.max(actualDuration, 0));
            detail.setTimerEndTime(now);
        }

        orderDetailService.updateBatchById(expired);
        log.info("到期自动结束计时，处理{}条记录", expired.size());
    }

    /**
     * 到期前5分钟提醒标记
     * 每30秒扫描 timer_status=1 且 timer_warned=0 且 timer_end_time <= NOW()+5min 的记录
     */
    @Scheduled(fixedRate = 30000)
    public void warnTimers() {
        Date now = new Date();
        Date warnThreshold = new Date(now.getTime() + 5 * 60 * 1000);

        boolean updated = orderDetailService.lambdaUpdate()
                .eq(OrderDetailEntity::getTimerStatus, TimerStatusEnum.RUNNING.getCode())
                .eq(OrderDetailEntity::getTimerWarned, 0)
                .le(OrderDetailEntity::getTimerEndTime, warnThreshold)
                .gt(OrderDetailEntity::getTimerEndTime, now) // 排除已到期的（由 expireTimers 处理）
                .set(OrderDetailEntity::getTimerWarned, 1)
                .update();

        if (updated) {
            log.info("标记到期前5分钟提醒");
        }
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add pos-server/src/main/java/org/haut/server/order/task/TimerScheduleTask.java
git commit -m "feat(order): 添加计时定时任务（到期自动结束+到期提醒）"
```

---

### Task 7: 编译验证

- [ ] **Step 1: 编译项目**

Run:
```bash
cd /e/Codes/pos/pos-java && mvn clean compile -DskipTests
```

Expected: BUILD SUCCESS

- [ ] **Step 2: 修复编译错误（如有）**

检查并修复任何编译错误，常见问题：
- import 缺失：确保 TimerStatusEnum 被正确导入
- 方法签名不匹配：确保接口和实现的方法签名一致
- 循环依赖：如果 OrderInfoServiceImpl 和 OrderDetailService 存在循环注入，需要检查

- [ ] **Step 3: 启动应用验证**

Run:
```bash
cd /e/Codes/pos/pos-java && mvn install -DskipTests && mvn spring-boot:run -pl pos-web -Dspring-boot.run.profiles=dev
```

验证：
- 应用正常启动
- Swagger UI 中出现"订单计时"分组和 4 个 API
- `GET /order/detail/timer/start/{detailId}` 等 4 个端点可见
