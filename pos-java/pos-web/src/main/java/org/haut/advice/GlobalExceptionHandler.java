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

import java.util.List;
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
    @ExceptionHandler(value = Exception.class)
    public JsonVO<String> exceptionHandler(Exception e) {
        log.error(e.getMessage(), e);
        if (e instanceof HttpMediaTypeException) {
            return JsonVO.create(e.getMessage(), ResultStatus.CONTENT_TYPE_ERR);
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
        log.error(ex.getMessage(), ex);
        return JsonVO.fail(null);
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public JsonVO<String> handleIllegalArgumentException(IllegalArgumentException ex) {
        log.error(ex.getMessage(), ex);
        return JsonVO.fail(ex.getMessage());
    }

    @ExceptionHandler(BusinessException.class)
    public JsonVO<Object> handleBusinessException(BusinessException ex) {
        List<String> stackTrace = ExceptionUtils.getStackTrace(ex)
                .lines()
                .limit(5)
                .toList();
        log.error("{}:\n{}",ex.getMessage(),stackTrace);
        return JsonVO.fail(ex.getMessage());
    }

    @ExceptionHandler(MissingRequestValueException.class)
    public JsonVO<String> handleMissingRequestValueException(MissingRequestValueException ex) {
        log.error(ex.getMessage(), ex);
        return JsonVO.fail("缺少必填参数");
    }

    /**
     * 接口幂等异常处理
     * @param ex 幂等异常
     * @return
     */
    @ExceptionHandler(IdempotentException.class)
    public JsonVO<String> handleIdempotentException(IdempotentException ex) {
        log.error(ex.getMessage(), ex);
        return JsonVO.create(null,ResultStatus.REPETITIVE_OPERATION.getCode(),ex.getMessage());
    }
}
