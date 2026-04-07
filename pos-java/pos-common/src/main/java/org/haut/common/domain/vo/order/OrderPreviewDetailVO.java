package org.haut.common.domain.vo.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "订单明细价格预览实体")
public class OrderPreviewDetailVO {

    @Schema(description = "业务类型(0:产品 1:服务项 2:疗程券)")
    private Integer detailType;

    @Schema(description = "业务ID")
    private Long bid;

    @Schema(description = "数量")
    private Integer quantity;

    @Schema(description = "原价(单价)")
    private BigDecimal stdPrice;

    @Schema(description = "实收总价")
    private BigDecimal truePrice;

    @Schema(description = "实收单价")
    private BigDecimal trueUnitPrice;

    @Schema(description = "优惠金额(总)")
    private BigDecimal discountAmount;
    
    @Schema(description = "明细标准总价(原价*数量)")
    private BigDecimal totalStdAmount;

    @Schema(description = "明细实付总价(实价*数量)")
    private BigDecimal totalAmount;
}