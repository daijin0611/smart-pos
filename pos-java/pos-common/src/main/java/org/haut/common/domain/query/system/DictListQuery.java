package org.haut.common.domain.query.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@Schema(description = "字典列表查询参数")
public class DictListQuery {
    @Schema(description = "字典名称")
    private String dictName;
    @Schema(description = "字典编码")
    private String dictCode;
}
