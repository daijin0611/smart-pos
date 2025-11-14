package org.haut.common.domain.vo.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 小票-订单信息VO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-11-14
 */
@Data
@Accessors(chain = true)
@Schema(description = "小票-订单信息")
public class OrderReceiptVO {
    /**
     * 系统单号
     */
    @Schema(description = "系统单号")
    private String orderCode;

    /**
     * 买单时间（开单时间）
     */
    @Schema(description = "买单时间（开单时间）")
    private Date orderTime;

    /**
     * 账务时间（结算时间）
     */
    @Schema(description = "账务时间（结算时间）")
    private Date settleTime;

    /**
     * 房间/床位编号
     */
    @Schema(description = "房间/床位编号")
    private String bedName;

    /**
     * 收银员
     */
    @Schema(description = "收银员")
    private String cashierName;

    /**
     * 顾客名称
     */
    @Schema(description = "顾客名称")
    private String customerName;

    /**
     * 原价总计
     */
    @Schema(description = "原价总计")
    private BigDecimal totalAmount;

    /**
     * 实付总计
     */
    @Schema(description = "实付总计")
    private BigDecimal actualAmount;

    /**
     * 节省总计
     */
    @Schema(description = "节省总计")
    private BigDecimal discountAmount;

    /**
     * 订单明细列表
     */
    @Schema(description = "订单明细列表")
    private List<ReceiptItemVO> items;

    /**
     * 支付明细列表
     */
    @Schema(description = "支付明细列表")
    private List<PaymentVO> payments;
}