package org.haut.common.domain.query.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Schema(description = "服务产品查询对象")
@Accessors(chain = true)
public class ServerProductListQuery {


    /**
     * 查询关键字
     */
    @Schema(description = "查询关键字(编码/名称)")
    private String keyWord;

    /**
     * 产品状态
     */
    @Schema(description = "产品状态（0 正常，1 停用，null 全部状态）")
    private Integer productStatus;

}
