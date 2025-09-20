package org.haut.common.domain.vo.vip;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
@Schema(description = "会员统计VO")
@Accessors(chain = true)
public class VipCountVO {

    @Schema(description = "会员信息VO")
    VipInfoVO vipInfoVO;

    @Schema(description = "会员资产列表")
    List<VipAssetVO> vipAssetVOList;

    @Schema(description = "会员券列表")
    List<TicketCountVO> vipTicketVOList;

}
