package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "角色添加用户DTO")
public class RoleUserAddDTO {
    @Schema(description = "角色ID")
    @NotNull
    private Long roleId;
    @Schema(description = "用户ID")
    @NotNull
    private List<Long> userIds;
}
