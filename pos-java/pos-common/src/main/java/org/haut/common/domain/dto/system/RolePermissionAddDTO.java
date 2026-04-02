package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "角色添加权限DTO")
public class RolePermissionAddDTO {
    @Schema(description = "角色ID")
    @NotNull
    private Long roleId;
    @Schema(description = "权限ID")
    @NotNull
    private List<Long> permissionIds;
}
