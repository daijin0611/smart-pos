package org.haut.controller.order;

import cn.hutool.json.JSONUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.order.*;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.order.OrderCreateVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.common.domain.vo.order.OrderReceiptVO;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 订单管理控制器
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-10-01
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
    public JsonVO<OrderCreateVO> addOrder(@Validated @RequestBody OrderCreateDTO createOrderDTO) {
        log.info("创建订单请求：\n{}", JSONUtil.parse(createOrderDTO).toStringPretty());
        return JsonVO.success(orderInfoService.addOrderWithBed(createOrderDTO));
    }

    @PostMapping("/settle-order")
    @Operation(summary = "结算", description = "对订单进行结算操作")
    public JsonVO<OrderReceiptVO> settleOrder(@Validated @RequestBody OrderSettleDTO settleOrderDTO) {
        log.info("结算订单请求：{}", settleOrderDTO);
        Long orderId = orderInfoService.settleOrder(settleOrderDTO);
        OrderReceiptVO receipt = orderInfoService.getReceiptByOrderId(orderId);
        return JsonVO.success(receipt);
    }


    @PutMapping("/cancel-order/{orderId}")
    @Operation(summary = "取消订单", description = "取消一个未结算的订单，将订单状态修改为已取消。")
    public JsonVO<String> cancelOrder(@PathVariable Long orderId) {
        log.info("删除订单请求：{}", orderId);
        return JsonVO.success(orderInfoService.cancelOrder(orderId));
    }

    @PostMapping("/add-detail/{orderId}")
    @Operation(summary = "添加订单明细", description = "为指定订单添加订单明细的方法")
    public JsonVO<String> addDetail(
            @Validated @RequestBody OrderDetailCreateDTO dto,
            @PathVariable Long orderId){
        log.info("添加订单明细请求：{}", dto);
        return JsonVO.success(orderDetailService.addDetails(dto,orderId));
    }

    @DeleteMapping("/delete-detail/{detailId}")
    @Operation(summary = "删除订单明细", description = "删除订单明细的方法")
    public JsonVO<String> deleteDetail(@PathVariable Long detailId) {
        log.info("删除订单明细请求：{}", detailId);
        orderDetailService.removeById(detailId);
        return JsonVO.success();
    }


    @GetMapping("/query-by-id/{orderId}")
    @Operation(summary = "根据订单ID查询订单信息", description = "根据订单ID查询订单详细信息，包含订单明细")
    public JsonVO<OrderReceiptVO> queryById(@PathVariable Long orderId) {
        log.info("查询订单信息，订单ID：{}", orderId);
        OrderReceiptVO receipt = orderInfoService.getReceiptByOrderId(orderId);
        return JsonVO.success(receipt);
    }

    @GetMapping("/query-by-bed-id/{bedId}")
    @Operation(summary = "根据床位ID查询订单信息", description = "根据床位ID查询订单详细信息，包含订单明细")
    public JsonVO<OrderInfoVO> queryByBedId(@PathVariable Long bedId) {
        log.info("查询订单信息，床位ID：{}", bedId);
        OrderInfoVO orderInfo = orderInfoService.queryByBedId(bedId);
        return JsonVO.success(orderInfo);
    }

    @GetMapping("/query-by-order-code/{orderCode}")
    @Operation(summary = "根据订单编号查询订单信息", description = "根据订单编号查询订单详细信息，包含订单明细")
    public JsonVO<OrderInfoVO> queryByOrderNo(@PathVariable String orderCode) {
        log.info("查询订单信息，订单编号：{}", orderCode);
        OrderInfoVO orderInfo = orderInfoService.queryByOrderCode(orderCode);
        return JsonVO.success(orderInfo);
    }

    /**
     * 订单冲正
     * 对已结算订单进行冲正操作，将订单状态修改为已冲正。
     * @param dto 冲正请求对象
     * @return 处理结果
     */
    @PostMapping("/roll-back")
    @Operation(summary = "订单冲正", description = "对已结算订单进行冲正操作，将订单状态修改为已冲正")
    public JsonVO<String> rollBackOrder(@Validated @RequestBody OrderRollBackDTO dto) {
        log.info("订单冲正请求：{}", dto);
        orderInfoService.rollBackOrder(dto);
        return JsonVO.success();
    }

    /**
     * 对单
     * 对已结算订单进行对单操作，更新订单状态为已对单。
     * @param dto 对单请求对象
     * @return 处理结果
     */
    @PostMapping("/reconcile-order")
    @Operation(summary = "订单对单", description = "确认对单")
    public JsonVO<String> reconcileOrder(@Validated @RequestBody OrderReconcileDTO dto) {
        log.info("订单对单请求：{}", dto);
        orderInfoService.reconcileOrder(dto);
        return JsonVO.success();
    }
}
