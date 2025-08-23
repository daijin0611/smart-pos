package org.haut.server.vip.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * 充值活动优惠券关联表
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
@TableName(value = "vip_recharge_active_ticket")
@Data
@Schema(description = "充值活动优惠券关联实体")
@Accessors(chain = true)
public class VipRechargeActiveTicket {
    
    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    @Schema(description = "主键ID")
    private Long id;
    
    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    @Schema(description = "创建时间")
    private Date createTime;
    
    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
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
     * 优惠券ID
     */
    @Schema(description = "优惠券ID")
    private Long ticketId;
    
    /**
     * 优惠券名称
     */
    @Schema(description = "优惠券名称")
    private String ticketName;
    
    /**
     * 充值活动ID
     */
    @Schema(description = "充值活动ID")
    private Long activeId;
    
    /**
     * 优惠券数量
     */
    @Schema(description = "优惠券数量")
    private Integer number;
}