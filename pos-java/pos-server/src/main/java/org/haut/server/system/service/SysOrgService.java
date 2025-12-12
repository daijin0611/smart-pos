package org.haut.server.system.service;

import org.haut.common.domain.query.system.OrgListQuery;
import org.haut.common.domain.dto.system.OrgDefaultRuleUpdateDTO;
import org.haut.common.domain.dto.system.OrgCreateDTO;
import org.haut.common.domain.dto.system.OrgPrintWidthUpdateDTO;
import org.haut.common.domain.vo.system.OrgInfoVO;
import org.haut.server.system.entity.SysOrg;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

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
}
