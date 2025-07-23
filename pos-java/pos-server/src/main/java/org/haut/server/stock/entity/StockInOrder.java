package org.haut.server.stock.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 入库订单表
 * 用于记录商品入库的订单信息，包括订单编码、总价、操作员等
 * 
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 * @TableName stock_in_order
 */
@TableName(value = "stock_in_order")
@Data
@Schema(description = "入库订单表")
public class StockInOrder {
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
     * 总价
     */
    private BigDecimal totalPrice;

    /**
     * 操作员
     */
    private String operator;

    /**
     * 订单编码
     */
    private String orderCode;

    /**
     * 组织ID
     */
    private Long orgId;
}