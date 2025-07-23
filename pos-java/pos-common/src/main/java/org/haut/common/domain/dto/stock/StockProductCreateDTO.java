package org.haut.common.domain.dto.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 库存产品创建DTO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "库存产品创建对象")
public class StockProductCreateDTO {

    /**
     * 产品编码
     */
    @Schema(description = "产品编码", example = "P001")
    @NotBlank(message = "产品编码不能为空")
    @Size(max = 50, message = "产品编码长度不能超过50")
    private String productCode;

    /**
     * 产品名称
     */
    @Schema(description = "产品名称", example = "洗发水")
    @NotBlank(message = "产品名称不能为空")
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
    @NotBlank(message = "计量单位不能为空")
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
    @NotNull(message = "成本价不能为空")
    @PositiveOrZero(message = "成本价不能为负数")
    private BigDecimal costPrice;

    /**
     * 售价
     */
    @Schema(description = "售价", example = "25.00")
    @NotNull(message = "售价不能为空")
    @PositiveOrZero(message = "售价不能为负数")
    private BigDecimal salePrice;

    /**
     * 安全库存
     */
    @Schema(description = "安全库存", example = "10")
    @NotNull(message = "安全库存不能为空")
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
    @NotNull(message = "状态不能为空")
    private Integer status;
}