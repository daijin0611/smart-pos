package org.haut.common.domain.dto.server;


import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Schema(description = "服务项目列表对象")
public class ServerItemListDTO {
    /**
     * 服务项目ID
     */
//    @Schema(description = "服务项目ID", example = "1")
//    private Long id;
    /**
     * 服务项目产品名称
     */
    @Schema(description = "服务项目名称", example = "服务项目名称")
    @NotBlank(message = "服务项目名称不能为空")
    private String itemName;

    /**
     * 服务项目产品编码
     */
    @Schema(description = "服务项目编码",example = "0001")
    @NotBlank(message = "服务项目编码不能为空")
    private String itemEncode;

    /**
     * 技师类型
     */
    @Schema(description = "技师类型")
    private String employeeType;

    /**
     * 服务时长
     */
    @Schema(description = "服务时长")
    private Integer serverTime;

    /**
     * 标准价
     */
    @Schema(description = "服务项目标准价格")
    private BigDecimal itemPrice;

    /**
     * 会员价
     */
    @Schema(description = "服务项目VIP价格")
    private BigDecimal vipItemPrice;

    /**
     * 是否参与打折（0 允许，1 禁止）
     */
    @Schema(description = "服务项目是否参与打折（0是，1否）")
    private Integer isDiscounts;
}
