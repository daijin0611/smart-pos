package org.haut.common.domain.vo.kpi;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

/**
 * KPI业绩汇总VO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-10-28
 */
@Data
@Accessors(chain = true)
@Schema(description = "KPI业绩汇总VO")
public class KpiSummaryVO {

    @Schema(description = "技师ID")
    private Long userId;

    @Schema(description = "技师姓名")
    private String userName;

    @Schema(description = "总业绩")
    private BigDecimal totalPerformance;

    @Schema(description = "总提成")
    private BigDecimal totalCommission;

    @Schema(description = "总项目次数")
    private Integer totalProjectCount;

    @Schema(description = "点钟次数")
    private Integer appointmentCount;

    @Schema(description = "轮牌次数")
    private Integer rotationCount;

    @Schema(description = "加钟次数")
    private Integer extendCount;

    @Schema(description = "项目业绩")
    private BigDecimal projectPerformance;

    @Schema(description = "项目提成")
    private BigDecimal projectCommission;

    @Schema(description = "产品业绩")
    private BigDecimal productPerformance;

    @Schema(description = "产品提成")
    private BigDecimal productCommission;

    @Schema(description = "疗程销售业绩")
    private BigDecimal cureTicketPerformance;

    @Schema(description = "疗程销售提成")
    private BigDecimal cureTicketCommission;

    @Schema(description = "卡金业绩")
    private BigDecimal rechargePerformance;

    @Schema(description = "卡金提成")
    private BigDecimal rechargeCommission;

    @Schema(description = "门店ID")
    private Long orgId;

    @Schema(description = "门店名称")
    private String orgName;
}
