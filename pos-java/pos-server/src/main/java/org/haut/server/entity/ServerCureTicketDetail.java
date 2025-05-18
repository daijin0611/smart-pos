package org.haut.server.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;
import lombok.Data;

/**
 * 疗程券内容表（关联server_cure_ticket, vip_ticket）
 * @TableName server_cure_ticket_detail
 */
@TableName(value ="server_cure_ticket_detail")
@Data
public class ServerCureTicketDetail {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
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
     * 疗程券id
     */
    private Long cureTicketId;

    /**
     * 优惠券id
     */
    private Long vipTicketId;

    /**
     * 优惠券数量
     */
    private Integer vipTicketNum;

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
        ServerCureTicketDetail other = (ServerCureTicketDetail) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getCureTicketId() == null ? other.getCureTicketId() == null : this.getCureTicketId().equals(other.getCureTicketId()))
            && (this.getVipTicketId() == null ? other.getVipTicketId() == null : this.getVipTicketId().equals(other.getVipTicketId()))
            && (this.getVipTicketNum() == null ? other.getVipTicketNum() == null : this.getVipTicketNum().equals(other.getVipTicketNum()));
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
        result = prime * result + ((getCureTicketId() == null) ? 0 : getCureTicketId().hashCode());
        result = prime * result + ((getVipTicketId() == null) ? 0 : getVipTicketId().hashCode());
        result = prime * result + ((getVipTicketNum() == null) ? 0 : getVipTicketNum().hashCode());
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
        sb.append(", cureTicketId=").append(cureTicketId);
        sb.append(", vipTicketId=").append(vipTicketId);
        sb.append(", vipTicketNum=").append(vipTicketNum);
        sb.append("]");
        return sb.toString();
    }
}