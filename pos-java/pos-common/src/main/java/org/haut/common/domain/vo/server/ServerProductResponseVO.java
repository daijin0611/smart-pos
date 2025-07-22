package org.haut.common.domain.vo.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "服务产品操作响应对象")
public class ServerProductResponseVO {
    @Schema(description = "操作结果消息", example = "添加成功")
    private String message;
    
    public static ServerProductResponseVO success(String message) {
        return new ServerProductResponseVO(message);
    }
}