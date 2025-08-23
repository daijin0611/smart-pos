package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.system.RolePermissionAddDTO;
import org.haut.common.domain.dto.system.RoleUserAddDTO;
import org.haut.server.system.entity.SysRolePermission;
import org.haut.server.system.entity.SysUserRole;
import org.haut.common.domain.query.system.AllocatedListQuery;
import org.haut.common.domain.query.system.UnAllocatedListQuery;
import org.haut.common.domain.vo.system.UserInfoVO;
import org.haut.server.system.entity.SysRole;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.system.mapper.SysRolePermissionMapper;
import org.haut.server.system.mapper.SysUserRoleMapper;
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
    private final SysUserRoleMapper sysUserRoleMapper;
    private final SysRolePermissionMapper sysRolePermissionMapper;

    /**
     * 查询角色已分配用户列表
     * 当前门店
     * @param query
     * @return
     */
    @Override
    public List<UserInfoVO> getAllocatedUserList(AllocatedListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        return sysRoleMapper.getAllocatedUserList(query, auth.getOrgId());
    }

    /**
     * 查询角色未分配用户列表
     * 当前门店
     * @param query
     * @return
     */
    @Override
    public List<UserInfoVO> getUnAllocatedUserList(UnAllocatedListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        return sysRoleMapper.getUnAllocatedUserList(query, auth.getOrgId());
    }

    /**
     * 添加用户到角色
     * 1. 检查角色是否存在
     * 2. 删除之前的用户
     * 3. 添加新用户
     * @param dto
     */
    @Override
    public void addUserToRole(RoleUserAddDTO dto) {
        // 检查角色是否存在
        SysRole role = sysRoleMapper.selectById(dto.getRoleId());
        if (role == null) {
            throw new BusinessException("角色不存在");
        }

        // 删除之前的用户
        sysUserRoleMapper.deleteByRoleId(dto.getRoleId());

        // 添加新用户
        List<SysUserRole> list = dto.getUserIds().stream()
                .map(userId -> new SysUserRole()
                        .setRoleId(dto.getRoleId())
                        .setUserId(userId))
                .toList();
        sysUserRoleMapper.insert(list);
    }

    /**
     * 添加权限到角色
     * @param dto
     */
    @Override
    public void addPermToRole(RolePermissionAddDTO dto) {
        // 检查角色是否存在
        SysRole role = sysRoleMapper.selectById(dto.getRoleId());
        if (role == null) {
            throw new BusinessException("角色不存在");
        }

        // 删除之前的权限
        sysRolePermissionMapper.deleteByRoleId(dto.getRoleId());

        // 添加新权限
        List<SysRolePermission> list = dto.getPermissionIds().stream()
                .map(permissionId -> new SysRolePermission()
                        .setRoleId(dto.getRoleId())
                        .setPermissionId(permissionId))
                .toList();
        sysRolePermissionMapper.insert(list);
    }

}




