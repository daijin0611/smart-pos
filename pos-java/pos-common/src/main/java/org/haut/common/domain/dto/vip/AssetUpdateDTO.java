package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;

@Data
@Accessors(chain = true)
@Schema(description = "会员资产更新DTO")
public class AssetUpdateDTO {
    @Schema(description = "会员资产id")
    private Long assetId;
    @Schema(description = "会员id")
    private Long vipId;
    @Schema(description = "会员资产备注")
    private String remark;
    @Schema(description = "会员资产余额")
    private BigDecimal assetBalance;
    @Schema(description = "会员资产类型(0 充值， 1 赠送)")
    private Integer assetType;
    @Schema(description = "会员资产折扣率")
    private Integer assetDiscountRate;
    @Schema(description = "会员资产折扣基数(0 标准间，1 会员价)")
    private Integer assetDiscountBase;
    @Schema(description = "会员资产是否跨门店(0 否，1 是)")
    private Integer assetIsCrossStore;
    @Schema(description = "会员资产实体卡号")
    private String assetCardNumber;
}
