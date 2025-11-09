package org.haut.server.kpi.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 业绩明细
 * @TableName kpi_detail
 */
@TableName(value ="kpi_detail")
@Data
@Accessors(chain = true)
public class KpiDetail {
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
     * 订单编号(收银订单、充值订单)
     */
    private String orderCode;

    /**
     * 业务编号(产品、服务、优惠券)
     */
    private String serviceCode;

    /**
     * 业务名称
     */
    private String serviceName;

    /**
     * 数量
     */
    private Integer quantity;

    /**
     * 业务类型
     */
    private Integer serviceType;

    /**
     * 上钟类型
     */
    private Integer itemType;

    /**
     * 技师id
     */
    private Long userId;

    /**
     * 提成技师
     */
    private String userName;

    /**
     * 业绩金额
     */
    private BigDecimal performance;

    /**
     * 提成金额
     */
    private BigDecimal commission;

    /**
     * 门店id
     */
    private Long orgId;
}