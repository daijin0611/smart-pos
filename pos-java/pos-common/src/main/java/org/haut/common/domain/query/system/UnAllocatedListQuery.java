package org.haut.common.domain.query.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
@Schema
public class UnAllocatedListQuery {

    @Schema(description = "角色id")
    @NotNull
    private Long roleId;
}
