package org.haut.common.domain.dto.vip;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

@Data
@Accessors(chain = true)
public class VipCreateDTO {

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    /**
     * 姓名
     */
    @Schema(description = "姓名")
    @NotBlank
    private String name;

    /**
     * 性别（0 男，1 女）
     */
    @Schema(description = "性别（0 男，1 女）")
    @NotNull
    private Integer gender;

    /**
     * 会员卡号
     */
    @Schema(description = "会员卡号")
    private String cardNumber;

    /**
     * 电话号码
     */
    @Schema(description = "电话号码")
    @NotBlank
    private String phoneNumber;

    /**
     * 会员身份
     */
    @Schema(description = "会员身份(字典表管理)")
    @NotNull
    private Integer identity;

    /**
     * 会员生日
     */
    @Schema(description = "会员生日")
    private LocalDate birthday;

    /**
     * 会员地址
     */
    @Schema(description = "会员地址")
    private String address;

    /**
     * 会员密码
     */
    @Schema(description = "会员密码")
    @NotBlank
    private String pwd;

}
