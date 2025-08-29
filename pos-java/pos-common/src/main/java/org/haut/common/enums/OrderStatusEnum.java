package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OrderStatusEnum {
    UNPAID(0,"未支付"),
    PAID(1,"已支付"),
    SETTLED(2,"已结算"),
    CANCELED(3,"已取消"),
    ;
    private final Integer code;
    private final String message;
    public static String getMessageByCode(Integer code) {
        for (OrderStatusEnum value : OrderStatusEnum.values()) {
            if (value.code.equals(code)) {
                return value.message;
            }
        }
        return null;
    }
}
