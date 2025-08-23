package org.haut.server.stock.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 出库商品明细表
 * 用于记录每个出库订单中具体商品的详细信息
 * 
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 * @TableName stock_out_item
 */
@TableName(value = "stock_out_item")
@Data
@Schema(description = "出库明细表")
@Accessors(chain = true)
public class StockOutItem {
    /**
     * 主键 自增
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    private Integer isDelete;

    /**
     * 备注(其他描述)
     */
    private String remark;

    /**
     * 产品ID
     */
    private Long productId;

    /**
     * 产品编码
     */
    private String productCode;

    /**
     * 产品名称
     */
    private String productName;

    /**
     * 单位
     */
    private String unit;

    /**
     * 数量
     */
    private Integer quantity;

    /**
     * 单价
     */
    private BigDecimal price;

    /**
     * 出库订单ID
     */
    private Long outOrderId;

    /**
     * 出库订单编码
     */
    private String outOrderCode;

    /**
     * 组织ID
     */
    private Long orgId;
}