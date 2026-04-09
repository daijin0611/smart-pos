package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Schema(description = "订单优惠券使用DTO")
@Data
public class OrderTicketUseDTO {

    @Schema(description = "优惠券ID")
    private Long ticketId;

    @Schema(description = "优惠券类型")
    private Integer ticketType;

    @Schema(description = "优惠券名称")
    private String ticketName;

    @Schema(description = "抵扣金额")
    private BigDecimal amount;

    @Schema(description = "订单详情ID，用于项目券抵扣项目")
    private Long detailId;

    private String businessName;

    @Schema(description = "业务编码")
    private String businessCode;

    @Schema(description = "暂时弃用，计算时订单明细已经保存过")
    @Deprecated
    private Integer detailIndex;
}
