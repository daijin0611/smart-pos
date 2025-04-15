package org.haut.server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.server.entity.SysUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.mybatis.spring.annotation.MapperScan;

/**
* @author daiji
* @description 针对表【sys_user(系统用户表（员工表）)】的数据库操作Mapper
* @createDate 2025-04-15 11:13:13
* @Entity org.haut.server.entity.SysUser
*/
@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {

}




