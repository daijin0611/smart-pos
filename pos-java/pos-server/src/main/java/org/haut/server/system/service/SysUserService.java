package org.haut.server.system.service;


import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.system.UserAllocateRoleDTO;
import org.haut.common.domain.dto.system.UserCreateDTO;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.server.system.entity.SysUser;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.vo.system.RoleInfoVo;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_user(系统用户表（员工表）)】的数据库操作Service
* @createDate 2025-04-15 11:13:13
*/
public interface SysUserService extends IService<SysUser> , UserDetailsService {

    PageDTO<UserInfoVO> getList(UserListQuery query);

    void addUser(UserCreateDTO user);

    void allocateRole(UserAllocateRoleDTO dto);

    List<RoleInfoVo> queryRoleList(Long userId);

    UserInfoVO queryOne(Long id, String userNumber);
}
