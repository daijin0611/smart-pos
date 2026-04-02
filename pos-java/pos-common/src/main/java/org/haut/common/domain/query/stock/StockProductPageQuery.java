package org.haut.common.domain.query.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 库存产品查询Query
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "库存产品分页查询对象")
public class StockProductPageQuery {

    /**
     * 产品名称
     */
    @Schema(description = "产品名称", example = "工具")
    private String productName;

    /**
     * 产品编号
     */
    @Schema(description = "产品编号", example = "PROD202412190001")
    private String productCode;


    /**
     * 页码
     */
    @Schema(description = "页码", example = "1")
    private Long pageNum = 1L;

    /**
     * 每页大小
     */
    @Schema(description = "每页大小", example = "10")
    private Long pageSize = 10L;
}