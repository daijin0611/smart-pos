package org.haut.common.domain.entity.stock;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * 库存商品表
 * 用于记录商品的库存信息，包括商品编码、当前库存数量、最小库存等
 * 
 * @author mhding
 * @version 1.0
 * @since 2025/07/23
 * @TableName stock_product
 */
@TableName(value = "stock_product")
@Data
@Schema(description = "库存产品表")
@Accessors(chain = true)
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

    /**
     * 机构ID（关联机构表）
     */
    private Long orgId;

}