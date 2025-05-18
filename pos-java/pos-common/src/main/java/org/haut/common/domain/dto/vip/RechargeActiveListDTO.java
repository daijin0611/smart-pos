package org.haut.common.domain.dto.vip;

import java.util.Date;

public class RechargeActiveListDTO {

    /**
     * 充值活动ID
     */
    private Long id;

    /**
     * 充值活动状态
     */
    private Integer activeStatus;

    /**
     * 活动名称
     */
    private String activeName;

    /**
     * 活动开始时间
     */
    private Date activeBeginTime;

    /**
     * 活动结束时间
     */
    private Date activeFinalTime;

    /**
     * 创建时间
     */
    private Date createTime;

}
