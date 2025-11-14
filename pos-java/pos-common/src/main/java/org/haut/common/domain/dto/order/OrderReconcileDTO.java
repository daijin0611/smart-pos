package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;
import org.haut.common.domain.dto.vip.PaymentInfoDTO;

import java.math.BigDecimal;
import java.util.List;

/**
 * 订单对单请求DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-11-13
 */
@Data
@Accessors(chain = true)
@Schema(description = "订单对单请求对象")
public class OrderReconcileDTO {
    /**
     * 订单ID
     */
    @Schema(description = "订单ID")
    @NotNull(message = "订单ID不能为空")
    private Long orderId;

    /**
     * 应收金额
     */
    @Schema(description = "应收金额")
    @NotNull(message = "应收金额不能为空")
    private BigDecimal totalAmount;

    /**
     * 实收金额
     */
    @Schema(description = "实收金额")
    @NotNull(message = "实收金额不能为空")
    private BigDecimal actualAmount;

    /**
     * 优惠金额
     */
    @Schema(description = "优惠金额")
    @NotNull(message = "优惠金额不能为空")
    private BigDecimal discountAmount;

    /**
     * 对单后的订单明细
     */
    @Schema(description = "对单后的订单明细")
    @NotEmpty(message = "订单明细不能为空")
    private List<OrderDetailSettleDTO> details;

    /**
     * 对单后的支付信息
     */
    @Schema(description = "对单后的支付信息")
    @NotEmpty(message = "支付信息不能为空")
    private List<PaymentInfoDTO> paymentInfoList;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;
}

