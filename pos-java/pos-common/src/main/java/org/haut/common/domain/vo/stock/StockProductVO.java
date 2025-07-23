package org.haut.common.domain.vo.stock;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 库存产品信息VO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "库存产品信息")
public class StockProductVO {

    /**
     * 产品ID
     */
    @Schema(description = "产品ID", example = "1")
    private Long id;

    /**
     * 产品ID（关联server_product表）
     */
    @Schema(description = "产品ID", example = "1")
    private Long productId;

    /**
     * 库存数量
     */
    @Schema(description = "库存数量", example = "150")
    private Integer quantity;

    /**
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)", example = "0")
    private Integer isDelete;

    /**
     * 备注(其他描述)
     */
    @Schema(description = "备注", example = "库存备注")
    private String remark;

    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /**
     * 更新时间
     */
    @Schema(description = "更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;
}