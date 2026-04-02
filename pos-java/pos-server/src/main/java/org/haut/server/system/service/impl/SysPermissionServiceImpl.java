package org.haut.server.system.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.query.system.PermissionListQuery;
import org.haut.common.domain.vo.system.PermissionInfoVO;
import org.haut.server.system.entity.SysPermission;
import org.haut.server.system.service.SysPermissionService;
import org.haut.server.system.mapper.SysPermissionMapper;
import org.springframework.stereotype.Service;

import java.util.*;

/**
* @author daiji
* @description 针对表【sys_permission(系统权限表)】的数据库操作Service实现
* @createDate 2025-07-10 13:49:56
*/
@Service
@RequiredArgsConstructor
public class SysPermissionServiceImpl extends ServiceImpl<SysPermissionMapper, SysPermission>
    implements SysPermissionService{
    private final SysPermissionMapper sysPermissionMapper;

    /**
     * 根据用户ID查询权限列表
     * @param userId
     * @return
     */
    @Override
    public List<PermissionInfoVO> queryTreeByUserId(Long userId) {
        List<SysPermission> sysPermissions = sysPermissionMapper.queryListByUserId(userId);
        List<PermissionInfoVO> permissionInfoVOS = BeanUtil.copyToList(sysPermissions, PermissionInfoVO.class);
        return buildTree(permissionInfoVOS, 0L);
    }

    @Override
    public List<PermissionInfoVO> queryTree(PermissionListQuery query) {
        List<SysPermission> sysPermissions = sysPermissionMapper.selectList(Wrappers.lambdaQuery(SysPermission.class)
                .eq(query.getStatus() != null, SysPermission::getPermStatus, 0)
                .like(StringUtils.isNotBlank(query.getName()), SysPermission::getName, query.getName())
        );
        List<PermissionInfoVO> permissionInfoVOS = BeanUtil.copyToList(sysPermissions, PermissionInfoVO.class);
        return buildTree(permissionInfoVOS, 0L);
    }

    /**
     * 查询权限列表
     * @param query
     * @return
     */
    @Override
    public List<PermissionInfoVO> queryList(PermissionListQuery query) {
        LambdaQueryWrapper<SysPermission> queryWrapper = Wrappers.lambdaQuery(SysPermission.class)
                .like(StringUtils.isNotBlank(query.getName()), SysPermission::getName, query.getName())
                .eq(query.getStatus() != null, SysPermission::getPermStatus, query.getStatus());
        List<SysPermission> sysPermissions = sysPermissionMapper.selectList(queryWrapper);
        return BeanUtil.copyToList(sysPermissions, PermissionInfoVO.class);
    }

    /**
     * 查询角色的权限列表
     * @param roleId
     * @return
     */
    @Override
    public List<PermissionInfoVO> queryTreeByRoleId(Long roleId) {
        List<SysPermission> sysPermissions = sysPermissionMapper.queryListByRoleId(roleId);
        List<PermissionInfoVO> permissionInfoVOS = BeanUtil.copyToList(sysPermissions, PermissionInfoVO.class);
        return buildTree(permissionInfoVOS, 0L);
    }

    /**
     * 递归构建权限树
     * @param permissionInfoVOS
     * @param parentId
     * @return
     */
    private List<PermissionInfoVO> buildTree(List<PermissionInfoVO> permissionInfoVOS, Long parentId) {
        List<PermissionInfoVO> children = new ArrayList<>();
        for (PermissionInfoVO permissionInfoVO : permissionInfoVOS){
            if (Objects.equals(permissionInfoVO.getParentId(), parentId)){
                permissionInfoVO.setChildren(buildTree(permissionInfoVOS, permissionInfoVO.getId()));
                children.add(permissionInfoVO);
            }
        }
        return children;
    }
}




