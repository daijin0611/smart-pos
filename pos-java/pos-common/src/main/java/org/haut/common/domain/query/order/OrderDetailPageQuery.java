package org.haut.common.domain.query.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDate;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Schema(description = "订单明细分页查询参数")
@Accessors(chain = true)
public class OrderDetailPageQuery {

    @Schema(description = "当前页码")
    @NotNull
    private Long pageNum = 1L;

    @Schema(description = "每页大小")
    @NotNull
    private Long pageSize = 20L;

    @Schema(description = "销售员id")
    private Long userId;

    @Schema(description = "业务编码")
    private String businessCode;


    @Schema(description = "搜索日期范围")
    private LocalDate[] date;}
