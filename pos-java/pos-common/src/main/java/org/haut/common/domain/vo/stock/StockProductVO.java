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
     * 产品编码
     */
    @Schema(description = "产品编码", example = "P001")
    private String productCode;

    /**
     * 产品名称
     */
    @Schema(description = "产品名称", example = "洗发水")
    private String productName;

    /**
     * 产品规格
     */
    @Schema(description = "产品规格", example = "500ml")
    private String specification;

    /**
     * 计量单位
     */
    @Schema(description = "计量单位", example = "瓶")
    private String unit;

    /**
     * 产品分类
     */
    @Schema(description = "产品分类", example = "洗护用品")
    private String category;

    /**
     * 品牌
     */
    @Schema(description = "品牌", example = "海飞丝")
    private String brand;

    /**
     * 成本价
     */
    @Schema(description = "成本价", example = "15.50")
    private BigDecimal costPrice;

    /**
     * 售价
     */
    @Schema(description = "售价", example = "25.00")
    private BigDecimal salePrice;

    /**
     * 当前库存
     */
    @Schema(description = "当前库存", example = "150")
    private Integer currentStock;

    /**
     * 安全库存
     */
    @Schema(description = "安全库存", example = "10")
    private Integer safetyStock;

    /**
     * 最大库存
     */
    @Schema(description = "最大库存", example = "1000")
    private Integer maxStock;

    /**
     * 是否库存不足
     */
    @Schema(description = "是否库存不足", example = "false")
    private Boolean lowStock;

    /**
     * 产品描述
     */
    @Schema(description = "产品描述", example = "去屑止痒洗发水")
    private String description;

    /**
     * 状态(0:正常 1:停用)
     */
    @Schema(description = "状态(0:正常 1:停用)", example = "0")
    private Integer status;

    /**
     * 状态描述
     */
    @Schema(description = "状态描述", example = "正常")
    private String statusDesc;

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

    /**
     * 创建人
     */
    @Schema(description = "创建人", example = "admin")
    private String createBy;

    /**
     * 更新人
     */
    @Schema(description = "更新人", example = "admin")
    private String updateBy;
}