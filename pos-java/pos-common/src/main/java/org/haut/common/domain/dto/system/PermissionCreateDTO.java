package org.haut.common.domain.dto.system;


import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.haut.common.domain.vo.system.PermissionInfoVO;
import java.util.List;

@Data
@Schema(description = "权限创建参数")
public class PermissionCreateDTO {
    /**
     * 权限名称
     */
    @Schema(description = "权限名称")
    @NotBlank
    private String name;

    /**
     * 权限标识
     */
    @Schema(description = "权限标识")
    @NotBlank
    private String permCode;

    /**
     * 资源路径
     */
    @Schema(description = "资源路径")
    @NotBlank
    private String path;

    /**
     * 组件名称
     */
    @Schema(description = "组件名称")
    @NotBlank
    private String component;

    /**
     * 父权限ID
     */
    @Schema(description = "父权限ID", example = "0")
    private Long parentId;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    /**
     * 权限状态(0 启用，1 停用)
     */
    @Schema(description = "权限状态(0 启用，1 停用)")
    @NotNull
    private Integer permStatus;

}
