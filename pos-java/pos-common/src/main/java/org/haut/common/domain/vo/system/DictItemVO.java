package org.haut.common.domain.vo.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

@Data
@Schema(description = "字典项信息")
public class DictItemVO {
    /**
     * 主键
     */
    @Schema(description = "字典项ID", example = "1")
    private Long dictItemId;

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
     * 关联字典编码
     */
    @Schema(description = "关联字典编码")
    private String dictCode;

    /**
     * 字典项内容
     */
    @Schema(description = "字典项内容")
    private String itemValue;

    /**
     * 字典项标签
     */
    @Schema(description = "字典项标签")
    private String itemLabel;

    /**
     * 排序权重
     */
    @Schema(description = "排序权重")
    private Integer sort;
}