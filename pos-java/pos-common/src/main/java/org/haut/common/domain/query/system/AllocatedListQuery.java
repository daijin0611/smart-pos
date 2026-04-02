package org.haut.common.domain.query.system;

import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.models.security.SecurityScheme;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "角色已分配用户列表查询对象")
public class AllocatedListQuery {

    @NotNull
    @Schema(description = "角色ID", example = "1")
    private Long roleId;
}
