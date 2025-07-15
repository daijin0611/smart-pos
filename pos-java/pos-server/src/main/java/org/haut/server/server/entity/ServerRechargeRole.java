package org.haut.server.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 充值提成规则表
 * @TableName server_recharge_role
 */
@TableName(value ="server_recharge_role")
@Data
public class ServerRechargeRole {
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
     * 备注（其他描述）
     */
    private String remark;

    /**
     * 充值提成规则名称
     */
    private String rechargeRoleName;

    /**
     * 充值金额
     */
    private BigDecimal rechargePrice;

    /**
     * 提成类型
     */
    private String commissionType;

    /**
     * 提成值（比例）
     */
    private BigDecimal rechargeCommissionValue;

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
        ServerRechargeRole other = (ServerRechargeRole) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getRechargeRoleName() == null ? other.getRechargeRoleName() == null : this.getRechargeRoleName().equals(other.getRechargeRoleName()))
            && (this.getRechargePrice() == null ? other.getRechargePrice() == null : this.getRechargePrice().equals(other.getRechargePrice()))
            && (this.getCommissionType() == null ? other.getCommissionType() == null : this.getCommissionType().equals(other.getCommissionType()))
            && (this.getRechargeCommissionValue() == null ? other.getRechargeCommissionValue() == null : this.getRechargeCommissionValue().equals(other.getRechargeCommissionValue()));
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
        result = prime * result + ((getRechargeRoleName() == null) ? 0 : getRechargeRoleName().hashCode());
        result = prime * result + ((getRechargePrice() == null) ? 0 : getRechargePrice().hashCode());
        result = prime * result + ((getCommissionType() == null) ? 0 : getCommissionType().hashCode());
        result = prime * result + ((getRechargeCommissionValue() == null) ? 0 : getRechargeCommissionValue().hashCode());
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
        sb.append(", rechargeRoleName=").append(rechargeRoleName);
        sb.append(", rechargePrice=").append(rechargePrice);
        sb.append(", commissionType=").append(commissionType);
        sb.append(", rechargeCommissionValue=").append(rechargeCommissionValue);
        sb.append("]");
        return sb.toString();
    }
}