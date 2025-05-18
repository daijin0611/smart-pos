package org.haut.common.domain.dto.vip;

import java.util.Date;


public class VipCountListDTO {

    /**
     * 会员唯一标识
     */
    private Long id;

    /**
     * 会员姓名
     */
    private String infoName;

    /**
     * 会员性别
     */
    private String infoGender;

    /**
     * 会员卡号
     */
    private String infoCardNumber;

    /**
     * 手机号码
     */
    private String infoPhoneNumber;

    /**
     * 店内总余额
     */
    private Double assetBalance;

    /**
     * 资料创建日期
     */
    private Date createTime;

    /**
     * 末次充值日期
     */
    private Date infoLastRechargeTime;

    /**
     * 末次消费日期
     */
    private Date infoLastConsumptionTime;

}


