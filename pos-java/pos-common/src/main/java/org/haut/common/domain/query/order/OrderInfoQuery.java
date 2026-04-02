package org.haut.common.domain.query.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单信息查询条件
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Data
@Accessors(chain = true)
@Schema(description = "订单信息查询条件")
public class OrderInfoQuery {
    
    /**
     * 销售单号
     */
    @Schema(description = "销售单号")
    private String orderNo;
    
    /**
     * 订单状态
     */
    @Schema(description = "订单状态")
    private Integer orderStatus;
    
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
     * 顾客类型（0 会员，1 散客）
     */
    @Schema(description = "顾客类型（0 会员，1 散客）")
    private Integer customerType;
    
    /**
     * 床位ID
     */
    @Schema(description = "床位ID")
    private Long bedId;
    
    /**
     * 收银人ID
     */
    @Schema(description = "收银人ID")
    private Long userId;
    
    /**
     * 门店ID
     */
    @Schema(description = "门店ID")
    private Long orgId;
    
    /**
     * 开单时间开始
     */
    @Schema(description = "开单时间开始")
    private Date orderTimeStart;
    
    /**
     * 开单时间结束
     */
    @Schema(description = "开单时间结束")
    private Date orderTimeEnd;
    
    /**
     * 结算时间开始
     */
    @Schema(description = "结算时间开始")
    private Date settleTimeStart;
    
    /**
     * 结算时间结束
     */
    @Schema(description = "结算时间结束")
    private Date settleTimeEnd;
    
    /**
     * 应收金额最小值
     */
    @Schema(description = "应收金额最小值")
    private BigDecimal totalAmountMin;
    
    /**
     * 应收金额最大值
     */
    @Schema(description = "应收金额最大值")
    private BigDecimal totalAmountMax;
    
    /**
     * 实收金额最小值
     */
    @Schema(description = "实收金额最小值")
    private BigDecimal actualAmountMin;
    
    /**
     * 实收金额最大值
     */
    @Schema(description = "实收金额最大值")
    private BigDecimal actualAmountMax;
}