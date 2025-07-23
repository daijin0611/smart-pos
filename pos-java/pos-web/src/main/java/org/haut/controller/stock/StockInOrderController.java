package org.haut.controller.stock;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.stock.StockInOrderCreateDTO;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockInOrderVO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.stock.service.StockInOrderService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 入库订单管理控制器
 *
 * @author mhding
 * @date 2024/12/19
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
    public JsonVO<Page<StockInOrderVO>> queryPage(StockOrderQuery query) {
        log.info("查询入库订单分页列表，查询条件：{}", query);
        return JsonVO.success(stockInOrderService.queryPage(query));
    }

    /**
     * 获取入库订单列表
     *
     * @param query 查询条件
     * @return 订单列表
     */
    @GetMapping("/query-list")
    @Operation(summary = "获取入库订单列表", description = "根据查询条件获取入库订单列表")
    public JsonVO<List<StockInOrderVO>> queryList(StockOrderQuery query) {
        log.info("查询入库订单列表，查询条件：{}", query);
        // TODO: 实现列表查询逻辑
        return JsonVO.success(List.of());
    }

    /**
     * 根据ID获取入库订单详情
     *
     * @param id 订单ID
     * @return 订单详情
     */
    @GetMapping("/query-one")
    @Operation(summary = "获取入库订单详情", description = "根据订单ID获取入库订单详情，包含明细信息")
    public JsonVO<StockInOrderVO> queryOne(@RequestParam("id") Long id) {
        log.info("查询入库订单详情，订单ID：{}", id);
        // TODO: 实现详情查询逻辑
        return JsonVO.success(new StockInOrderVO());
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


    /**
     * 删除入库单
     *
     * @param id 入库单ID
     * @return 操作结果
     */
    @DeleteMapping("/remove-order")
    @Operation(summary = "删除入库单", description = "根据入库单ID删除入库单")
    public JsonVO<Void> removeOrder(@RequestParam("id") Long id) {
        log.info("删除入库单，入库单ID：{}", id);
        // TODO: 实现删除逻辑
        return JsonVO.success();
    }

    /**
     * 批量删除入库单
     *
     * @param ids 入库单ID列表
     * @return 操作结果
     */
    @DeleteMapping("/remove-orders")
    @Operation(summary = "批量删除入库单", description = "根据入库单ID列表批量删除入库单")
    public JsonVO<Void> removeOrders(@RequestBody List<Long> ids) {
        log.info("批量删除入库单，入库单ID列表：{}", ids);
        // TODO: 实现批量删除逻辑
        return JsonVO.success();
    }

    /**
     * 根据订单号查询入库订单
     *
     * @param orderNo 订单号
     * @return 入库订单信息
     */
    @GetMapping("/query-by-order-no")
    @Operation(summary = "根据订单号查询入库订单", description = "根据订单号查询入库订单详细信息")
    public JsonVO<StockInOrderVO> queryByOrderNo(@RequestParam("orderNo") String orderNo) {
        log.info("根据订单号查询入库订单，订单号：{}", orderNo);
        // TODO: 实现查询逻辑
        return JsonVO.success(new StockInOrderVO());
    }


}