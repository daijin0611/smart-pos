package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import jakarta.validation.constraints.*;
import java.math.BigDecimal;

/**
 * 服务项目创建DTO
 * 用于接收创建服务项目的请求参数
 *
 * @author mhding
 * @version 1.0
 * @since 2025-07-28
 */
@Data
@Schema(description = "服务项目创建DTO")
public class ServerItemCreateDTO {

    /**
     * 备注(其他描述)
     */
    @Schema(description = "备注(其他描述)", example = "这是一个服务项目的备注信息")
    private String remark;

    /**
     * 服务项目名称
     */
    @NotBlank(message = "服务项目名称不能为空")
    @Size(max = 100, message = "服务项目名称长度不能超过100个字符")
    @Schema(description = "服务项目名称", example = "足疗按摩", required = true)
    private String itemName;

    /**
     * 服务项目编码
     */
    @NotBlank(message = "服务项目编码不能为空")
    @Size(max = 50, message = "服务项目编码长度不能超过50个字符")
    @Schema(description = "服务项目编码", example = "SRV001", required = true)
    private String itemEncode;

    /**
     * 服务时长
     */
    @NotNull(message = "服务时长不能为空")
    @Min(value = 1, message = "服务时长必须大于0")
    @Max(value = 999, message = "服务时长不能超过999分钟")
    @Schema(description = "服务时长(分钟)", example = "60", required = true)
    private Integer serverTime;

    /**
     * 标准价
     */
    @NotNull(message = "标准价不能为空")
    @DecimalMin(value = "0.01", message = "标准价必须大于0")
    @DecimalMax(value = "99999.99", message = "标准价不能超过99999.99")
    @Schema(description = "标准价", example = "100.00", required = true)
    private BigDecimal itemPrice;

    /**
     * 会员价
     */
    @NotNull(message = "会员价不能为空")
    @DecimalMin(value = "0.01", message = "会员价必须大于0")
    @DecimalMax(value = "99999.99", message = "会员价不能超过99999.99")
    @Schema(description = "会员价", example = "80.00", required = true)
    private BigDecimal vipItemPrice;

    /**
     * 是否参与打折（0 允许，1 禁止）
     */
    @NotNull(message = "是否参与打折不能为空")
    @Min(value = 0, message = "是否参与打折值必须为0或1")
    @Max(value = 1, message = "是否参与打折值必须为0或1")
    @Schema(description = "是否参与打折（0 允许，1 禁止）", example = "0", required = true)
    private Integer isDiscounts;

    /**
     * 提成类型（0 固定金额，1 比例提成）
     */
    @NotNull(message = "提成类型不能为空")
    @Min(value = 0, message = "提成类型值必须为0或1")
    @Max(value = 1, message = "提成类型值必须为0或1")
    @Schema(description = "提成类型（0 固定金额，1 比例提成）", example = "1", required = true)
    private Integer commissionType;

    /**
     * 提成值（固定/比例）（轮牌）
     */
    @NotNull(message = "轮牌提成值不能为空")
    @DecimalMin(value = "0.00", message = "轮牌提成值不能为负数")
    @DecimalMax(value = "99999.99", message = "轮牌提成值不能超过99999.99")
    @Schema(description = "提成值（固定/比例）（轮牌）", example = "10.00", required = true)
    private BigDecimal commissionValueRotation;

    /**
     * 提成值（固定/比例）（点钟）
     */
    @NotNull(message = "点钟提成值不能为空")
    @DecimalMin(value = "0.00", message = "点钟提成值不能为负数")
    @DecimalMax(value = "99999.99", message = "点钟提成值不能超过99999.99")
    @Schema(description = "提成值（固定/比例）（点钟）", example = "15.00", required = true)
    private BigDecimal commissionValueAppointment;

    /**
     * 提成值（固定/比例）（加钟）
     */
    @NotNull(message = "加钟提成值不能为空")
    @DecimalMin(value = "0.00", message = "加钟提成值不能为负数")
    @DecimalMax(value = "99999.99", message = "加钟提成值不能超过99999.99")
    @Schema(description = "提成值（固定/比例）（加钟）", example = "12.00", required = true)
    private BigDecimal commissionValueExtend;

    /**
     * 提成基准（0 标准价，1 实收价）
     */
    @NotNull(message = "提成基准不能为空")
    @Min(value = 0, message = "提成基准值必须为0或1")
    @Max(value = 1, message = "提成基准值必须为0或1")
    @Schema(description = "提成基准（0 标准价，1 实收价）", example = "0", required = true)
    private Integer commissionBase;

    /**
     * 项目状态（0 启用， 1 禁用）
     */
    @NotNull(message = "项目状态不能为空")
    @Min(value = 0, message = "项目状态值必须为0或1")
    @Max(value = 1, message = "项目状态值必须为0或1")
    @Schema(description = "项目状态（0 启用， 1 禁用）", example = "0", required = true)
    private Integer itemStatus;

}
