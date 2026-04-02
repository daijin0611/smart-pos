package org.haut.common.domain.query.stock;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Schema(description = "库存产品列表查询对象")
@Accessors(chain = true)
public class StockProductListQuery {
    /**
     * 产品名称
     */
    @Schema(description = "产品名称", example = "工具")
    private String productName;

    /**
     * 产品编号
     */
    @Schema(description = "产品编号", example = "PROD202412190001")
    private String productCode;
}
