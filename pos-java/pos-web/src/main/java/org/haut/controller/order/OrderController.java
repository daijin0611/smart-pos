package org.haut.controller.order;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.order.OrderCreateDTO;
import org.haut.common.domain.dto.order.OrderSettleDTO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.order.OrderCreateVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;

/**
 * 订单管理控制器
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Slf4j
@RestController
@RequestMapping("/order")
@RequiredArgsConstructor
@Validated
@Tag(name = "订单管理", description = "订单相关接口")
public class OrderController {
    
    private final OrderInfoService orderInfoService;
    private final OrderDetailService orderDetailService;
    // ==========收银相关接口==========
    @PostMapping("/add-order")
    @Operation(summary = "开单", description = "选择床位进行开单的方法")
    public JsonVO<OrderCreateVO> addOrder(@Valid @RequestBody OrderCreateDTO createOrderDTO) {
        log.info("创建订单请求：{}", createOrderDTO);
        return JsonVO.success(orderInfoService.addOrderWithBed(createOrderDTO));
    }
    
    @PostMapping("/settle-order")
    @Operation(summary = "结算订单", description = "对订单进行结算操作")
    public JsonVO<OrderInfoVO> settleOrder(@Valid @RequestBody OrderSettleDTO settleOrderDTO) {
        log.info("结算订单请求：{}", settleOrderDTO);
        OrderInfoVO orderInfo = orderInfoService.settleOrder(settleOrderDTO);
        return JsonVO.success(orderInfo);
    }
    @GetMapping("/query-by-id/{orderId}")
    @Operation(summary = "根据订单ID查询订单信息", description = "根据订单ID查询订单详细信息，包含订单明细")
    public JsonVO<OrderInfoVO> queryById(@PathVariable Long orderId) {
        log.info("查询订单信息，订单ID：{}", orderId);
        OrderInfoVO orderInfo = orderInfoService.queryById(orderId);
        return JsonVO.success(orderInfo);
    }


    // ==========销售数据相关接口==========
}