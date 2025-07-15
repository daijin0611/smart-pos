package org.haut.common.domain.vo.auth;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Date;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Builder
@Schema(description = "授权信息")
public class AuthorizeVO {
    @Schema(description = "用户名")
    String username;
    @Schema(description = "用户ID")
    String userId;
    @Schema(description = "用户角色")
    String role;
    @Schema(description = "用户令牌")
    String token;
    @Schema(description = "令牌过期时间")
    Date expire;
}
