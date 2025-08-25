package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum RechargeActiveType {
    AMOUNT(0, "赠送金额"),
    TICKET(1, "赠送优惠券"),
    AMOUNT_TICKET(2, "赠送金额和优惠券"),
    ANOTHER(3, "其他")
    ;

    private final Integer value;
    private final String type;

    public static RechargeActiveType getByValue(Integer value) {
        for (RechargeActiveType type : values()) {
            if (type.value.equals(value)) {
                return type;
            }
        }
        return ANOTHER;
    }
}
