package org.haut.server.system.service;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.common.domain.entity.system.SysUser;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
* @author daiji
* @description 针对表【sys_user(系统用户表（员工表）)】的数据库操作Service
* @createDate 2025-04-15 11:13:13
*/
public interface SysUserService extends IService<SysUser> , UserDetailsService {

    Page<SysUser> getList(UserListQuery query);
}
