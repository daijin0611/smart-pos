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
}
