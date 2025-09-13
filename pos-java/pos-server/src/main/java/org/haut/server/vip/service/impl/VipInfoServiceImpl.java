package org.haut.server.vip.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.PrefixConst;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.dto.vip.*;
import org.haut.common.domain.query.vip.VipListQuery;
import org.haut.common.domain.vo.vip.VipInfoVO;
import org.haut.common.domain.vo.vip.VipRechargeActiveVO;
import org.haut.common.enums.*;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.common.utils.CodeUtils;
import org.haut.server.kpi.entity.KpiDetail;
import org.haut.server.kpi.mapper.KpiDetailMapper;
import org.haut.server.payment.entity.PaymentDetail;
import org.haut.server.payment.mapper.PaymentDetailMapper;
import org.haut.server.server.entity.ServerRechargeRole;
import org.haut.server.server.mapper.ServerRechargeRoleMapper;
import org.haut.server.vip.entity.VipAsset;
import org.haut.server.vip.entity.VipInfo;
import org.haut.server.vip.entity.VipInfoTicket;
import org.haut.server.vip.entity.VipRechargeHistory;
import org.haut.server.vip.mapper.VipAssetMapper;
import org.haut.server.vip.mapper.VipInfoTicketMapper;
import org.haut.server.vip.mapper.VipRechargeActiveMapper;
import org.haut.server.vip.service.VipAssetService;
import org.haut.server.vip.service.VipInfoService;
import org.haut.server.vip.mapper.VipInfoMapper;
import org.haut.server.vip.service.VipInfoTicketService;
import org.haut.server.vip.service.VipRechargeHistoryService;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
interface VipInfoConvert{

    VipInfoVO toVO(VipInfo entity);

    List<VipInfoVO> toVOs(List<VipInfo> list);

    VipInfo toEntity(VipCreateDTO dto);

    VipInfo toEntity(VipUpdateDTO dto);
}

/**
* @author tinwf
* @description 针对表【vip_info(会员信息表)】的数据库操作Service实现
* @createDate 2025-04-26 18:30:22
*/
@Service
@RequiredArgsConstructor
@Slf4j
public class VipInfoServiceImpl extends ServiceImpl<VipInfoMapper, VipInfo>
    implements VipInfoService{
    private final VipInfoMapper vipInfoMapper;
    private final VipInfoConvert vipInfoConvert;
    private final VipAssetMapper vipAssetMapper;
    private final VipRechargeActiveMapper vipRechargeActiveMapper;
    private final VipAssetService vipAssetService;
    private final VipRechargeHistoryService vipRechargeHistoryService;
    private final ServerRechargeRoleMapper serverRechargeRoleMapper;
    private final KpiDetailMapper kpiDetailMapper;
    private final PaymentDetailMapper paymentDetailMapper;
    private final VipInfoTicketService vipInfoTicketService;

    /**
     * 获取会员列表,条件查询
     *
     * @param query
     * @return
     */

    @Override
    public PageDTO<VipInfoVO> getList(VipListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LambdaQueryWrapper<VipInfo> queryWrapper = Wrappers.lambdaQuery(VipInfo.class)
                .eq(VipInfo::getOrgId,auth.getOrgId());
        // 条件查询
        if (query.getQueryField() != null) {
            queryWrapper
            .like(VipInfo::getPhoneNumber, query.getQueryField()).or()
            .like(VipInfo::getName, query.getQueryField()).or()
            .like(VipInfo::getCardNumber, query.getQueryField());
        }
        //查询数据库
        Page<VipInfo> page = new Page<>(query.getPageNum(), query.getPageSize());
        vipInfoMapper.selectPage(page, queryWrapper);
        //转化为DTO
        return PageDTO.create(page, VipInfoVO.class);
    }

    /*
     * 1.将会员信息表和会员资产表关联查询，查询会员详细信息
     * 2.根据会员id查询会员详细信息（会员资产表中的余额部分）
     */
    @Override
    public VipInfoDTO getVipById(Long id) {
        VipInfo vipInfo = getById(id);

        //自定义方法
        VipAssetDTO vipAssetDTO = vipAssetMapper.selectByVipId(id);

        ////将VipInfo转化为VipInfoDTO
        VipInfoDTO dto = BeanUtil.toBean(vipInfo, VipInfoDTO.class);
        if(vipAssetDTO != null){
            dto.setAssetBalance(vipAssetDTO.getAssetBalance());
        }
        return dto;
    }

    /**
     * 更新会员余额
     * @param vipId
     */
    @Override
    public void updateVipBalance(Long vipId) {
        List<VipAsset> vipAssets = vipAssetMapper.selectList(Wrappers.lambdaQuery(VipAsset.class)
                .eq(VipAsset::getVipId, vipId));
        BigDecimal balance = vipAssets.stream()
                .map(VipAsset::getAssetBalance)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        log.info("会员{}余额为{}", vipId, balance);
        this.lambdaUpdate()
                .eq(VipInfo::getId, vipId)
                .set(VipInfo::getBalance, balance)
                .update();
        log.info("会员{}余额更新成功，余额为{}", vipId, balance);
    }

    /**
     * 添加vip
     * @param dto
     */
    @Override
    public void addVip(VipCreateDTO dto) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        VipInfo entity = vipInfoConvert.toEntity(dto);
        entity.setOrgId(auth.getOrgId());
        log.info("会员信息：{}", entity);
        this.save(entity);
    }

    /**
     * 修改会员信息
     * @param vip
     */
    @Override
    public void updateVip(VipUpdateDTO vip) {
        VipInfo entity = vipInfoConvert.toEntity(vip);
        log.info("会员信息：{}", entity);
        this.updateById(entity);
    }

    /**
     * 充值功能
     * @param dto
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void recharge(RechargeDTO dto) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        log.info("当前门店{}，当前操作员{}",auth.getOrgId(),auth.getUserId());

        if (vipInfoMapper.selectById(dto.getVipId()) == null){
            throw new BusinessException("会员不存在");
        }

        // 初始化充值记录
        VipRechargeHistory history = new VipRechargeHistory()
                .setHistoryCode(CodeUtils.generateByTime(PrefixConst.RECHARGE_HISTORY))
                .setVipId(dto.getVipId())
                .setVipName(dto.getVipName())
                .setVipPhoneNumber(dto.getVipPhoneNumber())
                .setVipCardNumber(dto.getVipCardNumber())
                .setActivityId(dto.getActiveId())
                .setActiveName(dto.getActiveName())
                .setRechargeValue(dto.getRechargeValue())
                .setRechargeStatus(RechargeStatusEnum.SUCCESS.getValue())
                .setRechargeType(RechargeTypeEnum.STORE.getType())
                .setRechargeTime(LocalDateTime.now())
                .setOrgId(auth.getOrgId())
                .setUserId(auth.getUserId())
                .setUserName(auth.getUserName());

        // 创建本金资产
        String assetNum = vipAssetService.createAsset(new AssetCreateDTO()
                .setVipId(dto.getVipId())
                .setAssetBalance(dto.getRechargeValue())
                .setAssetType(VipAssetType.RECHARGE.getValue()) // 门店充值
                .setAssetDiscountRate(dto.getAssetDiscountRate())
                .setAssetDiscountBase(dto.getAssetDiscountBase())
                .setAssetIsCrossStore(dto.getAssetIsCrossStore())
        );
        history.setAssetCode(assetNum);

        // 处理充值活动
        if (dto.getActiveId() != null){
            handelActive(dto, history);
        }

        // 创建充值记录
        vipRechargeHistoryService.save(history);
        log.info("充值记录：{}", history);

        // 创建业绩明细，支持多人业绩，为每个销售员都计算业绩
        ServerRechargeRole role = serverRechargeRoleMapper.selectById(dto.getRechargeRoleId());
        List<RechargeDTO.UserKpiDTO> userKpiList = dto.getUserKpiList();
        BigDecimal reduceKpi = userKpiList.stream()
                .map(RechargeDTO.UserKpiDTO::getKpi)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        if (reduceKpi.compareTo(dto.getRechargeValue()) != 0){
            throw new BusinessException("业绩金额与充值金额不一致");
        }
        List<KpiDetail> kpi = userKpiList.stream().map(kpiUser ->
                new KpiDetail()
                        .setServiceCode(history.getHistoryCode())
                        .setServiceName(ServiceTypeEnum.RECHARGE.getType())
                        .setServiceType(ServiceTypeEnum.RECHARGE.getValue())
                        .setItemType(ServerItemTypeEnum.ANOTHER.getValue())
                        .setUserId(kpiUser.getUserId())
                        .setUserName(kpiUser.getUserName())
                        .setPerformance(kpiUser.getKpi())
                        .setCommission(handelCommission(kpiUser.getKpi(), role))
                        .setOrgId(auth.getOrgId())
        ).toList();
        kpiDetailMapper.insert(kpi);
        log.info("业绩明细：{}", kpi);

        // 创建支付明细
        List<PaymentInfoDTO> paymentInfoList = dto.getPaymentInfoList();
        BigDecimal reducePay = paymentInfoList.stream()
                .map(PaymentInfoDTO::getPaymentAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        if (reducePay.compareTo(dto.getRechargeValue()) != 0){
            throw new BusinessException("支付金额与充值金额不一致");
        }
        List<PaymentDetail> list = paymentInfoList.stream().map(payment ->
                new PaymentDetail()
                        .setActiveCode(history.getHistoryCode())
                        .setActiveType(ServiceTypeEnum.RECHARGE.getValue())
                        .setActiveName(ServiceTypeEnum.RECHARGE.getType())
                        .setPaymentType(payment.getPaymentType())
                        .setTotalAmount(payment.getPaymentAmount())
                        .setPaymentStatus(PaymentStatusEnum.PAID.getStatus())
                        .setPaymentName(payment.getPaymentName())
                        .setOrgId(auth.getOrgId())
        ).toList();
        paymentDetailMapper.insert(list);
        log.info("支付明细{}", list);

        // 更新会员总余额
        updateVipBalance(dto.getVipId());
        // 更新会员最后充值时间
        this.lambdaUpdate()
                .eq(VipInfo::getId, dto.getVipId())
                .set(VipInfo::getLastRechargeTime, LocalDate.now())
                .update();
    }

    /**
     * 处理充值活动
     * @param dto 充值参数
     * @param history 充值记录
     */
    private void handelActive(RechargeDTO dto, VipRechargeHistory history) {
        VipRechargeActiveVO active = vipRechargeActiveMapper.queryOneById(dto.getActiveId());
        if (active == null){
            throw new BusinessException("活动不存在");
        }
        if (active.getActiveStatus().equals(Status.DISABLED.getValue())){
            throw new BusinessException("活动已停用");
        }
        // 充值金额不能小于活动金额
        if (active.getActiveCapital().compareTo(dto.getRechargeValue()) > 0){
            throw new BusinessException("充值金额不符合活动要求");
        }
        if (active.getActiveType().equals(RechargeActiveTypeEnum.ANOTHER.getValue())){
            log.warn("活动类型为{}，暂不处理", active.getActiveType());
            return;
        }
        // 创建赠送金资产
        if (!active.getActiveType().equals(RechargeActiveTypeEnum.TICKET.getValue())){
            String code = vipAssetService.createAsset(new AssetCreateDTO()
                    .setVipId(dto.getVipId())
                    .setAssetBalance(active.getPresentValue())
                    .setAssetType(VipAssetType.PRESENT.getValue())
                    .setAssetDiscountRate(active.getPresentDiscount())
                    .setAssetDiscountBase(active.getPresentBase())
                    .setAssetIsCrossStore(active.getPresentIsCrossStore())
            );
            history.setPresentAssetCode(code)
                    .setPresentValue(active.getPresentValue());
        }
        // 创建优惠券资产
        if (!active.getActiveType().equals(RechargeActiveTypeEnum.AMOUNT.getValue())){
            StringBuilder ticketInfo = new StringBuilder();
            Integer sum = active.getTicketList().stream().map(ticket -> {
                VipInfoTicketCreateDTO ticketCreateDTO = new VipInfoTicketCreateDTO()
                        .setVipInfoId(dto.getVipId())
                        .setRemark("充值活动赠送")
                        .setVipName(dto.getVipName())
                        .setVipPhoneNumber(dto.getVipPhoneNumber())
                        .setVipCardNumber(dto.getVipCardNumber())
                        .setTicketName(ticket.getTicketName())
                        .setNumber(ticket.getNumber())
                        .setVipTicketId(ticket.getTicketId())
                        .setActiveId(dto.getActiveId())
                        .setRechargeHistoryCode(history.getHistoryCode());
                String vipInfoTicket = vipInfoTicketService.createVipInfoTicket(ticketCreateDTO);
                ticketInfo.append(vipInfoTicket);
                return ticket.getNumber();
            }).mapToInt(i -> i).sum();
            history.setTicketInfo(ticketInfo.toString());
            history.setTicketNum(sum);
        }
    }

    /**
     * 处理提成金额
     * @param permission 业绩金额
     * @param role 充值参数
     * @return 提成金额
     */
    private BigDecimal handelCommission(BigDecimal permission, ServerRechargeRole role) {

        if (role.getCommissionType().equals(CommissionTypeEnum.FIXED.getValue())){
            // TODO 暂不支持固定金额
            throw new BusinessException("暂不支持固定金额提成");
        } else if (role.getCommissionType().equals(CommissionTypeEnum.RATIO.getValue())){
            BigDecimal ratio = role.getRechargeCommissionValue();
            // 结果向上取整
            return permission.multiply(ratio).divide(new BigDecimal("100"), 2, RoundingMode.UP);
        }else {
            throw new BusinessException("提成类型错误");
        }
    }
}
