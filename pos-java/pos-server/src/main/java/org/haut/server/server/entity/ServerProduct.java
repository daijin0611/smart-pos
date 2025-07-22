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
     * 提成类型（0 固定提成， 1 比例提成）
     */
    private Integer commissionType;

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

    /**
     * 组织id
     */
    private Long orgId;
}
