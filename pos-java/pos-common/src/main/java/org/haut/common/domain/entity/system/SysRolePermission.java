package org.haut.common.domain.entity.system;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * 角色权限关联表
 * @TableName sys_role_permission
 */
@TableName(value ="sys_role_permission")
@Data
@AllArgsConstructor
public class SysRolePermission {
    /**
     * 角色id
     */
    private Long roleId;

    /**
     * 权限id
     */
    private Long permissionId;
}