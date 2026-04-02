package org.haut.common.domain.vo.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.List;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "充值活动统计VO")
public class StatRechargeActiveVO {


    @Schema(description = "赠券数量")
    private Integer ticketCount;
    
    @Schema(description = "赠送金额总计")
    private BigDecimal presentValueCount;

    @Schema(description = "充值金额总计")
    private BigDecimal rechargeValueCount;

    @Schema(description = "充值会员数")
    private Integer vipCount;

    @Schema(description = "充值活动统计列表")
    List<RechargeHistoryVO> rechargeHistoryVOList;
}
