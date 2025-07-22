package org.haut.common.domain.dto.system;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Accessors(chain = true)
public class UserDTO {
    /**
     * 主键
     */
    private Long id;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    private Integer isDelete;

    /**
     * 编号
     */
    private String userCode;

    /**
     * 登录密码
     */
    private String userPassword;

    /**
     * 真实姓名
     */
    private String userName;

    /**
     * 手机号
     */
    private String userNumber;

    /**
     * 职位
     */
    private String userPosition;

    /**
     * 性别（0 男，1 女）
     */
    private Integer userSex;

    /**
     * 生日
     */
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
    private String userIdCard;

    /**
     * 人员地址
     */
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

    /**
     * 备注
     */
    private String remark;

    /**
     * 组织代码
     */
    private Long orgId;
}
