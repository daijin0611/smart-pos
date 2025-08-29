package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

/**
 * 结算订单请求DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Data
@Accessors(chain = true)
@Schema(description = "结算订单请求DTO")
public class SettleOrderDTO {
    
    /**
     * 订单ID
     */
    @NotNull(message = "订单ID不能为空")
    @Schema(description = "订单ID")
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
    
    /**
     * 备注
     */
    @Schema(description = "备注信息")
    private String remark;
}