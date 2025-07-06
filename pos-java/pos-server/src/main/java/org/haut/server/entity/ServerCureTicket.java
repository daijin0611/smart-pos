package org.haut.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 疗程券表
 * @TableName server_cure_ticket
 */
@TableName(value ="server_cure_ticket")
@Data
public class ServerCureTicket {
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
     * 备注（其它描述）
     */
    private String remark;

    /**
     * 疗程卷名称
     */
    private String cureTicketName;

    /**
     * 疗程编码
     */
    private String cureTicketEncode;

    /**
     * 疗程价格
     */
    private BigDecimal cureTicketPrice;

    /**
     * 提成类型
     */
    private String cureTicketType;

    /**
     * 提成值（比例）
     */
    private BigDecimal cureTicketCommissionValue;

    /**
     * 提成方式
     */
    private String cureTicketCommissionBy;

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
        ServerCureTicket other = (ServerCureTicket) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getCureTicketName() == null ? other.getCureTicketName() == null : this.getCureTicketName().equals(other.getCureTicketName()))
            && (this.getCureTicketEncode() == null ? other.getCureTicketEncode() == null : this.getCureTicketEncode().equals(other.getCureTicketEncode()))
            && (this.getCureTicketPrice() == null ? other.getCureTicketPrice() == null : this.getCureTicketPrice().equals(other.getCureTicketPrice()))
            && (this.getCureTicketType() == null ? other.getCureTicketType() == null : this.getCureTicketType().equals(other.getCureTicketType()))
            && (this.getCureTicketCommissionValue() == null ? other.getCureTicketCommissionValue() == null : this.getCureTicketCommissionValue().equals(other.getCureTicketCommissionValue()))
            && (this.getCureTicketCommissionBy() == null ? other.getCureTicketCommissionBy() == null : this.getCureTicketCommissionBy().equals(other.getCureTicketCommissionBy()));
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
        result = prime * result + ((getCureTicketName() == null) ? 0 : getCureTicketName().hashCode());
        result = prime * result + ((getCureTicketEncode() == null) ? 0 : getCureTicketEncode().hashCode());
        result = prime * result + ((getCureTicketPrice() == null) ? 0 : getCureTicketPrice().hashCode());
        result = prime * result + ((getCureTicketType() == null) ? 0 : getCureTicketType().hashCode());
        result = prime * result + ((getCureTicketCommissionValue() == null) ? 0 : getCureTicketCommissionValue().hashCode());
        result = prime * result + ((getCureTicketCommissionBy() == null) ? 0 : getCureTicketCommissionBy().hashCode());
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
        sb.append(", cureTicketName=").append(cureTicketName);
        sb.append(", cureTicketEncode=").append(cureTicketEncode);
        sb.append(", cureTicketPrice=").append(cureTicketPrice);
        sb.append(", cureTicketType=").append(cureTicketType);
        sb.append(", cureTicketCommissionValue=").append(cureTicketCommissionValue);
        sb.append(", cureTicketCommissionBy=").append(cureTicketCommissionBy);
        sb.append("]");
        return sb.toString();
    }
}