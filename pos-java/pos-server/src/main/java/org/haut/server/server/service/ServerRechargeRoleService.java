package org.haut.server.server.service;

import org.haut.common.domain.dto.server.RechargeRoleCreateDTO;
import org.haut.common.domain.dto.server.RechargeRoleUpdateDTO;
import org.haut.server.server.entity.ServerRechargeRole;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.query.server.ServerRechargeRoleListQuery;
import org.haut.common.domain.vo.server.RechargeRoleVO;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_recharge_role(充值提成规则表)】的数据库操作Service
* @createDate 2025-05-05 11:37:00
*/
public interface ServerRechargeRoleService extends IService<ServerRechargeRole> {

    List<RechargeRoleVO> getList(ServerRechargeRoleListQuery query);

    void addRole(RechargeRoleCreateDTO role);

    void updateRole(RechargeRoleUpdateDTO role);

    void setDefaultRole(Long roleId);

    RechargeRoleVO getDefaultRole();
}
