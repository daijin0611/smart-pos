package org.haut.server.system.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.haut.common.domain.query.system.PermissionListQuery;
import org.haut.common.domain.vo.system.PermissionInfoVO;
import org.haut.server.system.entity.SysPermission;
import org.haut.server.system.service.SysPermissionService;
import org.haut.server.system.mapper.SysPermissionMapper;
import org.springframework.stereotype.Service;

import java.util.List;

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
    @Override
    public List<PermissionInfoVO> queryList(PermissionListQuery query) {
        List<SysPermission> sysPermissions = sysPermissionMapper.selectList(Wrappers.lambdaQuery(SysPermission.class)
                .eq(StringUtils.isNotBlank(query.getPermName()), SysPermission::getPermName, query.getPermName())
                .eq(query.getPermStatus() != null, SysPermission::getPermStatus, query.getPermStatus())
        );
        List<PermissionInfoVO> permissionInfoVOS = BeanUtil.copyToList(sysPermissions, PermissionInfoVO.class);
        return List.of();
    }
}




