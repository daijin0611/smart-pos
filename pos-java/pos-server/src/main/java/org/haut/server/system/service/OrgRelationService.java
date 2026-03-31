package org.haut.server.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.server.system.entity.OrgRelationEntity;

import java.util.List;
import java.util.Map;

/**
 * 设定与门店关联 Service
 */
public interface OrgRelationService extends IService<OrgRelationEntity> {

    /**
     * 批量绑定门店关联
     */
    void bindOrgs(Integer itemType, Long itemId, List<Long> orgIds);

    /**
     * 解除某设定项目的全部门店关联
     */
    void unbindOrgs(Integer itemType, Long itemId);

    /**
     * 查询某门店关联的设定项目ID列表
     */
    List<Long> getItemIdsByOrg(Integer itemType, Long orgId);

    /**
     * 查询某设定项目关联的门店ID列表
     */
    List<Long> getOrgIdsByItem(Integer itemType, Long itemId);

    /**
     * 批量查询多个设定项目关联的门店ID列表
     * @param itemType 设定类型
     * @param itemIds 设定项目ID列表
     * @return key=itemId, value=orgId列表
     */
    Map<Long, List<Long>> getOrgIdsByItems(Integer itemType, List<Long> itemIds);
}
