package org.haut.common.domain.dto.pay;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;
import org.haut.common.domain.dto.vip.PaymentInfoDTO;

import java.math.BigDecimal;
import java.util.List;

/**
 * 通用业务支付请求 DTO，支持组合支付（购物车）
 *
 * <p>组合支付场景：paymentList 传入多条记录，各条金额之和应等于实收金额。
 * 单一支付场景：paymentList 仅包含一条记录。
 *
 * @see org.haut.common.enums.PaymentActiveTypeEnum bizType 取值
 * @see org.haut.common.enums.PaymentTypeEnum       paymentList[].paymentType 取值
 */
@Data
@Accessors(chain = true)
@Schema(description = "业务支付请求 DTO（支持组合支付）")
public class PayOrderDTO {

    @NotNull
    @Schema(description = "业务类型", example = "ORDER_PAYMENT")
    private String bizType;

    @NotNull
    @Schema(description = "业务 ID", example = "1234567890")
    private Long bizId;

    @NotNull
    @Schema(description = "支付金额，单位元", example = "99.99")
    private BigDecimal amount;

    @NotEmpty
    @Valid
    @Schema(description = "支付方式列表，至少包含一种支付方式")
    private List<PaymentInfoDTO> paymentList;

}

