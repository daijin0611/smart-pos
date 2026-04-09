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
