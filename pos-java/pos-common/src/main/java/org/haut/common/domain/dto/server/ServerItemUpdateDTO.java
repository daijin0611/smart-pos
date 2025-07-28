package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class ServerItemUpdateDTO extends ServerItemCreateDTO {

    /**
     * 主键
     */
    @Schema(description = "主键")
    @NotNull
    private Long id;
}
