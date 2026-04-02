package org.haut.common.domain.vo.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
@Schema(description = "订单价格预览返回实体")
public class OrderPreviewVO {
    
    @Schema(description = "标准总价")
    private BigDecimal totalAmount;

    @Schema(description = "实付金额")
    private BigDecimal actualAmount;

    @Schema(description = "优惠总额")
    private BigDecimal discountAmount;

    @Schema(description = "订单明细预览")
    private List<OrderPreviewDetailVO> details;
}