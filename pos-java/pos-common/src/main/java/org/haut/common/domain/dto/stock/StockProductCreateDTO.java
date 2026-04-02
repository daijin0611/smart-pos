package org.haut.common.domain.dto.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import lombok.Data;

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
     * 产品ID
     */
    @Schema(description = "产品ID", example = "1")
    @NotNull(message = "产品ID不能为空")
    private Long productId;

    /**
     * 库存数量
     */
    @Schema(description = "库存数量", example = "100")
    @NotNull(message = "库存数量不能为空")
    @PositiveOrZero(message = "库存数量不能为负数")
    private Integer quantity;

    /**
     * 备注
     */
    @Schema(description = "备注", example = "初始库存")
    @Size(max = 500, message = "备注长度不能超过500")
    private String remark;
}