package org.haut.common.domain.vo.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Schema(description = "支付信息响应VO")
@Data
@Accessors(chain = true)
public class PaymentVO {

    @Schema(description = "支付ID")
    private Long id;

    @Schema(description = "活动编码")
    private String activeCode;

    @Schema(description = "活动类型")
    private String activeType;

    @Schema(description = "活动名称")
    private String activeName;

    @Schema(description = "支付类型")
    private Integer paymentType;

    @Schema(description = "支付名称")
    private String paymentName;
    
    @Schema(description = "总金额")
    private BigDecimal totalAmount;
    
    @Schema(description = "资产编码")
    private String assetCode;
}
