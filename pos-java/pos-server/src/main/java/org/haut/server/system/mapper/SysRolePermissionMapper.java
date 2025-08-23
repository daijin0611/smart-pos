package org.haut.server.system.mapper;

import jakarta.validation.constraints.NotNull;
import org.haut.server.system.entity.SysRolePermission;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
* @author daiji
* @description 针对表【sys_role_permission(角色权限关联表)】的数据库操作Mapper
* @createDate 2025-07-16 15:46:30
* @Entity org.haut.server.system.entity.SysRolePermission
*/
public interface SysRolePermissionMapper extends BaseMapper<SysRolePermission> {

    void deleteByRoleId(@NotNull Long roleId);
}




