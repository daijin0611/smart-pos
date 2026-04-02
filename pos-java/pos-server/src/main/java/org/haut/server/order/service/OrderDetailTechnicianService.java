package org.haut.server.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import org.haut.server.order.entity.OrderDetailTechnicianEntity;

import java.util.List;

public interface OrderDetailTechnicianService extends IService<OrderDetailTechnicianEntity> {

    /**
     * 批量保存技师关联
     */
    void saveTechnicians(Long detailId, List<OrderDetailTechnicianDTO> technicians);

    /**
     * 根据订单明细ID查询技师列表
     */
    List<OrderDetailTechnicianDTO> listByDetailId(Long detailId);

    /**
     * 根据多个订单明细ID批量查询技师列表
     */
    List<OrderDetailTechnicianEntity> listByDetailIds(List<Long> detailIds);

    /**
     * 更新技师关联（先删后增）
     */
    void updateTechnicians(Long detailId, List<OrderDetailTechnicianDTO> technicians);

    /**
     * 根据订单明细ID删除技师关联
     */
    void removeByDetailId(Long detailId);
}