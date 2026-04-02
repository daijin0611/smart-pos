package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 订单状态枚举
 */
@Getter
@AllArgsConstructor
public enum OrderStatusEnum {
    UNSETTLED(1,"未结算"),
    SETTLED(2,"已结算"),
    CANCELLED(3,"已取消"),
    ROLLBACK(4,"已冲正"),
    RECONCILED(5,"已对单")
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
