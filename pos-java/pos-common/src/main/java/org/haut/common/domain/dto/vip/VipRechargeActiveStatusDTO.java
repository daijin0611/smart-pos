package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 充值活动状态修改DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
@Data
@Schema(description = "充值活动状态修改对象")
public class VipRechargeActiveStatusDTO {
    
    /**
     * 充值活动ID
     */
    @Schema(description = "充值活动ID")
    @NotNull(message = "充值活动ID不能为空")
    private Long id;
    
    /**
     * 活动状态
     */
    @Schema(description = "活动状态")
    @NotNull(message = "活动状态不能为空")
    private Integer activeStatus;
}