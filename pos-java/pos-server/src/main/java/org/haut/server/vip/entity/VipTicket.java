package org.haut.server.vip.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 会员优惠券
 * @TableName vip_ticket
 */
@TableName(value ="vip_ticket")
@Data
@Accessors(chain = true)
public class VipTicket {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    private Integer isDelete;

    /**
     * 备注
     */
    private String remark;

    /**
     * 优惠券状态（0 禁用，1 启用）
     */
    private Integer ticketStatus;

    /**
     * 优惠券名称
     */
    private String ticketName;

    /**
     * 优惠券类型
     */
    private Integer ticketType;

    /**
     * 有效天数（-1 代表无限期）
     */
    private Integer ticketEffectiveTime;

    /**
     * 限额满多少元可用
     */
    private BigDecimal ticketFullPayment;

    /**
     * 优惠券面值
     */
    private BigDecimal ticketValue;

    /**
     * 门店id
     */
    private Long orgId;
}