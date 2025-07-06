package org.haut.common.domain.query.server;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema(description = "服务项目列表查询对象")
public class ServerItemListQuery {
    /**
     * 服务项目产品名称
     */
    @NotNull
    private String itemName;

    /**
     * 服务项目产品编码
     */
    private String itemEncode;
}
