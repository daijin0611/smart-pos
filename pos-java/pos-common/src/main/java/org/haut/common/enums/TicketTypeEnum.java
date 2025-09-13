package org.haut.common.enums;

import lombok.Getter;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Getter
public enum TicketTypeEnum {
    CONSUMER(0, "代金券"),
    ITEM(1, "体验券");

    private final Integer value;
    private final String type;

    TicketTypeEnum(Integer value, String type) {
        this.value = value;
        this.type = type;
    }
}
