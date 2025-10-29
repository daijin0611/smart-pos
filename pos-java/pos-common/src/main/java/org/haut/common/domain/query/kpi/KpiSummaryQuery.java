package org.haut.common.domain.query.kpi;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Schema(description = "员工业绩汇总查询条件")
public class KpiSummaryQuery {


    @Schema(description = "员工id")
    private Long userId;

    @Schema(description = "机构ID", hidden = true)
    private Long orgId;

    @Schema(description = "查询开始日期", hidden = true)
    private LocalDateTime beginDate;

    @Schema(description = "查询结束日期", hidden = true)
    private LocalDateTime endDate;

    @Schema(description = "日期查询范围")
    private LocalDate[] date;

}
