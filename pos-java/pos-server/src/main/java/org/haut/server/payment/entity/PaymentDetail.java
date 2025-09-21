package org.haut.server.payment.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 支付明细表，记录各种业务的支付详情。
 * @TableName payment_detail
 */
@TableName(value ="payment_detail")
@Data
@Accessors(chain = true)
public class PaymentDetail {
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
     * 备注
     */
    private String remark;

    /**
     * 业务类型
     */
    private Integer activeType;

    /**
     * 业务编号
     */
    private String activeCode;

    /**
     * 业务名称
     */
    private String activeName;

    /**
     * 支付方式
     */
    private Integer paymentType;

    /**
     * 支付方式名称
     */
    private String paymentName;

    /**
     * 支付金额
     */
    private BigDecimal totalAmount;

    /**
     * 结算状态
     */
    private String paymentStatus;

    /**
     * 资产编号
     */
    private String assetCode;

    /**
     * 门店id
     */
    private Long orgId;
}