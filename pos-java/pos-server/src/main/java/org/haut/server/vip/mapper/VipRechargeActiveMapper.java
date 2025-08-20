package org.haut.server.vip.mapper;

import java.util.List;

import org.haut.common.domain.entity.vip.VipRechargeActive;
import org.haut.common.domain.query.vip.VipRechargeActiveQuery;
import org.haut.common.domain.vo.vip.VipRechargeActiveVO;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * 充值活动数据访问层
 * 
 * 针对表【vip_recharge_active(充值活动表)】的数据库操作Mapper
 * 提供充值活动的基础CRUD操作，继承MyBatis-Plus的BaseMapper
 *
 * @author mhding
 * @version 1.0
 * @since 2025-08-20
 */
public interface VipRechargeActiveMapper extends BaseMapper<VipRechargeActive> {

    /**
     * 查询充值活动列表
     * 
     * @param query 查询条件
     * @return 充值活动列表
     */
    List<VipRechargeActiveVO> queryList(VipRechargeActiveQuery query);

}