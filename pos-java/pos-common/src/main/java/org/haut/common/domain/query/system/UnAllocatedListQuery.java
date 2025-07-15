package org.haut.common.domain.query.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema
public class UnAllocatedListQuery {

    @Schema(description = "角色id")
    private  String roleId;
}
