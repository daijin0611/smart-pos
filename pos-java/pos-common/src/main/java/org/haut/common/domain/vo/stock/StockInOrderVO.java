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
    private String orderCode;

    /**
     * 总金额
     */
    @Schema(description = "总金额", example = "1000.00")
    private BigDecimal totalPrice;

    /**
     * 操作员
     */
    @Schema(description = "操作员", example = "admin")
    private String operator;

    /**
     * 备注
     */
    @Schema(description = "备注", example = "采购入库")
    private String remark;

    /**
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)", example = "0")
    private Integer isDelete;

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
     * 组织ID
     */
    @Schema(description = "组织ID", example = "1")
    private Long orgId;

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
         * 删除状态(0 存在，1 删除)
         */
        @Schema(description = "删除状态(0 存在，1 删除)", example = "0")
        private Integer isDelete;

        /**
         * 备注
         */
        @Schema(description = "备注", example = "正常入库")
        private String remark;

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
        private BigDecimal price;

        /**
         * 入库订单ID
         */
        @Schema(description = "入库订单ID", example = "1")
        private Long inOrderId;

        /**
         * 入库订单编码
         */
        @Schema(description = "入库订单编码", example = "IN202412190001")
        private String inOrderCode;

        /**
         * 组织ID
         */
        @Schema(description = "组织ID", example = "1")
        private Long orgId;
    }
}