package org.haut.server.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.server.system.entity.SysOrgUser;

import java.util.List;
import java.util.Map;

public interface SysOrgUserService extends IService<SysOrgUser> {

    /**
     * 批量绑定门店（先删后插）
     */
    void bindOrgs(Long userId, List<Long> orgIds);

    /**
     * 解除用户所有门店关联
     */
    void unbindOrgs(Long userId);

    /**
     * 查询用户关联的门店ID列表（不含主门店）
     */
    List<Long> getOrgIdsByUserId(Long userId);

    /**
     * 查询门店下的用户ID列表
     */
    List<Long> getUserIdsByOrgId(Long orgId);

    /**
     * 批量查询多个用户关联的门店ID（不含主门店），返回 Map<userId, List<orgId>>
     */
    Map<Long, List<Long>> batchGetOrgIdsByUserIds(List<Long> userIds);
}
