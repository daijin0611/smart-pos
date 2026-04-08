package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

@Data
@Schema(description = "结算订单明细请求DTO")
@Accessors(chain = true)
public class OrderDetailSettleDTO {

    @Schema(description = "订单明细ID")
    private Long id;

    @Schema(description = "订单明细编号")
    private String detailCode;

    @NotNull(message = "业务类型不能为空")
    @Schema(description = "业务类型（0 产品，1 服务，2 疗程券）")
    private Integer detailType;

    @NotNull(message = "业务ID不能为空")
    @Schema(description = "订单业务ID（产品ID、服务ID或疗程券ID）")
    private Long bid;

    @Schema(description = "业务名称")
    private String businessName;

    @Schema(description = "业务编码")
    private String businessCode;

    @Schema(description = "标准单价",example = "100.00")
    private BigDecimal stdPrice;

    @Schema(description = "实收总价")
    private BigDecimal truePrice;

    @Schema(description = "实收单价")
    private BigDecimal trueUnitPrice;

    @NotNull(message = "销售数量不能为空")
    @Schema(description = "销售数量")
    private Integer quantity;

    @Schema(description = "是否已计算折扣（0 未计算，1 已计算）")
    private Integer isDiscount;

    @Schema(description = "上钟类型（0 点钟，1 加钟，2 轮牌）")
    private Integer serverType;

    @Schema(description = "备注信息")
    private String remark;

    @Schema(description = "技师列表")
    private List<OrderDetailTechnicianDTO> technicians;
}
