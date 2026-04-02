package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 门店默认规则更新对象
 *
 * @author mhding
 * @version 1.0
 * @since 2025-11-30
 */
@Data
@Schema(description = "门店默认规则更新对象")
public class OrgDefaultRuleUpdateDTO {

    @Schema(description = "折扣率（百分比）", example = "100")
    @NotNull(message = "折扣率不能为空")
    @Min(value = 0, message = "折扣率不能小于0")
    @Max(value = 100, message = "折扣率不能大于100")
    private Integer defaultDiscountRate;

    @Schema(description = "折扣基准（0 标准价，1 会员价）", example = "1")
    @NotNull(message = "折扣基准不能为空")
    @Min(value = 0, message = "折扣基准值错误")
    @Max(value = 1, message = "折扣基准值错误")
    private Integer defaultDiscountBase;

    @Schema(description = "跨店结算（0 不允许，1 允许）", example = "1")
    @NotNull(message = "跨店结算设置不能为空")
    @Min(value = 0, message = "跨店结算值错误")
    @Max(value = 1, message = "跨店结算值错误")
    private Integer defaultIsCrossStore;

    @Schema(description = "默认充值提成规则ID", example = "1")
    private Long defaultRechargeRoleId;
}

