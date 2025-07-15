package org.haut.server.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 服务套餐表
 * @TableName server_package
 */
@TableName(value ="server_package")
@Data
public class ServerPackage {
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
     * 服务套餐名称
套餐名称
     */
    private String packageName;

    /**
     * 套餐编码
     */
    private String packageEncode;

    /**
     * 散客价
     */
    private BigDecimal packagePrice;

    /**
     * 会员价
     */
    private BigDecimal packagePriceVip;

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
        ServerPackage other = (ServerPackage) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getPackageName() == null ? other.getPackageName() == null : this.getPackageName().equals(other.getPackageName()))
            && (this.getPackageEncode() == null ? other.getPackageEncode() == null : this.getPackageEncode().equals(other.getPackageEncode()))
            && (this.getPackagePrice() == null ? other.getPackagePrice() == null : this.getPackagePrice().equals(other.getPackagePrice()))
            && (this.getPackagePriceVip() == null ? other.getPackagePriceVip() == null : this.getPackagePriceVip().equals(other.getPackagePriceVip()));
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
        result = prime * result + ((getPackageName() == null) ? 0 : getPackageName().hashCode());
        result = prime * result + ((getPackageEncode() == null) ? 0 : getPackageEncode().hashCode());
        result = prime * result + ((getPackagePrice() == null) ? 0 : getPackagePrice().hashCode());
        result = prime * result + ((getPackagePriceVip() == null) ? 0 : getPackagePriceVip().hashCode());
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
        sb.append(", packageName=").append(packageName);
        sb.append(", packageEncode=").append(packageEncode);
        sb.append(", packagePrice=").append(packagePrice);
        sb.append(", packagePriceVip=").append(packagePriceVip);
        sb.append("]");
        return sb.toString();
    }
}