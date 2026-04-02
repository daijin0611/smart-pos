package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 会员赠送资产DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-10-19
 */
@Data
@Schema(description = "会员赠送资产对象")
public class PresentAssetDTO {
    
    /**
     * 赠送金额
     */
    @Schema(description = "赠送金额", example = "100.00")
    @NotNull(message = "赠送金额不能为空")
    @DecimalMin(value = "0.01", message = "赠送金额必须大于0")
    @DecimalMax(value = "999999.99", message = "赠送金额不能超过999999.99")
    private BigDecimal presentAmount;
    
    /**
     * 折扣率百分比
     */
    @Schema(description = "折扣率", example = "80")
    @NotNull(message = "折扣率不能为空")
    private Integer discountRate;
    
    /**
     * 折扣基础（0 标准价，1 会员价）
     */
    @Schema(description = "折扣基础（0 标准价，1 会员价）", example = "0")
    @NotNull(message = "折扣基础不能为空")
    private Integer discountBase;
    
    /**
     * 是否跨店结算（0 不允许，1 允许）
     */
    @Schema(description = "是否跨店结算（0 不允许，1 允许）", example = "0")
    @NotNull(message = "跨店结算设置不能为空")
    private Integer isCrossStore;
    
    /**
     * 备注
     */
    @Schema(description = "备注", example = "手动赠送")
    private String remark;
}