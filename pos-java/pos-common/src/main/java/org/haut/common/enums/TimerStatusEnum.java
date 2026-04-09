package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 计时状态枚举
 */
@Getter
@AllArgsConstructor
public enum TimerStatusEnum {
    NOT_STARTED(0, "未开始"),
    RUNNING(1, "进行中"),
    PAUSED(2, "已暂停"),
    FINISHED(3, "已结束");

    private final Integer code;
    private final String message;

    public static TimerStatusEnum getByCode(Integer code) {
        for (TimerStatusEnum value : TimerStatusEnum.values()) {
            if (value.code.equals(code)) {
                return value;
            }
        }
        return null;
    }
}
