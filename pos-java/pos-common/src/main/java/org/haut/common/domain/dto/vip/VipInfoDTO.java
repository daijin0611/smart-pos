package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;
import java.util.Date;

@Data
@Schema(description = "会员详细信息对象")
public class VipInfoDTO {

    @Schema(description = "会员ID", example = "1")
    @NotNull(message = "ID不能为空")
    private Long id;

    @Schema(description = "会员姓名", example = "张三")
    @NotBlank(message = "姓名不能为空")
    @Size(max = 50, message = "姓名长度不能超过50")
    private String infoName;

    @Schema(description = "会员密码", example = "123456")
    @NotBlank(message = "密码不能为空")
    @Size(min = 6, max = 20, message = "密码长度必须在6到20位之间")
    private String infoPwd;

    @Schema(description = "会员卡号", example = "N008700235")
    @NotBlank(message = "会员卡号不能为空")
    @Size(min = 8, max = 20, message = "会员卡号长度必须在8到20位之间")
    private String infoCardNumber;

    @Schema(description = "性别(0-男,1-女)", example = "1")
    @NotNull(message = "性别不能为空")
    @Min(value = 0, message = "性别值不合法")
    @Max(value = 1, message = "性别值不合法")
    private Integer infoGender;

    @Schema(description = "会员手机号", example = "13800138000")
    @NotBlank(message = "会员手机号不能为空")
    @Size(min = 11, max = 11, message = "手机号长度必须为11位")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String infoPhoneNumber;

    @Schema(description = "会员身份", example = "钻石会员")
    @Pattern(regexp = "普通会员|白银会员|黄金会员|铂金会员|钻石会员", message = "会员身份只能是这几种")
    private String infoIdentity;

    @Schema(description = "会员生日", example = "1990-01-01")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate infoBirthday;

    @Schema(description = "会员地址", example = "")
    private String infoAddress;

    @Schema(description = "末次消费日期", example = "2025-03-01")
    @PastOrPresent(message = "末次消费日期不能是未来日期")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate infoLastConsumptionTime;

    @Schema(description = "末次充值日期", example = "2025-03-01")
    @PastOrPresent(message = "末次充值日期不能是未来日期")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate infoLastRechargeTime;

    @Schema(description = "备注信息", example = "")
    private String remark;

    @Schema(description = "会员资产余额", example = "100.00")
    private Double assetBalance;



}
