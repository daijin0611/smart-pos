package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 设定与门店关联类型枚举
 */
@Getter
@AllArgsConstructor
public enum OrgRelationTypeEnum {
    SERVER_ITEM(1, "服务项"),
    SERVER_PRODUCT(2, "服务产品"),
    CURE_TICKET(3, "疗程券"),
    VIP_TICKET(4, "优惠券"),
    RECHARGE_ACTIVE(5, "充值活动");

    private final Integer value;
    private final String name;

    public static OrgRelationTypeEnum getByValue(Integer value) {
        for (OrgRelationTypeEnum typeEnum : values()) {
            if (typeEnum.value.equals(value)) {
                return typeEnum;
            }
        }
        return null;
    }
}
