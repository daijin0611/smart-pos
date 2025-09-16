package org.haut.server.vip.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 充值记录表
 * @TableName vip_recharge_history
 */
@TableName(value ="vip_recharge_history")
@Data
@Accessors(chain = true)
public class VipRechargeHistory {
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
     * 充值单号
     */
    private String historyCode;

    /**
     * 充值状态（0 充值成功，1 已冲正）
     */
    private Integer rechargeStatus;

    /**
     * 充值类型（0 门店充值，1 手动赠送）
     */
    private String rechargeType;

    /**
     * 充值时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime rechargeTime;

    /**
     * 关联充值会员id
     */
    private Long vipId;

    /**
     * 会员姓名
     */
    private String vipName;

    /**
     * 会员电话号
     */
    private String vipPhoneNumber;

    /**
     * 会员卡号
     */
    private String vipCardNumber;

    /**
     * 关联充值活动id
     */
    private Long activityId;

    /**
     * 充值活动名称
     */
    private String activeName;

    /**
     * 充值金额
     */
    private BigDecimal rechargeValue;

    /**
     * 本金资产编号
     */
    private String assetCode;

    /**
     * 赠送金额
     */
    private BigDecimal presentValue;

    /**
     * 赠送资产编号
     */
    private String presentAssetCode;

    /**
     * 赠券信息
     */
    private String ticketInfo;

    /**
     * 赠券数量
     */
    private Integer ticketNum;

    /**
     * 操作员名称
     */
    private String userName;

    /**
     * 操作员id
     */
    private Long userId;

    /**
     * 门店id
     */
    private Long orgId;

    /**
     * 是否续费充值（0 否，1 是）
     */
    private Integer isRenewal;
}