package org.haut.common.domain.dto.server;


import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "服务项目列表对象")
public class ServerItemListDTO {
    /**
     * 服务项目ID
     */
    private Long id;
    /**
     * 服务项目产品名称
     */
    private String itemName;

    /**
     * 服务项目产品编码
     */
    private String itemEncode;

    /**
     * 技师类型
     */
    private String employeeType;

    /**
     * 服务时长
     */
    private Integer serverTime;

    /**
     * 标准价
     */
    private BigDecimal itemPrice;

    /**
     * 会员价
     */
    private BigDecimal vipItemPrice;

    /**
     * 是否参与打折（0 允许，1 禁止）
     */
    private Integer isDiscounts;
}
