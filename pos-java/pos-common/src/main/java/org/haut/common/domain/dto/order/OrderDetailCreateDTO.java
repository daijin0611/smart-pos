package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

/**
 * 订单明细DTO
 */
@Data
@Accessors(chain = true)
@Schema(description = "订单明细DTO")
public class OrderDetailCreateDTO {

    /**
     * 员工ID
     */
    @NotNull(message = "员工ID不能为空")
    @Schema(description = "技师ID")
    private Long userId;

    /**
     * 员工名称
     */
    @Schema(description = "技师名称")
    private String userName;

    /**
     * 业务类型（0 产品，1 服务，2 疗程券）
     */
    @NotNull(message = "业务类型不能为空")
    @Schema(description = "业务类型（0 产品，1 服务，2 疗程券）")
    private Integer detailType;

    /**
     * 订单业务ID（产品ID、服务ID或疗程券ID）
     */
    @NotNull(message = "业务ID不能为空")
    @Schema(description = "订单业务ID（产品ID、服务ID或疗程券ID）")
    private Long bid;

    /**
     * 标准单价
     */
    @Schema(description = "标准单价",example = "100.00")
    private BigDecimal stdPrice;

    /**
     * 实际单价
     */
    @Schema(description = "实际单价(结算前和实收价保持一致；结算时更新实际单价)",example = "100.00")
    private BigDecimal truePrice;

    /**
     * 销售数量
     */
    @NotNull(message = "销售数量不能为空")
    @Schema(description = "销售数量")
    private Integer quantity;

    /**
     * 上钟类型（0 点钟，1 加钟，2 轮牌）
     */
    @Schema(description = "上钟类型（0 点钟，1 加钟，2 轮牌）")
    private Integer serverType;

    /**
     * 备注
     */
    @Schema(description = "备注信息")
    private String remark;
}