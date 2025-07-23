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
 * 入库订单创建DTO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "入库订单创建对象")
public class StockInOrderCreateDTO {

    /**
     * 入库单号
     */
    @Schema(description = "入库单号", example = "IN202412190001")
    @NotBlank(message = "入库单号不能为空")
    @Size(max = 50, message = "入库单号长度不能超过50")
    private String orderNo;

    /**
     * 供应商ID
     */
    @Schema(description = "供应商ID", example = "1")
    private Long supplierId;

    /**
     * 供应商名称
     */
    @Schema(description = "供应商名称", example = "XX供应商")
    @Size(max = 100, message = "供应商名称长度不能超过100")
    private String supplierName;

    /**
     * 入库类型(1:采购入库 2:退货入库 3:调拨入库 4:其他入库)
     */
    @Schema(description = "入库类型(1:采购入库 2:退货入库 3:调拨入库 4:其他入库)", example = "1")
    @NotNull(message = "入库类型不能为空")
    private Integer inType;

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
    @Schema(description = "备注", example = "采购入库")
    @Size(max = 500, message = "备注长度不能超过500")
    private String remark;

    /**
     * 入库明细列表
     */
    @Schema(description = "入库明细列表")
    @NotNull(message = "入库明细不能为空")
    private List<StockInItemCreateDTO> items;

    /**
     * 入库明细创建DTO
     */
    @Data
    @Schema(description = "入库明细创建对象")
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
        @Schema(description = "备注", example = "正常入库")
        @Size(max = 200, message = "备注长度不能超过200")
        private String remark;
    }
}