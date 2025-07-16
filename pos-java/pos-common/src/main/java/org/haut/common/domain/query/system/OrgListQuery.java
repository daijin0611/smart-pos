package org.haut.common.domain.query.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "机构列表查询参数")
public class OrgListQuery {
    @Schema(description = "机构名称")
    private String orgName;
    @Schema(description = "机构状态")
    private Integer orgStatus;
    @Schema(description = "机构编码")
    private String orgCode;
}
