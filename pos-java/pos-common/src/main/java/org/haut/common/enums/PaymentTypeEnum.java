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

    WECHAT("0", "微信支付"),
    ALIPAY("1", "支付宝支付"),
    CASH("2","现金支付"),
    ASSET("3","会员卡支付");

    private final String code;
    private final String label;
}
