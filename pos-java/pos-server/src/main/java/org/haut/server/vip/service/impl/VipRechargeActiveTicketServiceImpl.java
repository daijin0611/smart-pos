package org.haut.server.vip.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.entity.vip.VipRechargeActiveTicket;
import org.haut.server.vip.mapper.VipRechargeActiveTicketMapper;
import org.haut.server.vip.service.VipRechargeActiveTicketService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.List;

/**
 * 充值活动优惠券关联服务实现类
 * 
 * 实现充值活动优惠券关联的业务逻辑处理，包括查询、新增、删除等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class VipRechargeActiveTicketServiceImpl extends ServiceImpl<VipRechargeActiveTicketMapper, VipRechargeActiveTicket>
        implements VipRechargeActiveTicketService {

}