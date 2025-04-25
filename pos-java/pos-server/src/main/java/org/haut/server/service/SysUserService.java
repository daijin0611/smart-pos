package org.haut.server.service;

import org.haut.common.domain.dto.system.UserListDTO;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.server.entity.SysUser;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_user(系统用户表（员工表）)】的数据库操作Service
* @createDate 2025-04-15 11:13:13
*/
public interface SysUserService extends IService<SysUser> {

    List<UserListDTO> getList(UserListQuery query);

}
