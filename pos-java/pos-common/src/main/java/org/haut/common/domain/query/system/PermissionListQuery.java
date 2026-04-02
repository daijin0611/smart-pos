package org.haut.common.domain.query.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "权限列表查询对象")
public class PermissionListQuery {

    @Schema(description = "权限名称", example = "人事管理")
    private String name;
    @Schema(description = "权限状态(0 正常，1 停用) 查全部用null", example = "0")
    private Integer status;

}
