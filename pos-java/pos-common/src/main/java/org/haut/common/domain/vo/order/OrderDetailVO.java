package org.haut.common.domain.vo.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单明细响应VO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Data
@Accessors(chain = true)
@Schema(description = "订单明细响应VO")
public class OrderDetailVO {
    
    /**
     * 主键ID
     */
    @Schema(description = "主键ID")
    private Long id;
    
    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    private Date createTime;
    
    /**
     * 更新时间
     */
    @Schema(description = "更新时间")
    private Date updateTime;
    
    /**
     * 备注信息
     */
    @Schema(description = "备注信息")
    private String remark;
    
    /**
     * 明细编号
     */
    @Schema(description = "明细编号")
    private String detailCode;
    
    /**
     * 订单ID
     */
    @Schema(description = "订单ID")
    private Long orderId;
    
    /**
     * 订单编号
     */
    @Schema(description = "订单编号")
    private String orderCode;
    
    /**
     * 员工ID
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
     * 订单业务ID
     */
    @Schema(description = "订单业务ID")
    private Long bid;
    
    /**
     * 业务名称（产品名称、服务名称或疗程券名称）
     */
    @Schema(description = "业务名称（产品名称、服务名称或疗程券名称）")
    private String businessName;
    
    /**
     * 业务编码
     */
    @Schema(description = "业务编码")
    private String businessCode;
    
    /**
     * 标准价格
     */
    @Schema(description = "标准价格")
    private BigDecimal stdPrice;
    
    /**
     * 实际单价
     */
    @Schema(description = "实际单价")
    private BigDecimal truePrice;
    
    /**
     * 销售数量
     */
    @Schema(description = "销售数量")
    private Integer quantity;

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

}