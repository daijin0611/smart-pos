package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Schema(description = "员工更新对象")
public class UserUpdateDTO {

    @Schema(description = "员工ID", example = "1")
    @NotNull(message = "ID不能为空")
    private Long id;

    @Schema(description = "员工编号", example = "EMP001")
    @NotBlank(message = "员工编号不能为空")
    @Size(max = 20, message = "员工编号长度不能超过20")
    private String userCode;//

    @Schema(description = "登录密码", example = "password123")
    @NotBlank(message = "密码不能为空")
    @Size(min = 6, max = 20, message = "密码长度6-20位")
    private String userPassword;

    @Schema(description = "员工姓名", example = "张三")
    @NotBlank(message = "姓名不能为空")
    @Size(max = 50, message = "姓名长度不能超过50")
    private String userName;

    @Schema(description = "手机号码", example = "13800138000")
    @NotBlank(message = "手机号不能为空")
    @Size(min = 11, max = 11, message = "手机号长度必须为11位")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String userNumber;

    @Schema(description = "职位", example = "店长")
    @NotBlank(message = "职位不能为空")
    private String userPosition;

    @Schema(description = "性别(0-男,1-女)", example = "1")
    @NotNull(message = "性别不能为空")
    @Min(value = 0, message = "性别值不合法")
    @Max(value = 1, message = "性别值不合法")
    private Integer userSex;

    @Schema(description = "出生日期", example = "1990-01-01")
    @PastOrPresent(message = "生日不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date userBirthday;

    @Schema(description = "所属部门", example = "管理部")
    private String userDept;

    @Schema(description = "入职日期", example = "2020-01-01")
    @PastOrPresent(message = "生日不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date userEntryDate;

    @Schema(description = "在职状态", example = "在职")
    private String userStatus;

    @Schema(description = "身份证号", example = "110101199001011234")
    @Size(min = 18, max = 18, message = "身份证号长度必须为18位")
    private String userIdCard;

    @Schema(description = "居住地址", example = "北京市朝阳区")
    @Size(max = 200, message = "地址长度不能超过200")
    private String userAddress;

    @Schema(description = "婚姻状况", example = "已婚")
    private String userMarry;

    @Schema(description = "学历", example = "本科")
    private String userEdu;

    @Schema(description = "健康证到期日", example = "2025-12-31")
    private Date userHealth;

    @Schema(description = "角色id")
    @NotNull(message = "角色不能为空")
    private Long roleId;
}
