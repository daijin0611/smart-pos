package org.haut.controller.stock;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.core.util.Json;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.query.stock.StockOrderQuery;
import org.haut.common.domain.vo.stock.StockLogVO;
import org.haut.common.domain.vo.JsonVO;
import org.haut.server.stock.service.StockLogService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 库存日志管理控制器
 *
 * @author mhding
 * @date 2024/12/19
 */
@Slf4j
@RestController
@RequestMapping("/stock/log")
@Tag(name = "库存日志管理", description = "库存变动日志的查询操作")
@RequiredArgsConstructor
public class StockLogController {

    private final StockLogService stockLogService;

    /**
     * 获取库存日志分页列表
     *
     * @param query 查询条件
     * @return 分页结果
     */
    @GetMapping("/query-page")
    @Operation(
            summary = "获取库存日志分页列表",
            description = "根据查询条件获取库存日志分页列表"
    )
    public JsonVO<PageDTO<StockLogVO>> queryPage(StockOrderQuery query) {
        log.info("查询库存日志分页列表，查询条件：{}", query);
        return JsonVO.success(stockLogService.queryPage(query));
    }

}