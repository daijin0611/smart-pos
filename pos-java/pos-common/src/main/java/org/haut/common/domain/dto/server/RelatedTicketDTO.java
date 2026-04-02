package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Schema(description = "疗程关联优惠券")
@Accessors(chain = true)
public class RelatedTicketDTO {
    @Schema(description = "关联优惠券ID")
    private Long vipTicketId;
    @Schema(description = "关联优惠券名称")
    private String vipTicketName;
    @Schema(description = "关联优惠券数量")
    private Integer vipTicketNum;
}
