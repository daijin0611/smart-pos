package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;

import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@Schema(description = "疗程券信息对象")

public class CureTicketInfoDTO {

    @Schema(description = "疗程券ID")
    private Long cureTicketId;

    @Schema(description = "疗程券创建时间")
    @PastOrPresent(message = "创建时间不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createTime;


    @Schema(description = "疗程券更新时间")
    @PastOrPresent(message = "更新时间不能是未来日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;

    @Schema(description = "删除状态(0 存在，1 删除)")
    private Integer isDelete;

    @Schema(description = "备注（其他描述）")
    private String remark;

    @Schema(description = "疗程券名称")
//    @NotBlank(message = "疗程券名称不能为空")
    @Size(max = 20, message = "疗程券名称长度不能超过20")
    private String cureTicketName;

    @Schema(description = "疗程券编码")
//    @NotBlank(message = "疗程券编码不能为空")
    @Size(max = 20, message = "疗程券编码长度不能超过20")
    private String cureTicketEncode;

    @Schema(description = "疗程券价格")
    private BigDecimal cureTicketPrice;

    @Schema(description = "疗程券类型")
    private String cureTicketType;

    @Schema(description = "提成值（比例）")
    private BigDecimal cureTicketCommissionValue;

    @Schema(description = "提成方式")
    private String cureTicketCommissionBy;


    private List<CureTicketDetailInfoDTO> cureTicketDetailInfoDTOList;
}

