package org.haut.common.domain.query.kpi;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Schema(description = "员工业绩明细查询条件")
public class KpiListQuery {

    @Schema(description = "员工姓名")
    private String username;

    @Schema(description = "机构ID")
    private Long orgId;

    @Schema(description = "查询开始日期")
    private String beginDate;

    @Schema(description = "查询结束日期")
    private String endDate;

    @Schema(description = "分页页码 (默认 1)")
    @Min(value = 1, message = "页码必须大于等于 1")
    @NotNull
    private Integer pageNum = 1;

    @Schema(description = "分页大小 (默认 20, 最大 100)")
    @Min(value = 1, message = "分页大小必须大于等于 1")
    @Max(value = 100, message = "分页大小不能超过 100")
    @NotNull
    private Integer pageSize = 20;
}
