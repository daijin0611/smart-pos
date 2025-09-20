package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;
import lombok.experimental.Accessors;
import jakarta.validation.constraints.NotNull;
import org.haut.common.domain.dto.vip.PaymentInfoDTO;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 结算订单请求DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Data
@Accessors(chain = true)
@Schema(description = "结算订单请求DTO")
public class OrderSettleDTO{

    /**
     * 订单ID
     */
    @Schema(description = "订单ID（如果已在床位创建订单,传入此id用于更改订单状态）")
    private Long orderId;

    /**
     * 会员ID
     */
    @Schema(description = "会员ID")
    private Long vipId;

    /**
     * 床位ID
     */
    @Schema(description = "床位ID")
    private Long bedId;

    /**
     * 床位名称
     */
    @Schema(description = "床位名称")
    private String bedName;

    /**
     * 客户类型
     */
    @Schema(description = "客户类型")
    private Integer customerType;

    /**
     * 客户姓名
     */
    @Schema(description = "客户姓名")
    private String customerName;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    
    /**
     * 应收金额
     */
    @NotNull(message = "应收金额不能为空")
    @Schema(description = "应收金额")
    private BigDecimal totalAmount;
    
    /**
     * 实收金额
     */
    @NotNull(message = "实收金额不能为空")
    @Schema(description = "实收金额")
    private BigDecimal actualAmount;
    
    /**
     * 优惠金额
     */
    @Schema(description = "优惠金额")
    @NotNull(message = "优惠金额不能为空")
    private BigDecimal discountAmount;

    @Schema(description = "下单时间")
    private Date orderTime;

    /**
     * 订单明细
     */
    @Schema(description = "订单明细")
    @NotEmpty(message = "订单明细不能为空")
    private List<OrderDetailSettleDTO> details;

    /**
     * 优惠券ID
     */
    @Schema(description = "优惠券ID")
    private List<OrderTicketUseDTO> ticketUseList;

    /**
     * 资产id
     */
    @Schema(description = "资产ID")
    private List<Long> assetIds;

    /**
     * 支付信息
     */
    @Schema(description = "支付信息")
    @NotEmpty(message = "支付信息不能为空")
    private List<PaymentInfoDTO> paymentInfoList;


}