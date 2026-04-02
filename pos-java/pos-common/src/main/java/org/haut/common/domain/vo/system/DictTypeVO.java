package org.haut.common.domain.vo.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
@Schema(description = "字典类型信息")
public class DictTypeVO {
    /**
     * 主键
     */
    @Schema(description = "字典类型ID", example = "1")
    private Long dictTypeId;

    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @Schema(description = "更新时间")
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)")
    private Integer isDelete;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    /**
     * 字典名称
     */
    @Schema(description = "字典名称")
    private String dictName;

    /**
     * 字典编码
     */
    @Schema(description = "字典编码")
    private String dictCode;

    /**
     * 排序权重
     */
    @Schema(description = "排序权重")
    private Integer sort;

    /**
     * 字典项列表
     */
    @Schema(description = "字典项列表")
    private List<DictItemVO> dictItems;
}