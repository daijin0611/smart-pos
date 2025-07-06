package org.haut.common.domain.query.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "充值提成规则列表查询对象")
public class ServerRechaegeRoleListQuery {
    @Schema(description = "充值提成规则名称")
    private String rechargeRoleName;
}
