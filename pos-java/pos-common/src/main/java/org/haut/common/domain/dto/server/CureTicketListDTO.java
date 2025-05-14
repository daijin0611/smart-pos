package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
@Schema(description = "疗程券列表对象")
public class CureTicketListDTO {


    @Schema(description = "疗程券ID")
    private Long cureTicketId;

    @Schema(description = "删除状态(0 存在，1 删除)")

    private Integer isDelete;

    @Schema(description = "备注（其他描述）")
    private String remark;

    /**
     * 疗程卷名称
     */
    @Schema(description = "疗程卷名称")
    @NotBlank(message = "疗程卷名称不能为空")
    private String cureTicketName;

    /**
     * 疗程编码
     */
    @Schema(description = "疗程编码")
    @NotBlank(message = "疗程编码不能为空")
    private String cureTicketEncode;

    /**
     * 疗程价格
     */
    @Schema(description = "疗程价格")
    private BigDecimal cureTicketPrice;

    /**
     * 提成类型
     */
    @Schema(description = "提成类型")
    private String cureTicketType;

    /**
     * 提成值（比例）
     */
    @Schema(description = "提成值（比例）")
    private BigDecimal cureTicketCommissionValue;

    @Schema(description = "疗程卷关联中间表的列表")
    private List<CureTicketDetailInfoDTO> cureTicketDetailInfoDTOList;
}


