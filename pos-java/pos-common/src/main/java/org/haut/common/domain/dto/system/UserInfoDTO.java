package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;


import java.util.Date;

@Data
@Schema(description = "员工详细信息对象")
public class UserInfoDTO {


    @NotNull(message = "ID不能为空")
    private Long id;

    @NotBlank(message = "员工编号不能为空")
    @Size(max = 20, message = "员工编号长度不能超过20")
    private String userCode;

    @NotBlank(message = "密码不能为空")
    @Size(min = 6, max = 20, message = "密码长度6-20位")
    private String userPassword;

    @NotBlank(message = "姓名不能为空")
    @Size(max = 50, message = "姓名长度不能超过50")
    private String userName;

    @NotBlank(message = "手机号不能为空")
    @Size(min = 11, max = 11, message = "手机号长度必须为11位")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String userNumber;

    @NotBlank(message = "职位不能为空")
    private String userPosition;

    @NotNull(message = "性别不能为空")
    @Min(value = 0, message = "性别值不合法")
    @Max(value = 1, message = "性别值不合法")
    private Integer userSex;

    @PastOrPresent(message = "生日不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date userBirthday;

    /**
     * 部门
     */
    private String userDept;

    /**
     * 入职时间
     */
    private Date userEntryDate;

    /**
     * 在职状态
     */
    private String userStatus;

    /**
     * 身份证号
     */
    @Size(min = 18, max = 18, message = "身份证号长度必须为18位")
    private String userIdCard;

    @Size(max = 200, message = "地址长度不能超过200")
    private String userAddress;

    /**
     * 婚姻状况
     */
    private String userMarry;

    /**
     * 学历状况
     */
    private String userEdu;

    /**
     * 健康证到期
     */
    private Date userHealth;

}
