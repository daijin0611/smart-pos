package org.haut.common.domain.entity.vip;

import com.baomidou.mybatisplus.annotation.*;

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
    private String infoName;

    /**
     * 会员密码
     */
    private String infoPwd;

    /**
     * 性别（0 男，1 女）
     */
    private Integer infoGender;

    /**
     * 会员卡号
     */
    private String infoCardNumber;

    /**
     * 电话号码
     */
    private String infoPhoneNumber;

    /**
     * 会员身份
     */
    private String infoIdentity;

    /**
     * 会员生日
     */
    private Date infoBirthday;

    /**
     * 会员地址
     */
    private String infoAddress;

    /**
     * 末次消费日期
     */
    private Date infoLastConsumptionTime;

    /**
     * 末次充值日期
     */
    private Date infoLastRechargeTime;

    /**
     * 结构id
     */
    private Long orgId;

}

