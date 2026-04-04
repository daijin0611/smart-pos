package org.haut.server.system.service;

import org.haut.common.domain.query.system.OrgListQuery;
import org.haut.common.domain.dto.system.OrgDefaultRuleUpdateDTO;
import org.haut.common.domain.dto.system.OrgCreateDTO;
import org.haut.common.domain.dto.system.OrgPrintWidthUpdateDTO;
import org.haut.common.domain.vo.system.OrgInfoVO;
import org.haut.common.domain.vo.system.OrgSimpleVO;
import org.haut.server.system.entity.SysOrg;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
* @author daiji
* @description 针对表【sys_org(机构信息表)】的数据库操作Service
* @createDate 2025-07-12 23:54:18
*/
public interface SysOrgService extends IService<SysOrg> {

    List<OrgInfoVO> queryList(OrgListQuery query);

    void updateDefaultRule(OrgDefaultRuleUpdateDTO dto);

    void addOrg(OrgCreateDTO dto);

    /**
     * 更新门店打印宽度
     * @param dto 打印宽度更新对象
     */
    void updatePrintWidth(OrgPrintWidthUpdateDTO dto);

    /**
     * 批量查询门店简要信息，返回 Map<orgId, OrgSimpleVO>
     */
    Map<Long, OrgSimpleVO> getOrgSimpleMapByIds(Collection<Long> orgIds);

    /**
     * 批量查询门店简要信息，返回列表
     */
    List<OrgSimpleVO> getOrgSimpleListByIds(Collection<Long> orgIds);

    /**
     * 校验门店ID是否全部存在，不存在则抛出 BusinessException
     */
    void validateOrgIdsExist(Collection<Long> orgIds);
}
