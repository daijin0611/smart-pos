package org.haut.server.system.service;

import org.haut.common.domain.query.system.PermissionListQuery;
import org.haut.common.domain.vo.system.PermissionInfoVO;
import org.haut.server.system.entity.SysPermission;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_permission(系统权限表)】的数据库操作Service
* @createDate 2025-07-10 13:49:56
*/
public interface SysPermissionService extends IService<SysPermission> {

    List<PermissionInfoVO> queryList(PermissionListQuery query);

    List<PermissionInfoVO> queryTreeByRoleId(Long roleId);

    List<PermissionInfoVO> queryTreeByUserId(Long userId);

    List<PermissionInfoVO> queryTree(PermissionListQuery query);
}
