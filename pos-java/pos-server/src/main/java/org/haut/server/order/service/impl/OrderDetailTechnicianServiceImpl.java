package org.haut.server.order.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import org.haut.server.order.entity.OrderDetailTechnicianEntity;
import org.haut.server.order.mapper.OrderDetailTechnicianMapper;
import org.haut.server.order.service.OrderDetailTechnicianService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderDetailTechnicianServiceImpl
        extends ServiceImpl<OrderDetailTechnicianMapper, OrderDetailTechnicianEntity>
        implements OrderDetailTechnicianService {

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveTechnicians(Long detailId, List<OrderDetailTechnicianDTO> technicians) {
        if (technicians == null || technicians.isEmpty()) {
            return;
        }
        List<OrderDetailTechnicianEntity> entities = technicians.stream()
                .map(t -> new OrderDetailTechnicianEntity()
                        .setDetailId(detailId)
                        .setUserId(t.getUserId())
                        .setUserName(t.getUserName()))
                .toList();
        saveBatch(entities);
    }

    @Override
    public List<OrderDetailTechnicianDTO> listByDetailId(Long detailId) {
        if (detailId == null) {
            return Collections.emptyList();
        }
        List<OrderDetailTechnicianEntity> entities = lambdaQuery()
                .eq(OrderDetailTechnicianEntity::getDetailId, detailId)
                .list();
        return entities.stream()
                .map(e -> new OrderDetailTechnicianDTO()
                        .setUserId(e.getUserId())
                        .setUserName(e.getUserName()))
                .toList();
    }

    @Override
    public List<OrderDetailTechnicianEntity> listByDetailIds(List<Long> detailIds) {
        if (detailIds == null || detailIds.isEmpty()) {
            return Collections.emptyList();
        }
        return lambdaQuery()
                .in(OrderDetailTechnicianEntity::getDetailId, detailIds)
                .list();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateTechnicians(Long detailId, List<OrderDetailTechnicianDTO> technicians) {
        removeByDetailId(detailId);
        saveTechnicians(detailId, technicians);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void removeByDetailId(Long detailId) {
        lambdaUpdate()
                .eq(OrderDetailTechnicianEntity::getDetailId, detailId)
                .remove();
    }
}