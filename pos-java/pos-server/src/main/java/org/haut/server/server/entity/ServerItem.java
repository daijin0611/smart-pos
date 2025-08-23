package org.haut.server.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 服务项目
 * @TableName server_item
 */
@TableName(value ="server_item")
@Data
@Accessors(chain = true)
public class ServerItem {
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
     * 备注(其他描述)
     */
    private String remark;

    /**
     * 服务项目名称
     */
    private String itemName;

    /**
     * 服务项目编码
     */
    private String itemEncode;

    /**
     * 服务时长
     */
    private Integer serverTime;

    /**
     * 标准价
     */
    private BigDecimal itemPrice;

    /**
     * 会员价
     */
    private BigDecimal vipItemPrice;

    /**
     * 是否参与打折（0 允许，1 禁止）
     */
    private Integer isDiscounts;

    /**
     * 提成类型（0 固定金额，1 比例提成）
     */
    private Integer commissionType;

    /**
     * 提成值（固定/比例）（轮牌）
     */
    private BigDecimal commissionValueRotation;

    /**
     * 提成值（固定/比例）（点钟）
     */
    private BigDecimal commissionValueAppointment;

    /**
     * 提成值（固定/比例）（加钟）
     */
    private BigDecimal commissionValueExtend;

    /**
     * 提成基准（0 标准价，1 实收价）
     */
    private Integer commissionBase;

    /**
     * 项目状态（0 启用， 1 禁用）
     */
    private Integer itemStatus;

    /**
     * 机构id
     */
    private Long orgId;
}