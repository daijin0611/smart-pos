package org.haut.common.domain.vo.system;

import lombok.Builder;
import lombok.Data;

import java.util.Date;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Builder
public class AuthorizeVO {
    /**
     * 用户ID
     */
    String username;
    /**
     * 用户角色
     */
    String role;
    /**
     * JWT令牌
     */
    String token;
    /**
     * JWT过期时间
     */
    Date expire;
}
