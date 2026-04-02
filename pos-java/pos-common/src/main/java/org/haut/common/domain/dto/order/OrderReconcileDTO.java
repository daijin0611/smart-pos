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
     * 备注
     */
    @Schema(description = "备注")
    private String remark;
}

