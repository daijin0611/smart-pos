package org.haut.common.domain.vo.auth;

import com.fasterxml.jackson.annotation.JsonFormat;
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
    @Schema(description = "真实姓名")
    String userName;
    @Schema(description = "用户id")
    Long userId;
    @Schema(description = "用户编号")
    String userCode;
    @Schema(description = "用户令牌")
    String token;
    @Schema(description = "机构id")
    Long orgId;
    @Schema(description = "令牌过期时间")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    Date expire;
}
