package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.query.system.AllocatedListQuery;
import org.haut.common.domain.query.system.UnAllocatedListQuery;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.common.domain.entity.system.SysRole;
import org.haut.server.system.service.SysRoleService;
import org.haut.server.system.mapper.SysRoleMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_role(系统角色表)】的数据库操作Service实现
* @createDate 2025-07-10 11:04:40
*/
@Service
@RequiredArgsConstructor
@Transactional
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole>
    implements SysRoleService{
    private final SysRoleMapper sysRoleMapper;

    /**
     * 查询角色已分配用户列表
     * @param query
     * @return
     */
    @Override
    public List<UserInfoVO> getAllocatedUserList(AllocatedListQuery query) {
        return sysRoleMapper.getAllocatedUserList(query);
    }

    /**
     * 查询角色未分配用户列表
     * @param query
     * @return
     */
    @Override
    public List<UserInfoVO> getUnAllocatedUserList(UnAllocatedListQuery query) {
        return sysRoleMapper.getUnAllocatedUserList(query);
    }

}




