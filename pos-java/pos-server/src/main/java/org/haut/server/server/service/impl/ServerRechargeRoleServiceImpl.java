package org.haut.server.server.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.server.RechargeRoleCreateDTO;
import org.haut.common.domain.dto.server.RechargeRoleUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.exception.BusinessException;
import org.haut.server.server.entity.ServerRechargeRole;
import org.haut.common.domain.query.server.ServerRechargeRoleListQuery;
import org.haut.common.domain.vo.server.RechargeRoleVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.server.service.ServerRechargeRoleService;
import org.haut.server.server.mapper.ServerRechargeRoleMapper;
import org.haut.server.system.entity.SysOrg;
import org.haut.server.system.mapper.SysOrgMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
* @author Cdh
* @description 针对表【server_recharge_role(充值提成规则表)】的数据库操作Service实现
* @createDate 2025-05-05 11:37:00
*/
@Service
@Slf4j
public class ServerRechargeRoleServiceImpl extends ServiceImpl<ServerRechargeRoleMapper, ServerRechargeRole>
    implements ServerRechargeRoleService{
    @Autowired
    private ServerRechargeRoleMapper serverRechargeRoleMapper;
    @Autowired
    private SysOrgMapper sysOrgMapper;

    /**
     * 查询充值提成规则列表（全局查询，不再按门店过滤）
     */
    @Override
    public List<RechargeRoleVO> getList(ServerRechargeRoleListQuery query) {
        log.info("查询充值提成规则列表，状态：{}，名称：{}", query.getStatus(), query.getRechargeRoleName());
        LambdaQueryWrapper<ServerRechargeRole> queryWrapper = Wrappers.lambdaQuery(ServerRechargeRole.class)
                .eq(query.getStatus() != null, ServerRechargeRole::getStatus, query.getStatus())
                .like(StringUtils.isNotBlank(query.getRechargeRoleName()), ServerRechargeRole::getRechargeRoleName, query.getRechargeRoleName());
        List<ServerRechargeRole> serverRechargeRoles = serverRechargeRoleMapper.selectList(queryWrapper);
        log.info("查询到充值提成规则数量：{}", serverRechargeRoles.size());
        List<RechargeRoleVO> voList = BeanUtil.copyToList(serverRechargeRoles, RechargeRoleVO.class);
        // 填充每个规则关联的门店ID列表
        for (RechargeRoleVO vo : voList) {
            List<Long> orgIds = sysOrgMapper.selectList(Wrappers.lambdaQuery(SysOrg.class)
                            .select(SysOrg::getId)
                            .eq(SysOrg::getDefaultRechargeRoleId, vo.getId()))
                    .stream().map(SysOrg::getId).collect(Collectors.toList());
            vo.setOrgIds(orgIds);
        }
        return voList;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addRole(RechargeRoleCreateDTO role) {
        log.info("新增充值提成规则，名称：{}", role.getRechargeRoleName());
        ServerRechargeRole bean = BeanUtil.toBean(role, ServerRechargeRole.class);
        this.save(bean);
        // 批量关联门店
        bindOrgs(bean.getId(), role.getOrgIds());
        log.info("充值提成规则新增成功，ID：{}，关联门店数：{}", bean.getId(),
                role.getOrgIds() != null ? role.getOrgIds().size() : 0);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateRole(RechargeRoleUpdateDTO role) {
        log.info("更新充值提成规则，ID：{}，名称：{}", role.getId(), role.getRechargeRoleName());
        ServerRechargeRole bean = BeanUtil.toBean(role, ServerRechargeRole.class);
        this.updateById(bean);
        // 先解除旧的门店关联，再绑定新的
        unbindOrgsByRoleId(role.getId());
        bindOrgs(bean.getId(), role.getOrgIds());
        log.info("充值提成规则更新完成，关联门店数：{}", role.getOrgIds() != null ? role.getOrgIds().size() : 0);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void setDefaultRole(Long roleId) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        log.info("设置默认充值提成规则，门店ID：{}，规则ID：{}", auth.getOrgId(), roleId);
        ServerRechargeRole role = this.getById(roleId);
        if (role == null) {
            throw new BusinessException("提成规则不存在");
        }
        // 将当前门店的默认充值提成规则设置为指定规则
        sysOrgMapper.update(null, Wrappers.lambdaUpdate(SysOrg.class)
                .set(SysOrg::getDefaultRechargeRoleId, roleId)
                .eq(SysOrg::getId, auth.getOrgId()));
        log.info("默认充值提成规则设置成功");
    }

    @Override
    public RechargeRoleVO getDefaultRole() {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        log.info("获取门店默认充值提成规则，门店ID：{}", auth.getOrgId());
        SysOrg org = sysOrgMapper.selectById(auth.getOrgId());
        if (org == null || org.getDefaultRechargeRoleId() == null) {
            log.info("门店未设置默认充值提成规则");
            return null;
        }
        ServerRechargeRole role = this.getById(org.getDefaultRechargeRoleId());
        log.info("获取默认充值提成规则，规则ID：{}，名称：{}", org.getDefaultRechargeRoleId(),
                role != null ? role.getRechargeRoleName() : "null");
        RechargeRoleVO vo = BeanUtil.toBean(role, RechargeRoleVO.class);
        if (vo != null) {
            List<Long> orgIds = sysOrgMapper.selectList(Wrappers.lambdaQuery(SysOrg.class)
                            .select(SysOrg::getId)
                            .eq(SysOrg::getDefaultRechargeRoleId, vo.getId()))
                    .stream().map(SysOrg::getId).collect(Collectors.toList());
            vo.setOrgIds(orgIds);
        }
        return vo;
    }

    /**
     * 批量将门店的默认充值提成规则ID设置为指定的规则ID
     */
    private void bindOrgs(Long roleId, List<Long> orgIds) {
        if (orgIds == null || orgIds.isEmpty()) {
            return;
        }
        log.info("绑定门店到提成规则，规则ID：{}，门店数量：{}", roleId, orgIds.size());
        for (Long orgId : orgIds) {
            sysOrgMapper.update(null, Wrappers.lambdaUpdate(SysOrg.class)
                    .set(SysOrg::getDefaultRechargeRoleId, roleId)
                    .eq(SysOrg::getId, orgId));
        }
    }

    /**
     * 解除指定规则关联的所有门店
     */
    private void unbindOrgsByRoleId(Long roleId) {
        log.info("解除规则关联的门店，规则ID：{}", roleId);
        sysOrgMapper.update(null, Wrappers.lambdaUpdate(SysOrg.class)
                .set(SysOrg::getDefaultRechargeRoleId, null)
                .eq(SysOrg::getDefaultRechargeRoleId, roleId));
    }
}
