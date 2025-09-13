package org.haut.common.domain.query.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDate;

@Data
@Schema(description = "充值活动统计查询参数")
@Accessors(chain = true)
public class ActiveStatQuery {

    @Schema(description = "充值活动ID")
    @NotNull(message = "充值活动ID不能为空")
    private Long activeId;
    @Schema(description = "开始时间")
    private LocalDate startTime;
    @Schema(description = "结束时间")
    private LocalDate endTime;
}
