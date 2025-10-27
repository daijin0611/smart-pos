package org.haut.controller.order;

import io.swagger.v3.core.util.Json;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.query.order.OrderDetailPageQuery;
import org.haut.common.domain.query.order.OrderInfoQuery;
import org.haut.common.domain.query.order.OrderPageQuery;
import org.haut.common.domain.query.order.OrderSummaryQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.common.domain.vo.order.OrderSummaryVO;
import org.haut.server.order.service.OrderDetailService;
import org.haut.server.order.service.OrderInfoService;
import org.haut.server.order.service.OrderSalesSummaryService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 销售数据接口
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
@Tag(name = "销售数据", description = "销售数据接口")
public class OrderDataController {
    private final OrderInfoService orderInfoService;
    private final OrderSalesSummaryService orderSalesSummaryService;
    private final OrderDetailService orderDetailService;


    @PostMapping("/page")
    @Operation(summary = "分页查询销售数据", description = "分页查询销售数据")
    public JsonVO<PageDTO<OrderInfoVO>> pageQuery(@RequestBody OrderPageQuery query){
        return JsonVO.success(orderInfoService.pageQuery(query));
    }

    @PostMapping("/summary")
    @Operation(summary = "获取销售汇总", description = "获取销售汇总")
    public JsonVO<List<OrderSummaryVO>> getOrderSummary(@RequestBody OrderSummaryQuery query){
        return JsonVO.success(orderSalesSummaryService.getOrderSummaries(query));
    }

    @PostMapping("/detail/page")
    @Operation(summary = "分页查询销售明细", description = "分页查询销售明细")
    public JsonVO<PageDTO<OrderDetailVO>> pageQueryDetails(@RequestBody OrderDetailPageQuery query){
        return JsonVO.success(orderDetailService.pageQuery(query));
    }

}
