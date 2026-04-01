package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "登录信息")
@Builder
public class AuthInfoDTO {
    @Schema(description = "用户ID")
    private Long userId;
    @Schema(description = "组织ID（主门店）")
    private Long orgId;
    @Schema(description = "用户名")
    private String userName;
    @Schema(description = "用户关联的所有门店ID列表")
    private List<Long> orgIds;
}
