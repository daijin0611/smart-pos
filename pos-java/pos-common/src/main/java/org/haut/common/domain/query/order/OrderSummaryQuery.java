package org.haut.common.domain.query.order;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Accessors(chain = true)
public class OrderSummaryQuery {

    @Schema(description = "搜索日期范围")
    private LocalDate[] date;
}
