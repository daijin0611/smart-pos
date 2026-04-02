package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 疗程券状态修改DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
@Data
@Schema(description = "疗程券状态修改对象")
public class CureTicketStatusDTO {

    /**
     * 疗程券ID
     */
    @Schema(description = "疗程券ID")
    @NotNull(message = "疗程券ID不能为空")
    private Long id;

    /**
     * 状态（0 启用，1 停用）
     */
    @Schema(description = "状态（0 启用，1 停用）")
    @NotNull(message = "状态不能为空")
    private Integer status;
}