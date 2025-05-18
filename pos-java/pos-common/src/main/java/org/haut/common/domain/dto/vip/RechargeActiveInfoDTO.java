package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.models.security.SecurityScheme;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class RechargeActiveInfoDTO {

    @Schema(description = "充值活动id", example = "1")
    @NotNull(message = "充值活动id不能为空")
    private Long id;

    @Schema(description = "活动名称", example = "1380送88项目两次")
    @NotNull(message = "活动名称不能为空")
    private String activeName;

    @Schema(description = "活动开始时间", example = "2023-01-01")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date activeBeginTime;

    @Schema(description = "活动结束时间", example = "2023-01-01")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date activeFinalTime;

    @Schema(description = "活动类型", example = "赠送储值金")
    @Pattern(regexp = "赠送储值金|赠送优惠券|赠送储值金和优惠券", message = "活动类型为这三种")
    private String activeType;

    @Schema(description = "充值本金", example = "100.00")
    @NotNull(message = "充值本金不能为空")
    private Double activeCapital;

    @Schema(description = "活动折扣", example = "0.8")
    @NotNull(message = "活动折扣不能为空")
    @Pattern(regexp = "^(0|[1-9]\\d*|1\\d{2}|200)$", message = "活动折扣不合法")
    private Double activeDiscount;

    @Schema(description = "折扣基础", example = "会员价")
    @Pattern(regexp = "会员价|标准价", message = "折扣基础只能为会员价或标准价")
    private String activeBaseOn;

    @Schema(description = "是否允许跨店结算（0-不允许，1-允许）", example = "1")
    @NotNull(message = "是否允许跨店结算不能为空")
    @Pattern(regexp = "0|1", message = "是否允许跨店结算只能为0或1")
    private Integer isCrossStore;

    @Schema(description = "赠送金额", example = "100.00")
    private Double activePresent;

    @Schema(description = "赠送优惠券", example = "100.00")
    private String activePresentTicket;

    @Schema(description = "折扣是否同本金（0-否，1-是）", example = "1")
    @Pattern(regexp = "0|1", message = "折扣是否同本金只能为0或1")
    private Integer isDiscountSameAs;

    @Schema(description = "是否累加赠送（0-否，1-是）", example = "1")
    @Pattern(regexp = "0|1", message = "是否累加赠送只能为0或1")
    private Integer isAccum;

    @Schema(description = "备注", example = "")
    private String remark;

}
