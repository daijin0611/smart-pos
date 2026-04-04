package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.server.system.entity.SysOrgUser;
import org.haut.server.system.mapper.SysOrgUserMapper;
import org.haut.server.system.service.SysOrgService;
import org.haut.server.system.service.SysOrgUserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SysOrgUserServiceImpl extends ServiceImpl<SysOrgUserMapper, SysOrgUser>
        implements SysOrgUserService {

    private final SysOrgService sysOrgService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void bindOrgs(Long userId, List<Long> orgIds) {
        if (orgIds == null || orgIds.isEmpty()) {
            return;
        }
        sysOrgService.validateOrgIdsExist(orgIds);
        List<SysOrgUser> records = orgIds.stream().map(orgId -> {
            SysOrgUser entity = new SysOrgUser();
            entity.setUsrId(userId);
            entity.setOrgId(orgId);
            return entity;
        }).toList();
        saveBatch(records);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void unbindOrgs(Long userId) {
        remove(new LambdaQueryWrapper<SysOrgUser>().eq(SysOrgUser::getUsrId, userId));
    }

    @Override
    public List<Long> getOrgIdsByUserId(Long userId) {
        List<SysOrgUser> list = list(new LambdaQueryWrapper<SysOrgUser>()
                .eq(SysOrgUser::getUsrId, userId));
        if (list.isEmpty()) {
            return Collections.emptyList();
        }
        return list.stream().map(SysOrgUser::getOrgId).toList();
    }

    @Override
    public List<Long> getUserIdsByOrgId(Long orgId) {
        List<SysOrgUser> list = list(new LambdaQueryWrapper<SysOrgUser>()
                .eq(SysOrgUser::getOrgId, orgId));
        if (list.isEmpty()) {
            return Collections.emptyList();
        }
        return list.stream().map(SysOrgUser::getUsrId).toList();
    }

    @Override
    public Map<Long, List<Long>> batchGetOrgIdsByUserIds(List<Long> userIds) {
        if (userIds == null || userIds.isEmpty()) {
            return Collections.emptyMap();
        }
        List<SysOrgUser> list = list(new LambdaQueryWrapper<SysOrgUser>()
                .in(SysOrgUser::getUsrId, userIds));
        return list.stream().collect(Collectors.groupingBy(
                SysOrgUser::getUsrId,
                Collectors.mapping(SysOrgUser::getOrgId, Collectors.toList())
        ));
    }
}
