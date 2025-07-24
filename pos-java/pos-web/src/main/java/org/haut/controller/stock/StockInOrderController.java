package org.haut.controller.stock;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.stock.StockInOrderCreateDTO;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockInOrderVO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.stock.service.StockInOrderService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 入库订单管理控制器
 *
 * @author mhding
 * @version 1.0
 */
@Slf4j
@RestController
@RequestMapping("/stock/in-order")
@Tag(name = "入库订单管理", description = "入库订单的增删改查操作")
@RequiredArgsConstructor
public class StockInOrderController {

    private final StockInOrderService stockInOrderService;

    /**
     * 获取入库订单分页列表
     *
     * @param query 查询条件
     * @return 分页结果
     */
    @GetMapping("/query-page")
    @Operation(summary = "获取入库订单分页列表", description = "根据查询条件获取入库订单分页列表")
    public JsonVO<PageDTO<StockInOrderVO>> queryPage(StockOrderQuery query) {
        log.info("查询入库订单分页列表，查询条件：{}", query);
        return JsonVO.success(stockInOrderService.queryPage(query));
    }


    /**
     * 根据订单编号获取入库订单详情
     *
     * @param orderCode 订单编号
     * @return 订单详情
     */
    @GetMapping("/query-one/{orderCode}")
    @Operation(
        summary = "根据订单编号获取入库订单详情",
        description = "根据订单编号获取入库订单详情，包含明细信息。主要在库存流水页面查看原单使用")
    public JsonVO<StockInOrderVO> queryOne(@PathVariable String orderCode) {
        log.info("查询入库订单详情，订单编号：{}", orderCode);
        return JsonVO.success(stockInOrderService.getOneByCode(orderCode));
    }

    /**
     * 创建入库单
     *
     * @param dto 创建参数
     * @return 操作结果
     */
    @PostMapping("/add-order")
    @Operation(summary = "创建入库单", description = "创建新的入库单")
    public JsonVO<Void> addOrder(@Validated @RequestBody StockInOrderCreateDTO dto) {
        log.info("创建入库单，参数：{}", dto);
        stockInOrderService.addOrder(dto);
        return JsonVO.success();
    }

}