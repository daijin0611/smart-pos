package org.haut.server.stock.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 库存日志表
 * 用于记录库存变动的详细日志信息，包括操作类型、变动数量、操作员等
 * 
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 * @TableName stock_log
 */
@TableName(value = "stock_log")
@Data
@Schema(description = "库存日志表")
public class StockLog {
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
     * 订单编码
     */
    private String orderCode;

    /**
     * 订单类型（入库/出库）
     */
    private String orderType;

    /**
     * 产品ID
     */
    private Long productId;

    /**
     * 产品名称
     */
    private String productName;

    /**
     * 产品编码
     */
    private String productCode;

    /**
     * 操作员
     */
    private String operator;

    /**
     * 数量
     */
    private Integer quantity;

    /**
     * 单价
     */
    private BigDecimal price;

    /**
     * 总价
     */
    private BigDecimal totalPrice;

    /**
     * 结构id
     */
    private Long orgId;
}