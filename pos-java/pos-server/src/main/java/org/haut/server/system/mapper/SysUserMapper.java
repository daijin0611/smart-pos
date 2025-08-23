package org.haut.server.system.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.haut.server.system.entity.SysUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.haut.common.domain.query.system.UserListQuery;
import org.haut.common.domain.vo.system.RoleInfoVo;
import org.haut.common.domain.vo.system.UserInfoVO;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_user(系统用户表（员工表）)】的数据库操作Mapper
* @createDate 2025-04-15 11:13:13
* @Entity org.haut.server.system.entity.SysUser
*/
@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {

    List<RoleInfoVo> queryRoleList(Long userId);

    IPage<UserInfoVO> getList(
            @Param("page") Page<UserInfoVO> page,
            @Param("query") UserListQuery query,
            @Param("orgId") Long orgId);
}




