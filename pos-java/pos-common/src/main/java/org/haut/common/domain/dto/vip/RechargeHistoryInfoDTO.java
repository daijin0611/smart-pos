package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import org.springframework.format.annotation.DateTimeFormat;

public class RechargeHistoryInfoDTO {

    @Schema(description = "充值记录ID", example = "1")
    @NotBlank(message = "ID不能为空")
    private Long id;

    @Schema(description = "充值时间", example = "2025-03-01")
    @PastOrPresent(message = "生日不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Long rechargeTime;

    @Schema(description = "员工姓名", example = "张三")
    @NotBlank(message = "姓名不能为空")
    @Size(max = 50, message = "姓名长度不能超过50")
    private String userName;

    @Schema(description = "会员姓名", example = "张三")
    @NotBlank(message = "姓名不能为空")
    @Size(max = 50, message = "姓名长度不能超过50")
    private String infoName;

    @Schema(description = "会员卡号", example = "N008700235")
    @NotBlank(message = "会员卡号不能为空")
    @Size(min = 8, max = 20, message = "会员卡号长度必须在8到20位之间")
    private String infoCardNumber;

    @Schema(description = "会员手机号", example = "13800138000")
    @NotBlank(message = "会员手机号不能为空")
    @Size(min = 11, max = 11, message = "手机号长度必须为11位")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String infoPhoneNumber;

    @Schema(description = "充值金额", example = "100.00")
    private Double rechargeAmount;

    @Schema(description = "会员资产编号", example = "004A1E97")
    @NotBlank(message = "会员资产编号不能为空")
    @Size(min = 8, max = 20, message = "会员资产编号长度必须在8到20位之间")
    private  String assetNum;

    @Schema(description = "赠券", example = "无")
    @Size(max = 50, message = "赠券长度不能超过50")
    private String rechargeCoupon;

    @Schema(description = "充值方式", example = "门店充值")
    @Pattern(regexp = "门店充值|手动赠送", message = "充值类型只能是这两种")
    private String rechargeType;

    @Schema(description = "充值状态(0-充值成功，1-已冲正)", example = "1")
    private Integer  rechargeStatus;

    @Schema(description = "支付渠道", example = "现金")
    @Pattern(regexp = "微信支付|支付宝支付|现金支付|银行卡|抖音支付", message = "支付方式为该5种")
    private String rechargePayment;


}
