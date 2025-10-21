package org.haut.controller.order;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.query.order.OrderPageQuery;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.server.order.service.OrderInfoService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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



    @PostMapping("/page")
    @Operation(summary = "分页查询销售数据", description = "分页查询销售数据")
    public JsonVO<PageDTO<OrderInfoVO>> pageQuery(OrderPageQuery query){
        return JsonVO.success(orderInfoService.pageQuery(query));
    }



}
