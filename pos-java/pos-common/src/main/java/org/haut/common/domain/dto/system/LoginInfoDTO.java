package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;


@Data
@Schema(description = "登录信息")
public class LoginInfoDTO {
    @Schema(description = "用户编号")
    private String userCode;
}
