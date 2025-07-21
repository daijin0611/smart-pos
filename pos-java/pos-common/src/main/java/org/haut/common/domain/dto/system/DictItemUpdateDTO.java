package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class DictItemUpdateDTO {

    /**
     * 字典项ID
     */
    @Schema(description = "字典项ID")
    @NotNull(message = "字典项ID不能为空")
    private Long dictItemId;

    /**
     * 字典编码
     */
    @Schema(description = "字典编码")
    @NotBlank(message = "字典编码不能为空")
    private String dictCode;

    /**
     * 字典项值
     */
    @Schema(description = "字典项值")
    @NotBlank(message = "字典项值不能为空")
    private String itemValue;

    /**
     * 字典项标签
     */
    @Schema(description = "字典项标签")
    @NotBlank(message = "字典项标签不能为空")
    private String itemLabel;

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