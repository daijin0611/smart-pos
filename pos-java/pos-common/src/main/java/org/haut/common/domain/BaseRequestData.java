package org.haut.common.domain;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "公共请求字段")
public class BaseRequestData {

    @Schema(description = "组织ID")
    private Long orgId;
}
