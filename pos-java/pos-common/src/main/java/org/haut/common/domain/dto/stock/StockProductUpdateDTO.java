package org.haut.common.domain.dto.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 库存产品更新DTO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "库存产品更新对象")
public class StockProductUpdateDTO {

    /**
     * 产品ID
     */
    @Schema(description = "产品ID", example = "1")
    @NotNull(message = "产品ID不能为空")
    private Long id;

    /**
     * 产品名称
     */
    @Schema(description = "产品名称", example = "洗发水")
    @Size(max = 100, message = "产品名称长度不能超过100")
    private String productName;

    /**
     * 产品规格
     */
    @Schema(description = "产品规格", example = "500ml")
    @Size(max = 50, message = "产品规格长度不能超过50")
    private String specification;

    /**
     * 计量单位
     */
    @Schema(description = "计量单位", example = "瓶")
    @Size(max = 20, message = "计量单位长度不能超过20")
    private String unit;

    /**
     * 产品分类
     */
    @Schema(description = "产品分类", example = "洗护用品")
    @Size(max = 50, message = "产品分类长度不能超过50")
    private String category;

    /**
     * 品牌
     */
    @Schema(description = "品牌", example = "海飞丝")
    @Size(max = 50, message = "品牌长度不能超过50")
    private String brand;

    /**
     * 成本价
     */
    @Schema(description = "成本价", example = "15.50")
    @PositiveOrZero(message = "成本价不能为负数")
    private BigDecimal costPrice;

    /**
     * 售价
     */
    @Schema(description = "售价", example = "25.00")
    @PositiveOrZero(message = "售价不能为负数")
    private BigDecimal salePrice;

    /**
     * 安全库存
     */
    @Schema(description = "安全库存", example = "10")
    @PositiveOrZero(message = "安全库存不能为负数")
    private Integer safetyStock;

    /**
     * 最大库存
     */
    @Schema(description = "最大库存", example = "1000")
    @PositiveOrZero(message = "最大库存不能为负数")
    private Integer maxStock;

    /**
     * 产品描述
     */
    @Schema(description = "产品描述", example = "去屑止痒洗发水")
    @Size(max = 500, message = "产品描述长度不能超过500")
    private String description;

    /**
     * 状态(0:正常 1:停用)
     */
    @Schema(description = "状态(0:正常 1:停用)", example = "0")
    private Integer status;
}