package org.haut.common.domain.query.order;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDate;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Accessors(chain = true)
public class OrderSummaryQuery {

    /**
     * 开始时间
     */
    @NotNull(message = "开始时间不可为空")
    private LocalDate startDate;

    /**
     * 结束时间
     */
    @NotNull(message = "结束时间不可为空")
    private LocalDate endDate;
}
