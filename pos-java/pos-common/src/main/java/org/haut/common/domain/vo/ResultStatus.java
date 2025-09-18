package org.haut.common.domain.vo;

import lombok.Getter;

/**
 * <p>
 * 描述：响应码枚举
 * </p>
 * <p>版权：&copy;01星球</p>
 * <p>地址：01星球总部</p>
 * @author 阿伟学长
 * @version 1.0.0
 */

@Getter
public enum ResultStatus {
    /***/
    UNAUTHORIZED("暂未登录或TOKEN已经过期", 401),
    USERNAME_OR_PASSWORD_ERROR("用户名或密码错误", 401),
    FORBIDDEN("没有相关权限", 403),
    REPETITIVE_OPERATION("请勿重复操作",9993),
    SERVER_ERROR("服务器错误", 9994),
    PARAMS_INVALID("请求参数异常", 9995),
    CONTENT_TYPE_ERR("ContentType错误", 9996),
    API_UN_IMPL("功能尚未实现", 9997),
    SERVER_BUSY("服务器繁忙", 9998),
    FAIL("操作失败", 9999),
    SUCCESS("操作成功"),
    LOGIN_SUCCESS("登录成功"),
    LOGOUT_SUCCESS("登出成功");

    private final String message;
    private final int code;

    ResultStatus(String message, int code) {
        this.message = message;
        this.code = code;
    }

    ResultStatus(String message) {
        this(message, 10000);
    }

}
