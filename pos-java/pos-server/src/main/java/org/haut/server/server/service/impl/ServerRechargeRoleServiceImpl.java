package org.haut.server.server.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.server.RechargeRoleCreateDTO;
import org.haut.common.domain.dto.server.RechargeRoleUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.server.server.entity.ServerRechargeRole;
import org.haut.common.domain.query.server.ServerRechargeRoleListQuery;
import org.haut.common.domain.vo.server.RechargeRoleVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.server.service.ServerRechargeRoleService;
import org.haut.server.server.mapper.ServerRechargeRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_recharge_role(充值提成规则表)】的数据库操作Service实现
* @createDate 2025-05-05 11:37:00
*/
@Service
public class ServerRechargeRoleServiceImpl extends ServiceImpl<ServerRechargeRoleMapper, ServerRechargeRole>
    implements ServerRechargeRoleService{
    @Autowired
    private ServerRechargeRoleMapper serverRechargeRoleMapper;
    /**
     * 查询充值提成规则列表
     * @param query
     * @return
     */
    @Override
    public List<RechargeRoleVO> getList(ServerRechargeRoleListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LambdaQueryWrapper<ServerRechargeRole> queryWrapper = Wrappers.lambdaQuery(ServerRechargeRole.class)
                .eq(query.getStatus() != null, ServerRechargeRole::getStatus, query.getStatus())
                .like(StringUtils.isNotBlank(query.getRechargeRoleName()), ServerRechargeRole::getRechargeRoleName, query.getRechargeRoleName())
                .eq(auth.getOrgId() != null, ServerRechargeRole::getOrgId, auth.getOrgId());
        //查询数据库
        List<ServerRechargeRole> serverRechargeRoles = serverRechargeRoleMapper.selectList(queryWrapper);
        return BeanUtil.copyToList(serverRechargeRoles, RechargeRoleVO.class);
    }

    @Override
    public void addRole(RechargeRoleCreateDTO role) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        ServerRechargeRole bean = BeanUtil.toBean(role, ServerRechargeRole.class);
        bean.setOrgId(auth.getOrgId());
        this.save(bean);
        if(this.lambdaQuery().eq(ServerRechargeRole::getIsDefault, 1).eq(ServerRechargeRole::getOrgId, auth.getOrgId()).count() == 0){
            // 如果该门店下没有默认规则，则将新增的规则设置为默认
            this.lambdaUpdate()
                    .set(ServerRechargeRole::getIsDefault, 1)
                    .eq(ServerRechargeRole::getId, bean.getId())
                    .update();
        }
    }

    @Override
    public void updateRole(RechargeRoleUpdateDTO role) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        ServerRechargeRole bean = BeanUtil.toBean(role, ServerRechargeRole.class);
        bean.setOrgId(auth.getOrgId());
        this.updateById(bean);
    }

    @Override
    public void setDefaultRole(Long roleId) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        // 将该门店下的所有规则都设置为非默认
        this.lambdaUpdate()
                .set(ServerRechargeRole::getIsDefault, 0)
                .eq(ServerRechargeRole::getOrgId, auth.getOrgId())
                .update();
        // 将指定的规则设置为默认
        this.lambdaUpdate()
                .set(ServerRechargeRole::getIsDefault, 1)
                .eq(ServerRechargeRole::getId, roleId)
                .update();
    }

    @Override
    public RechargeRoleVO getDefaultRole() {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        ServerRechargeRole role = this.getOne(Wrappers.lambdaQuery(ServerRechargeRole.class)
                .eq(ServerRechargeRole::getOrgId, auth.getOrgId())
                .eq(ServerRechargeRole::getIsDefault, 1));
        return BeanUtil.toBean(role, RechargeRoleVO.class);
    }

}




