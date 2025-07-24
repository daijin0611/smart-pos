package org.haut.server.system.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.common.domain.entity.system.SysUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
* @author daiji
* @description 针对表【sys_user(系统用户表（员工表）)】的数据库操作Mapper
* @createDate 2025-04-15 11:13:13
* @Entity org.haut.common.domain.entity.system.SysUser
*/
@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {
}




