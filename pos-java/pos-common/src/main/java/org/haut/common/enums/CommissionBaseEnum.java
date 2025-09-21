package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum CommissionBaseEnum {
    STAND(0, "标准价"),
    TRUE(1, "实际价");

    private final Integer value;
    private final String type;
    public static CommissionBaseEnum getByValue(Integer value) {
        for (CommissionBaseEnum item : CommissionBaseEnum.values()) {
            if (item.value.equals(value)) {
                return item;
            }
        }
        return null;
    }

}
