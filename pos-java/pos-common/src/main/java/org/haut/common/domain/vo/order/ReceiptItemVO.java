package org.haut.common.domain.vo.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

/**
 * 小票-订单明细项VO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-11-14
 */
@Data
@Accessors(chain = true)
@Schema(description = "小票-订单明细项信息")
public class ReceiptItemVO {
    /**
     * 项目/商品名称
     */
    @Schema(description = "项目/商品名称")
    private String itemName;

    /**
     * 技师名称
     */
    @Schema(description = "技师名称")
    private String technicianName;

    /**
     * 数量
     */
    @Schema(description = "数量")
    private Integer quantity;

    /**
     * 标准价
     */
    @Schema(description = "标准价")
    private BigDecimal stdPrice;

    /**
     * 实际单价
     */
    @Schema(description = "实际单价")
    private BigDecimal truePrice;

    /**
     * 行金额（实际单价 * 数量）
     */
    @Schema(description = "行金额（实际单价 * 数量）")
    private BigDecimal amount;

    /**
     * 上钟类型名称（点钟/加钟/轮牌）
     */
    @Schema(description = "上钟类型名称（点钟/加钟/轮牌）")
    private String serverTypeName;
}