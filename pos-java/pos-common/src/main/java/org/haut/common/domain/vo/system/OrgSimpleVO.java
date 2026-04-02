package org.haut.common.domain.vo.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "门店简要信息")
public class OrgSimpleVO {

    @Schema(description = "门店ID")
    private Long id;

    @Schema(description = "门店名称")
    private String orgName;

    @Schema(description = "门店编号")
    private String orgCode;
}
