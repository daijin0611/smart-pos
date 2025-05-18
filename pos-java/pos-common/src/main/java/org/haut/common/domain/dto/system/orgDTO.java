package org.haut.common.domain.dto.system;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.*;

public class orgDTO {

    @Schema(description = "门店ID", example = "1")
    @NotNull(message = "ID不能为空")
    private Long id;

    @Schema(description = "门店状态(0-正常，1-停用)", example = "0")
    @NotNull(message = "状态不能为空")
    @Min(value = 0, message = "状态值不合法")
    @Max(value = 1, message = "状态值不合法")
    private Integer orgState;

    @Schema(description = "门店名称", example = "门店名称")
    @NotNull(message = "门店名称不能为空")
    @Size(max = 50, message = "门店名称长度不能超过50")
    private String orgName;

    @Schema(description = "门店简称", example = "简称")
    @NotNull(message = "门店简称不能为空")
    @Size(max = 50, message = "门店简称长度不能超过50")
    private String orgShortName;

    @Schema(description = "门店编号", example = "0001")
    @NotNull(message = "门店编号不能为空")
    @Size(max = 20, message = "门店编号长度不能超过20")
    private String orgCode;

    @Schema(description = "父级门店", example = "郑州棉纺路店")
    @NotNull(message = "父级门店不能为空")
    @Size(max = 50, message = "父级门店长度不能超过50")
    private String orgParent;

    @Schema(description = "门店性质", example = "采耳")
    @NotNull(message = "门店性质不能为空")
    @Size(max = 50, message = "门店性质长度不能超过50")
    private String orgProperty;

    @Schema(description = "门店类型", example = "门店")
    @NotNull(message = "门店类型不能为空")
    @Size(max = 50, message = "门店类型长度不能超过50")
    private String orgType;

    @Schema(description = "门店区域",example = "郑州")
    private String orgArea;

    @Schema(description = "门店电话", example = "12345678901")
    @NotNull(message = "门店电话不能为空")
    @Size(max = 11, message = "门店电话长度不能超过11")
    private String orgNumber;

    @Schema(description = "门店负责人", example = "张三")
    @NotNull(message = "门店负责人不能为空")
    private String orgLeader;

    @Schema(description = "门店负责人电话", example = "13938006569")
    @NotNull(message = "门店负责人电话不能为空")
    @Size(min = 11, max = 11, message = "手机号长度必须为11位")
    @Pattern(regexp = "^1[3-9]\\d{9}$", message = "手机号格式不正确")
    private String orgNum;

    @Schema(description = "详细地址", example = "郑州棉纺路")
    @NotNull(message = "详细地址不能为空")
    @Size(max = 200, message = "详细地址长度不能超过200")
    private String orgAddress;

    @Schema(description = "备注", example = "备注信息")
    @Size(max = 200, message = "备注长度不能超过200")
    private String remark;
}
