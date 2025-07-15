package org.haut.server.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 产品表
 * @TableName server_product
 */
@TableName(value ="server_product")
@Data
@Schema(description = "服务产品表")
public class ServerProduct {
    /**
     * 主键 自增
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
     * 备注(其他描述)
     */
    private String remark;

    /**
     * 产品名称
     */
    private String productName;

    /**
     * 产品编码
     */
    private String productEncode;

    /**
     * 标准价
     */
    private BigDecimal productPrice;

    /**
     * 会员价
     */
    private BigDecimal vipProductPrice;

    /**
     * 是否参与打折（0 是，1 否）
     */
    private Integer isDiscount;

    /**
     * 提成类型
     */
    private Integer commissioinType;

    /**
     * 提成值（比例）
     */
    private BigDecimal productCommissionValue;

    /**
     * 提成价格（固定）
     */
    private BigDecimal productCommissionPrice;

    /**
     * 产品状态（启用、禁用）
     */
    private Integer productStatus;
}


//    equals 方法：
//    作用：用于比较两个对象是否相等。
//    实现：通过比较对象的各个字段来判断两个对象是否相等。如果所有字段都相等，则认为两个对象相等。
//    @Override
//    public boolean equals(Object that) {
//        if (this == that) {
//            return true;
//        }
//        if (that == null) {
//            return false;
//        }
//        if (getClass() != that.getClass()) {
//            return false;
//        }
//        ServerProduct other = (ServerProduct) that;
//        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
//            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
//            && (this.getUpdateTime() == null ? other.getUpdateTime() == null : this.getUpdateTime().equals(other.getUpdateTime()))
//            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
//            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
//            && (this.getProductName() == null ? other.getProductName() == null : this.getProductName().equals(other.getProductName()))
//            && (this.getProductEncode() == null ? other.getProductEncode() == null : this.getProductEncode().equals(other.getProductEncode()))
//            && (this.getProductPrice() == null ? other.getProductPrice() == null : this.getProductPrice().equals(other.getProductPrice()))
//            && (this.getVipProductPrice() == null ? other.getVipProductPrice() == null : this.getVipProductPrice().equals(other.getVipProductPrice()))
//            && (this.getIsDiscount() == null ? other.getIsDiscount() == null : this.getIsDiscount().equals(other.getIsDiscount()))
//            && (this.getCommissioinType() == null ? other.getCommissioinType() == null : this.getCommissioinType().equals(other.getCommissioinType()))
//            && (this.getProductCommissionValue() == null ? other.getProductCommissionValue() == null : this.getProductCommissionValue().equals(other.getProductCommissionValue()))
//            && (this.getProductCommissionPrice() == null ? other.getProductCommissionPrice() == null : this.getProductCommissionPrice().equals(other.getProductCommissionPrice()));
//    }
//
//hashCode 方法：
//    作用：用于生成对象的哈希码，通常用于哈希表（如 HashMap）中。
//    实现：根据对象的字段生成一个整数哈希码
//    @Override
//    public int hashCode() {
//        final int prime = 31;
//        int result = 1;
//        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
//        result = prime * result + ((getCreateTime() == null) ? 0 : getCreateTime().hashCode());
//        result = prime * result + ((getUpdateTime() == null) ? 0 : getUpdateTime().hashCode());
//        result = prime * result + ((getIsDelete() == null) ? 0 : getIsDelete().hashCode());
//        result = prime * result + ((getRemark() == null) ? 0 : getRemark().hashCode());
//        result = prime * result + ((getProductName() == null) ? 0 : getProductName().hashCode());
//        result = prime * result + ((getProductEncode() == null) ? 0 : getProductEncode().hashCode());
//        result = prime * result + ((getProductPrice() == null) ? 0 : getProductPrice().hashCode());
//        result = prime * result + ((getVipProductPrice() == null) ? 0 : getVipProductPrice().hashCode());
//        result = prime * result + ((getIsDiscount() == null) ? 0 : getIsDiscount().hashCode());
//        result = prime * result + ((getCommissioinType() == null) ? 0 : getCommissioinType().hashCode());
//        result = prime * result + ((getProductCommissionValue() == null) ? 0 : getProductCommissionValue().hashCode());
//        result = prime * result + ((getProductCommissionPrice() == null) ? 0 : getProductCommissionPrice().hashCode());
//        return result;
//    }
//
//    @Override
//    public String toString() {
//        StringBuilder sb = new StringBuilder();
//        sb.append(getClass().getSimpleName());
//        sb.append(" [");
//        sb.append("Hash = ").append(hashCode());
//        sb.append(", id=").append(id);
//        sb.append(", createTime=").append(createTime);
//        sb.append(", updateTime=").append(updateTime);
//        sb.append(", isDelete=").append(isDelete);
//        sb.append(", remark=").append(remark);
//        sb.append(", productName=").append(productName);
//        sb.append(", productEncode=").append(productEncode);
//        sb.append(", productPrice=").append(productPrice);
//        sb.append(", vipProductPrice=").append(vipProductPrice);
//        sb.append(", isDiscount=").append(isDiscount);
//        sb.append(", commissioinType=").append(commissioinType);
//        sb.append(", productCommissionValue=").append(productCommissionValue);
//        sb.append(", productCommissionPrice=").append(productCommissionPrice);
//        sb.append("]");
//        return sb.toString();
//    }