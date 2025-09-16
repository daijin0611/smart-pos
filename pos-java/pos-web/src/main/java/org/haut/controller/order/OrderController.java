package org.haut.controller.order;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.CreateOrderDTO;
import org.haut.common.domain.dto.order.SettleOrderDTO;
import org.haut.common.domain.query.order.OrderInfoQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.order.OrderCreateVO;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.util.List;

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
    @Operation(summary = "创建订单", description = "创建新的订单，包含订单明细")
    public JsonVO<OrderCreateVO> addOrder(@Valid @RequestBody CreateOrderDTO createOrderDTO) {
        log.info("创建订单请求：{}", createOrderDTO);
        return JsonVO.success(orderInfoService.addOrderWithBed(createOrderDTO));
    }
    
    @PostMapping("/settle-order")
    @Operation(summary = "结算订单", description = "对订单进行结算操作")
    public JsonVO<OrderInfoVO> settleOrder(@Valid @RequestBody SettleOrderDTO settleOrderDTO) {
        log.info("结算订单请求：{}", settleOrderDTO);
        OrderInfoVO orderInfo = orderInfoService.settleOrder(settleOrderDTO);
        return JsonVO.success(orderInfo);
    }

    // ==========销售数据相关接口==========
}