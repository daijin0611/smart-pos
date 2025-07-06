package org.haut.common.domain.query.vip;


import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "会员列表查询对象")
public class VipListQuery {

    /**
     * 会员卡号
     */
    private String vipCardNumber;

    /**
     * 真实姓名
     */
    private String vipName;

    /**
     * 手机号
     */
    private String vipPhone;
}
