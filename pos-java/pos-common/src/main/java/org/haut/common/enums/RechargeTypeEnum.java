package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum RechargeTypeEnum {
    STORE(1, "门店充值"),
    PRESENT(2, "手动赠送");

    private final Integer value;
    private final String type;
}
