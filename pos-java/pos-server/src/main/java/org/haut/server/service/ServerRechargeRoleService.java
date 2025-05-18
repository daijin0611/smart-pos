package org.haut.server.service;

import org.haut.common.domain.dto.server.RechaegeRoleListDTO;
import org.haut.common.domain.query.ServerRechaegeRoleListQuery;
import org.haut.server.entity.ServerRechargeRole;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_recharge_role(充值提成规则表)】的数据库操作Service
* @createDate 2025-05-05 11:37:00
*/
public interface ServerRechargeRoleService extends IService<ServerRechargeRole> {

    List<RechaegeRoleListDTO> getList(ServerRechaegeRoleListQuery query);
}
