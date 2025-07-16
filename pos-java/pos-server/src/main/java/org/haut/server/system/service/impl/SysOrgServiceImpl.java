package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.hutool.core.bean.BeanUtil;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.query.system.OrgListQuery;
import org.haut.common.domain.vo.system.OrgInfoVO;
import org.haut.server.system.entity.SysOrg;
import org.haut.server.system.service.SysOrgService;
import org.haut.server.system.mapper.SysOrgMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_org(机构信息表)】的数据库操作Service实现
* @createDate 2025-07-12 23:54:18
*/
@Service
public class SysOrgServiceImpl extends ServiceImpl<SysOrgMapper, SysOrg>
    implements SysOrgService{

    /**
     * 获取机构列表
     * @param query 查询条件
     * @return 机构列表
     */
    @Override
    public List<OrgInfoVO> queryList(OrgListQuery query) {
        LambdaQueryWrapper<SysOrg> queryWrapper = Wrappers.lambdaQuery(SysOrg.class)
                .eq(StringUtils.isNotBlank(query.getOrgName()), SysOrg::getOrgName, query.getOrgName())
                .eq(query.getOrgStatus() != null, SysOrg::getOrgState, query.getOrgStatus())
                .eq(StringUtils.isNotBlank(query.getOrgCode()), SysOrg::getOrgCode, query.getOrgCode());
        List<SysOrg> list = this.list(queryWrapper);
        return BeanUtil.copyToList(list, OrgInfoVO.class);
    }
}




