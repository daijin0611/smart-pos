package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.DecimalMin;
import lombok.Data;
import org.haut.common.domain.dto.server.RelatedTicketDTO;
import org.springframework.cglib.core.Local;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

/**
 * 充值活动新增DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
@Data
@Schema(description = "充值活动新增对象")
public class VipRechargeActiveAddDTO {
    
    /**
     * 活动名称
     */
    @Schema(description = "活动名称")
    @NotBlank(message = "活动名称不能为空")
    private String activeName;
    
    /**
     * 活动开始时间
     */
    @Schema(description = "活动开始时间")
    @NotNull(message = "活动开始时间不能为空")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate activeBeginTime;
    
    /**
     * 活动结束时间
     */
    @Schema(description = "活动结束时间")
    @NotNull(message = "活动结束时间不能为空")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate activeFinalTime;
    
    /**
     * 活动类型
     */
    @Schema(description = "活动类型")
    @NotNull(message = "活动类型不能为空")
    private Integer activeType;
    
    /**
     * 活动资金
     */
    @Schema(description = "活动资金")
    @NotNull(message = "活动资金不能为空")
    @DecimalMin(value = "0.01", message = "活动资金必须大于0")
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
    @Schema(description = "赠送折扣是否相同（0 不同， 1 相同）")
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
     * 关联优惠券ID列表
     */
    @Schema(description = "关联优惠券ID列表")
    private List<RelatedTicketDTO> ticketIds;
    
    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

}