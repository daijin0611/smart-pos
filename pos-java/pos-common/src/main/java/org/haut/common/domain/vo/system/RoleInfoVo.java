package org.haut.common.domain.vo.system;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import io.swagger.v3.oas.annotations.media.Schema;

import java.util.Date;

@Data
@Schema(description = "角色信息")
public class RoleInfoVo {
    /**
     * 主键
     */
    @Schema(description = "角色ID")
    private Long id;

    /**
     * 角色标识
     */
    @Schema(description = "角色编码")
    private String roleCode;

    /**
     * 角色名称
     */
    @Schema(description = "角色名称")
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
    @Schema(description = "角色状态")
    private Integer roleStatus;

}
