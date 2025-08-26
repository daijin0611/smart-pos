package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum TicketStatusEnum {
    UNUSED(0, "未使用"),
    USED(1, "已使用");

    private final Integer value;
    private final String status;
}
