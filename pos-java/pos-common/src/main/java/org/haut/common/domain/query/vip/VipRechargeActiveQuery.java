package org.haut.common.domain.query.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 充值活动查询条件
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
@Data
@Schema(description = "充值活动查询条件")
public class VipRechargeActiveQuery {
    
    /**
     * 活动状态
     */
    @Schema(description = "活动状态")
    private Integer activeStatus;
    
    /**
     * 活动名称
     */
    @Schema(description = "活动名称")
    private String activeName;

}