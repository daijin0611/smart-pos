package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

/**
 * 充值冲正请求 DTO
 *
 * @author mhding
 * @version 1.0
 * @since 2025-11-30
 */
@Data
@Schema(description = "充值冲正请求参数")
public class RechargeReverseDTO {

    @Schema(description = "交易流水号（充值单号）", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotBlank(message = "交易流水号不能为空")
    private String historyCode;

    @Schema(description = "冲正原因")
    private String reverseReason;
}
