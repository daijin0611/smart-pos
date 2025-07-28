package org.haut.common.domain.vo.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@Schema(description = "服务产品详细信息展示对象")
public class ServerProductInfoVO {
    @Schema(description = "服务产品ID", example = "1")
    private Long id;

    @Schema(description = "服务产品创建时间", example = "2023-01-01 10:00:00")
    private Date createTime;

    @Schema(description = "服务产品更新时间", example = "2023-01-01 10:00:00")
    private Date updateTime;

    @Schema(description = "删除状态(0存在，1删除)", example = "0")
    private Integer isDelete;

    @Schema(description = "备注(其他描述)", example = "特殊产品")
    private String remark;

    @Schema(description = "服务产品名称", example = "基础护理")
    private String productName;

    @Schema(description = "服务产品编码", example = "PROD001")
    private String productEncode;

    @Schema(description = "服务产品标准价格", example = "100.00")
    private BigDecimal productPrice;

    @Schema(description = "服务产品VIP价格", example = "80.00")
    private BigDecimal vipProductPrice;

    @Schema(description = "服务产品是否参与打折（0是，1否）", example = "0")
    private Integer isDiscount;

    @Schema(description = "该服务产品的提成类型", example = "1")
    private Integer commissionType;

    @Schema(description = "提成值(固定/比例)", example = "0.15")
    private BigDecimal commissionValue;

    @Schema(description = "提成基准(0-标准价提成，1-实收价提成)", example = "10.00")
    private Integer commissionBase;
    
    @Schema(description = "产品状态(0-启用，1-禁用)", example = "0")
    private Integer productStatus;
    
    @Schema(description = "组织ID", example = "1")
    private Long orgId;

    @Schema(description = "单位", example = "个")
    private String unit;

    @Schema(description = "库存", example = "100")
    private String quantity;
}