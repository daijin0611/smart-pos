package org.haut.common.domain.dto.room;

import lombok.Data;
import lombok.experimental.Accessors;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Data
@Accessors(chain = true)
public class RoomCreateDTO {

    @Schema(description = "房间名称", example = "VIP包间A")
    @NotBlank(message = "房间名称不能为空")
    @Size(max = 50, message = "房间名称长度不能超过50")
    private String roomName;

    @Schema(description = "备注", example = "豪华VIP包间，配备独立卫生间")
    @Size(max = 200, message = "备注长度不能超过200")
    private String remark;
}
