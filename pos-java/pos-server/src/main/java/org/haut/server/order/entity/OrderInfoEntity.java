package org.haut.server.order.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单信息表实体类
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-09-18
 * @TableName order_info
 */
@TableName(value = "order_info")
@Data
@Accessors(chain = true)
@Schema(description = "订单信息表")
public class OrderInfoEntity {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    @Schema(description = "主键ID")
    private Long id;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    @Schema(description = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @Schema(description = "更新时间")
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)")
    private Integer isDelete;

    /**
     * 备注
     */
    @Schema(description = "备注信息")
    private String remark;

    /**
     * 订单编号
     */
    @Schema(description = "订单编号")
    private String orderCode;

    /**
     * 开单时间
     */
    @Schema(description = "开单时间")
    private Date orderTime;

    /**
     * 订单状态
     */
    @Schema(description = "订单状态")
    private Integer orderStatus;

    /**
     * 客户姓名
     */
    @Schema(description = "客户姓名")
    private String customerName;

    /**
     * 顾客类型（0 会员，1 散客）
     */
    @Schema(description = "顾客类型（0 会员，1 散客）")
    private Integer customerType;
    /**
     * 会员ID
     */
    @Schema(description = "会员ID")
    private Long vipId;

    /**
     * 会员名称
     */
    @Schema(description = "会员名称")
    private String vipName;

    /**
     * 会员卡号
     */
    @Schema(description = "会员卡号")
    private String vipCardNumber;

    /**
     * 会员电话号码
     */
    @Schema(description = "会员电话号码")
    private String vipPhoneNumber;

    /**
     * 消费前余额
     */
    @Schema(description = "消费前余额")
    private BigDecimal beforeBalance;

    /**
     * 消费后余额
     */
    @Schema(description = "消费后余额")
    private BigDecimal afterBalance;

    /**
     * 结算时间
     */
    @Schema(description = "结算时间")
    private Date settleTime;

    /**
     * 应收金额
     */
    @Schema(description = "应收金额")
    private BigDecimal totalAmount;

    /**
     * 实收金额
     */
    @Schema(description = "实收金额")
    private BigDecimal actualAmount;

    /**
     * 优惠金额
     */
    @Schema(description = "优惠金额")
    private BigDecimal discountAmount;

    /**
     * 床位ID
     */
    @Schema(description = "床位ID")
    private Long bedId;

    /**
     * 床位名称
     */
    @Schema(description = "床位名称")
    private String bedName;

    /**
     * 收银人ID
     */
    @Schema(description = "收银人ID")
    private Long userId;

    /**
     * 收银人名称
     */
    @Schema(description = "收银人名称")
    private String userName;

    /**
     * 门店ID
     */
    @Schema(description = "门店ID")
    private Long orgId;
}