package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
@Schema(description = "服务项目管理")
public class ServerItemInfoDTO {

    @Schema(description = "服务项目ID", example = "1")
    private Long id;

    @Schema(description="服务项目创建时间")
    @PastOrPresent(message = "创建时间不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createTime;

    @Schema(description="服务项目更新时间")
    @PastOrPresent(message = "更新时间不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;

    @Schema(description = "删除状态（0存在，1删除）")
    private Integer isDelete;

    @Schema(description = "备注(其他描述)")
    private String remark;

    @Schema(description = "服务项目名称", example = "服务项目名称")
    @NotBlank(message = "服务项目名称不能为空")
    @Size(max = 20, message = "服务项目名称长度不能超过20")
    private String itemName;

    @Schema(description = "服务项目编码",example = "0001")
    @NotBlank(message = "服务项目编码不能为空")
    @Size(max = 20, message = "服务项目编码长度不能超过20")
    private String itemEncode;

    @Schema(description = "技师类型")
    private String employeeType;

    @Schema(description = "服务时长")
    private Integer serverTime;

    @Schema(description = "服务项目标准价格")
    private BigDecimal itemPrice;

    @Schema(description = "服务项目VIP价格")
    private BigDecimal vipItemPrice;

    @Schema(description = "服务项目是否参与打折（0是，1否）")
    private Integer isDiscounts;

    @Schema(description = "该服务项目提成类型")
    private String commissionType;

    @Schema(description = "该服务项目提成值（比例）（轮牌）")
    private BigDecimal commissionValueRotation;

    @Schema(description = "该服务项目提成值（比例）（点钟）")
    private BigDecimal commissionValueAppointment;

    @Schema(description = "该服务项目提成值（固定值）")
    private BigDecimal commissionValueExtend;


}
