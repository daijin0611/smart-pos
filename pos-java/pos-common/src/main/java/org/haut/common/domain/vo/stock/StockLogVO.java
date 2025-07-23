package org.haut.common.domain.vo.stock;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 库存日志信息VO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "库存日志信息")
public class StockLogVO {

    /**
     * 日志ID
     */
    @Schema(description = "日志ID", example = "1")
    private Long id;

    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /**
     * 更新时间
     */
    @Schema(description = "更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)", example = "0")
    private Integer isDelete;

    /**
     * 备注
     */
    @Schema(description = "备注", example = "库存变动")
    private String remark;

    /**
     * 订单编码
     */
    @Schema(description = "订单编码", example = "IN202412190001")
    private String orderCode;

    /**
     * 订单类型（入库/出库）
     */
    @Schema(description = "订单类型", example = "入库")
    private String orderType;

    /**
     * 产品ID
     */
    @Schema(description = "产品ID", example = "1")
    private Long productId;

    /**
     * 产品名称
     */
    @Schema(description = "产品名称", example = "洗发水")
    private String productName;

    /**
     * 产品编码
     */
    @Schema(description = "产品编码", example = "P001")
    private String productCode;

    /**
     * 操作员
     */
    @Schema(description = "操作员", example = "admin")
    private String operator;

    /**
     * 数量
     */
    @Schema(description = "数量", example = "100")
    private Integer quantity;

    /**
     * 单价
     */
    @Schema(description = "单价", example = "10.00")
    private BigDecimal price;

    /**
     * 总价
     */
    @Schema(description = "总价", example = "1000.00")
    private BigDecimal totalPrice;
}