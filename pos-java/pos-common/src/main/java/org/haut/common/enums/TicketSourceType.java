package org.haut.common.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Getter
@RequiredArgsConstructor
public enum TicketSourceType {

    RECHARGE("充值",1),
    ORDER("订单",2),
    ;

    private final String type;
    private final Integer code;
}
