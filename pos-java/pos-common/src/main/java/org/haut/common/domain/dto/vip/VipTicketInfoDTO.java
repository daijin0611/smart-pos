package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

public class VipTicketInfoDTO {

    @Schema(description = "会员ID", example="1")
    @NotNull(message = "会员ID不能为空")
    private Long id;

    @Schema(description = "优惠券状态（0-禁用，1-启用）", example="1")
    @NotNull(message = "优惠券状态不能为空")
    private Integer ticketStatus;

    @Schema(description = "优惠券名称", example="699水洗头疗10次")
    private String ticketName;

    @Schema(description = "优惠券类型", example="代金券")
    @Pattern(regexp = "体验券|代金券", message = "类型只能是体验券或者代金券")
    private String ticketType;

    @Schema(description = "领取后几天有效", example="100")
    private Integer ticketAfterDay;

    @Schema(description = "满多少元可用", example="100.00")
    private Double ticketFullPayment;

    @Schema(description = "优惠券面值", example="100.00")
    private Double ticketValue;

    @Schema(description = "是否为套餐体验券（0-否，1-是）", example="0")
    private Integer isPackageTicket;

}
