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
    @Schema(description = "主键")
    private Long id;

    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @Schema(description = "更新时间")
    private Date updateTime;

    /**
     * 权限名称
     */
    @Schema(description = "权限名称")
    private String name;

    /**
     * 权限标识
     */
    @Schema(description = "权限标识")
    private String permCode;

    /**
     * 资源路径
     */
    @Schema(description = "资源路径")
    private String path;

    /**
     * 组件名称
     */
    @Schema(description = "组件名称")
    private String component;

    /**
     * 父权限ID
     */
    @Schema(description = "父权限ID")
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
    private Integer permStatus;

    /**
     * 子权限
     */
    @Schema(description = "子权限")
    private List<PermissionInfoVO> children;

}
