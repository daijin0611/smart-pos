package org.haut.server.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.order.OrderDetailCreateDTO;
import org.haut.common.domain.dto.order.OrderDetailSettleDTO;
import org.haut.common.domain.dto.order.OrderDetailTechnicianDTO;
import org.haut.common.domain.query.order.OrderDetailPageQuery;
import org.haut.common.domain.vo.order.OrderDetailVO;
import org.haut.server.order.entity.OrderDetailEntity;
import org.haut.server.order.entity.OrderInfoEntity;

import java.util.List;

/**
 * 订单明细服务接口
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-01-29
 */
public interface OrderDetailService extends IService<OrderDetailEntity> {

    /**
     * 创建订单明细
     * @param orderDetails 订单明细
     * @param orderId 订单ID
     */
    List<OrderDetailVO> createOrderDetails (List<OrderDetailCreateDTO> orderDetails, Long orderId);
    
    /**
     * 根据订单ID查询订单明细列表
     * 
     * @param orderId 订单ID
     * @return 订单明细列表
     */
    List<OrderDetailVO> queryByOrderId(Long orderId);

    /**
     * 根据不同业务类型处理订单业务信息，并计算基础价格
     * @param dto 订单明细DTO
     * @return 包含基础价格计算结果的订单明细实体
     */
    OrderDetailEntity calculateDetailPriceInfo(OrderDetailCreateDTO dto);

    /**
     * 添加订单明细
     * @param dto
     * @param orderId
     * @return
     */
    Long addDetails(OrderDetailCreateDTO dto, Long orderId);

    /**
     * 结算订单明细
     * @param orderInfoEntity 订单信息
     * @param orderDetails 待结算订单明细
     */
    void settleOrderDetail(OrderInfoEntity orderInfoEntity, List<OrderDetailSettleDTO> orderDetails);

    /**
     * 结算订单明细（返回保存后的实体列表）
     * @param orderInfoEntity 订单信息
     * @param orderDetails 待结算订单明细
     * @return 保存后的订单明细实体列表
     */
    List<OrderDetailEntity> settleOrderDetailAndReturn(OrderInfoEntity orderInfoEntity, List<OrderDetailSettleDTO> orderDetails);

    /**
     * 订单明细分页查询
     * @return
     */
    PageDTO<OrderDetailVO> pageQuery(OrderDetailPageQuery query);

    /**
     * 更新订单明细的上钟类型
     * @param detailId 明细ID
     * @param serverType 上钟类型（0 点钟，1 加钟，2 轮牌）
     */
    void updateServerType(Long detailId, Integer serverType);

    /**
     * 更新订单明细的服务技师（多人模式）
     * @param detailId 订单明细ID
     * @param technicians 技师列表
     */
    void updateServerEmployee(Long detailId, List<OrderDetailTechnicianDTO> technicians);

    /**
     * 删除订单明细
     * @param detailId 明细ID
     * @return 操作结果信息
     */
    String deleteDetail(Long detailId);

    /**
     * 填充订单明细VO的技师列表
     * @param entities 订单明细实体列表
     * @param vos 订单明细VO列表
     */
    void fillTechnicians(List<OrderDetailEntity> entities, List<OrderDetailVO> vos);
}