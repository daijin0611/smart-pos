package org.haut.common.domain.vo.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Schema(description = "服务产品信息展示对象")
@Data
public class ServerProductVO {
    @Schema(description = "主键ID", example = "1")
    private Long id;

    @Schema(description = "创建时间", example = "2023-01-01 10:00:00")
    private Date createTime;

    @Schema(description = "更新时间", example = "2023-01-01 10:00:00")
    private Date updateTime;

    @Schema(description = "删除状态(0-存在，1-删除)", example = "0")
    private Integer isDelete;

    @Schema(description = "备注信息", example = "特殊产品")
    private String remark;

    @Schema(description = "产品名称", example = "基础护理")
    private String productName;

    @Schema(description = "产品编码", example = "PROD001")
    private String productEncode;

    @Schema(description = "标准价格", example = "100.00")
    private BigDecimal productPrice;

    @Schema(description = "会员价格", example = "80.00")
    private BigDecimal vipProductPrice;

    @Schema(description = "是否参与打折(0-是，1-否)", example = "0")
    private Integer isDiscount;

    @Schema(description = "提成类型", example = "1")
    private Integer commissioinType;

    @Schema(description = "提成比例值", example = "0.15")
    private BigDecimal productCommissionValue;

    @Schema(description = "固定提成价格", example = "10.00")
    private BigDecimal productCommissionPrice;

    @Schema(description = "产品状态(0-启用，1-禁用)", example = "0")
    private Integer productStatus;
    
    @Schema(description = "组织ID", example = "1")
    private Long orgId;
}
