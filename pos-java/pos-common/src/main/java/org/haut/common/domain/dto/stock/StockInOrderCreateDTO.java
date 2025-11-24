package org.haut.common.domain.dto.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

/**
 * 入库订单创建DTO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "入库订单创建对象")
@Accessors(chain = true)
public class StockInOrderCreateDTO {

    /**
     * 总金额
     */
    @Schema(description = "总金额", example = "1000.00")
    @NotNull(message = "总金额不能为空")
    @Positive(message = "总金额必须大于0")
    private BigDecimal totalPrice;

    /**
     * 操作员
     */
    @Schema(description = "操作员", example = "admin")
    @Size(max = 50, message = "操作员长度不能超过50")
    private String operator;

    /**
     * 备注
     */
    @Schema(description = "备注", example = "采购入库")
    @Size(max = 500, message = "备注长度不能超过500")
    private String remark;

    /**
     * 入库明细列表
     */
    @Schema(description = "入库明细列表")
    @NotEmpty(message = "入库明细不能为空")
    private List<StockInItemCreateDTO> items;

    /**
     * 入库明细创建DTO
     */
    @Data
    @Schema(description = "入库明细创建对象")
    @Accessors(chain = true)
    public static class StockInItemCreateDTO {

        /**
         * 产品ID
         */
        @Schema(description = "产品ID", example = "1")
        @NotNull(message = "产品ID不能为空")
        private Long productId;

        /**
         * 入库数量
         */
        @Schema(description = "入库数量", example = "100")
        @NotNull(message = "入库数量不能为空")
        @Positive(message = "入库数量必须大于0")
        private Integer quantity;

        /**
         * 单价
         */
        @Schema(description = "单价", example = "10.00")
        @NotNull(message = "单价不能为空")
        @Positive(message = "单价必须大于0")
        private BigDecimal price;

        /**
         * 备注
         */
        @Schema(description = "备注", example = "正常入库")
        @Size(max = 200, message = "备注长度不能超过200")
        private String remark;
    }
}