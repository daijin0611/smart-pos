package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Schema(description = "会员添加优惠券DTO")
@Accessors(chain = true)
public class VipInfoTicketCreateDTO {
    @Schema(description = "会员优惠券备注信息", example = "")
    private String remark;
    @Schema(description = "会员ID", example = "1")
    private Long vipInfoId;
    @Schema(description = "会员名称", example = "张三")
    private String vipName;
    @Schema(description = "会员手机号", example = "12345678901")
    private String vipPhoneNumber;
    @Schema(description = "会员卡号", example = "12345678901")
    private String vipCardNumber;
    @Schema(description = "会员优惠券ID", example = "1")
    private Long vipTicketId;
    @Schema(description = "会员优惠券名称", example = "会员优惠券")
    private String ticketName;
    @Schema(description = "会员优惠券数量", example = "1")
    private Integer number;
    @Schema(description = "活动id", example = "1")
    private Long activeId;
    @Schema(description = "充值历史code")
    private String rechargeHistoryCode;
}
