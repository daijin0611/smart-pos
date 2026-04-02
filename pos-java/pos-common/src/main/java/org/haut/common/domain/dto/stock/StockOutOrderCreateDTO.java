package org.haut.common.domain.dto.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

/**
 * 出库订单创建DTO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "出库订单创建对象")
@Accessors(chain = true)
public class StockOutOrderCreateDTO {

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
    @Schema(description = "备注", example = "销售出库")
    @Size(max = 500, message = "备注长度不能超过500")
    private String remark;

    /**
     * 出库明细列表
     */
    @Schema(description = "出库明细列表")
    @NotNull(message = "出库明细不能为空")
    private List<StockOutItemCreateDTO> items;

    /**
     * 出库明细创建DTO
     */
    @Data
    @Schema(description = "出库明细创建对象")
    @Accessors(chain = true)
    public static class StockOutItemCreateDTO {

        /**
         * 产品ID
         */
        @Schema(description = "产品ID", example = "1")
        @NotNull(message = "产品ID不能为空")
        private Long productId;


        /**
         * 出库数量
         */
        @Schema(description = "出库数量", example = "50")
        @NotNull(message = "出库数量不能为空")
        @Positive(message = "出库数量必须大于0")
        private Integer quantity;

        /**
         * 单价
         */
        @Schema(description = "单价", example = "20.00")
        @NotNull(message = "单价不能为空")
        @Positive(message = "单价必须大于0")
        private BigDecimal price;

        /**
         * 备注
         */
        @Schema(description = "备注", example = "正常出库")
        @Size(max = 200, message = "备注长度不能超过200")
        private String remark;
    }
}