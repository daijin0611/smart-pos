package org.haut.server.server.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 服务产品表实体类
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-07-27
 * @TableName server_product
 */
@TableName(value ="server_product")
@Data
@Accessors(chain = true)
@Schema(description = "服务产品表")
public class ServerProduct {
    /**
     * 主键 自增
     */
    @TableId(type = IdType.AUTO)
    @Schema(description = "主键ID")
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
     * 备注(其他描述)
     */
    @Schema(description = "备注信息")
    private String remark;

    /**
     * 产品名称
     */
    @Schema(description = "产品名称")
    private String productName;

    /**
     * 产品编码
     */
    @Schema(description = "产品编码")
    private String productEncode;

    /**
     * 标准价
     */
    @Schema(description = "产品标准价格")
    private BigDecimal productPrice;

    /**
     * 会员价
     */
    @Schema(description = "会员价格")
    private BigDecimal vipProductPrice;

    /**
     * 是否参与打折（0 是，1 否）
     */
    @Schema(description = "是否参与打折（0 是，1 否）")
    private Integer isDiscount;

    /**
     * 提成类型（0 固定提成， 1 比例提成）
     */
    @Schema(description = "提成类型（0 固定提成， 1 比例提成）")
    private Integer commissionType;

    /**
     * 提成值（固定/比例）
     */
    @Schema(description = "提成值")
    private BigDecimal commissionValue;

    /**
     * 提成计算基准 (0 标准价提成， 1 会员价提成)
     */
    @Schema(description = "提成计算基准 (0 标准价提成， 1 会员价提成)")
    private Integer commissionBase;

    /**
     * 产品状态（0 禁用，1 启用）
     */
    @Schema(description = "产品状态（0 禁用，1 启用）")
    private Integer status;

    /**
     * 组织id
     */
    @Schema(description = "所属组织ID")
    private Long orgId;

    /**
     * 单位
     */
    @Schema(description = "产品单位")
    private String unit;

    /**
     * 库存数量
     */
    @Schema(description = "库存数量")
    private Integer quantity;

    /**
     * 版本号（乐观锁）
     */
    @Version
    @Schema(description = "版本号（乐观锁）")
    private Integer version;
}
