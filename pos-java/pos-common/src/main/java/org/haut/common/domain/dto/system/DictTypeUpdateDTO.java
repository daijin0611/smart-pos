package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class DictTypeUpdateDTO {

    /**
     * 字典类型ID
     */
    @Schema(description = "字典类型ID")
    @NotNull(message = "字典类型ID不能为空")
    private Long dictTypeId;

    /**
     * 字典名称
     */
    @Schema(description = "字典名称")
    @NotBlank(message = "字典名称不能为空")
    private String dictName;

    /**
     * 字典编码
     */
    @Schema(description = "字典编码")
    @NotBlank(message = "字典编码不能为空")
    private String dictCode;

    /**
     * 排序
     */
    @Schema(description = "排序")
    @NotNull(message = "排序不能为空")
    private Integer sort;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;
}