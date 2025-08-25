package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum CommissionTypeEnum {
    FIXED(0, "固定金额"),
    RATIO(1, "比例金额");

    private final Integer value;
    private final String type;
}
