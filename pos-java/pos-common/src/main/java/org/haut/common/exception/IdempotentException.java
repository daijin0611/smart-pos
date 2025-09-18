package org.haut.common.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 幂等性异常
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class IdempotentException extends RuntimeException {
    private String message;
    private Integer code;
}
