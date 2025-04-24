package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
@Schema(description = "服务产品管理")
public class ServerProductInfoDTO {
    @Schema(description = "服务产品ID", example = "1")
    private Long id;

    @Schema(description = "服务产品创建时间")
    @PastOrPresent(message = "创建时间不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createTime;

    @Schema(description = "服务产品更新时间")
    @PastOrPresent(message = "更新时间不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;

    @Schema(description = "删除状态(0存在，1删除)")
    private Integer isDelete;

    @Schema(description = "备注(其他描述)")
    private String remark;

    @Schema(description = "服务产品名称", example = "服务产品名称")
    @NotBlank(message = "服务产品名称不能为空")
    @Size(max = 20, message = "服务产品名称长度不能超过20")
    private String productName;

    @Schema(description = "服务产品编码",example = "0001")
    @NotBlank(message = "服务产品编码不能为空")
    @Size(max = 20, message = "服务产品编码长度不能超过20")
    private String productEncode;

    @Schema(description = "服务产品标准价格")
    @NotBlank(message = "服务产品标准价格不能为空")
    private BigDecimal productPrice;

    @Schema(description = "服务产品VIP价格")
    @NotBlank(message = "服务产品VIP价格不能为空")
    private BigDecimal vipProductPrice;

    @Schema(description = "服务产品是否参与打折（0是，1否）")
    private Integer isDiscount;

    @Schema(description = "该服务产品的提成类型")
    private String commissionType;

    @Schema(description = "该服务产品的提成比例")
    private BigDecimal productCommissionValue;

    @Schema(description = "该服务产品的提成固定值")
    private BigDecimal productCommissionPrice;
}
