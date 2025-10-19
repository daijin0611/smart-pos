package org.haut.controller.order;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.order.OrderInfoVO;
import org.haut.server.order.service.OrderInfoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Tag(name = "销售数据相关接口")
@RequestMapping("/sale")
@RestController
@RequiredArgsConstructor
public class SaleDataController {

    private final OrderInfoService orderInfoService;

    @GetMapping("/page")
    @Operation(description = "销售数据分页查询")
    public JsonVO<PageDTO<OrderInfoVO>> page(){

        return JsonVO.success();
    }
}
