package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.system.entity.OrgRelationEntity;
import org.haut.server.system.mapper.OrgRelationMapper;
import org.haut.server.system.service.OrgRelationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 设定与门店关联 ServiceImpl
 */
@Service
public class OrgRelationServiceImpl extends ServiceImpl<OrgRelationMapper, OrgRelationEntity>
        implements OrgRelationService {

    @Override
    @Transactional
    public void bindOrgs(Integer itemType, Long itemId, List<Long> orgIds) {
        if (orgIds == null || orgIds.isEmpty()) {
            return;
        }
        List<OrgRelationEntity> entities = orgIds.stream().map(orgId -> {
            OrgRelationEntity entity = new OrgRelationEntity();
            entity.setItemType(itemType);
            entity.setItemId(itemId);
            entity.setOrgId(orgId);
            return entity;
        }).collect(Collectors.toList());
        this.saveBatch(entities);
    }

    @Override
    @Transactional
    public void unbindOrgs(Integer itemType, Long itemId) {
        LambdaQueryWrapper<OrgRelationEntity> wrapper = new LambdaQueryWrapper<OrgRelationEntity>()
                .eq(OrgRelationEntity::getItemType, itemType)
                .eq(OrgRelationEntity::getItemId, itemId);
        this.remove(wrapper);
    }

    @Override
    public List<Long> getItemIdsByOrg(Integer itemType, Long orgId) {
        LambdaQueryWrapper<OrgRelationEntity> wrapper = new LambdaQueryWrapper<OrgRelationEntity>()
                .eq(OrgRelationEntity::getItemType, itemType)
                .eq(OrgRelationEntity::getOrgId, orgId);
        List<OrgRelationEntity> list = this.list(wrapper);
        return list.stream().map(OrgRelationEntity::getItemId).collect(Collectors.toList());
    }

    @Override
    public List<Long> getOrgIdsByItem(Integer itemType, Long itemId) {
        LambdaQueryWrapper<OrgRelationEntity> wrapper = new LambdaQueryWrapper<OrgRelationEntity>()
                .eq(OrgRelationEntity::getItemType, itemType)
                .eq(OrgRelationEntity::getItemId, itemId);
        List<OrgRelationEntity> list = this.list(wrapper);
        return list.stream().map(OrgRelationEntity::getOrgId).collect(Collectors.toList());
    }

    @Override
    public Map<Long, List<Long>> getOrgIdsByItems(Integer itemType, List<Long> itemIds) {
        if (itemIds == null || itemIds.isEmpty()) {
            return Collections.emptyMap();
        }
        LambdaQueryWrapper<OrgRelationEntity> wrapper = new LambdaQueryWrapper<OrgRelationEntity>()
                .eq(OrgRelationEntity::getItemType, itemType)
                .in(OrgRelationEntity::getItemId, itemIds);
        List<OrgRelationEntity> list = this.list(wrapper);
        return list.stream().collect(Collectors.groupingBy(
                OrgRelationEntity::getItemId,
                Collectors.mapping(OrgRelationEntity::getOrgId, Collectors.toList())));
    }
}
