package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Schema(description = "服务产品创建信息对象")
public class ServerProductCreateDTO {
    @Schema(description = "备注信息", example = "特殊产品")
    @Size(max = 200, message = "备注长度不能超过200")
    private String remark;

    @Schema(description = "产品名称", example = "基础护理")
    @NotBlank(message = "产品名称不能为空")
    @Size(max = 50, message = "产品名称长度不能超过50")
    private String productName;

    @Schema(description = "产品编码", example = "PROD001")
    @NotBlank(message = "产品编码不能为空")
    @Size(min = 4, max = 20, message = "产品编码长度4-20位")
    private String productEncode;

    @Schema(description = "标准价格", example = "100.00")
    @NotNull(message = "标准价格不能为空")
    @DecimalMin(value = "0.00", message = "标准价格不能小于0")
    private BigDecimal productPrice;

    @Schema(description = "会员价格", example = "80.00")
    @NotNull(message = "会员价格不能为空")
    @DecimalMin(value = "0.00", message = "会员价格不能小于0")
    private BigDecimal vipProductPrice;

    @Schema(description = "是否参与打折(0-是，1-否)", example = "0")
    @NotNull(message = "是否打折不能为空")
    @Min(value = 0, message = "是否打折值不合法")
    @Max(value = 1, message = "是否打折值不合法")
    private Integer isDiscount;

    @Schema(description = "提成类型（0 固定提成, 1 比例提成）", example = "1")
    @NotNull(message = "提成类型不能为空")
    private Integer commissionType;


    @Schema(description = "提成值(固定提成时为固定金额，比例提成时为比例)", example = "0.15")
    private BigDecimal commissionValue;

    @Schema(description = "提成基准(0-标准价提成，1-实收价提成)", example = "0")
    private Integer commissionBase;

    @NotNull(message = "产品状态不能为空")
    @Min(value = 0, message = "产品状态值不合法")
    @Max(value = 1, message = "产品状态值不合法")
    @Schema(description = "产品状态(0-启用，1-禁用)", example = "0")
    private Integer productStatus;

    @Schema(description = "单位", example = "个")
    @NotBlank
    private String unit;
}
