package org.haut.server.server.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.server.RechaegeRoleListDTO;
import org.haut.common.domain.query.server.ServerRechaegeRoleListQuery;
import org.haut.server.server.entity.ServerRechargeRole;
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
    public List<RechaegeRoleListDTO> getList(ServerRechaegeRoleListQuery query) {
        //构建条件查询器，当充值提成规则名称不为空时，进行查询
        QueryWrapper<ServerRechargeRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(StringUtils.isNotBlank(query.getRechargeRoleName()),"recharge_role_name",query.getRechargeRoleName());
        //查询数据库
        List<ServerRechargeRole> serverRechargeRoles = serverRechargeRoleMapper.selectList(queryWrapper);
        return BeanUtil.copyToList(serverRechargeRoles, RechaegeRoleListDTO.class);
    }



}




