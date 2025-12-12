package org.haut.server.system.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;
import lombok.Data;

/**
 * 机构信息表
 * @TableName sys_org
 */
@TableName(value ="sys_org")
@Data
public class SysOrg {
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
     * 机构状态(0 正常，1 停用)
     */
    private Integer orgState;

    /**
     * 机构名称
     */
    private String orgName;

    /**
     * 机构简称
     */
    private String orgShortName;

    /**
     * 机构编号
     */
    private String orgCode;

    /**
     * 父级机构
     */
    private String orgParent;

    /**
     * 机构性质
     */
    private String orgProperty;

    /**
     * 机构类型
     */
    private String orgType;

    /**
     * 行政区域
     */
    private String orgArea;

    /**
     * 机构电话
     */
    private String orgNumber;

    /**
     * 机构负责人
     */
    private String orgLeader;

    /**
     * 负责人电话
     */
    private String orgLeaderNum;

    /**
     * 详细地址
     */
    private String orgAddress;

    /**
     * 备注
     */
    private String remark;

    /**
     * 默认充值角色id
     */
    private Integer defaultRechargeRoleId;

    /**
     * 默认折扣率（百分比）
     */
    private Integer defaultDiscountRate;

    /**
     * 默认折扣基准（0 标准价，1 会员价）
     */
    private Integer defaultDiscountBase;

    /**
     * 默认跨店结算（0 不允许，1 允许）
     */
    private Integer defaultIsCrossStore;

    /**
     * 打印宽度（毫米），默认58
     */
    private Integer printWidth;
}
