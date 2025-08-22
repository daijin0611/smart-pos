package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;
import reactor.util.function.Tuple3;

import java.math.BigDecimal;
import java.util.List;

@Data
@Accessors(chain = true)
@Schema(description = "会员充值DTO")
public class RechargeDTO {
    @Schema(description = "会员id")
    private Long vipId;
    @Schema(description = "会员姓名")
    private String name;
    @Schema(description = "会员手机号")
    private String phoneNumber;
    @Schema(description = "会员卡号")
    private String cardNumber;

    @Schema(description = "活动id")
    private Long activeId;
    @Schema(description = "活动名称")
    private String activeName;

    @Schema(description = "资产折扣率")
    private Integer assetDiscountRate;
    @Schema(description = "资产折扣基数（0 标准价，1 会员价）")
    private Integer assetDiscountBase;
    @Schema(description = "资产是否允许跨店（0 不允许，1 允许）")
    private Integer asset_is_cross_store;

    @Schema(description = "业绩技师信息(支持多人业绩)")
    private List<UserKpi> userKpiList;

    @Schema(description = "支付信息")
    private List<PaymentInfo> paymentInfoList;

    @Data
    @Accessors
    @Schema(description = "业绩技师信息")
    public static class UserKpi{
        @Schema(description = "业绩技师id")
        private Long userId;
        @Schema(description = "业绩技师姓名")
        private String userName;
        @Schema(description = "业绩金额")
        private BigDecimal kpi;
    }

    @Data
    @Accessors
    @Schema(description = "支付信息")
    public static class PaymentInfo {
        @Schema(description = "支付类型")
        private Integer paymentType;
        @Schema(description = "支付名称")
        private String paymentName;
        @Schema(description = "支付金额")
        private BigDecimal paymentAmount;
    }
}
