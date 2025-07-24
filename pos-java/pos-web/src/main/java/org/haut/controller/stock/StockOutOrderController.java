package org.haut.controller.stock;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.stock.StockOutOrderCreateDTO;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockOutOrderVO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.stock.service.StockOutOrderService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 出库订单管理控制器
 *
 * @author mhding
 * @date 2024/12/19
 */
@Slf4j
@RestController
@RequestMapping("/stock/out-order")
@Tag(name = "出库订单管理", description = "出库订单的增删改查操作")
@RequiredArgsConstructor
public class StockOutOrderController {

    private final StockOutOrderService stockOutOrderService;

    /**
     * 获取出库订单分页列表
     *
     * @param query 查询条件
     * @return 分页结果
     */
    @GetMapping("/query-page")
    @Operation(summary = "获取出库订单分页列表", description = "根据查询条件获取出库订单分页列表")
    public JsonVO<PageDTO<StockOutOrderVO>> queryPage(StockOrderQuery query) {
        log.info("查询出库订单分页列表，查询条件：{}", query);
        return JsonVO.success(stockOutOrderService.queryPage(query));
    }


    /**
     * 根据订单编号获取出库订单详情
     *
     * @param orderCode 订单编号
     * @return 订单详情
     */
    @GetMapping("/query-one")
    @Operation(
        summary = "根据订单编号获取出库订单详情",
        description = "根据订单编号获取出库订单详情，包含明细信息。主要在库存流水页面查看原单使用")
    public JsonVO<StockOutOrderVO> queryOne(@RequestParam("orderCode") String orderCode) {
        log.info("查询出库订单详情，订单编号：{}", orderCode);
        return JsonVO.success(stockOutOrderService.getOneByCode(orderCode));
    }

    /**
     * 创建出库单
     *
     * @param dto 创建参数
     * @return 操作结果
     */
    @PostMapping("/add-order")
    @Operation(summary = "创建出库单", description = "创建新的出库单")
    public JsonVO<Void> addOrder(@Valid @RequestBody StockOutOrderCreateDTO dto) {
        log.info("创建出库单，参数：{}", dto);
        stockOutOrderService.addOrder(dto);
        return JsonVO.success();
    }

}