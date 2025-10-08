package org.haut.common.domain.vo.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 订单信息响应VO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Data
@Accessors(chain = true)
@Schema(description = "订单信息响应VO")
public class OrderInfoVO {
    
    /**
     * 主键ID
     */
    @Schema(description = "主键ID")
    private Long id;
    
    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    private Date createTime;
    
    /**
     * 更新时间
     */
    @Schema(description = "更新时间")
    private Date updateTime;
    
    /**
     * 备注信息
     */
    @Schema(description = "备注信息")
    private String remark;
    
    /**
     * 订单编号
     */
    @Schema(description = "订单编号")
    private String orderCode;
    
    /**
     * 开单时间
     */
    @Schema(description = "开单时间")
    private Date orderTime;
    
    /**
     * 订单状态
     */
    @Schema(description = "订单状态")
    private Integer orderStatus;
    
    /**
     * 订单状态名称
     */
    @Schema(description = "订单状态名称")
    private String orderStatusName;
    
    /**
     * 会员ID
     */
    @Schema(description = "会员ID")
    private Long vipId;
    
    /**
     * 顾客名称
     */
    @Schema(description = "顾客名称")
    private String vipName;
    
    /**
     * 会员卡号
     */
    @Schema(description = "会员卡号")
    private String vipCardNumber;
    
    /**
     * 会员电话号码
     */
    @Schema(description = "会员电话号码")
    private String vipPhoneNumber;
    
    /**
     * 消费前余额
     */
    @Schema(description = "消费前余额")
    private BigDecimal beforeBalance;
    
    /**
     * 消费后余额
     */
    @Schema(description = "消费后余额")
    private BigDecimal afterBalance;
    
    /**
     * 结算时间
     */
    @Schema(description = "结算时间")
    private Date settleTime;
    
    /**
     * 应收金额
     */
    @Schema(description = "应收金额")
    private BigDecimal totalAmount;
    
    /**
     * 实收金额
     */
    @Schema(description = "实收金额")
    private BigDecimal actualAmount;
    
    /**
     * 优惠金额
     */
    @Schema(description = "优惠金额")
    private BigDecimal discountAmount;
    
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
     * 收银人ID
     */
    @Schema(description = "收银人ID")
    private Long userId;

    /**
     * 收银人名称
     */
    @Schema(description = "收银人名称")
    private String userName;
    
    /**
     * 顾客类型（0 会员，1 散客）
     */
    @Schema(description = "顾客类型（0 会员，1 散客）")
    private Integer customerType;
    
    /**
     * 顾客类型名称
     */
    @Schema(description = "顾客名称")
    private String customerName;

    /**
     * 门店ID
     */
    @Schema(description = "门店ID")
    private Long orgId;
    
    /**
     * 订单明细列表
     */
    @Schema(description = "订单明细列表")
    private List<OrderDetailVO> orderDetails;

    /**
     * 支付信息列表
     */
    @Schema(description = "支付信息列表")
    private List<PaymentVO> payments;
}