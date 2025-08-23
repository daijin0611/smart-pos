package org.haut.server.system.mapper;

import org.apache.ibatis.annotations.Param;
import org.haut.common.domain.query.system.AllocatedListQuery;
import org.haut.common.domain.query.system.UnAllocatedListQuery;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.server.system.entity.SysRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_role(系统角色表)】的数据库操作Mapper
* @createDate 2025-07-10 11:04:40
* @Entity org.haut.server.system.entity.SysRole
*/
public interface SysRoleMapper extends BaseMapper<SysRole> {

    List<UserInfoVO> getAllocatedUserList(@Param("query") AllocatedListQuery query,
                                          @Param("orgId") Long orgId);

    List<UserInfoVO> getUnAllocatedUserList(@Param("query") UnAllocatedListQuery query,
                                            @Param("orgId") Long orgId);
}




