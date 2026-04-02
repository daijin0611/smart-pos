package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum BedStatusEnum {

    FREE(0, "空闲中"),
    USING(1, "服务中"),
    DISABLE(2, "暂停使用");

    private final Integer code;
    private final String message;

    public static String getMessageByCode(Integer code) {
        for (BedStatusEnum value : values()) {
            if (value.code.equals(code)) {
                return value.message;
            }
        }
        return null;
    }

}
