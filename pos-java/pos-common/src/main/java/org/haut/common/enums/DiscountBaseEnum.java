package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum DiscountBaseEnum {
    SOURCE(0, "标准价"),
    VIP(1, "会员价");

    private final Integer value;
    private final String type;

}
