package org.haut.common.domain.dto.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import lombok.Data;

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
public class StockOutOrderCreateDTO {

    /**
     * 出库单号
     */
    @Schema(description = "出库单号", example = "OUT202412190001")
    @NotBlank(message = "出库单号不能为空")
    @Size(max = 50, message = "出库单号长度不能超过50")
    private String orderNo;

    /**
     * 客户ID
     */
    @Schema(description = "客户ID", example = "1")
    private Long customerId;

    /**
     * 客户名称
     */
    @Schema(description = "客户名称", example = "XX客户")
    @Size(max = 100, message = "客户名称长度不能超过100")
    private String customerName;

    /**
     * 出库类型(1:销售出库 2:退货出库 3:调拨出库 4:其他出库)
     */
    @Schema(description = "出库类型(1:销售出库 2:退货出库 3:调拨出库 4:其他出库)", example = "1")
    @NotNull(message = "出库类型不能为空")
    private Integer outType;

    /**
     * 总金额
     */
    @Schema(description = "总金额", example = "1000.00")
    @NotNull(message = "总金额不能为空")
    @Positive(message = "总金额必须大于0")
    private BigDecimal totalAmount;

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
        private BigDecimal unitPrice;

        /**
         * 小计金额
         */
        @Schema(description = "小计金额", example = "1000.00")
        @NotNull(message = "小计金额不能为空")
        @Positive(message = "小计金额必须大于0")
        private BigDecimal subtotal;

        /**
         * 备注
         */
        @Schema(description = "备注", example = "正常出库")
        @Size(max = 200, message = "备注长度不能超过200")
        private String remark;
    }
}