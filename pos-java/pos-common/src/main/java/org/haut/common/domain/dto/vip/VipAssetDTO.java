package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class VipAssetDTO {

    @Schema(description = "会员资产ID", example = "1")
    @NotNull(message = "ID不能为空")
    private Long id;

    @Schema(description = "会员资产编号", example = "004A1E97")
    @NotBlank(message = "会员资产编号不能为空")
    @Size(min = 8, max = 20, message = "会员资产编号长度必须在8到20位之间")
    private  String assetNum;

    @Schema(description = "会员资产名称", example = "充值卡")
    private String assetName;

    @Schema(description = "会员资产余额", example = "100.00")
    @NotNull(message = "会员资产余额不能为空")
    @Size(min = 0, max = 20, message = "会员资产余额不合法")
    private Double assetBalance;

    @Schema(description = "会员资产类型（0-充值，1-赠送）", example = "1")
    @NotNull(message = "会员资产类型不能为空")
    @Size(min = 0, max = 1, message = "会员资产类型不合法")
    private Integer assetType;

    @Schema(description = "会员资产基础折扣（0-标准价，1-会员价）", example = "1")
    @NotNull(message = "会员资产基础折扣不能为空")
    @Size(min = 0, max = 1, message = "会员资产基础折扣不合法")
    private Integer assetBaseDiscount;

    @Schema(description = "会员资产折扣率", example = "0.69")
    @NotNull(message = "会员资产折扣率不能为空")
    @Size(min = 0, max = 1, message = "会员资产折扣率不合法")
    private Double assetDiscountRate;

    @Schema(description = "会员资产是否跨店使用（0-不允许，1-允许）", example = "1")
    @NotNull(message = "会员资产是否跨店使用不能为空")
    @Size(min = 0, max = 1, message = "会员资产是否跨店使用不合法")
    private Integer assetIsCrossStore;

    @Schema(description = "实体卡号", example = "N145900101")
    @NotNull(message = "实体卡号不能为空")
    @Size(min = 8, max = 20, message = "实体卡号长度必须在8到20位之间")
    private String assetCardNumber;

    @Schema(description = "会员卡号", example = "VIP001")
    private String vipCardNumber;

    @Schema(description = "兼容美管家会员卡类型分类ID", example = "type001")
    private String cardTypeId;

    public @NotNull(message = "会员资产余额不能为空") @Size(min = 0, max = 20, message = "会员资产余额不合法") Double getAssetBalance() {
        return assetBalance;
    }

    public void setAssetBalance(@NotNull(message = "会员资产余额不能为空") @Size(min = 0, max = 20, message = "会员资产余额不合法") Double assetBalance) {
        this.assetBalance = assetBalance;
    }


}
