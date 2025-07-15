package org.haut.common.domain.vo.system;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
@Schema(description = "权限信息VO")
public class PermissionInfoVO {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    @Schema(name = "主键",description = "主键")
    private Long id;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    @Schema(name = "创建时间",description = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @Schema(name = "更新时间",description = "更新时间")
    private Date updateTime;

    /**
     * 权限标识
     */
    @Schema(name = "权限标识",description = "权限标识")
    private String permCode;

    /**
     * 权限类型
     */
    @Schema(name = "权限类型",description = "权限类型")
    private String permType;

    /**
     * 资源路径
     */
    @Schema(name = "资源路径",description = "资源路径")
    private String resourcePath;

    /**
     * 操作类型
     */
    @Schema(name = "操作类型",description = "操作类型")
    private String operation;

    /**
     * 父权限ID
     */
    @Schema(name = "父权限ID",description = "父权限ID")
    private Long parentId;

    /**
     * 备注
     */
    @Schema(name = "备注",description = "备注")
    private String remark;

    /**
     * 权限名称
     */
    @Schema(name = "权限名称",description = "权限名称")
    private String permName;

    /**
     * 权限状态(0 启用，1 停用)
     */
    @Schema(name = "权限状态(0 启用，1 停用)",description = "权限状态(0 启用，1 停用)")
    private String permStatus;

    /**
     * 子权限
     */
    @Schema(name = "子权限",description = "子权限")
    private List<PermissionInfoVO> children;

}
