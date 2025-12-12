package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 门店打印宽度更新对象
 */
@Data
@Schema(description = "门店打印宽度更新对象")
public class OrgPrintWidthUpdateDTO {

    /**
     * 门店ID
     */
    @Schema(description = "门店ID")
    @NotNull(message = "门店ID不能为空")
    private Long id;

    /**
     * 打印宽度（毫米）
     */
    @Schema(description = "打印宽度（毫米）", example = "58")
    @NotNull(message = "打印宽度不能为空")
    private Integer printWidth;
}
