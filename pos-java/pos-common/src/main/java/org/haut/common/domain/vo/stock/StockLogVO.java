package org.haut.common.domain.vo.stock;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.haut.common.domain.entity.stock.StockLog;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 库存日志信息VO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Schema(description = "库存日志信息")
public class StockLogVO extends StockLog {

}