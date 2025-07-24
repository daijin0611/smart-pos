package org.haut.common.domain.vo.stock;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.haut.common.domain.entity.server.ServerProduct;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 库存产品信息VO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "库存产品信息")
public class StockProductVO extends ServerProduct {

    /**
     * 库存数量
     */
    @Schema(description = "库存数量", example = "150")
    private Integer quantity;

}