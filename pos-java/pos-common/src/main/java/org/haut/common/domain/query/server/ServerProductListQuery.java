package org.haut.common.domain.query.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "服务产品查询对象")
public class ServerProductListQuery {

    /**
     * 产品名称
     */
    private String productName;

    /**
     * 产品编码
     */
    private String productEncode;

    /**
     * 产品状态
     */
    private Integer productStatus;

}
