package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Schema(description = "用户分配角色DTO")
public class UserAllocateRoleDTO {

    @Schema(description = "用户ID")
    private Long userId;

    @Schema(description = "角色ID")
    private Long roleId;
}
