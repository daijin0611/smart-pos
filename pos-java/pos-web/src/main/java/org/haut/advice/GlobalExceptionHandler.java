package org.haut.advice;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.haut.common.domain.vo.JsonVO;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.exception.BusinessException;
import org.haut.common.exception.IdempotentException;
import org.springframework.web.HttpMediaTypeException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingRequestValueException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.validation.FieldError;

import java.util.stream.Collectors;

/**
 * 全局异常处理器
 * @author 丁铭瀚
 */
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    /**
     * 系统通用异常处理
     * @param e 异常类型
     * @return 返回异常信息回显数据
     */
    private static final int DEFAULT_STACK_LINES = 5;

    private void logError(Exception e, int lines) {
        String stackTrace = ExceptionUtils.getStackTrace(e)
                .lines()
                .limit(lines)
                .collect(Collectors.joining("\n"));
        log.error("{}\n{}", e.getMessage(), stackTrace);
    }

    @ExceptionHandler(value = Exception.class)
    public JsonVO<String> exceptionHandler(Exception e) {
        logError(e, DEFAULT_STACK_LINES);
        if (e instanceof HttpMediaTypeException) {
            return JsonVO.create(null, ResultStatus.CONTENT_TYPE_ERR.getCode(), e.getMessage());
        }
        return JsonVO.create(null, ResultStatus.SERVER_ERROR);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public JsonVO<String> handleValidationException(MethodArgumentNotValidException ex) {
        log.error(ex.getMessage(), ex);
        String errorMsg = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.joining(", "));
        return JsonVO.fail(errorMsg);
    }

    @ExceptionHandler(RuntimeException.class)
    public JsonVO<String> handleRuntimeException(RuntimeException ex) {
        logError(ex, DEFAULT_STACK_LINES);
        return JsonVO.fail(ex.getMessage());
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public JsonVO<String> handleIllegalArgumentException(IllegalArgumentException ex) {
        logError(ex, DEFAULT_STACK_LINES);
        return JsonVO.fail(ex.getMessage());
    }

    @ExceptionHandler(BusinessException.class)
    public JsonVO<Object> handleBusinessException(BusinessException ex) {
        logError(ex, DEFAULT_STACK_LINES);
        return JsonVO.create(null, ResultStatus.FAIL.getCode(), ex.getMessage());
    }

    @ExceptionHandler(MissingRequestValueException.class)
    public JsonVO<String> handleMissingRequestValueException(MissingRequestValueException ex) {
        logError(ex, DEFAULT_STACK_LINES);
        return JsonVO.fail("缺少必填参数");
    }

    /**
     * 接口幂等异常处理
     * @param ex 幂等异常
     */
    @ExceptionHandler(IdempotentException.class)
    public JsonVO<String> handleIdempotentException(IdempotentException ex) {
        logError(ex, DEFAULT_STACK_LINES);
        return JsonVO.create(null, ResultStatus.REPETITIVE_OPERATION.getCode(), ex.getMessage());
    }
}
