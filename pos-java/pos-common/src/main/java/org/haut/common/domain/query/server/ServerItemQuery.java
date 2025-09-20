package org.haut.common.domain.query.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Schema(description = "服务项目列表查询对象")
@Accessors(chain = true)
public class ServerItemQuery {

    @Schema(description = "查询关键字")
    private String keyWord;

    @Schema(description = "服务项目状态(0 正常，1 停用，null 全部状态)")
    private Integer itemStatus;
}
