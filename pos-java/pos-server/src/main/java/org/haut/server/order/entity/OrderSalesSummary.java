package org.haut.server.order.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 销售数据汇总表，整合销售、支付、充值相关数据
 * @TableName order_sales_summary
 */
@TableName(value ="order_sales_summary")
@Data
@Accessors(chain = true)
public class OrderSalesSummary {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 机构id
     */
    private Long orgId;

    /**
     * 销售数据创建时间
     */
    private LocalDateTime createTime;

    /**
     * 销售日期
     */
    private LocalDate statsDate;

    /**
     * 总营业额
     */
    private BigDecimal totalTurnover;

    /**
     * 总实收金额
     */
    private BigDecimal totalActualReceipt;

    /**
     * 总单次数量
     */
    private Integer totalSingleTime;

    /**
     * 总人次
     */
    private Integer totalPeopleTime;

    /**
     * 总项目数
     */
    private Integer totalProjectCount;

    /**
     * 支付宝支付金额
     */
    private BigDecimal alipayPayment;

    /**
     * 银行卡支付金额
     */
    private BigDecimal bankCardPayment;

    /**
     * 现金支付金额
     */
    private BigDecimal cashPayment;

    /**
     * 电子优惠券支付金额
     */
    private BigDecimal electronicCouponPayment;

    /**
     * 会员卡支付金额
     */
    private BigDecimal membershipCardPayment;

    /**
     * 其他方式支付金额
     */
    private BigDecimal otherPayment;

    /**
     * 微信支付金额
     */
    private BigDecimal wechatPayment;

    /**
     * 现金充值金额
     */
    private BigDecimal cashRecharge;

    /**
     * 微信充值金额
     */
    private BigDecimal wechatRecharge;

    /**
     * 其他方式充值
     */
    private BigDecimal otherRecharge;
}