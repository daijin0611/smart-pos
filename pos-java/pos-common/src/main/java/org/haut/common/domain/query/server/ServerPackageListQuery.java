package org.haut.common.domain.query.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "套餐列表查询对象")
public class ServerPackageListQuery {

    @Schema(description = "套餐名称")
    private String packageName;

    @Schema(description = "套餐编码")
    private String packageEncode;
}
