package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

@Data
@Accessors(chain = true)
@Schema(description = "更新资产余额DTO")
public class AssetUpdateBalanceDTO {
    @Schema(description = "会员资产id")
    private Long assetId;
    @Schema(description = "会员id")
    private Long vipId;
    @Schema(description = "会员资产备注")
    private String remark;
    @Schema(description = "会员资产余额")
    private BigDecimal assetBalance;
}
