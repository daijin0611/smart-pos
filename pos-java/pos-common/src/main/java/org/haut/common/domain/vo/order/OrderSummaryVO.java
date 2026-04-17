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
 * @version 2.0
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
     * 门店名称
     */
    private String orgName;

    /**
     * 门店编码
     */
    private String orgCode;

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
     * 扫码支付金额
     */
    @Schema(description = "扫码支付金额")
    private BigDecimal qrPayment;

    /**
     * 现金支付金额
     */
    @Schema(description = "现金支付金额")
    private BigDecimal cashPayment;

    /**
     * POS支付金额
     */
    @Schema(description = "POS支付金额")
    private BigDecimal posPayment;

    /**
     * 抖音支付金额
     */
    @Schema(description = "抖音支付金额")
    private BigDecimal douyinPayment;

    /**
     * 美团支付金额
     */
    @Schema(description = "美团支付金额")
    private BigDecimal meituanPayment;

    /**
     * 会员卡支付金额
     */
    @Schema(description = "会员卡支付金额")
    private BigDecimal memberCardPayment;

    /**
     * 代金券支付金额
     */
    @Schema(description = "代金券支付金额")
    private BigDecimal ticketConsumerPayment;

    /**
     * 项目券支付金额
     */
    @Schema(description = "项目券支付金额")
    private BigDecimal ticketItemPayment;

}
