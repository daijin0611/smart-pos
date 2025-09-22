package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Schema(description = "订单优惠券使用DTO")
@Data
public class OrderTicketUseDTO {

    @Schema(description = "优惠券ID")
    private Long ticketId;

    @Schema(description = "优惠券类型")
    private Integer ticketType;
    // 50 55

    /**
     * 订单详情ID，如果为代金券则设置为空
     */
    @Schema(description = "订单详情ID")
    private Long detailId;
}
