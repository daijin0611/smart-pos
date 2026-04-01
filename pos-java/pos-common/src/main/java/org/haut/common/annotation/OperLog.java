package org.haut.common.annotation;

import java.lang.annotation.*;

/**
 * 操作日志注解
 * 标记在Controller方法上，用于记录关键业务操作日志
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface OperLog {
    /**
     * 操作模块
     */
    String module();

    /**
     * 操作描述
     */
    String description();

    /**
     * 是否记录响应结果（默认记录）
     */
    boolean saveResponse() default true;
}