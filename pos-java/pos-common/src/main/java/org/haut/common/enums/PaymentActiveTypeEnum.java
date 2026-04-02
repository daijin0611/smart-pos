package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 支付明细业务类型
 */
@Getter
@AllArgsConstructor
public enum PaymentActiveTypeEnum {
    CONSUMER(0, "消费"),
    RECHARGER(1, "充值");

    private final Integer value;
    private final String type;
    public static PaymentActiveTypeEnum getByValue(Integer value) {
        for (PaymentActiveTypeEnum type : PaymentActiveTypeEnum.values()) {
            if (type.value.equals(value)) {
                return type;
            }
        }
        return null;
    }
}
