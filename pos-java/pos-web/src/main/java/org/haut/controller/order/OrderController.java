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
    
    @PostMapping("/query-page")
    @Operation(summary = "分页查询订单", description = "根据条件分页查询订单信息")
    public JsonVO<PageDTO<OrderInfoVO>> queryOrderPage(
            @Parameter(description = "页码", example = "1") @RequestParam(defaultValue = "1") Integer pageNum,
            @Parameter(description = "每页大小", example = "10") @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestBody(required = false) OrderInfoQuery query) {
        
        Page<OrderInfoEntity> page = new Page<>(pageNum, pageSize);
        IPage<OrderInfoVO> result = orderInfoService.queryOrderInfoPage(page, query);
        
        PageDTO<OrderInfoVO> pageDTO = new PageDTO<>();
//        pageDTO.setRows(result.getRecords())
//                .setTotal(result.getTotal())
//                .setSize(result.getSize())
//                .setCurrent(result.getCurrent())
//                .setPages(result.getPages());
        
        return JsonVO.success(pageDTO);
    }
    
    @PostMapping("/query-list")
    @Operation(summary = "查询订单列表", description = "根据条件查询订单信息列表")
    public JsonVO<List<OrderInfoVO>> queryOrderList(@RequestBody(required = false) OrderInfoQuery query) {
        List<OrderInfoVO> orderList = orderInfoService.queryOrderInfoList(query);
        return JsonVO.success(orderList);
    }
    
    @GetMapping("/query-by-id")
    @Operation(summary = "根据ID查询订单", description = "根据订单ID查询订单详情")
    public JsonVO<OrderInfoVO> queryOrderById(
            @Parameter(description = "订单ID", required = true) @RequestParam @NotNull Long orderId) {
        OrderInfoVO orderInfo = orderInfoService.queryOrderById(orderId);
        return JsonVO.success(orderInfo);
    }
    
    @GetMapping("/query-by-no")
    @Operation(summary = "根据订单号查询订单", description = "根据订单号查询订单详情")
    public JsonVO<OrderInfoVO> queryOrderByNo(
            @Parameter(description = "订单号", required = true) @RequestParam @NotNull String orderNo) {
        OrderInfoVO orderInfo = orderInfoService.queryOrderByNo(orderNo);
        return JsonVO.success(orderInfo);
    }
    
    @GetMapping("/query-by-vip-id")
    @Operation(summary = "根据会员ID查询订单", description = "根据会员ID查询订单列表")
    public JsonVO<List<OrderInfoVO>> queryOrderByVipId(
            @Parameter(description = "会员ID", required = true) @RequestParam @NotNull Long vipId) {
        List<OrderInfoVO> orderList = orderInfoService.queryOrderByVipId(vipId);
        return JsonVO.success(orderList);
    }
    
    @GetMapping("/query-unsettled-by-bed-id")
    @Operation(summary = "根据床位ID查询未结算订单", description = "根据床位ID查询未结算的订单列表")
    public JsonVO<List<OrderInfoVO>> queryUnsettledOrderByBedId(
            @Parameter(description = "床位ID", required = true) @RequestParam @NotNull Long bedId) {
        List<OrderInfoVO> orderList = orderInfoService.queryUnsettledOrderByBedId(bedId);
        return JsonVO.success(orderList);
    }
    
    @PostMapping("/cancel-order")
    @Operation(summary = "取消订单", description = "取消未结算的订单")
    public JsonVO<Boolean> cancelOrder(
            @Parameter(description = "订单ID", required = true) @RequestParam @NotNull Long orderId) {
        Boolean result = orderInfoService.cancelOrder(orderId);
        return JsonVO.success(result);
    }
    
    @DeleteMapping("/remove-order")
    @Operation(summary = "删除订单", description = "删除订单及其明细")
    public JsonVO<Boolean> removeOrder(
            @Parameter(description = "订单ID", required = true) @RequestParam @NotNull Long orderId) {
        Boolean result = orderInfoService.removeOrder(orderId);
        return JsonVO.success(result);
    }
    
    @PostMapping("/count-order")
    @Operation(summary = "统计订单数量", description = "根据条件统计订单数量")
    public JsonVO<Long> countOrder(@RequestBody(required = false) OrderInfoQuery query) {
        Long count = orderInfoService.countOrderInfo(query);
        return JsonVO.success(count);
    }
    
    // ==================== 订单明细相关接口 ====================
    
    @GetMapping("/detail/query-by-order-id")
    @Operation(summary = "根据订单ID查询明细", description = "根据订单ID查询订单明细列表")
    public JsonVO<List<OrderDetailVO>> queryDetailByOrderId(
            @Parameter(description = "订单ID", required = true) @RequestParam @NotNull Long orderId) {
        List<OrderDetailVO> detailList = orderDetailService.queryDetailByOrderId(orderId);
        return JsonVO.success(detailList);
    }
    
    @GetMapping("/detail/query-by-order-code")
    @Operation(summary = "根据订单编号查询明细", description = "根据订单编号查询订单明细列表")
    public JsonVO<List<OrderDetailVO>> queryDetailByOrderCode(
            @Parameter(description = "订单编号", required = true) @RequestParam @NotNull String orderCode) {
        List<OrderDetailVO> detailList = orderDetailService.queryDetailByOrderCode(orderCode);
        return JsonVO.success(detailList);
    }
    
    @GetMapping("/detail/query-by-type-and-bid")
    @Operation(summary = "根据业务类型和ID查询明细", description = "根据业务类型和业务ID查询订单明细列表")
    public JsonVO<List<OrderDetailVO>> queryDetailByTypeAndBid(
            @Parameter(description = "业务类型", required = true) @RequestParam @NotNull Integer detailType,
            @Parameter(description = "业务ID", required = true) @RequestParam @NotNull Long bid) {
        List<OrderDetailVO> detailList = orderDetailService.queryDetailByTypeAndBid(detailType, bid);
        return JsonVO.success(detailList);
    }
    
    @GetMapping("/detail/query-by-user-id")
    @Operation(summary = "根据员工ID查询明细", description = "根据员工ID查询订单明细列表")
    public JsonVO<List<OrderDetailVO>> queryDetailByUserId(
            @Parameter(description = "员工ID", required = true) @RequestParam @NotNull Long userId) {
        List<OrderDetailVO> detailList = orderDetailService.queryDetailByUserId(userId);
        return JsonVO.success(detailList);
    }
    
    @GetMapping("/detail/count-by-order-id")
    @Operation(summary = "统计订单明细数量", description = "根据订单ID统计明细数量")
    public JsonVO<Long> countDetailByOrderId(
            @Parameter(description = "订单ID", required = true) @RequestParam @NotNull Long orderId) {
        Long count = orderDetailService.countDetailByOrderId(orderId);
        return JsonVO.success(count);
    }
}