package org.haut.common.domain.vo.vip;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "会员信息VO")
public class VipInfoVO {
    /**
     * 主键
     */
    @Schema(description = "主键")
    private Long id;

    /**
     * 备注
     */
    @Schema(description = "备注")
    private String remark;

    /**
     * 姓名
     */
    @Schema(description = "姓名")
    private String name;

    /**
     * 性别（0 男，1 女）
     */
    @Schema(description = "性别（0 男，1 女）")
    private Integer gender;

    /**
     * 会员卡号
     */
    @Schema(description = "会员卡号")
    private String cardNumber;

    /**
     * 电话号码
     */
    @Schema(description = "电话号码")
    private String phoneNumber;

    /**
     * 末次消费日期
     */
    @Schema(description = "末次消费日期")
    private LocalDate lastConsumptionTime;

    /**
     * 末次充值时间
     */
    @Schema(description = "末次充值时间")
    private LocalDate lastRechargeTime;

    /**
     * 会员身份
     */
    @Schema(description = "会员身份(字典表管理)")
    private Integer identity;

    /**
     * 店内总余额
     */
    @Schema(description = "店内总余额")
    private BigDecimal balance;

    /**
     * 会员生日
     */
    @Schema(description = "会员生日")
    private LocalDate birthday;

    /**
     * 会员地址
     */
    @Schema(description = "会员地址")
    private String address;

    /**
     * 会员密码
     */
    @Schema(description = "会员密码")
    private String pwd;

    /**
     *
     */
    @Schema(description = "组织ID")
    private Long orgId;
}
