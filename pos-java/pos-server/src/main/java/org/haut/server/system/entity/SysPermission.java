package org.haut.server.system.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;
import lombok.Data;

/**
 * 系统权限表
 * @TableName sys_permission
 */
@TableName(value ="sys_permission")
@Data
public class SysPermission {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    private Integer isDelete;

    /**
     * 资源路径
     */
    @TableField("resource_path")
    private String path;

    /**
     * 权限名称
     */
    @TableField("perm_name")
    private String name;

    /**
     * 组件名称
     */
    @TableField("component_name")
    private String component;

    /**
     * 权限标识
     */
    private String permCode;

    /**
     * 权限状态(0 启用，1 停用)
     */
    private Integer permStatus;

    /**
     * 父权限ID
     */
    private Long parentId;

    /**
     * 备注
     */
    private String remark;

}