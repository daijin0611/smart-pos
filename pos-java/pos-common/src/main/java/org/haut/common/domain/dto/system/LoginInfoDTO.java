package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;


@Data
@Schema(description = "登录信息")
@Builder
public class LoginInfoDTO {
    @Schema(description = "用户编号")
    private String userCode;
    @Schema(description = "用户姓名")
    private String userName;
    @Schema(description = "用户ID")
    private Long userId;
    @Schema(description = "组织ID")
    private Long orgId;
}
