package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 服务项目枚举
 */
@Getter
@AllArgsConstructor
public enum ServerItemTypeEnum {
    APPOINTMENT(0, "点钟"),
    EXTEND(1, "加钟"),
    ROTATION(2, "轮牌"),
    ANOTHER(null, "其他"),
    ;

    private final Integer value;
    private final String type;

    public static ServerItemTypeEnum getByValue(Integer value) {
        for (ServerItemTypeEnum item : values()) {
            if (item.value.equals(value)) {
                return item;
            }
        }
        return ServerItemTypeEnum.ANOTHER;
    }
}
