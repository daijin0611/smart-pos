package org.haut.common.domain.dto.room;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "房间信息数据传输对象")
public class RoomInfoDTO {
    /**
     * 主键
     */
    @Schema(description = "房间ID", example = "1")
    private Long id;

    /**
     * 房间名
     */
    @Schema(description = "房间名称", example = "VIP包间")
    private String roomName;

    /**
     * 房间总床位
     */
    @Schema(description = "房间总床位数", example = "5")
    private Integer bedTotal;

    /**
     * 剩余的床位
     */
    @Schema(description = "剩余床位数", example = "3")
    private Integer bedRemaining;
}
