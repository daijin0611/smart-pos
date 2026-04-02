package org.haut.common.domain.query.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "疗程券列表查询对象")
public class ServerCureTicketListQuery {

    /**
     * 疗程卷名称
     */
    @Schema(description = "疗程卷名称")
    private String cureTicketName;

    /**
     * 状态
     */
    @Schema(description = "状态")
    private Integer status;

    /**
     * 组织ID（可选，用于筛选门店关联的疗程券）
     */
    @Schema(description = "组织ID")
    private Long orgId;
}
