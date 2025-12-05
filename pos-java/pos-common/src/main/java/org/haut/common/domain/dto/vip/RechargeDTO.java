package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

@Data
@Accessors(chain = true)
@Schema(description = "会员充值DTO")
public class RechargeDTO {
    @Schema(description = "会员id")
    @NotNull(message = "会员不能为空")
    private Long vipId;
    @Schema(description = "会员姓名")
    private String vipName;
    @Schema(description = "会员手机号")
    private String vipPhoneNumber;
    @Schema(description = "会员卡号")
    private String vipCardNumber;

    @Schema(description = "活动id")
    private Long activeId;
    @Schema(description = "活动名称")
    private String activeName;
    @Schema(description = "充值金额")
    @NotNull(message = "充值金额不能为空")
    private BigDecimal rechargeValue;

    @Schema(description = "资产折扣率")
    private Integer assetDiscountRate;
    @Schema(description = "资产折扣基数（0 标准价，1 会员价）")
    private Integer assetDiscountBase;
    @Schema(description = "资产是否允许跨店（0 不允许，1 允许）")
    private Integer assetIsCrossStore;
    @Schema(description = "充值提成规则id")
    @NotNull(message = "充值提成规则不能为空")
    private Long rechargeRoleId;

    @Schema(description = "业绩技师信息(支持多人业绩)")
    private List<UserKpiDTO> userKpiList;

    @Schema(description = "支付信息")
    private List<PaymentInfoDTO> paymentInfoList;

    @Data
    @Accessors(chain = true)
    @Schema(description = "业绩技师信息")
    public static class UserKpiDTO{
        @Schema(description = "业绩技师id")
        private Long userId;
        @Schema(description = "业绩技师姓名")
        private String userName;
        @Schema(description = "业绩金额")
        private BigDecimal kpi;
    }

}
