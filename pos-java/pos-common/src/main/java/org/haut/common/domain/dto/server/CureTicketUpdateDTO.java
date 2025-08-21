package org.haut.common.domain.dto.server;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

@Data
@Schema(description = "疗程券更新对象")
@Accessors(chain = true)
public class CureTicketUpdateDTO {
    /**
     * 疗程卷ID
     */
    @Schema(description = "疗程卷ID")
    private Long id;
    /**
     * 备注（其它描述）
     */
    @Schema(description = "备注（其它描述）")
    private String remark;

    /**
     * 疗程卷名称
     */
    @Schema(description = "疗程卷名称")
    private String name;

    /**
     * 疗程编码
     */
    @Schema(description = "疗程编码")
    private String encode;

    /**
     * 疗程价格
     */
    @Schema(description = "疗程价格")
    private BigDecimal price;

    /**
     * 疗程时长
     */
    @Schema(description = "疗程时长")
    private Integer duration;

    /**
     * 提成类型（0 固定金额，1 比例提成）
     */
    @Schema(description = "提成类型（0 固定金额，1 比例提成）")
    private Integer type;

    /**
     * 提成值（固定/比例）
     */
    @Schema(description = "提成值（固定/比例）")
    private BigDecimal commissionValue;

    /**
     * 提成基准（0 标准价，1 实收价）
     */
    @Schema(description = "提成基准（0 标准价，1 实收价）")
    private Integer commissionBase;

    /**
     * 状态（0 启用，1 停用）
     */
    @Schema(description = "状态（0 启用，1 停用）")
    private Integer status;

    /**
     * 疗程关联优惠券
     */
    @Schema(description = "疗程关联优惠券")
    private List<RelatedTicketDTO> vipTicketList;
}
