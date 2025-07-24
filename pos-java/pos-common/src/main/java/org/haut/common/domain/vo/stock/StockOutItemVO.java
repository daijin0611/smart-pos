package org.haut.common.domain.vo.stock;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.haut.common.domain.entity.stock.StockOutItem;

import java.math.BigDecimal;
import java.util.Date;

@Data
@Accessors(chain = true)
public class StockOutItemVO {
    /**
     * 主键 自增
     */
    private Long id;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
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
