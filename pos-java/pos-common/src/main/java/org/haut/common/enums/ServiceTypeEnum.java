package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 业务类型枚举
 */
@Getter
@AllArgsConstructor
public enum ServiceTypeEnum {
    PRODUCT(0, "商品"),
    SERVER(1, "服务"),
    CURE_TICKET(2, "治疗券"),
    RECHARGE(3, "充值"),
    UNKNOWN(4, "未知");

    private final Integer value;
    private final String type;

    public static ServiceTypeEnum getByValue(Integer value) {
        for (ServiceTypeEnum type : ServiceTypeEnum.values()) {
            if (type.value.equals(value)) {
                return type;
            }
        }
        return UNKNOWN;
    }
}
