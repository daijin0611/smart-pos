package org.haut.common.domain.query.system;

import lombok.Data;
import io.swagger.v3.oas.annotations.media.Schema;

@Data
@Schema(description = "角色列表查询")
public class RoleListQuery {

    @Schema(description = "角色名称")
    private String roleName;

    @Schema(description = "角色编码")
    private String roleCode;

    @Schema(description = "角色状态")
    private Integer status;

}
