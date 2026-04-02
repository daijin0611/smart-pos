package org.haut.common.domain.vo.order;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Accessors(chain = true)
@Schema(description = "销售数据统计")
public class OrderSummaryVO {

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
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
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
