package org.haut.common.enums;

import lombok.Data;
import lombok.Getter;

@Getter
public enum Status {
    ENABLED(0, "启用"),
    DISABLED(1, "停用");

    private final int value;
    private final String name;

    Status(int value, String name) {
        this.value = value;
        this.name = name;
    }

    public static Status getStatus(Integer status) {
        if (status == null) {
            return null;
        }
        for (Status value : Status.values()) {
            if (value.ordinal() == status) {
                return value;
            }
        }
        return null;
    }
}
