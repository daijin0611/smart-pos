package org.haut.common.domain.query.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Schema(description = "订单分页查询参数")
@Data
@Accessors(chain = true)
public class OrderPageQuery {

    @Schema(description = "当前页码")
    @NotNull
    private Long pageNum = 1L;
    
    @Schema(description = "每页大小")
    @NotNull
    private Long pageSize = 20L;

    @Schema(description = "开单时段")
    private LocalDate[] date;

    @Schema(description = "开始日期")
    private LocalDate startDate;

    @Schema(description = "结束日期")
    private LocalDate endDate;

    @Schema(description = "收银员ID")
    private Long userId;

    @Schema(description = "订单状态")
    private Integer status;

    @Schema(description = "支付方式")
    private Integer paymentType;

    @Schema(description = "会员信息字段(卡号/手机号)")
    private String vipInfoFiled;

    @Schema(description = "订单号")
    private String orderCode;

    @Schema(description = "机构ID", hidden = true)
    private Long orgId;

    @Schema(description = "进查看支付为0的订单")
    private Integer payZero;
}
