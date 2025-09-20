package org.haut.server.vip.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import lombok.Data;

/**
 * 会员信息表
 * @TableName vip_info
 */
@TableName(value ="vip_info")
@Data
public class VipInfo {
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
     * 姓名
     */
    private String name;

    /**
     * 性别（0 男，1 女）
     */
    private Integer gender;

    /**
     * 会员卡号
     */
    private String cardNumber;

    /**
     * 电话号码
     */
    private String phoneNumber;

    /**
     * 末次消费日期
     */
    private LocalDate lastConsumptionTime;

    /**
     * 末次充值时间
     */
    private LocalDate lastRechargeTime;

    /**
     * 会员身份
     */
    private Integer identity;

    /**
     * 店内总余额
     */
    private BigDecimal balance;

    /**
     * 会员生日
     */
    private LocalDate birthday;

    /**
     * 会员地址
     */
    private String address;

    /**
     * 会员密码
     */
    private String pwd;

    /**
     * 机构id
     */
    private Long orgId;
}