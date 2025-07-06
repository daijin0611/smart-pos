package org.haut.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 会员优惠券
 * @TableName vip_ticket
 */
@TableName(value ="vip_ticket")
@Data
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
    @TableField(fill = FieldFill.UPDATE)
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
    private String ticketType;

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
     * 领取后几天内有效
     */
    private Integer ticketAfterDay;

    /**
     * 是否套餐体验券
     */
    private Integer isPackageTicket;

    /**
     * 可体验项目id
     */
    private Long serverId;

    /**
     * 可体验套餐id
     */
    private Long packageId;

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        VipTicket other = (VipTicket) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getTicketStatus() == null ? other.getTicketStatus() == null : this.getTicketStatus().equals(other.getTicketStatus()))
            && (this.getTicketName() == null ? other.getTicketName() == null : this.getTicketName().equals(other.getTicketName()))
            && (this.getTicketType() == null ? other.getTicketType() == null : this.getTicketType().equals(other.getTicketType()))
            && (this.getTicketEffectiveTime() == null ? other.getTicketEffectiveTime() == null : this.getTicketEffectiveTime().equals(other.getTicketEffectiveTime()))
            && (this.getTicketFullPayment() == null ? other.getTicketFullPayment() == null : this.getTicketFullPayment().equals(other.getTicketFullPayment()))
            && (this.getTicketValue() == null ? other.getTicketValue() == null : this.getTicketValue().equals(other.getTicketValue()))
            && (this.getTicketAfterDay() == null ? other.getTicketAfterDay() == null : this.getTicketAfterDay().equals(other.getTicketAfterDay()))
            && (this.getIsPackageTicket() == null ? other.getIsPackageTicket() == null : this.getIsPackageTicket().equals(other.getIsPackageTicket()))
            && (this.getServerId() == null ? other.getServerId() == null : this.getServerId().equals(other.getServerId()))
            && (this.getPackageId() == null ? other.getPackageId() == null : this.getPackageId().equals(other.getPackageId()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getCreateTime() == null) ? 0 : getCreateTime().hashCode());
        result = prime * result + ((getUpdateTime() == null) ? 0 : getUpdateTime().hashCode());
        result = prime * result + ((getIsDelete() == null) ? 0 : getIsDelete().hashCode());
        result = prime * result + ((getRemark() == null) ? 0 : getRemark().hashCode());
        result = prime * result + ((getTicketStatus() == null) ? 0 : getTicketStatus().hashCode());
        result = prime * result + ((getTicketName() == null) ? 0 : getTicketName().hashCode());
        result = prime * result + ((getTicketType() == null) ? 0 : getTicketType().hashCode());
        result = prime * result + ((getTicketEffectiveTime() == null) ? 0 : getTicketEffectiveTime().hashCode());
        result = prime * result + ((getTicketFullPayment() == null) ? 0 : getTicketFullPayment().hashCode());
        result = prime * result + ((getTicketValue() == null) ? 0 : getTicketValue().hashCode());
        result = prime * result + ((getTicketAfterDay() == null) ? 0 : getTicketAfterDay().hashCode());
        result = prime * result + ((getIsPackageTicket() == null) ? 0 : getIsPackageTicket().hashCode());
        result = prime * result + ((getServerId() == null) ? 0 : getServerId().hashCode());
        result = prime * result + ((getPackageId() == null) ? 0 : getPackageId().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", createTime=").append(createTime);
        sb.append(", updateTime=").append(updateTime);
        sb.append(", isDelete=").append(isDelete);
        sb.append(", remark=").append(remark);
        sb.append(", ticketStatus=").append(ticketStatus);
        sb.append(", ticketName=").append(ticketName);
        sb.append(", ticketType=").append(ticketType);
        sb.append(", ticketEffectiveTime=").append(ticketEffectiveTime);
        sb.append(", ticketFullPayment=").append(ticketFullPayment);
        sb.append(", ticketValue=").append(ticketValue);
        sb.append(", ticketAfterDay=").append(ticketAfterDay);
        sb.append(", isPackageTicket=").append(isPackageTicket);
        sb.append(", serverId=").append(serverId);
        sb.append(", packageId=").append(packageId);
        sb.append("]");
        return sb.toString();
    }
}