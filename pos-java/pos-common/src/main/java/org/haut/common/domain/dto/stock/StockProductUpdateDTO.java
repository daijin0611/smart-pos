package org.haut.common.domain.dto.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import lombok.Data;

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
     * 库存产品ID
     */
    @Schema(description = "库存产品ID", example = "1")
    @NotNull(message = "库存产品ID不能为空")
    private Long id;

    /**
     * 产品ID
     */
    @Schema(description = "产品ID", example = "1")
    private Long productId;

    /**
     * 库存数量
     */
    @Schema(description = "库存数量", example = "100")
    @PositiveOrZero(message = "库存数量不能为负数")
    private Integer quantity;

    /**
     * 备注
     */
    @Schema(description = "备注", example = "库存调整")
    @Size(max = 500, message = "备注长度不能超过500")
    private String remark;
}