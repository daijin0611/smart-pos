package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Getter
@AllArgsConstructor
public enum PaymentTypeEnum {

    WECHAT("0", "微信"),
    ALIPAY("1", "支付宝"),
    CASH("2","现金"),
    ASSET("3","会员卡"),
    TICKET("4","优惠券"),
    MEITUAN("5","美团"),
    DOUYIN("6","抖音"),
    UNKNOWN("99","未知"),
    ;

    private final String code;
    private final String label;
}
