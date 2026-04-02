package org.haut.server.server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.ServerItemCreateDTO;
import org.haut.common.domain.dto.server.ServerItemUpdateDTO;
import org.haut.common.domain.query.server.ServerItemQuery;
import org.haut.common.enums.OrgRelationTypeEnum;
import org.haut.server.server.entity.ServerItem;
import org.haut.common.domain.vo.server.ServerItemVO;
import org.haut.common.exception.BusinessException;
import org.haut.server.server.mapper.ServerItemMapper;
import org.haut.server.server.service.ServerItemService;
import org.haut.server.system.service.OrgRelationService;
import org.haut.server.system.service.SysOrgService;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
interface ServerItemConvert{

    List<ServerItemVO> toVOList(List<ServerItem> serverItems);

    ServerItemVO toVO(ServerItem serverItem);

    ServerItem toEntity(ServerItemCreateDTO item);

    ServerItem toEntity(ServerItemUpdateDTO item);
}

/**
 * 服务项目
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ServerItemServiceImpl extends ServiceImpl<ServerItemMapper, ServerItem>
        implements ServerItemService {
    private final ServerItemConvert serverItemConvert;
    private final OrgRelationService orgRelationService;
    private final SysOrgService sysOrgService;

    /**
     * 查询服务项目列表
     */
    @Override
    public List<ServerItemVO> getList(ServerItemQuery query) {
        log.info("查询服务项目列表，查询条件：{}", query);
        LambdaQueryWrapper<ServerItem> queryWrapper = Wrappers.lambdaQuery(ServerItem.class)
                .and(StringUtils.isNotBlank(query.getKeyWord()),
                        w -> w.like(ServerItem::getItemName, query.getKeyWord())
                                .or()
                                .like(ServerItem::getItemEncode, query.getKeyWord()))
                .eq(query.getItemStatus() != null, ServerItem::getItemStatus, query.getItemStatus())
                .eq(StringUtils.isNotBlank(query.getCategory()), ServerItem::getCategory, query.getCategory());
        if (query.getOrgId() != null) {
            List<Long> itemIds = orgRelationService.getItemIdsByOrg(
                    OrgRelationTypeEnum.SERVER_ITEM.getValue(), query.getOrgId());
            if (itemIds.isEmpty()) {
                return Collections.emptyList();
            }
            queryWrapper.in(ServerItem::getId, itemIds);
        }
        List<ServerItem> serverItems = this.list(queryWrapper);
        List<ServerItemVO> voList = serverItemConvert.toVOList(serverItems);
        if (!voList.isEmpty()) {
            List<Long> itemIds = serverItems.stream().map(ServerItem::getId).toList();
            Map<Long, List<Long>> orgIdMap = orgRelationService.getOrgIdsByItems(
                    OrgRelationTypeEnum.SERVER_ITEM.getValue(), itemIds);
            Set<Long> allOrgIds = orgIdMap.values().stream()
                    .flatMap(List::stream).collect(Collectors.toSet());
            Map<Long, OrgSimpleVO> orgVoMap = sysOrgService.getOrgSimpleMapByIds(allOrgIds);
            voList.forEach(vo -> {
                List<Long> idList = orgIdMap.getOrDefault(vo.getId(), Collections.emptyList());
                vo.setOrgs(idList.stream().map(orgVoMap::get)
                        .filter(Objects::nonNull).toList());
            });
        }
        log.info("查询服务项目列表完成，共{}条", voList.size());
        return voList;
    }

    /**
     * 根据ID查询服务项目
     */
    @Override
    public ServerItemVO queryById(Long id) {
        log.info("查询服务项目详情，id：{}", id);
        ServerItemVO vo = serverItemConvert.toVO(this.getById(id));
        if (vo != null) {
            vo.setOrgs(sysOrgService.getOrgSimpleListByIds(orgRelationService.getOrgIdsByItem(
                    OrgRelationTypeEnum.SERVER_ITEM.getValue(), id)));
        }
        return vo;
    }

    /**
     * 添加服务项目
     */
    @Override
    @Transactional
    public void addServerItem(ServerItemCreateDTO item) {
        log.info("新增服务项目，数据：{}", item);
        // 校验编码唯一
        if (this.count(Wrappers.lambdaQuery(ServerItem.class)
                .eq(ServerItem::getItemEncode, item.getItemEncode())) > 0) {
            throw new BusinessException("服务项目编码已存在");
        }
        // 校验名称唯一
        if (this.count(Wrappers.lambdaQuery(ServerItem.class)
                .eq(ServerItem::getItemName, item.getItemName())) > 0) {
            throw new BusinessException("服务项目名称已存在");
        }
        ServerItem entity = serverItemConvert.toEntity(item);
        this.save(entity);
        // 绑定门店关联
        if (item.getOrgIds() != null && !item.getOrgIds().isEmpty()) {
            log.info("绑定服务项目门店关联，itemId：{}，orgIds：{}", entity.getId(), item.getOrgIds());
            orgRelationService.bindOrgs(OrgRelationTypeEnum.SERVER_ITEM.getValue(),
                    entity.getId(), item.getOrgIds());
        }
    }

    /**
     * 更新服务项目
     */
    @Override
    @Transactional
    public void updateServerItem(ServerItemUpdateDTO item) {
        log.info("更新服务项目，数据：{}", item);
        // 校验编码唯一
        if (this.count(Wrappers.lambdaQuery(ServerItem.class)
                .eq(ServerItem::getItemEncode, item.getItemEncode())
                .ne(ServerItem::getId, item.getId())) > 0) {
            throw new BusinessException("服务项目编码已存在");
        }
        // 校验名称唯一
        if (this.count(Wrappers.lambdaQuery(ServerItem.class)
                .eq(ServerItem::getItemName, item.getItemName())
                .ne(ServerItem::getId, item.getId())) > 0) {
            throw new BusinessException("服务项目名称已存在");
        }
        ServerItem entity = serverItemConvert.toEntity(item);
        this.updateById(entity);
        // 更新门店关联
        if (item.getOrgIds() != null) {
            log.info("更新服务项目门店关联，itemId：{}，orgIds：{}", item.getId(), item.getOrgIds());
            orgRelationService.unbindOrgs(OrgRelationTypeEnum.SERVER_ITEM.getValue(), item.getId());
            orgRelationService.bindOrgs(OrgRelationTypeEnum.SERVER_ITEM.getValue(),
                    item.getId(), item.getOrgIds());
        }
    }
}
