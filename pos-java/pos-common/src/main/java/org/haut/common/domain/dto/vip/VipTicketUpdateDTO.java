package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Accessors(chain = true)
@Schema(description = "优惠券更新对象")
public class VipTicketUpdateDTO {

    /**
     * 主键id
     */
    @NotNull
    @Schema(description = "主键id")
    private Integer id;

    /**
     * 优惠券名称
     */
    @Schema(description = "优惠券名称")
    @NotBlank(message = "优惠券名称不能为空")

    private String ticketName;

    /**
     * 优惠券类型
     */
    @Schema(description = "优惠券类型")
    @NotNull(message = "优惠券类型不能为空")
    private Integer ticketType;

    /**
     * 有效天数（-1 代表无限期）
     */
    @Schema(description = "有效天数（-1 代表无限期）")
    @NotNull(message = "有效天数不能为空")
    private Integer ticketEffectiveTime;

    /**
     * 限额满多少元可用
     */
    @Schema(description = "限额满多少元可用")
    private BigDecimal ticketFullPayment;

    /**
     * 优惠券面值
     */
    @Schema(description = "优惠券面值")
    private BigDecimal ticketValue;

    /**
     * 优惠券描述
     */
    @Schema(description = "优惠券描述")
    private String ticketDescription;

    /**
     * 优惠券适用服务项目
     */
    @Schema(description = "优惠券适用服务项目")
    private List<Long> serverItemIds;
}
