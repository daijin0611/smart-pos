package org.haut.common.domain.dto.order;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @description 订单冲正DTO
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Accessors(chain = true)
public class OrderRollBackDTO {

    /**
     * 订单ID
     */
    @NotNull(message = "订单ID不能为空")
    private Long orderId;

    /**
     * 冲正原因
     */
    @NotNull(message = "冲正原因不能为空")
    private String reason;
}
