package org.haut.common.domain.dto.vip;

import java.util.Date;

public class RechargeHistoryListDTO {

    /**
     * 充值记录id
     */
    private Long id;

    /**
     * 充值时间
     */
    private Date rechargeTime;

    /**
     * 相关人员
     */
    private String relateUser;

    /**
     * 充值会员
     */
    private String relateVip;

    /**
     * 充值金额及资产编号
     */
    private String rechargeAmountAndAssetNum;

    /**
     * 充值及支付方式
     */
    private String rechargeTypeAndPayment;

}
