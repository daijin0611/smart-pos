package org.haut.common.domain.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
@Schema(description = "分页查询对象")
public class PageQuery {
    @Schema(description = "当前页码")
    private Long pageNum = 1L;

    @Schema(description = "每页大小")
    private Long pageSize =  20L;
}
