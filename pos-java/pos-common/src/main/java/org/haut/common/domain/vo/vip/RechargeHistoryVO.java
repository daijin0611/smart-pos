package org.haut.common.domain.vo.vip;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.haut.common.domain.dto.vip.PaymentInfoDTO;
import org.haut.common.domain.dto.vip.RechargeDTO;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "充值历史记录")
public class RechargeHistoryVO {
    /**
     * 主键
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 备注
     */
    private String remark;

    /**
     * 充值单号
     */
    private String historyCode;

    /**
     * 充值状态（0 充值成功，1 已冲正）
     */
    private Integer rechargeStatus;

    /**
     * 充值类型（0 门店充值，1 手动赠送）
     */
    private String rechargeType;

    /**
     * 充值时间
     */
    private LocalDateTime rechargeTime;

    /**
     * 关联充值会员id
     */
    private Long vipId;

    /**
     * 会员姓名
     */
    private String vipName;

    /**
     * 会员电话号
     */
    private String vipPhoneNumber;

    /**
     * 会员卡号
     */
    private String vipCardNumber;

    /**
     * 关联充值活动id
     */
    private Long activityId;

    /**
     * 充值活动名称
     */
    private String activeName;

    /**
     * 充值金额
     */
    private BigDecimal rechargeValue;

    /**
     * 本金资产编号
     */
    private String assetCode;

    /**
     * 赠送金额
     */
    private BigDecimal presentValue;

    /**
     * 赠送资产编号
     */
    private String presentAssetCode;

    /**
     * 赠券信息
     */
    private String ticketInfo;

    /**
     * 操作员名称
     */
    private String userName;

    /**
     * 操作员id
     */
    private Long userId;

    /**
     * 门店id
     */
    private Long orgId;

    /**
     * 支付信息
     */
    private List<PaymentInfoDTO> paymentInfoList;

    /**
     * 业绩信息
     */
    private List<RechargeDTO.UserKpiDTO> userKpiList;

}
