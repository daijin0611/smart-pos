package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class OrgCreateDTO {

    /**
     * 机构状态(0 正常，1 停用)
     */
    @Schema(description = "机构状态(0 正常，1 停用)")
    @NotNull(message = "机构状态不能为空")
    private Integer orgState;

    /**
     * 机构名称
     */
    @Schema(description = "机构名称")
    @NotBlank(message = "机构名称不能为空")
    private String orgName;

    /**
     * 机构简称
     */
    @Schema(description = "机构简称")
    @NotBlank(message = "机构简称不能为空")
    private String orgShortName;

    /**
     * 机构编号
     */
    @Schema(description = "机构编号")
    @NotBlank(message = "机构编号不能为空")
    private String orgCode;

    /**
     * 父级机构
     */
    @Schema(description = "父级机构")
    @NotBlank(message = "父级机构不能为空")
    private String orgParent;

    /**
     * 机构性质
     */
    @Schema(description = "机构性质")
    @NotBlank(message = "机构性质不能为空")
    private String orgProperty;

    /**
     * 机构类型
     */
    @Schema(description = "机构类型")
    @NotBlank(message = "机构类型不能为空")
    private String orgType;

    /**
     * 行政区域
     */
    @Schema(description = "行政区域")
    @NotBlank(message = "行政区域不能为空")
    private String orgArea;

    /**
     * 机构电话
     */
    @Schema(description = "机构电话")
    @NotBlank(message = "机构电话不能为空")
    private String orgNumber;

    /**
     * 机构负责人
     */
    @Schema(description = "机构负责人")
    @NotBlank(message = "机构负责人不能为空")
    private String orgLeader;

    /**
     * 负责人电话
     */
    @Schema(description = "负责人电话")
    @NotBlank(message = "负责人电话不能为空")
    private String orgLeaderNum;

    /**
     * 详细地址
     */
    @Schema(description = "详细地址")
    @NotBlank(message = "详细地址不能为空")
    private String orgAddress;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;
}
