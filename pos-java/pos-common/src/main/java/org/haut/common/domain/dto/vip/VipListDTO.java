package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

@Data
@Schema(description = "会员列表对象")
public class VipListDTO {

    /**
     * 唯一标识
     */
    private Long id;

    /**
     * 姓名
     */
    private String infoName;

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
     * 末次消费日期
     */
    private Date infoLastConsumptionTime;

    /**
     * 末次充值日期
     */
    private Date infoLastRechargeTime;

    /**
     * 备注
     */
    private String remark;

    /**
     * 组织id
     */
    private Long orgId;

}
