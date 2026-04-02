package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "订单价格预览请求实体")
public class OrderPreviewDTO {
    
    @Schema(description = "VIP客户ID(散客不传)")
    private Long vipId;

    @NotEmpty(message = "订单明细不能为空")
    @Valid
    @Schema(description = "订单明细列表", requiredMode = Schema.RequiredMode.REQUIRED)
    private List<OrderDetailCreateDTO> orderDetails;

    @Schema(description = "使用的票券/卡项列表")
    private List<OrderTicketUseDTO> ticketUseList;

    @Schema(description = "使用的资产ID列表")
    private List<Long> assetIds;
}