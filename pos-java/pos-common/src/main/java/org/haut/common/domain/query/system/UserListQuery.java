package org.haut.common.domain.query.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "用户列表查询对象")
public class UserListQuery {
    /**
     * 真实姓名
     */
    private String userName;

    /**
     * 手机号
     */
    @NotNull
    private String userNumber;

    /**
     * 在职状态
     */
    private String userStatus;
}
