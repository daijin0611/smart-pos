package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
 *
 */
@Data
@Schema(description = "员工列表对象")
public class UserListDTO {

    /**
     * 唯一标识
     */
    private Long id;

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

}
