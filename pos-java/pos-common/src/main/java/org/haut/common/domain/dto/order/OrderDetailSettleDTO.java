package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

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

    @Schema(description = "实际单价(结算前和实收价保持一致；结算时更新实际单价)",example = "100.00")
    private BigDecimal truePrice;

    @NotNull(message = "销售数量不能为空")
    @Schema(description = "销售数量")
    private Integer quantity;

    @Schema(description = "上钟类型（0 点钟，1 加钟，2 轮牌）")
    private Integer serverType;

    @NotNull(message = "员工ID不能为空")
    private Long userId;

    @Schema(description = "技师名称")
    private String userName;

    @Schema(description = "备注信息")
    private String remark;
}
