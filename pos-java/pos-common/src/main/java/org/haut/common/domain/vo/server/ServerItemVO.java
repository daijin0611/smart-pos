package org.haut.common.domain.vo.server;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "服务项目VO")
public class ServerItemVO {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    @Schema(description = "主键")
    private Long id;

    /**
     * 备注(其他描述)
     */
    @Schema(description = "备注(其他描述)")
    private String remark;

    /**
     * 服务项目名称
     */
    @Schema(description = "服务项目名称")
    private String itemName;

    /**
     * 服务项目编码
     */
    @Schema(description = "服务项目编码")
    private String itemEncode;

    /**
     * 服务时长
     */
    @Schema(description = "服务时长")
    private Integer serverTime;

    /**
     * 标准价
     */
    @Schema(description = "标准价")
    private BigDecimal itemPrice;

    /**
     * 会员价
     */
    @Schema(description = "会员价")
    private BigDecimal vipItemPrice;

    /**
     * 是否参与打折（0 允许，1 禁止）
     */
    @Schema(description = "是否参与打折（0 允许，1 禁止）")
    private Integer isDiscounts;

    /**
     * 提成类型（0 固定金额，1 比例提成）
     */
    @Schema(description = "提成类型（0 固定金额，1 比例提成）")
    private Integer commissionType;

    /**
     * 提成值（固定/比例）（轮牌）
     */
    @Schema(description = "提成值（固定/比例）（轮牌）")
    private BigDecimal commissionValueRotation;

    /**
     * 提成值（固定/比例）（点钟）
     */
    @Schema(description = "提成值（固定/比例）（点钟）")
    private BigDecimal commissionValueAppointment;

    /**
     * 提成值（固定/比例）（加钟）
     */
    @Schema(description = "提成值（固定/比例）（加钟）")
    private BigDecimal commissionValueExtend;

    /**
     * 提成基准（0 标准价，1 实收价）
     */
    @Schema(description = "提成基准（0 标准价，1 实收价）")
    private Integer commissionBase;

    /**
     * 项目状态（0 启用， 1 禁用）
     */
    @Schema(description = "项目状态（0 启用， 1 禁用）")
    private Integer itemStatus;

    /**
     * 机构id
     */
    @Schema(description = "机构id")
    private Long orgId;
}
