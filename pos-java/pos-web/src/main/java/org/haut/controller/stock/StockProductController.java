package org.haut.controller.stock;

import cn.hutool.core.bean.BeanUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.query.stock.StockProductListQuery;
import org.haut.common.domain.query.stock.StockProductPageQuery;
import org.haut.common.domain.vo.stock.StockProductVO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.stock.service.StockProductService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 库存产品管理控制器
 *
 * @author mhding
 * @date 2024/12/19
 */
@Slf4j
@RestController
@RequestMapping("/stock/product")
@Tag(name = "库存产品管理", description = "库存产品的增删改查操作")
@RequiredArgsConstructor
public class StockProductController {

    private final StockProductService stockProductService;

    /**
     * 获取库存产品分页列表
     *
     * @param query 查询条件
     * @return 分页结果
     */
    @GetMapping("/query-page")
    @Operation(summary = "获取库存产品分页列表", description = "根据查询条件获取库存产品分页列表")
    public JsonVO<PageDTO<StockProductVO>> queryPage(StockProductPageQuery query) {
        log.info("查询库存产品分页列表，查询条件：{}", query);
        return JsonVO.success(stockProductService.queryPage(query));
    }

    /**
     * 获取库存产品列表
     * 产品信息 + 库存数量（没有库存则为0）
     *
     * @param query 查询条件
     * @return 产品列表
     */
    @GetMapping("/query-list")
    @Operation(summary = "获取库存产品列表", description = "根据查询条件获取库存产品列表")
    public JsonVO<List<StockProductVO>> queryList(StockProductListQuery query) {
        log.info("查询库存产品列表，查询条件：{}", query);
        StockProductPageQuery pageQuery = BeanUtil.toBean(query, StockProductPageQuery.class);
        pageQuery.setPageNum(1L);
        // 设置一个足够大的页大小，确保获取所有数据
        pageQuery.setPageSize(9999L);
        return JsonVO.success(stockProductService.queryPage(pageQuery).getRows());
    }


}