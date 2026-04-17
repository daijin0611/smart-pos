package org.haut.common.domain.query.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDate;
import java.util.List;

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

    /**
     * 当前页码
     */
    @Schema(description = "当前页码", example = "1")
    private Integer pageNum = 1;

    /**
     * 每页条数
     */
    @Schema(description = "每页条数", example = "10")
    private Integer pageSize = 10;

    @Schema(description = "门店ID列表，不传则查全部关联门店")
    private List<Long> orgIds;
}
