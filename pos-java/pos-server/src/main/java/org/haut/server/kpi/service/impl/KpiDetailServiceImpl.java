package org.haut.server.kpi.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.kpi.KpiDetailCreateDTO;
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.kpi.KpiListQuery;
import org.haut.common.domain.vo.kpi.KpiListVO;
import org.haut.common.enums.CommissionBaseEnum;
import org.haut.common.enums.CommissionTypeEnum;
import org.haut.common.enums.ServerItemTypeEnum;
import org.haut.common.enums.ServiceTypeEnum;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.kpi.entity.KpiDetail;
import org.haut.server.kpi.service.KpiDetailService;
import org.haut.server.kpi.mapper.KpiDetailMapper;
import org.haut.server.order.entity.OrderInfoEntity;
import org.haut.server.server.entity.ServerCureTicket;
import org.haut.server.server.entity.ServerItem;
import org.haut.server.server.entity.ServerProduct;
import org.haut.server.server.service.ServerCureTicketService;
import org.haut.server.server.service.ServerItemService;
import org.haut.server.server.service.ServerProductService;
import org.mapstruct.Mapper;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

import static org.haut.common.enums.ServiceTypeEnum.PRODUCT;
import static org.haut.common.enums.ServiceTypeEnum.SERVER;

@Mapper(componentModel = "spring")
interface KpiDetailConvert {
    KpiDetail toEntity(KpiDetailCreateDTO dto);
}

/**
* @author daiji
* @description 针对表【kpi_detail(业绩明细)】的数据库操作Service实现
* @createDate 2025-08-25 16:35:17
*/
@Service
@RequiredArgsConstructor
public class KpiDetailServiceImpl extends ServiceImpl<KpiDetailMapper, KpiDetail>
    implements KpiDetailService{
    private final KpiDetailConvert kpiDetailConvert;
    private final ServerItemService serverItemService;
    private final ServerProductService serverProductService;
    private final ServerCureTicketService serverCureTicketService;

    /**
     * 创建业绩明细
     * @param kpiDetailCreateDTO 创建参数
     */
    @Override
    public boolean createKpiDetail(KpiDetailCreateDTO kpiDetailCreateDTO) {
        return this.save(kpiDetailConvert.toEntity(kpiDetailCreateDTO));
    }

    /**
     * 获取业绩列表
     * @param query 查询条件
     * @return 列表
     */
    @Override
    public PageDTO<KpiListVO> getKpiList(KpiListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        query.setOrgId(auth.getOrgId());
        if(query.getDate() != null && query.getDate()[0] != null && query.getDate()[1] != null) {
            query.setBeginDate(query.getDate()[0]);
            query.setEndDate(query.getDate()[1]);
        }
        //处理空指针异常
        int pageNum = (query.getPageNum() == null || query.getPageNum() <= 0) ? 1 : query.getPageNum();
        int pageSize = (query.getPageSize() == null || query.getPageSize() <= 0) ? 20 : query.getPageSize();

        Page<KpiListVO> page = new Page<>(pageNum, pageSize);

        //调用Mapper方法，接收返回的IPage对象
        IPage<KpiListVO> iPage = baseMapper.selectKpiList(page, query);

        //直接调用静态方法create来创建并返回 PageDTO
        return PageDTO.create((Page<KpiListVO>) iPage);
    }

    /**
     * 处理订单业绩
     * @param order 订单信息
     * @param orderDetails 订单明细
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void handelOrder(OrderInfoEntity order, List<OrderDetailSettleDTO> orderDetails) {
        List<KpiDetail> kpis = orderDetails.stream()
                .map(e ->
                        new KpiDetail()
                                .setServiceCode(order.getOrderCode())
                                .setServiceName(e.getBusinessName())
                                .setServiceType(e.getDetailType())
                                .setItemType(e.getServerType())
                                .setUserId(e.getUserId())
                                .setUserName(e.getUserName())
                                .setPerformance(e.getTruePrice())
                                .setCommission(handelCommission(e))
                                .setOrgId(order.getOrgId()))
                .toList();
        saveBatch(kpis);
    }

    public BigDecimal handelCommission(OrderDetailSettleDTO dto) {
        ServiceTypeEnum serviceType = ServiceTypeEnum.getByValue(dto.getDetailType());
        switch (serviceType){
            case SERVER -> {
                ServerItem item = serverItemService.getById(dto.getBid());
                Integer commissionType = item.getCommissionType();
                ServerItemTypeEnum serverItemType = ServerItemTypeEnum.getByValue(dto.getServerType());
                return switch (serverItemType){
                    case APPOINTMENT -> {
                        BigDecimal commissionValueAppointment = item.getCommissionValueAppointment();
                        // 固定金额提成
                        if (CommissionTypeEnum.FIXED.getValue().equals(commissionType)) {
                            yield commissionValueAppointment;
                        }
                        // 比例金额提成
                        else if (CommissionTypeEnum.RATIO.getValue().equals(commissionType)) {
                            // 标准价提成
                            if (CommissionBaseEnum.STAND.getValue().equals(item.getCommissionBase())){
                                yield commissionValueAppointment.multiply(dto.getStdPrice());
                            }
                            // 实际价提成
                            else if (CommissionBaseEnum.TRUE.getValue().equals(item.getCommissionBase())) {
                                yield commissionValueAppointment.multiply(dto.getTruePrice());
                            } else {
                                throw new BusinessException("未知的提成基基准类型");
                            }
                        } else {
                            throw new BusinessException("未知的提成类型");
                        }
                    }
                    case EXTEND -> {
                        BigDecimal commissionValueExtend = item.getCommissionValueExtend();
                        // 固定金额提成
                        if (CommissionTypeEnum.FIXED.getValue().equals(commissionType)) {
                            yield commissionValueExtend;
                        }
                        // 比例金额提成
                        else if (CommissionTypeEnum.RATIO.getValue().equals(commissionType)) {
                            // 标准价提成
                            if (CommissionBaseEnum.STAND.getValue().equals(item.getCommissionBase())){
                                yield commissionValueExtend.multiply(dto.getStdPrice());
                            }
                            // 实际价提成
                            else if (CommissionBaseEnum.TRUE.getValue().equals(item.getCommissionBase())) {
                                yield commissionValueExtend.multiply(dto.getTruePrice());
                            } else {
                                throw new BusinessException("未知的提成基基准类型");
                            }
                        } else {
                            throw new BusinessException("未知的提成类型");
                        }
                    }
                    case ROTATION -> {
                        BigDecimal commissionValueRotation = item.getCommissionValueRotation();
                        // 固定金额提成
                        if (CommissionTypeEnum.FIXED.getValue().equals(commissionType)) {
                            yield commissionValueRotation;
                        }
                        // 比例金额提成
                        else if (CommissionTypeEnum.RATIO.getValue().equals(commissionType)) {
                            // 标准价提成
                            if (CommissionBaseEnum.STAND.getValue().equals(item.getCommissionBase())){
                                yield commissionValueRotation.multiply(dto.getStdPrice());
                            }
                            // 实际价提成
                            else if (CommissionBaseEnum.TRUE.getValue().equals(item.getCommissionBase())) {
                                yield commissionValueRotation.multiply(dto.getTruePrice());
                            } else {
                                throw new BusinessException("未知的提成基基准类型");
                            }
                        } else {
                            throw new BusinessException("未知的提成类型");
                        }
                    }
                    case ANOTHER -> throw new BusinessException("未知的上钟类型");
                };
            }
            case PRODUCT -> {
                ServerProduct product = serverProductService.getById(dto.getBid());
                Integer commissionType = product.getCommissionType();
                if (CommissionTypeEnum.FIXED.getValue().equals(commissionType))
                    return product.getCommissionValue();
                else if (CommissionTypeEnum.RATIO.getValue().equals(commissionType)) {
                    // 标准价提成
                    if (CommissionBaseEnum.STAND.getValue().equals(product.getCommissionBase()))
                        return product.getCommissionValue().multiply(dto.getStdPrice());
                    // 实际价提成
                    else if (CommissionBaseEnum.TRUE.getValue().equals(product.getCommissionBase()))
                        return product.getCommissionValue().multiply(dto.getTruePrice());
                    else
                        throw new BusinessException("未知的提成基基准类型");
                }
            }
            case CURE_TICKET -> {
                ServerCureTicket cureTicket = serverCureTicketService.getById(dto.getBid());
                Integer type = cureTicket.getType();
                if (CommissionTypeEnum.FIXED.getValue().equals(type))
                    return cureTicket.getCommissionValue();
                else if (CommissionTypeEnum.RATIO.getValue().equals(type)) {
                    // 标准价提成
                    if (CommissionBaseEnum.STAND.getValue().equals(cureTicket.getCommissionBase()))
                        return cureTicket.getCommissionValue().multiply(dto.getStdPrice());
                        // 实际价提成
                    else if (CommissionBaseEnum.TRUE.getValue().equals(cureTicket.getCommissionBase()))
                        return cureTicket.getCommissionValue().multiply(dto.getTruePrice());
                    else
                        throw new BusinessException("未知的提成基基准类型");
                }
            }
            case UNKNOWN -> throw new BusinessException("未知的业务类型");
        }
        return BigDecimal.ZERO;
    }
}




