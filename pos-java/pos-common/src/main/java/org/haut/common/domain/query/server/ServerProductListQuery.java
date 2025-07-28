package org.haut.common.domain.query.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "服务产品查询对象")
public class ServerProductListQuery {

    /**
     * 产品名称
     */
    @Schema(description = "产品名称")
    private String productName;

    /**
     * 产品编码
     */
    @Schema(description = "产品编码")
    private String productEncode;

    /**
     * 产品状态
     */
    @Schema(description = "产品状态（0 正常，1 停用）")
    private Integer productStatus;

    /**
     * 页码
     */
    @Schema(description = "页码", example = "1")
    private Integer pageNum = 1;

    /**
     * 页大小
     */
    @Schema(description = "页大小", example = "10")
    private Integer pageSize = 20;

}
