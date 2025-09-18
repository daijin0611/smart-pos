package org.haut.common.domain.vo.order;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 创建订单响应VO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-09-18
 */
@Data
@Schema(description = "创建订单响应VO")
@Accessors(chain = true)
public class OrderCreateVO {

    /**
     * 订单ID
     */
    @Schema(description = "订单ID")
    private Long id;

    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /**
     * 更新时间
     */
    @Schema(description = "更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    /**
     * 逻辑删除标识（0 存在，1 删除）
     */
    @Schema(description = "逻辑删除标识（0 存在，1 删除）")
    private Integer isDelete;

    /**
     * 备注信息
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
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
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
     * 会员ID（可选，散客时为null）
     */
    @Schema(description = "会员ID（可选，散客时为null）")
    private Long vipId;

    /**
     * 会员姓名
     */
    @Schema(description = "会员姓名")
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
     * 会员余额（结算时的会员余额）
     */
    @Schema(description = "会员余额（结算时的会员余额）")
    private BigDecimal vipBalance;

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
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
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
     * 收银人姓名
     */
    @Schema(description = "收银人姓名")
    private String userName;

    /**
     * 门店ID
     */
    @Schema(description = "门店ID")
    private Long orgId;

    /**
     * 订单明细列表
     */
    @Schema(description = "订单明细列表")
    private List<OrderDetailVO> details;
}
