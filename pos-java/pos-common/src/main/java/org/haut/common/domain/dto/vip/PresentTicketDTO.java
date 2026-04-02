package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 会员赠送优惠券DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-10-19
 */
@Data
@Schema(description = "会员赠送优惠券对象")
@Accessors(chain = true)
public class PresentTicketDTO {

    /**
     * 优惠券ID
     */
    @Schema(description = "优惠券ID", example = "1")
    @NotNull(message = "优惠券ID不能为空")
    private Long vipTicketId;

    /**
     * 赠送数量
     */
    @Schema(description = "赠送数量", example = "1")
    @NotNull(message = "赠送数量不能为空")
    @Positive(message = "赠送数量必须大于0")
    private Integer number;

    /**
     * 赠送备注
     */
    @Schema(description = "赠送备注", example = "手动赠送")
    private String remark;

}