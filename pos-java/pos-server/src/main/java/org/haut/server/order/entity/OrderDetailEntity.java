package org.haut.server.order.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;

/**
 * 订单明细表实体类
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-09-01
 * @TableName order_detail
 */
@TableName(value = "order_detail")
@Data
@Accessors(chain = true)
@Schema(description = "订单明细表")
public class OrderDetailEntity {
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
     * 明细编号
     */
    @Schema(description = "明细编号")
    private String detailCode;

    /**
     * 订单id
     */
    @Schema(description = "订单ID")
    private Long orderId;

    /**
     * 订单编号
     */
    @Schema(description = "订单编号")
    private String orderCode;

    /**
     * 员工id
     */
    @Schema(description = "员工ID")
    private Long userId;

    /**
     * 员工名称
     */
    @Schema(description = "员工名称")
    private String userName;

    /**
     * 业务类型（0 产品，1 服务，2 疗程券）
     */
    @Schema(description = "业务类型（0 产品，1 服务，2 疗程券）")
    private Integer detailType;

    /**
     * 订单业务id
     */
    @Schema(description = "订单业务ID")
    private Long bid;

    /**
     * 业务名称
     */
    @Schema(description = "业务名称")
    private String businessName;

    /**
     * 业务编码
     */
    @Schema(description = "业务编码")
    private String businessCode;

    /**
     * 标准价
     */
    @Schema(description = "标准价格")
    private BigDecimal stdPrice;

    /**
     * 实收总价
     */
    @Schema(description = "实收总价")
    private BigDecimal truePrice;

    /**
     * 实收单价
     */
    @Schema(description = "实收单价")
    private BigDecimal trueUnitPrice;

    /**
     * VIP价格
     */
    @Schema(description = "VIP价格")
    private BigDecimal vipPrice;

    /**
     * 销售数量
     */
    @Schema(description = "销售数量")
    private Integer quantity;

    /**
     * 是否已计算折扣（0 未计算，1 已计算）
     */
    @Schema(description = "是否已计算折扣（0 未计算，1 已计算）")
    private Integer isDiscount;

    /**
     * 上钟类型（0 点钟，1 加钟，2 轮牌）
     */
    @Schema(description = "上钟类型（0 点钟，1 加钟，2 轮牌）")
    private Integer serverType;

    /**
     * 结算时间
     */
    @Schema(description = "结算时间")
    private Date settledTime;

    /**
     * 订单状态
     */
    @Schema(description = "订单状态")
    private Integer orderStatus;

    /**
     * 门店id
     */
    @Schema(description = "门店ID")
    private Long orgId;

    /**
     * 计时状态（0未开始,1进行中,2已暂停,3已结束）
     */
    @Schema(description = "计时状态（0未开始,1进行中,2已暂停,3已结束）")
    private Integer timerStatus;

    /**
     * 计时开始时间
     */
    @Schema(description = "计时开始时间")
    private Date timerStartTime;

    /**
     * 预计结束时间
     */
    @Schema(description = "预计结束时间")
    private Date timerEndTime;

    /**
     * 累计暂停时长（秒）
     */
    @Schema(description = "累计暂停时长(秒)")
    private Integer timerPausedDuration;

    /**
     * 最近一次暂停开始时间
     */
    @Schema(description = "最近暂停开始时间")
    private Date timerLastPauseTime;

    /**
     * 实际服务时长（秒）
     */
    @Schema(description = "实际服务时长(秒)")
    private Integer actualDuration;

    /**
     * 是否已发送到期提醒
     */
    @Schema(description = "是否已发送到期提醒")
    private Integer timerWarned;
}