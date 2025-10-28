package org.haut.common.domain.vo.kpi;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class KpiListVO {

    @Schema(description = "ID")
    private long id;

    @Schema(description = "员工姓名")
    private String userName;

    @Schema(description = "所属机构")
    private String orgName;

    @Schema(description = "提成")
    private BigDecimal Commission;

    @Schema(description = "创建时间")
    private Date createTime;

    @Schema(description = "订单/充值记录编号")
    private String orderCode;

    @Schema(description = "项目编号")
    private String serviceCode;

    @Schema(description = "项目名称")
    private String serviceName;

    @Schema(description = "业务类型")
    private Integer serviceType;

    @Schema(description = "上钟类型")
    private Integer itemType;

    @Schema(description = "业绩金额")
    private BigDecimal performance;

    @Schema(description = "数量")
    private Integer quantity;
}
