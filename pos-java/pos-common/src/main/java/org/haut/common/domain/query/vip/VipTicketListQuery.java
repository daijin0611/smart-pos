package org.haut.common.domain.query.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Schema(description = "会员优惠券列表查询对象")
public class VipTicketListQuery {

    @Schema(description = "优惠券状态")
    private Integer ticketStatus;
    @Schema(description = "优惠券名称")
    private String ticketName;
}
