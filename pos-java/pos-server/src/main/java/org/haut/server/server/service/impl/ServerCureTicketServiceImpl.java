package org.haut.server.server.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.server.CureTicketDetailInfoDTO;
import org.haut.common.domain.dto.server.CureTicketCreateDTO;
import org.haut.common.domain.dto.server.CureTicketStatusDTO;
import org.haut.common.domain.dto.server.CureTicketUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.server.ServerCureTicketListQuery;
import org.haut.common.domain.entity.server.ServerCureTicket;
import org.haut.common.domain.entity.server.ServerCureTicketDetail;
import org.haut.common.domain.entity.vip.VipTicket;
import org.haut.common.domain.vo.server.ServerCureTicketVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.server.mapper.ServerCureTicketDetailMapper;
import org.haut.server.server.mapper.ServerCureTicketMapper;
import org.haut.server.vip.mapper.VipTicketMapper;
import org.haut.server.server.service.ServerCureTicketService;
import org.mapstruct.Mapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ServerCureTicketServiceImpl extends ServiceImpl<ServerCureTicketMapper, ServerCureTicket>
        implements ServerCureTicketService {
    private final ServerCureTicketDetailMapper serverCureTicketDetailMapper;
    private final CureTicketConvert cureTicketConvert;
    private final CureTicketDetailConvert cureTicketDetailConvert;


    /**
     * 保存疗程券
     * @param cureTicket
     */
    @Override
    @Transactional
    public void saveCureTicket(CureTicketCreateDTO cureTicket) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Long count = this.baseMapper.selectCount(Wrappers.lambdaQuery(ServerCureTicket.class)
                .eq(ServerCureTicket::getName, cureTicket.getName())
                .eq(auth.getOrgId() != null, ServerCureTicket::getOrgId, auth.getOrgId()));
        if (count > 0){
            throw new BusinessException("疗程券名称已存在");
        }
        // 插入疗程券
        ServerCureTicket entity = cureTicketConvert.toEntity(cureTicket);
        entity.setOrgId(auth.getOrgId());
        this.baseMapper.insert(entity);

        // 插入关联表
        Long ticketId = entity.getId();
        List<ServerCureTicketDetail> details = cureTicket.getVipTicketList().stream()
                .map(detailDTO -> {
                    ServerCureTicketDetail detail = cureTicketDetailConvert.toEntity(detailDTO);
                    detail.setCureTicketId(ticketId);
                    return detail;
                })
                .toList();
        serverCureTicketDetailMapper.insert(details);
    }

    /**
     * 更新疗程券
     * @param cureTicket
     */
    @Override
    public void updateCureTicket(CureTicketUpdateDTO cureTicket) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        Long count = this.baseMapper.selectCount(Wrappers.lambdaQuery(ServerCureTicket.class)
                .eq(ServerCureTicket::getName, cureTicket.getName())
                .eq(auth.getOrgId() != null, ServerCureTicket::getOrgId, auth.getOrgId())
                .ne(ServerCureTicket::getId, cureTicket.getId()));
        if (count > 0){
            throw new BusinessException("疗程券名称已存在");
        }
        // 更新优惠券主表
        ServerCureTicket entity = cureTicketConvert.toEntity(cureTicket);
        this.updateById(entity);
        // 删除关联表
        serverCureTicketDetailMapper.delete(Wrappers.lambdaQuery(ServerCureTicketDetail.class)
                .eq(ServerCureTicketDetail::getCureTicketId, cureTicket.getId()));
        // 插入关联表
        Long cureTicketId = cureTicket.getId();
        List<ServerCureTicketDetail> details = cureTicket.getVipTicketList().stream()
                .map(detailDTO -> {
                    ServerCureTicketDetail detail = cureTicketDetailConvert.toEntity(detailDTO);
                    detail.setCureTicketId(cureTicketId);
                    return detail;
                })
                .toList();
        serverCureTicketDetailMapper.insert(details);
    }

    /**
     * 获取治疗券列表
     * @param query
     * @return
     */
    @Override
    public List<ServerCureTicketVO> getList(ServerCureTicketListQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        return this.baseMapper.getList(query, auth.getOrgId());
    }

    /**
     * 修改疗程券状态
     * @param cureTicketStatus
     */
    @Override
    public void updateCureTicketStatus(CureTicketStatusDTO cureTicketStatus) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        // 检查疗程券是否存在
        ServerCureTicket existingTicket = this.baseMapper.selectOne(Wrappers.lambdaQuery(ServerCureTicket.class)
                .eq(ServerCureTicket::getId, cureTicketStatus.getId())
                .eq(auth.getOrgId() != null, ServerCureTicket::getOrgId, auth.getOrgId()));
        if (existingTicket == null) {
            throw new BusinessException("疗程券不存在");
        }
        
        // 更新状态
        ServerCureTicket updateEntity = new ServerCureTicket();
        updateEntity.setId(cureTicketStatus.getId());
        updateEntity.setStatus(cureTicketStatus.getStatus());
        this.updateById(updateEntity);
    }

}

@Mapper(componentModel = "spring")
interface CureTicketConvert {
    ServerCureTicket toEntity(CureTicketCreateDTO dto);
    ServerCureTicket toEntity(CureTicketUpdateDTO dto);
}

@Mapper(componentModel = "spring")
interface CureTicketDetailConvert {
    ServerCureTicketDetail toEntity(CureTicketDetailInfoDTO dto);
}