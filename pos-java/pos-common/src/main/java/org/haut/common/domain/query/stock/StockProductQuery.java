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
@Schema(description = "库存产品查询对象")
public class StockProductQuery {

    /**
     * 产品ID
     */
    @Schema(description = "产品ID", example = "1")
    private Long productId;

    /**
     * 库存数量范围 - 最小值
     */
    @Schema(description = "库存数量最小值", example = "10")
    private Integer minQuantity;

    /**
     * 库存数量范围 - 最大值
     */
    @Schema(description = "库存数量最大值", example = "1000")
    private Integer maxQuantity;

    /**
     * 页码
     */
    @Schema(description = "页码", example = "1")
    private Integer pageNum = 1;

    /**
     * 每页大小
     */
    @Schema(description = "每页大小", example = "10")
    private Integer pageSize = 10;
}