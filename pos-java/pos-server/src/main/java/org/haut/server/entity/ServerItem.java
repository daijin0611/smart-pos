package org.haut.server.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 服务项目
 * @TableName server_item
 */
@TableName(value ="server_item")
@Data
public class ServerItem {
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
     * 备注(其他描述)
     */
    private String remark;

    /**
     * 服务项目产品名称
     */
    private String itemName;

    /**
     * 服务项目产品编码
     */
    private String itemEncode;

    /**
     * 技师类型
     */
    private String employeeType;

    /**
     * 服务时长
     */
    private Integer serverTime;

    /**
     * 标准价
     */
    private BigDecimal itemPrice;

    /**
     * 会员价
     */
    private BigDecimal vipItemPrice;

    /**
     * 是否参与打折（0 允许，1 禁止）
     */
    private Integer isDiscounts;

    /**
     * 提成类型
     */
    private String commissionType;

    /**
     * 提成值（比例）（轮牌）
     */
    private BigDecimal commissionValueRotation;

    /**
     * 提成值（比例）（点钟）
     */
    private BigDecimal commissionValueAppointment;

    /**
     * 提成值（比例）（加钟）
     */
    private BigDecimal commissionValueExtend;

    /**
     * 提成基准
     */
    private String commissionBase;

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
        ServerItem other = (ServerItem) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getItemName() == null ? other.getItemName() == null : this.getItemName().equals(other.getItemName()))
            && (this.getItemEncode() == null ? other.getItemEncode() == null : this.getItemEncode().equals(other.getItemEncode()))
            && (this.getEmployeeType() == null ? other.getEmployeeType() == null : this.getEmployeeType().equals(other.getEmployeeType()))
            && (this.getServerTime() == null ? other.getServerTime() == null : this.getServerTime().equals(other.getServerTime()))
            && (this.getItemPrice() == null ? other.getItemPrice() == null : this.getItemPrice().equals(other.getItemPrice()))
            && (this.getVipItemPrice() == null ? other.getVipItemPrice() == null : this.getVipItemPrice().equals(other.getVipItemPrice()))
            && (this.getIsDiscounts() == null ? other.getIsDiscounts() == null : this.getIsDiscounts().equals(other.getIsDiscounts()))
            && (this.getCommissionType() == null ? other.getCommissionType() == null : this.getCommissionType().equals(other.getCommissionType()))
            && (this.getCommissionValueRotation() == null ? other.getCommissionValueRotation() == null : this.getCommissionValueRotation().equals(other.getCommissionValueRotation()))
            && (this.getCommissionValueAppointment() == null ? other.getCommissionValueAppointment() == null : this.getCommissionValueAppointment().equals(other.getCommissionValueAppointment()))
            && (this.getCommissionValueExtend() == null ? other.getCommissionValueExtend() == null : this.getCommissionValueExtend().equals(other.getCommissionValueExtend()))
            && (this.getCommissionBase() == null ? other.getCommissionBase() == null : this.getCommissionBase().equals(other.getCommissionBase()));
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
        result = prime * result + ((getItemName() == null) ? 0 : getItemName().hashCode());
        result = prime * result + ((getItemEncode() == null) ? 0 : getItemEncode().hashCode());
        result = prime * result + ((getEmployeeType() == null) ? 0 : getEmployeeType().hashCode());
        result = prime * result + ((getServerTime() == null) ? 0 : getServerTime().hashCode());
        result = prime * result + ((getItemPrice() == null) ? 0 : getItemPrice().hashCode());
        result = prime * result + ((getVipItemPrice() == null) ? 0 : getVipItemPrice().hashCode());
        result = prime * result + ((getIsDiscounts() == null) ? 0 : getIsDiscounts().hashCode());
        result = prime * result + ((getCommissionType() == null) ? 0 : getCommissionType().hashCode());
        result = prime * result + ((getCommissionValueRotation() == null) ? 0 : getCommissionValueRotation().hashCode());
        result = prime * result + ((getCommissionValueAppointment() == null) ? 0 : getCommissionValueAppointment().hashCode());
        result = prime * result + ((getCommissionValueExtend() == null) ? 0 : getCommissionValueExtend().hashCode());
        result = prime * result + ((getCommissionBase() == null) ? 0 : getCommissionBase().hashCode());
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
        sb.append(", itemName=").append(itemName);
        sb.append(", itemEncode=").append(itemEncode);
        sb.append(", employeeType=").append(employeeType);
        sb.append(", serverTime=").append(serverTime);
        sb.append(", itemPrice=").append(itemPrice);
        sb.append(", vipItemPrice=").append(vipItemPrice);
        sb.append(", isDiscounts=").append(isDiscounts);
        sb.append(", commissionType=").append(commissionType);
        sb.append(", commissionValueRotation=").append(commissionValueRotation);
        sb.append(", commissionValueAppointment=").append(commissionValueAppointment);
        sb.append(", commissionValueExtend=").append(commissionValueExtend);
        sb.append(", commissionBase=").append(commissionBase);
        sb.append("]");
        return sb.toString();
    }
}