package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

@Data
@Accessors(chain = true)
@Schema(description = "支付信息")
public class PaymentInfoDTO {
    @Schema(description = "支付类型")
    private Integer paymentType;
    @Schema(description = "支付名称")
    private String paymentName;
    @Schema(description = "支付金额")
    private BigDecimal paymentAmount;
}
