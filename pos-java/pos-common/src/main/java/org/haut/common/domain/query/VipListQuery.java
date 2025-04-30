package org.haut.common.domain.query;


import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
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
    @NotNull
    private String vipPhone;
}
