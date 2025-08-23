package org.haut.server.server.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 疗程券表
 * @TableName server_cure_ticket
 */
@TableName(value ="server_cure_ticket")
@Data
public class ServerCureTicket {
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
     * 备注（其它描述）
     */
    private String remark;

    /**
     * 疗程卷名称
     */
    private String name;

    /**
     * 疗程编码
     */
    private String encode;

    /**
     * 疗程价格
     */
    private BigDecimal price;

    /**
     * 提成类型（0 固定金额，1 比例提成）
     */
    private Integer type;

    /**
     * 提成值（固定/比例）
     */
    private BigDecimal commissionValue;

    /**
     * 提成基准（0 标准价，1 实收价）
     */
    private Integer commissionBase;

    /**
     * 状态（0 启用，1 停用）
     */
    private Integer status;

    /**
     * 组织ID
     */
    private Long orgId;
}