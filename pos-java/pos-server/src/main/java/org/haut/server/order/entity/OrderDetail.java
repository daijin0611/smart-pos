package org.haut.server.order.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;
import lombok.Data;
import lombok.experimental.Accessors;
import org.springframework.cglib.core.Local;

/**
 * 订单明细表
 * @TableName order_detail
 */
@TableName(value ="order_detail")
@Data
@Accessors(chain = true)
public class OrderDetail {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    @TableLogic
    private Integer isDelete;

    /**
     * 备注
     */
    private String remark;

    /**
     * 
     */
    private String detailCode;

    /**
     * 订单id
     */
    private Long orderId;

    /**
     * 订单编号
     */
    private String orderCode;

    /**
     * 员工id
     */
    private Long userId;

    /**
     * 技师名称
     */
    private String userName;

    /**
     * 业务类型（0 产品，1 服务，2 套餐）
     */
    private Integer detailType;

    /**
     * 订单业务id
     */
    private Long serverId;

    /**
     * 订单业务id
     */
    private Long bid;

    /**
     * 标准价
     */
    private BigDecimal stdPrice;

    /**
     * 实际单价
     */
    private BigDecimal truePrice;

    /**
     * 销售数量
     */
    private Integer quantity;

    /**
     * 上钟类型（0 点钟，1 加钟，2 轮牌）
     */
    private Integer serverType;

    /**
     * 结算时间
     */
    private LocalDateTime settledTime;

    /**
     * 订单状态
     */
    private Integer orderStatus;

    /**
     * 机构id
     */
    private Long orgId;
}