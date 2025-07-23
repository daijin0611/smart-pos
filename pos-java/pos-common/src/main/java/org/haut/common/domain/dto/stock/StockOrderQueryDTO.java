package org.haut.common.domain.dto.stock;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
 * 库存订单查询DTO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "库存订单查询对象")
public class StockOrderQueryDTO {

    /**
     * 订单号
     */
    @Schema(description = "订单号", example = "IN202412190001")
    private String orderNo;

    /**
     * 订单类型(1:入库 2:出库)
     */
    @Schema(description = "订单类型(1:入库 2:出库)", example = "1")
    private Integer orderType;

    /**
     * 业务类型(入库:1采购 2退货 3调拨 4其他; 出库:1销售 2退货 3调拨 4其他)
     */
    @Schema(description = "业务类型", example = "1")
    private Integer businessType;

    /**
     * 状态(0:待审核 1:已审核 2:已完成 3:已取消)
     */
    @Schema(description = "状态(0:待审核 1:已审核 2:已完成 3:已取消)", example = "1")
    private Integer status;

    /**
     * 供应商/客户名称
     */
    @Schema(description = "供应商/客户名称", example = "XX供应商")
    private String partnerName;

    /**
     * 开始日期
     */
    @Schema(description = "开始日期", example = "2024-12-01")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date startDate;

    /**
     * 结束日期
     */
    @Schema(description = "结束日期", example = "2024-12-31")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    /**
     * 页码
     */
    @Schema(description = "页码", example = "1")
    private Integer pageNum = 1;

    /**
     * 每页大小
     */
    @Schema(description = "每页大小", example = "10")
    private Integer pageSize = 10;
}