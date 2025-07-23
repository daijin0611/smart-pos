package org.haut.common.domain.dto.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 库存产品查询DTO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "库存产品查询对象")
public class StockProductQueryDTO {

    /**
     * 产品编码
     */
    @Schema(description = "产品编码", example = "P001")
    private String productCode;

    /**
     * 产品名称
     */
    @Schema(description = "产品名称", example = "洗发水")
    private String productName;

    /**
     * 产品分类
     */
    @Schema(description = "产品分类", example = "洗护用品")
    private String category;

    /**
     * 品牌
     */
    @Schema(description = "品牌", example = "海飞丝")
    private String brand;

    /**
     * 状态(0:正常 1:停用)
     */
    @Schema(description = "状态(0:正常 1:停用)", example = "0")
    private Integer status;

    /**
     * 是否库存不足
     */
    @Schema(description = "是否库存不足", example = "true")
    private Boolean lowStock;

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