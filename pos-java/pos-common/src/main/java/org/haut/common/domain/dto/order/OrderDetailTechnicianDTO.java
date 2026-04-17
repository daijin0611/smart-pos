package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Schema(description = "订单明细技师DTO")
public class OrderDetailTechnicianDTO {

    @NotNull(message = "技师ID不能为空")
    @Schema(description = "技师ID")
    private Long userId;

    @Schema(description = "技师姓名")
    private String userName;

    @Schema(description = "员工编号")
    private String userCode;
}