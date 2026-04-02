package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum VipAssetType {
    RECHARGE(0, "充值"),
    PRESENT(1,"赠送");
    private final Integer value;
    private final String type;
}
