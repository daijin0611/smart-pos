package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

/**
 * 会员取消优惠券DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-10-19
 */
@Data
@Schema(description = "会员取消优惠券对象")
@Accessors(chain = true)
public class CancelTicketDTO {

    /**
     * 优惠券ID列表
     */
    @Schema(description = "要取消的优惠券ID列表", example = "[1, 2, 3]")
    @NotEmpty(message = "优惠券ID列表不能为空")
    private List<Long> ticketIds;
}