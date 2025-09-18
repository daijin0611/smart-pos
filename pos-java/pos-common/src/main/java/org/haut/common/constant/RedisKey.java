package org.haut.common.constant;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
public interface RedisKey {

    String JWT_BLACK_LIST = "jwt:blacklist"; // JWT黑名单列表
    String IDEMPOTENT = "idempotent:%s";
}
