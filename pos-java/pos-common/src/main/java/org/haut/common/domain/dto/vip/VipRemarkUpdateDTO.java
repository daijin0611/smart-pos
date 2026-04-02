package org.haut.common.domain.dto.vip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 修改会员备注请求对象
 * @author 丁铭瀚
 * @version 1.0
 */
@Data
@Schema(description = "修改会员备注请求对象")
public class VipRemarkUpdateDTO {
     /**
      * 会员备注
      */
    private String remark;
}
