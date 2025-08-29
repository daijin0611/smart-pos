package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import jakarta.validation.constraints.NotNull;
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
     * 会员余额（结算时的会员余额）
     */
    @Schema(description = "会员余额（结算时的会员余额）")
    private BigDecimal vipBalance;
    

}