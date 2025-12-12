package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.hutool.core.bean.BeanUtil;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.query.system.OrgListQuery;
import org.haut.common.domain.dto.system.OrgDefaultRuleUpdateDTO;
import org.haut.common.domain.dto.system.OrgCreateDTO;
import org.haut.common.domain.dto.system.OrgPrintWidthUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.vo.system.OrgInfoVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.system.entity.SysOrg;
import org.haut.server.system.entity.SysRole;
import org.haut.server.system.entity.SysUser;
import org.haut.server.system.entity.SysUserRole;
import org.haut.server.system.mapper.SysOrgMapper;
import org.haut.server.system.mapper.SysRoleMapper;
import org.haut.server.system.mapper.SysUserMapper;
import org.haut.server.system.mapper.SysUserRoleMapper;
import org.haut.server.system.service.SysOrgService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_org(机构信息表)】的数据库操作Service实现
* @createDate 2025-07-12 23:54:18
*/
@Service
@RequiredArgsConstructor
public class SysOrgServiceImpl extends ServiceImpl<SysOrgMapper, SysOrg>
    implements SysOrgService{

    private final SysUserMapper sysUserMapper;
    private final SysUserRoleMapper sysUserRoleMapper;
    private final SysRoleMapper sysRoleMapper;

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

    @Override
    public void updateDefaultRule(OrgDefaultRuleUpdateDTO dto) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        this.lambdaUpdate()
                .set(SysOrg::getDefaultDiscountRate, dto.getDefaultDiscountRate())
                .set(SysOrg::getDefaultDiscountBase, dto.getDefaultDiscountBase())
                .set(SysOrg::getDefaultIsCrossStore, dto.getDefaultIsCrossStore())
                .set(SysOrg::getDefaultRechargeRoleId, dto.getDefaultRechargeRoleId())
                .eq(SysOrg::getId, auth.getOrgId())
                .update();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addOrg(OrgCreateDTO dto) {
        SysOrg org = BeanUtil.toBean(dto, SysOrg.class);
        this.save(org);

        SysRole managerRole = sysRoleMapper.selectOne(Wrappers.lambdaQuery(SysRole.class)
                .eq(SysRole::getRoleCode, "STORE_MANAGER"));
        if (managerRole == null) {
            throw new BusinessException("店长角色不存在");
        }

        SysUser user = new SysUser();
        String defaultCode = StringUtils.isNotBlank(dto.getOrgLeaderNum())
                ? dto.getOrgLeaderNum()
                : dto.getOrgCode() + "_MGR";
        user.setUserCode(defaultCode);
        user.setUserPassword("123456");
        user.setUserName(dto.getOrgLeader());
        user.setUserNumber(dto.getOrgLeaderNum());
        user.setUserPosition("店长");
        user.setOrgId(org.getId());
        user.setRoleId(managerRole.getId());
        user.setRemark("门店创建默认用户");
        sysUserMapper.insert(user);

        sysUserRoleMapper.insert(new SysUserRole()
                .setUserId(user.getId())
                .setRoleId(managerRole.getId()));
    }

    @Override
    public void updatePrintWidth(OrgPrintWidthUpdateDTO dto) {
        // 校验门店是否存在
        SysOrg org = this.getById(dto.getId());
        if (org == null) {
            throw new BusinessException("门店不存在");
        }
        // 更新打印宽度
        this.lambdaUpdate()
                .set(SysOrg::getPrintWidth, dto.getPrintWidth())
                .eq(SysOrg::getId, dto.getId())
                .update();
    }
}




