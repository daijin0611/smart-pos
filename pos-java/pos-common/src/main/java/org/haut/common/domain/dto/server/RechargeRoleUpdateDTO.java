package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "充值提成规则更新对象")
@Accessors(chain = true)
public class RechargeRoleUpdateDTO extends RechargeRoleCreateDTO{

    @Schema(description = "充值提成规则ID")
    private Long id;
}
