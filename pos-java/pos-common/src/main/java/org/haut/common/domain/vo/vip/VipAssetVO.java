package org.haut.common.domain.vo.vip;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Schema(description = "会员资产信息VO")
@Data
public class VipAssetVO {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    @Schema(description = "主键")
    private Long id;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    @Schema(description = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @Schema(description = "更新时间")
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)")
    private Integer isDelete;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    /**
     * 资产编号
     */
    @Schema(description = "资产编号")
    private String assetNum;

    /**
     * 资产名称
     */
    @Schema(description = "资产名称")
    private String assetName;

    /**
     * 余额
     */
    @Schema(description = "余额")
    private BigDecimal assetBalance;

    /**
     * 资产类型（0 充值，1 赠送）
     */
    @Schema(description = "资产类型（0 充值，1 赠送）")
    private Integer assetType;

    /**
     * 折扣基础（0 标准价，1 会员价）
     */
    @Schema(description = "折扣基础（0 标准价，1 会员价）")
    private Integer assetDiscountBase;

    /**
     * 折扣率
     */
    @Schema(description = "折扣率")
    private BigDecimal assetDiscountRate;

    /**
     * 跨店消费（0 不允许，1 允许）
     */
    @Schema(description = "跨店消费（0 不允许，1 允许）")
    private Integer assetIsCrossStore;

    /**
     * 实体卡号
     */
    @Schema(description = "实体卡号")
    private String assetCardNumber;

    /**
     * 会员卡号
     */
    @Schema(description = "会员卡号")
    private String vipCardNumber;

    /**
     * 兼容美管家会员卡类型分类ID
     */
    @Schema(description = "兼容美管家会员卡类型分类ID")
    private String cardTypeId;

    /**
     * 会员id
     */
    @Schema(description = "会员id")
    private Long vipId;

    /**
     * 门店id
     */
    @Schema(description = "门店id")
    private Long orgId;

    /**
     * 乐观锁
     */
    @Version
    @Schema(description = "乐观锁")
    private Integer version;
}
