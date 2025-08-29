package org.haut.common.domain.dto.order;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.List;

/**
 * 创建订单请求DTO
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
@Data
@Accessors(chain = true)
@Schema(description = "创建订单请求DTO")
public class CreateOrderDTO {
    
    /**
     * 会员ID（可选，散客时为null）
     */
    @Schema(description = "会员ID（可选，散客时为null）")
    private Long vipId;
    
    /**
     * 顾客名称
     */
    @Schema(description = "顾客名称")
    private String vipName;
    
    /**
     * 会员卡号
     */
    @Schema(description = "会员卡号")
    private String vipCardNumber;
    
    /**
     * 会员电话号码
     */
    @Schema(description = "会员电话号码")
    private String vipPhoneNumber;
    
    /**
     * 顾客类型（0 会员，1 散客）
     */
    @NotNull(message = "顾客类型不能为空")
    @Schema(description = "顾客类型（0 会员，1 散客）")
    private Integer customerType;
    
    /**
     * 床位ID
     */
    @NotNull(message = "床位ID不能为空")
    @Schema(description = "床位ID")
    private Long bedId;
    
    /**
     * 床位名称
     */
    @Schema(description = "床位名称")
    private String bedName;
    
    /**
     * 门店ID
     */
    @NotNull(message = "门店ID不能为空")
    @Schema(description = "门店ID")
    private Long orgId;
    
    /**
     * 备注
     */
    @Schema(description = "备注信息")
    private String remark;
    
    /**
     * 订单明细列表
     */
    @NotEmpty(message = "订单明细不能为空")
    @Valid
    @Schema(description = "订单明细列表")
    private List<CreateOrderDetailDTO> orderDetails;
    
    /**
     * 订单明细DTO
     */
    @Data
    @Accessors(chain = true)
    @Schema(description = "订单明细DTO")
    public static class CreateOrderDetailDTO {
        
        /**
         * 员工ID
         */
        @NotNull(message = "员工ID不能为空")
        @Schema(description = "员工ID")
        private Long userId;
        
        /**
         * 员工名称
         */
        @Schema(description = "员工名称")
        private String userName;
        
        /**
         * 业务类型（0 产品，1 服务，2 疗程券）
         */
        @NotNull(message = "业务类型不能为空")
        @Schema(description = "业务类型（0 产品，1 服务，2 疗程券）")
        private Integer detailType;
        
        /**
         * 订单业务ID（产品ID、服务ID或疗程券ID）
         */
        @NotNull(message = "业务ID不能为空")
        @Schema(description = "订单业务ID（产品ID、服务ID或疗程券ID）")
        private Long bid;
        
        /**
         * 标准价格
         */
        @NotNull(message = "标准价格不能为空")
        @Schema(description = "标准价格")
        private BigDecimal stdPrice;
        
        /**
         * 实际单价
         */
        @NotNull(message = "实际单价不能为空")
        @Schema(description = "实际单价")
        private BigDecimal truePrice;
        
        /**
         * 销售数量
         */
        @NotNull(message = "销售数量不能为空")
        @Schema(description = "销售数量")
        private Integer quantity;
        
        /**
         * 上钟类型（0 点钟，1 加钟，2 轮牌）
         */
        @Schema(description = "上钟类型（0 点钟，1 加钟，2 轮牌）")
        private Integer serverType;
        
        /**
         * 备注
         */
        @Schema(description = "备注信息")
        private String remark;
    }
}