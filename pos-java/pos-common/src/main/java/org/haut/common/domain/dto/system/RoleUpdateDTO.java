package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "角色更新DTO")
public class RoleUpdateDTO {

    /**
     * 角色ID
     */
    @Schema(description = "角色ID")
    @NotNull
    private Long id;

    /**
     * 角色标识
     */
    @Schema(description = "角色编码")
    @NotBlank
    private String roleCode;

    /**
     * 角色名称
     */
    @Schema(description = "角色名称")
    @NotBlank
    private String roleName;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    /**
     * 显示顺序
     */
    @Schema(description = "显示顺序")
    private Integer roleSort;

    /**
     * 角色状态（0 正常，1 停用）
     */
    @Schema(description = "角色状态（0 正常，1 停用）")
    private Integer roleStatus;
}
