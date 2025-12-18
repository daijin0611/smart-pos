package org.haut.server.vip.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 会员资产表
 * @TableName vip_asset
 */
@TableName(value ="vip_asset")
@Data
@Accessors(chain = true)
public class VipAsset {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    private Integer isDelete;

    /**
     * 备注
     */
    private String remark;

    /**
     * 资产编号
     */
    private String assetNum;

    /**
     * 资产名称
     */
    private String assetName;

    /**
     * 余额
     */
    private BigDecimal assetBalance;

    /**
     * 资产类型（0 充值，1 赠送）
     */
    private Integer assetType;

    /**
     * 折扣基础（0 标准价，1 会员价）
     */
    private Integer assetDiscountBase;

    /**
     * 折扣率
     */
    private BigDecimal assetDiscountRate;

    /**
     * 跨店消费（0 不允许，1 允许）
     */
    private Integer assetIsCrossStore;

    /**
     * 实体卡号
     */
    private String assetCardNumber;

    /**
     * 会员卡号
     */
    private String vipCardNumber;


    /**
     * 兼容美管家会员卡类型分类ID
     */
    private String cardTypeId;

    /**
     * 会员id
     */
    private Long vipId;

    /**
     * 门店id
     */
    private Long orgId;

    /**
     * 乐观锁
     */
    @Version
    private Integer version;
}