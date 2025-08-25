package org.haut.common.domain.dto.kpi;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

@Data
@Accessors(chain = true)
@Schema(description = "KPI明细创建参数")
public class KpiDetailCreateDTO {
    @Schema(description = "服务编码")
    private String serviceCode;
    
    @Schema(description = "服务名称")
    private String serviceName;
    
    @Schema(description = "服务类型")
    private Integer serviceType;
    
    @Schema(description = "用户ID")
    private Long userId;
    
    @Schema(description = "用户名称")
    private String userName;
    
    @Schema(description = "业绩金额")
    private BigDecimal performance;
    
    @Schema(description = "提成金额")
    private BigDecimal commission;
    
    @Schema(description = "备注")
    private String remark;
    
    @Schema(description = "组织机构ID")
    private Long orgId;
}
