package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum CustomerTypeEnum {
    VISITOR(1, "散客"),
    VIP(0, "会员");

    private final Integer value;
    private final String type;

}
