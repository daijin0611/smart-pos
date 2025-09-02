package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import jakarta.validation.constraints.NotNull;
import org.haut.common.domain.dto.vip.PaymentInfoDTO;
import org.haut.common.domain.dto.vip.RechargeDTO;

import java.math.BigDecimal;
import java.util.List;

/**
 * 结算订单请求DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Accessors(chain = true)
@Schema(description = "结算订单请求DTO")
public class SettleOrderDTO extends CreateOrderDTO{

    /**
     * 订单ID
     */
    @Schema(description = "订单ID（如果已在床位创建订单,传入此id用于更改订单状态）")
    private Long orderId;
    
    /**
     * 应收金额
     */
    @NotNull(message = "应收金额不能为空")
    @Schema(description = "应收金额")
    private BigDecimal totalAmount;
    
    /**
     * 实收金额
     */
    @NotNull(message = "实收金额不能为空")
    @Schema(description = "实收金额")
    private BigDecimal actualAmount;
    
    /**
     * 优惠金额
     */
    @Schema(description = "优惠金额")
    private BigDecimal discountAmount;


    /**
     * 优惠券ID
     */
    @Schema(description = "优惠券ID")
    private List<Long> ticketIds;

    /**
     * 资产id
     */
    @Schema(description = "资产ID")
    private List<Long> assetIds;

    /**
     * 支付信息
     */
    @Schema(description = "支付信息")
    private List<PaymentInfoDTO> paymentInfoList;


}