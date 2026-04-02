package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
@Schema(description = "套餐列表对象")
public class PackageListDTO {

    /**
     * 服务套餐名称
     套餐名称
     */
    @Schema(description = "套餐名称")
    private String packageName;

    /**
     * 套餐编码
     */
    @Schema(description = "套餐编码")
    private String packageEncode;

    /**
     * 散客价
     */
    @Schema(description = "散客价")
    private BigDecimal packagePrice;

    /**
     * 会员价
     */
    @Schema(description = "会员价")
    private BigDecimal packagePriceVip;

    @Schema(description = "套餐项目信息")
    private List<PackageDetailDTO> packageDetailDTOList;
}
