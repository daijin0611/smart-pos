package org.haut.server.system.service;

import org.haut.common.domain.dto.system.RolePermissionAddDTO;
import org.haut.common.domain.dto.system.RoleUserAddDTO;
import org.haut.common.domain.query.system.AllocatedListQuery;
import org.haut.common.domain.query.system.UnAllocatedListQuery;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.server.system.entity.SysRole;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_role(系统角色表)】的数据库操作Service
* @createDate 2025-07-10 11:04:40
*/
public interface SysRoleService extends IService<SysRole> {

    List<UserInfoVO> getAllocatedUserList(AllocatedListQuery query);

    List<UserInfoVO> getUnAllocatedUserList(UnAllocatedListQuery query);

    void addUserToRole(RoleUserAddDTO dto);

    void addPermToRole(RolePermissionAddDTO dto);
}
