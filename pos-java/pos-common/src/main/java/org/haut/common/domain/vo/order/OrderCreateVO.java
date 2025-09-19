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
    @Schema(description = "订单ID")
    private Long orderId;
    @Schema(description = "订单编号")
    private String orderCode;
}
