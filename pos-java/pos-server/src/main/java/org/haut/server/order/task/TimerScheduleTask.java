package org.haut.server.order.task;

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
            int totalPaused = detail.getTimerPausedDuration() != null ? detail.getTimerPausedDuration() : 0;
            int actualDuration = (int) ((now.getTime() - detail.getTimerStartTime().getTime()) / 1000) - totalPaused;

            detail.setTimerStatus(TimerStatusEnum.FINISHED.getCode());
            detail.setActualDuration(Math.max(actualDuration, 0));
            detail.setTimerEndTime(now);
        }

        orderDetailService.updateBatchById(expired);
        log.info("到期自动结束计时，处理{}条记录", expired.size());
    }

    /**
     * 到期前5分钟提醒标记
     */
    @Scheduled(fixedRate = 30000)
    public void warnTimers() {
        Date now = new Date();
        Date warnThreshold = new Date(now.getTime() + 5 * 60 * 1000);

        boolean updated = orderDetailService.lambdaUpdate()
                .eq(OrderDetailEntity::getTimerStatus, TimerStatusEnum.RUNNING.getCode())
                .eq(OrderDetailEntity::getTimerWarned, 0)
                .le(OrderDetailEntity::getTimerEndTime, warnThreshold)
                .gt(OrderDetailEntity::getTimerEndTime, now)
                .set(OrderDetailEntity::getTimerWarned, 1)
                .update();

        if (updated) {
            log.info("标记到期前5分钟提醒");
        }
    }
}
