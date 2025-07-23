package org.haut.server.stock.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
 * 库存产品表
 * @TableName stock_product
 */
@TableName(value = "stock_product")
@Data
@Schema(description = "库存产品表")
public class StockProduct {
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
     * 产品ID（关联server_product表）
     */
    private Long productId;

    /**
     * 库存数量
     */
    private Integer quantity;
}