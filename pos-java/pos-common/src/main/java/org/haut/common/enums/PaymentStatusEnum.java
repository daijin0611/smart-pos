package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Getter
@AllArgsConstructor
public enum PaymentStatusEnum {
    CANCELLED("已取消"),
    WAITING("待结算"),
    PAID("已结算"),
    ROLLBACK("已冲正")
    ;



    private final String status;

}
