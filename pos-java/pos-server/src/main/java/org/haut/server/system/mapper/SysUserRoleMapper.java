package org.haut.server.system.mapper;

import org.haut.server.system.entity.SysUserRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
* @author daiji
* @description 针对表【sys_user_role(用户角色关联表)】的数据库操作Mapper
* @createDate 2025-04-21 17:06:12
* @Entity org.haut.server.system.entity.SysUserRole
*/
public interface SysUserRoleMapper extends BaseMapper<SysUserRole> {

    void deleteByUserId(Long userId);

    void deleteByRoleId(Long roleId);
}




