package org.haut.common.domain.query.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "权限列表查询对象")
public class PermissionListQuery {

    @Schema(description = "权限名称", example = "权限名称")
    private String permName;
    @Schema(description = "权限状态(0 正常，1 停用)", example = "0")
    private Integer permStatus;

}
