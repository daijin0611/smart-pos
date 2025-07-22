package org.haut.common.domain.dto.room;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.experimental.Accessors;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Data
@Accessors(chain = true)
public class BedCreateDTO {

    @Schema(description = "床位名称", example = "VIP包间A")
    @NotBlank(message = "床位名称不能为空")
    @Size(max = 50, message = "床位名称长度不能超过50")
    private String bedName;

    @Schema(description = "房间ID", example = "1")
    @NotNull(message = "房间ID不能为空")
    private Long roomId;

    @Schema(description = "备注", example = "豪华VIP包间")
    private String remark;

}
