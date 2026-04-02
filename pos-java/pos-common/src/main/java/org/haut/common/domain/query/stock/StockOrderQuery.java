package org.haut.common.domain.query.stock;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 库存订单查询Query
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "库存订单查询对象")
public class StockOrderQuery {

    /**
     * 订单号
     */
    @Schema(description = "订单号", example = "IN202412190001")
    private String orderCode;

    /**
     * 操作员
     */
    @Schema(description = "操作员", example = "admin")
    private String operator;

    /**
     * 开始日期
     */
    @Schema(description = "开始日期", example = "2024-12-01")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;

    /**
     * 结束日期
     */
    @Schema(description = "结束日期", example = "2024-12-31")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    /**
     * 页码
     */
    @Schema(description = "页码", example = "1")
    private Long pageNum = 1L;

    /**
     * 每页大小
     */
    @Schema(description = "每页大小", example = "10")
    private Long pageSize = 10L;
}