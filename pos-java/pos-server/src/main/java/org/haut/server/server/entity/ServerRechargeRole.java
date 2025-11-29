package org.haut.server.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 充值提成规则表
 * @TableName server_recharge_role
 */
@TableName(value ="server_recharge_role")
@Data
public class ServerRechargeRole {
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
     * 备注（其他描述）
     */
    private String remark;

    /**
     * 充值提成规则名称
     */
    private String rechargeRoleName;

    /**
     * 充值金额
     */
    private BigDecimal rechargePrice;

    /**
     * 提成类型
     */
    private Integer commissionType;

    /**
     * 提成值（比例）
     */
    private BigDecimal rechargeCommissionValue;

    /**
     * 状态
     */
    private Integer status;

    /**
     * 机构id
     */
    private Long orgId;

    /**
     * 是否为默认规则 0-否 1-是
     */
    private Integer isDefault;
}