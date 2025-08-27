package org.haut.common.domain.query.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDate;

@Data
@Accessors(chain = true)
@Schema(description = "会员充值记录查询参数")
public class RechargeHistoryQuery {

    /**
     * 开始时间
     */
    private LocalDate startDate;

    /**
     * 结束时间
     */
    private LocalDate endDate;

    /**
     * 会员信息
     */
    private String vipInfoFiled;

    /*
    * 销售人员
     */
    private Long userId;

    /**
     * 支付方式
     */
    private Integer paymentType;

    /**
     * 充值状态
     */
    private Integer rechargeStatus;
}
