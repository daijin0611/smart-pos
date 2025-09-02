package org.haut.common.domain.vo.order;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Schema(description = "创建订单响应VO")
@Accessors(chain = true)
public class OrderCreateVO {

    /**
     * 订单ID
     */
    private Long id;

    /**
     * 会员ID（可选，散客时为null）
     */
    @Schema(description = "会员ID（可选，散客时为null）")
    private Long vipId;

    /**
     * 顾客名称
     */
    @Schema(description = "顾客名称")
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
     * 顾客类型（0 会员，1 散客）
     */
    @Schema(description = "顾客类型（0 会员，1 散客）")
    private Integer customerType;

    /**
     * 床位ID
     */
    @Schema(description = "床位ID(可选)")
    private Long bedId;

    /**
     * 床位名称
     */
    @Schema(description = "床位名称")
    private String bedName;

    /**
     * 备注
     */
    @Schema(description = "备注信息")
    private String remark;

    /**
     * 订单编号
     */
    @Schema(description = "销售单号")
    private String orderCode;

    /**
     * 订单明细
     */
    private List<OrderDetailVO> orderDetailVOList;
}
