package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author 丁铭瀚
 * @version 2.0
 */
@Getter
@AllArgsConstructor
public enum PaymentTypeEnum {

    QR("0", "扫码"),
    CASH("1", "现金"),
    POS("2", "POS"),
    DOUYIN("3", "抖音"),
    MEITUAN("4", "美团"),
    MEMBER_CARD("5", "会员卡"),
    ;

    private final String code;
    private final String label;

    /**
     * 根据 code 获取枚举
     */
    public static PaymentTypeEnum getByCode(String code) {
        for (PaymentTypeEnum e : values()) {
            if (e.code.equals(code)) {
                return e;
            }
        }
        return null;
    }
}
