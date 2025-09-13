package org.haut.server.vip.service;

import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

import org.haut.common.domain.dto.vip.VipRechargeActiveAddDTO;
import org.haut.common.domain.dto.vip.VipRechargeActiveStatusDTO;
import org.haut.common.domain.query.vip.ActiveStatQuery;
import org.haut.common.domain.vo.vip.RechargeHistoryVO;
import org.haut.server.vip.entity.VipRechargeActive;
import org.haut.common.domain.query.vip.VipRechargeActiveQuery;
import org.haut.common.domain.vo.vip.VipRechargeActiveVO;

/**
 * 充值活动服务接口
 * 
 * 提供充值活动的业务逻辑处理，包括查询、新增、状态修改等功能
 *
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
public interface VipRechargeActiveService extends IService<VipRechargeActive> {
    
    /**
     * 分页查询充值活动列表
     * 
     * @param query 查询条件
     * @return 分页结果
     */
    List<VipRechargeActiveVO> queryList(VipRechargeActiveQuery query);
    
    /**
     * 新增充值活动
     * 
     * @param addDTO 新增数据
     * @return 操作结果
     */
    Boolean addRechargeActive(VipRechargeActiveAddDTO addDTO);
    
    /**
     * 修改充值活动状态
     * 
     * @param statusDTO 状态修改数据
     * @return 操作结果
     */
    Boolean updateStatus(VipRechargeActiveStatusDTO statusDTO);

}