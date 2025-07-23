package org.haut.common.domain.vo.stock;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 库存日志信息VO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "库存日志信息")
public class StockLogVO {

    /**
     * 日志ID
     */
    @Schema(description = "日志ID", example = "1")
    private Long id;

    /**
     * 产品ID
     */
    @Schema(description = "产品ID", example = "1")
    private Long productId;

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
     * 操作类型(1:入库 2:出库 3:盘点 4:调整)
     */
    @Schema(description = "操作类型(1:入库 2:出库 3:盘点 4:调整)", example = "1")
    private Integer operationType;

    /**
     * 操作类型描述
     */
    @Schema(description = "操作类型描述", example = "入库")
    private String operationTypeDesc;

    /**
     * 业务单号
     */
    @Schema(description = "业务单号", example = "IN202412190001")
    private String businessNo;

    /**
     * 变动数量(正数为增加，负数为减少)
     */
    @Schema(description = "变动数量", example = "100")
    private Integer changeQuantity;

    /**
     * 变动前库存
     */
    @Schema(description = "变动前库存", example = "50")
    private Integer beforeStock;

    /**
     * 变动后库存
     */
    @Schema(description = "变动后库存", example = "150")
    private Integer afterStock;

    /**
     * 单价
     */
    @Schema(description = "单价", example = "10.00")
    private BigDecimal unitPrice;

    /**
     * 金额
     */
    @Schema(description = "金额", example = "1000.00")
    private BigDecimal amount;

    /**
     * 备注
     */
    @Schema(description = "备注", example = "采购入库")
    private String remark;

    /**
     * 操作时间
     */
    @Schema(description = "操作时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date operationTime;

    /**
     * 操作人
     */
    @Schema(description = "操作人", example = "admin")
    private String operationBy;

    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}