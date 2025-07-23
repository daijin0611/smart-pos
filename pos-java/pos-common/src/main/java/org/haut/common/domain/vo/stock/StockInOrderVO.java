package org.haut.common.domain.vo.stock;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 入库订单信息VO
 *
 * @author mhding
 * @date 2024/12/19
 */
@Data
@Schema(description = "入库订单信息")
public class StockInOrderVO {

    /**
     * 订单ID
     */
    @Schema(description = "订单ID", example = "1")
    private Long id;

    /**
     * 入库单号
     */
    @Schema(description = "入库单号", example = "IN202412190001")
    private String orderNo;

    /**
     * 供应商ID
     */
    @Schema(description = "供应商ID", example = "1")
    private Long supplierId;

    /**
     * 供应商名称
     */
    @Schema(description = "供应商名称", example = "XX供应商")
    private String supplierName;

    /**
     * 入库类型(1:采购入库 2:退货入库 3:调拨入库 4:其他入库)
     */
    @Schema(description = "入库类型(1:采购入库 2:退货入库 3:调拨入库 4:其他入库)", example = "1")
    private Integer inType;

    /**
     * 入库类型描述
     */
    @Schema(description = "入库类型描述", example = "采购入库")
    private String inTypeDesc;

    /**
     * 总数量
     */
    @Schema(description = "总数量", example = "100")
    private Integer totalQuantity;

    /**
     * 总金额
     */
    @Schema(description = "总金额", example = "1000.00")
    private BigDecimal totalAmount;

    /**
     * 状态(0:待审核 1:已审核 2:已完成 3:已取消)
     */
    @Schema(description = "状态(0:待审核 1:已审核 2:已完成 3:已取消)", example = "1")
    private Integer status;

    /**
     * 状态描述
     */
    @Schema(description = "状态描述", example = "已审核")
    private String statusDesc;

    /**
     * 备注
     */
    @Schema(description = "备注", example = "采购入库")
    private String remark;

    /**
     * 入库时间
     */
    @Schema(description = "入库时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date inTime;

    /**
     * 审核时间
     */
    @Schema(description = "审核时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date auditTime;

    /**
     * 审核人
     */
    @Schema(description = "审核人", example = "admin")
    private String auditBy;

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

    /**
     * 入库明细列表
     */
    @Schema(description = "入库明细列表")
    private List<StockInItemVO> items;

    /**
     * 入库明细信息VO
     */
    @Data
    @Schema(description = "入库明细信息")
    public static class StockInItemVO {

        /**
         * 明细ID
         */
        @Schema(description = "明细ID", example = "1")
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
         * 入库数量
         */
        @Schema(description = "入库数量", example = "100")
        private Integer quantity;

        /**
         * 单价
         */
        @Schema(description = "单价", example = "10.00")
        private BigDecimal unitPrice;

        /**
         * 小计金额
         */
        @Schema(description = "小计金额", example = "1000.00")
        private BigDecimal subtotal;

        /**
         * 备注
         */
        @Schema(description = "备注", example = "正常入库")
        private String remark;
    }
}