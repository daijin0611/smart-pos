package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum RechargeStatusEnum {
    SUCCESS(0, "充值成功"),
    REVOKE(1, "冲正");
    private final Integer value;
    private final String name;

}
