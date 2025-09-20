package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.util.Date;
import java.util.List;

/**
 * 创建订单请求DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Data
@Accessors(chain = true)
@Schema(description = "开单请求DTO")
public class OrderCreateDTO {
    
    /**
     * 会员ID（可选，散客时为null）
     */
    @Schema(description = "会员ID（可选，散客时为null）")
    private Long vipId;

    
    /**
     * 顾客类型（0 会员，1 散客）
     */
    @NotNull(message = "顾客类型不能为空")
    @Schema(description = "顾客类型（0 会员，1 散客）")
    private Integer customerType;

    @Schema(description = "散客名称")
    private String customerName;

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
     * 订单明细列表
     */
    @NotEmpty(message = "订单明细不能为空")
    @Schema(description = "订单明细列表（至少一个项目明细）")
    private List<OrderDetailCreateDTO> orderDetails;

}