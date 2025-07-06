package org.haut.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 会员资产表
 * @TableName vip_asset
 */
@TableName(value ="vip_asset")
@Data
public class VipAsset {
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
     * 资产编号
     */
    private String assetNum;

    /**
     * 余额
     */
    private BigDecimal assetBalance;

    /**
     * 资产类型（0 充值，1 赠送）
     */
    private Integer assetType;

    /**
     * 折扣基础（0 标准价，1 会员价）
     */
    private Integer assetBaseDiscount;

    /**
     * 折扣率
     */
    private BigDecimal assetDiscountRate;

    /**
     * 跨店消费（0 不允许，1 允许）
     */
    private Integer assetIsCrossStore;

    /**
     * 实体卡号
     */
    private String assetCardNumber;

    /**
     * 会员id
     */
    private Long vipId;

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
        VipAsset other = (VipAsset) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getAssetNum() == null ? other.getAssetNum() == null : this.getAssetNum().equals(other.getAssetNum()))
            && (this.getAssetBalance() == null ? other.getAssetBalance() == null : this.getAssetBalance().equals(other.getAssetBalance()))
            && (this.getAssetType() == null ? other.getAssetType() == null : this.getAssetType().equals(other.getAssetType()))
            && (this.getAssetBaseDiscount() == null ? other.getAssetBaseDiscount() == null : this.getAssetBaseDiscount().equals(other.getAssetBaseDiscount()))
            && (this.getAssetDiscountRate() == null ? other.getAssetDiscountRate() == null : this.getAssetDiscountRate().equals(other.getAssetDiscountRate()))
            && (this.getAssetIsCrossStore() == null ? other.getAssetIsCrossStore() == null : this.getAssetIsCrossStore().equals(other.getAssetIsCrossStore()))
            && (this.getAssetCardNumber() == null ? other.getAssetCardNumber() == null : this.getAssetCardNumber().equals(other.getAssetCardNumber()))
            && (this.getVipId() == null ? other.getVipId() == null : this.getVipId().equals(other.getVipId()));
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
        result = prime * result + ((getAssetNum() == null) ? 0 : getAssetNum().hashCode());
        result = prime * result + ((getAssetBalance() == null) ? 0 : getAssetBalance().hashCode());
        result = prime * result + ((getAssetType() == null) ? 0 : getAssetType().hashCode());
        result = prime * result + ((getAssetBaseDiscount() == null) ? 0 : getAssetBaseDiscount().hashCode());
        result = prime * result + ((getAssetDiscountRate() == null) ? 0 : getAssetDiscountRate().hashCode());
        result = prime * result + ((getAssetIsCrossStore() == null) ? 0 : getAssetIsCrossStore().hashCode());
        result = prime * result + ((getAssetCardNumber() == null) ? 0 : getAssetCardNumber().hashCode());
        result = prime * result + ((getVipId() == null) ? 0 : getVipId().hashCode());
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
        sb.append(", assetNum=").append(assetNum);
        sb.append(", assetBalance=").append(assetBalance);
        sb.append(", assetType=").append(assetType);
        sb.append(", assetBaseDiscount=").append(assetBaseDiscount);
        sb.append(", assetDiscountRate=").append(assetDiscountRate);
        sb.append(", assetIsCrossStore=").append(assetIsCrossStore);
        sb.append(", assetCardNumber=").append(assetCardNumber);
        sb.append(", vipId=").append(vipId);
        sb.append("]");
        return sb.toString();
    }
}