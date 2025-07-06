package org.haut.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.util.Date;
import lombok.Data;

/**
 * 会员信息表
 * @TableName vip_info
 */
@TableName(value ="vip_info")
@Data
public class VipInfo {
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
     * 姓名
     */
    private String infoName;

    /**
     * 会员密码
     */
    private String infoPwd;

    /**
     * 性别（0 男，1 女）
     */
    private Integer infoGender;

    /**
     * 会员卡号
     */
    private String infoCardNumber;

    /**
     * 电话号码
     */
    private String infoPhoneNumber;

    /**
     * 会员身份
     */
    private String infoIdentity;

    /**
     * 会员生日
     */
    private Date infoBirthday;

    /**
     * 会员地址
     */
    private String infoAddress;

    /**
     * 末次消费日期
     */
    private Date infoLastConsumptionTime;

    /**
     * 末次充值日期
     */
    private Date infoLastRechargeTime;

}

    /*@Override
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
        VipInfo other = (VipInfo) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getInfoName() == null ? other.getInfoName() == null : this.getInfoName().equals(other.getInfoName()))
            && (this.getInfoGender() == null ? other.getInfoGender() == null : this.getInfoGender().equals(other.getInfoGender()))
            && (this.getInfoCardNumber() == null ? other.getInfoCardNumber() == null : this.getInfoCardNumber().equals(other.getInfoCardNumber()))
            && (this.getInfoPhoneMunber() == null ? other.getInfoPhoneMunber() == null : this.getInfoPhoneMunber().equals(other.getInfoPhoneMunber()))
            && (this.getInfoLastConsumptionTime() == null ? other.getInfoLastConsumptionTime() == null : this.getInfoLastConsumptionTime().equals(other.getInfoLastConsumptionTime()))
            && (this.getInfoLasetRechargeTime() == null ? other.getInfoLasetRechargeTime() == null : this.getInfoLasetRechargeTime().equals(other.getInfoLasetRechargeTime()));
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
        result = prime * result + ((getInfoName() == null) ? 0 : getInfoName().hashCode());
        result = prime * result + ((getInfoGender() == null) ? 0 : getInfoGender().hashCode());
        result = prime * result + ((getInfoCardNumber() == null) ? 0 : getInfoCardNumber().hashCode());
        result = prime * result + ((getInfoPhoneMunber() == null) ? 0 : getInfoPhoneMunber().hashCode());
        result = prime * result + ((getInfoLastConsumptionTime() == null) ? 0 : getInfoLastConsumptionTime().hashCode());
        result = prime * result + ((getInfoLasetRechargeTime() == null) ? 0 : getInfoLasetRechargeTime().hashCode());
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
        sb.append(", infoName=").append(infoName);
        sb.append(", infoGender=").append(infoGender);
        sb.append(", infoCardNumber=").append(infoCardNumber);
        sb.append(", infoPhoneMunber=").append(infoPhoneMunber);
        sb.append(", infoLastConsumptionTime=").append(infoLastConsumptionTime);
        sb.append(", infoLasetRechargeTime=").append(infoLasetRechargeTime);
        sb.append("]");
        return sb.toString();
    }
}
*/
