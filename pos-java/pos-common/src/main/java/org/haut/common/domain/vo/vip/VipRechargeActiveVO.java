package org.haut.common.domain.vo.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

/**
 * 充值活动视图对象
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
@Data
@Schema(description = "充值活动视图对象")
public class VipRechargeActiveVO {
    
    /**
     * 主键ID
     */
    @Schema(description = "主键ID")
    private Long id;
    
    /**
     * 活动状态
     */
    @Schema(description = "活动状态")
    private Integer activeStatus;
    
    /**
     * 活动名称
     */
    @Schema(description = "活动名称")
    private String activeName;
    
    /**
     * 活动开始时间
     */
    @Schema(description = "活动开始时间")
    private LocalDate activeBeginTime;
    
    /**
     * 活动结束时间
     */
    @Schema(description = "活动结束时间")
    private LocalDate activeFinalTime;
    
    /**
     * 活动类型
     */
    @Schema(description = "活动类型")
    private Integer activeType;
    
    /**
     * 活动资金
     */
    @Schema(description = "活动资金")
    private BigDecimal activeCapital;
    
    /**
     * 活动折扣
     */
    @Schema(description = "活动折扣")
    private Integer activeDiscount;
    
    /**
     * 活动基础
     */
    @Schema(description = "活动基础")
    private Integer activeBase;
    
    /**
     * 是否跨店使用(0 不允许，1 允许)
     */
    @Schema(description = "是否跨店使用(0 不允许，1 允许)")
    private Integer isCrossStore;
    
    /**
     * 赠送金额
     */
    @Schema(description = "赠送金额")
    private BigDecimal presentValue;
    
    /**
     * 赠送折扣是否相同
     */
    @Schema(description = "赠送折扣是否相同")
    private Integer presentDiscountIsSame;
    
    /**
     * 赠送折扣
     */
    @Schema(description = "赠送折扣")
    private Integer presentDiscount;
    
    /**
     * 赠送基础
     */
    @Schema(description = "赠送基础")
    private Integer presentBase;
    
    /**
     * 赠送是否跨店使用(0 不允许，1 允许)
     */
    @Schema(description = "赠送是否跨店使用(0 不允许，1 允许)")
    private Integer presentIsCrossStore;
    
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
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)")
    private Integer isDelete;
    
    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;
    
    /**
     * 机构ID
     */
    @Schema(description = "机构ID")
    private Long orgId;

    /**
     * 优惠券列表
     */
    @Schema(description = "优惠券列表")
    private List<TicketVO> ticketList;

    @Data
    @Schema(description = "关联优惠券VO")
    public static class TicketVO {
        @Schema(description = "优惠券ID")
        private Long ticketId;
        @Schema(description = "优惠券名称")
        private String ticketName;
        @Schema(description = "有效天数")
        private Integer ticketEffectiveTime;
        @Schema(description = "数量")
        private Integer number;
    }


}