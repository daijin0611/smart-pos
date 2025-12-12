package org.haut.common.domain.vo.system;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

@Data
@Schema(description = "机构信息")
public class OrgInfoVO {
    /**
     * 主键
     */
    @Schema(description = "主键")
    private Long id;

    /**
     * 创建时间
     */
    @Schema(description = "创建时间")
    private Date createTime;

    /**
     * 更新时间
     */
    @Schema(description = "更新时间")
    private Date updateTime;

    /**
     * 删除状态(0 存在，1 删除)
     */
    @Schema(description = "删除状态(0 存在，1 删除)")
    private Integer isDelete;

    /**
     * 机构状态(0 正常，1 停用)
     */
    @Schema(description = "机构状态(0 正常，1 停用)")
    private Integer orgState;

    /**
     * 机构名称
     */
    @Schema(description = "机构名称")
    private String orgName;

    /**
     * 机构简称
     */
    @Schema(description = "机构简称")
    private String orgShortName;

    /**
     * 机构编号
     */
    @Schema(description = "机构编号")
    private String orgCode;

    /**
     * 父级机构
     */
    @Schema(description = "父级机构")
    private String orgParent;

    /**
     * 机构性质
     */
    @Schema(description = "机构性质")
    private String orgProperty;

    /**
     * 机构类型
     */
    @Schema(description = "机构类型")
    private String orgType;

    /**
     * 行政区域
     */
    @Schema(description = "行政区域")
    private String orgArea;

    /**
     * 机构电话
     */
    @Schema(description = "机构电话")
    private String orgNumber;

    /**
     * 机构负责人
     */
    @Schema(description = "机构负责人")
    private String orgLeader;

    /**
     * 负责人电话
     */
    @Schema(description = "负责人电话")
    private String orgLeaderNum;

    /**
     * 详细地址
     */
    @Schema(description = "详细地址")
    private String orgAddress;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    @Schema(description = "默认折扣率（百分比）")
    private Integer defaultDiscountRate;

    @Schema(description = "默认折扣基准（0 标准价，1 会员价）")
    private Integer defaultDiscountBase;

    @Schema(description = "默认跨店结算（0 不允许，1 允许）")
    private Integer defaultIsCrossStore;

    @Schema(description = "默认充值提成规则ID")
    private Long defaultRechargeRoleId;

    @Schema(description = "打印宽度（毫米）")
    private Integer printWidth;
}
