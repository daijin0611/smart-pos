package org.haut.server.system.mapper;

import org.haut.server.system.entity.SysPermission;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_permission(系统权限表)】的数据库操作Mapper
* @createDate 2025-07-10 13:49:56
* @Entity org.haut.server.system.entity.SysPermission
*/
public interface SysPermissionMapper extends BaseMapper<SysPermission> {

    List<SysPermission> queryListByRoleId(Long roleId);

    List<SysPermission> queryListByUserId(Long userId);
}




