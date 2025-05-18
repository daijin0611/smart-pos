package org.haut.common.domain.dto.server;


import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "服务产品列表对象")
public class ServerProductListDTO {


    /**
     * 产品ID（唯一标识）
     */
    private Long id;
    /**
     * 产品名称
     */
    private String productName;

    /**
     * 产品编码
     */
    private String productEncode;

    /**
     * 标准价
     */
    private BigDecimal productPrice;

    /**
     * 会员价
     */
    private BigDecimal vipProductPrice;

    /**
     * 是否参与打折（0 是，1 否）
     */
    private Integer isDiscount;
}
