package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum TicketStatusEnum {
    UNUSED(0, "未使用"),
    USED(1, "已使用"),
    CANCELLED(2, "已取消");

    private final Integer value;
    private final String status;

    public static TicketStatusEnum getByValue(Integer value) {
        if (value == null) {
            return null;
        }
        for (TicketStatusEnum status : TicketStatusEnum.values()) {
            if (value.equals(status.value)) {
                return status;
            }
        }
        return null;
    }
}
