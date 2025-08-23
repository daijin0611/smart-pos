package org.haut.common.domain.vo.system;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Schema(description = "用户信息展示对象")
public class UserInfoVO {

    @Schema(description = "员工ID", example = "1")
    private Long id;

    @Schema(description = "员工编号", example = "EMP001")
    private String userCode;//

    @Schema(description = "登录密码", example = "password123")
    private String userPassword;

    @Schema(description = "员工姓名", example = "张三")
    private String userName;

    @Schema(description = "手机号码", example = "13800138000")
    private String userNumber;

    @Schema(description = "职位", example = "店长")
    private String userPosition;

    @Schema(description = "性别(0-男,1-女)", example = "1")
    private Integer userSex;

    @Schema(description = "出生日期", example = "1990-01-01")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date userBirthday;

    @Schema(description = "所属部门", example = "管理部")
    private String userDept;

    @Schema(description = "入职日期", example = "2020-01-01")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date userEntryDate;

    @Schema(description = "在职状态", example = "在职")
    private String userStatus;

    @Schema(description = "身份证号", example = "110101199001011234")
    private String userIdCard;

    @Schema(description = "居住地址", example = "北京市朝阳区")
    private String userAddress;

    @Schema(description = "婚姻状况", example = "已婚")
    private String userMarry;

    @Schema(description = "学历", example = "本科")
    private String userEdu;

    @Schema(description = "健康证到期日", example = "2025-12-31")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date userHealth;

    @Schema(description = "组织机构id")
    private Long orgId;

    @Schema(description = "角色信息")
    private RoleInfoVo role;

}
