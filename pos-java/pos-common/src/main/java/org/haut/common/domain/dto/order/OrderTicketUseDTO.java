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
     * 订单详情ID（已废弃，请使用detailIndex）
     * @deprecated 使用 detailIndex 代替，保留用于向后兼容
     */
    @Schema(description = "订单详情ID（已废弃）")
    @Deprecated
    private Long detailId;

    /**
     * 订单明细在details数组中的索引位置（从0开始）
     * 用于体验券关联订单明细
     */
    @Schema(description = "订单明细索引（从0开始）")
    private Integer detailIndex;
}
