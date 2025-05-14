package org.haut.server.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.server.CureTicketDetailInfoDTO;
import org.haut.common.domain.dto.server.CureTicketInfoDTO;
import org.haut.common.domain.dto.server.CureTicketListDTO;
import org.haut.common.domain.query.ServerCureTicketListQuery;
import org.haut.server.entity.ServerCureTicket;
import org.haut.server.entity.ServerCureTicketDetail;
import org.haut.server.entity.VipTicket;
import org.haut.server.mapper.ServerCureTicketDetailMapper;
import org.haut.server.mapper.ServerCureTicketMapper;
import org.haut.server.mapper.VipTicketMapper;
import org.haut.server.service.ServerCureTicketService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class ServerCureTicketServiceImpl extends ServiceImpl<ServerCureTicketMapper, ServerCureTicket>
        implements ServerCureTicketService {

    @Autowired
    private ServerCureTicketDetailMapper serverCureTicketDetailMapper;
    @Autowired
    private VipTicketMapper vipTicketMapper;

    @Override
    public List<CureTicketListDTO> getCureTicketWithVipTickets(ServerCureTicketListQuery query) {
        QueryWrapper<ServerCureTicket> cureTicketQuery = new QueryWrapper<>();
        cureTicketQuery.eq("is_delete", 0)
                .like(BeanUtil.isNotEmpty(query.getCureTicketName()), "cure_ticket_name", query.getCureTicketName())
                .like(BeanUtil.isNotEmpty(query.getCureTicketEncode()), "cure_ticket_encode", query.getCureTicketEncode());
        List<ServerCureTicket> cureTicketList = baseMapper.selectList(cureTicketQuery);
        if (CollectionUtils.isEmpty(cureTicketList)) {
            return Collections.emptyList();
        }

        List<Long> cureTicketIds = cureTicketList.stream()
                .map(ServerCureTicket::getId)
                .collect(Collectors.toList());
        QueryWrapper<ServerCureTicketDetail> detailQuery = new QueryWrapper<>();
        detailQuery.in("cure_ticket_id", cureTicketIds)
                .eq("is_delete", 0);
        List<ServerCureTicketDetail> detailList = serverCureTicketDetailMapper.selectList(detailQuery);

        List<Long> vipTicketIds = detailList.stream()
                .map(ServerCureTicketDetail::getVipTicketId)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());
        List<VipTicket> vipTicketList = CollectionUtils.isEmpty(vipTicketIds) ? Collections.emptyList()
                : vipTicketMapper.selectBatchIds(vipTicketIds);

        Map<Long, VipTicket> vipTicketMap = vipTicketList.stream()
                .collect(Collectors.toMap(VipTicket::getId, Function.identity()));
        Map<Long, List<ServerCureTicketDetail>> cureTicketDetailMap = detailList.stream()
                .collect(Collectors.groupingBy(ServerCureTicketDetail::getCureTicketId));

        return cureTicketList.stream()
                .map(cureTicket -> {
                    CureTicketListDTO dto = new CureTicketListDTO();
                    BeanUtils.copyProperties(cureTicket, dto);
                    List<ServerCureTicketDetail> details = cureTicketDetailMap.getOrDefault(cureTicket.getId(), Collections.emptyList());
                    List<CureTicketDetailInfoDTO> detailDTOList = details.stream()
                            .map(detail -> {
                                CureTicketDetailInfoDTO detailDTO = new CureTicketDetailInfoDTO();
                                BeanUtils.copyProperties(detail, detailDTO);
                                VipTicket vipTicket = vipTicketMap.get(detail.getVipTicketId());
                                if (vipTicket != null) {
                                    detailDTO.setVipTicketName(vipTicket.getTicketName());
                                }
                                return detailDTO;
                            })
                            .collect(Collectors.toList());
                    dto.setCureTicketDetailInfoDTOList(detailDTOList);
                    return dto;
                })
                .collect(Collectors.toList());
    }

    @Override
    public CureTicketInfoDTO getCureTicketInfoById(Long id) {
        ServerCureTicket cureTicketEntity = baseMapper.selectById(id);
        if (cureTicketEntity == null || cureTicketEntity.getIsDelete() == 1) {
            return null;
        }
        QueryWrapper<ServerCureTicketDetail> detailQuery = new QueryWrapper<>();
        detailQuery.eq("cure_ticket_id", id)
                .eq("is_delete", 0);
        List<ServerCureTicketDetail> detailList = serverCureTicketDetailMapper.selectList(detailQuery);

        List<Long> vipTicketIds = detailList.stream()
                .map(ServerCureTicketDetail::getVipTicketId)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());
        List<VipTicket> vipTicketList = CollectionUtils.isEmpty(vipTicketIds) ? Collections.emptyList()
                : vipTicketMapper.selectBatchIds(vipTicketIds);

        CureTicketInfoDTO infoDTO = new CureTicketInfoDTO();
        BeanUtils.copyProperties(cureTicketEntity, infoDTO);
        List<CureTicketDetailInfoDTO> detailDTOList = detailList.stream()
                .map(detail -> {
                    CureTicketDetailInfoDTO detailDTO = new CureTicketDetailInfoDTO();
                    BeanUtils.copyProperties(detail, detailDTO);
                    VipTicket vipTicket = vipTicketList.stream()
                            .filter(t -> t.getId().equals(detail.getVipTicketId()))
                            .findFirst()
                            .orElse(null);
                    if (vipTicket != null) {
                        detailDTO.setVipTicketName(vipTicket.getTicketName());
                    }
                    return detailDTO;
                })
                .collect(Collectors.toList());
        infoDTO.setCureTicketDetailInfoDTOList(detailDTOList);
        return infoDTO;
    }

    @Override
    public void saveCureTicket(CureTicketInfoDTO cureTicket) {
        // 保存主表时将主键置空，避免重复插入
        ServerCureTicket cureTicketEntity = BeanUtil.toBean(cureTicket, ServerCureTicket.class);
        cureTicketEntity.setId(null);
        cureTicketEntity.setIsDelete(0);
        baseMapper.insert(cureTicketEntity);
        Long cureTicketId = cureTicketEntity.getId();

        List<CureTicketDetailInfoDTO> detailList = cureTicket.getCureTicketDetailInfoDTOList();
        // 如果详情列表为空，为防止空数据错误，添加一条默认的详情数据
        if (CollectionUtils.isEmpty(detailList)) {
            CureTicketDetailInfoDTO defaultDetail = new CureTicketDetailInfoDTO();
            defaultDetail.setVipTicketId(0L); // 根据业务设定默认会员券ID
            detailList = Collections.singletonList(defaultDetail);
        }
        detailList.forEach(detailDTO -> {
            ServerCureTicketDetail detailEntity = BeanUtil.toBean(detailDTO, ServerCureTicketDetail.class);
            detailEntity.setCureTicketId(cureTicketId);
            detailEntity.setIsDelete(0);
            serverCureTicketDetailMapper.insert(detailEntity);
        });
    }

    @Override
    public void updateCureTicket(CureTicketInfoDTO cureTicket) {
        Long cureTicketId = cureTicket.getCureTicketId();
        ServerCureTicket existCureTicket = baseMapper.selectById(cureTicketId);
        if (existCureTicket == null || existCureTicket.getIsDelete() == 1) {
            throw new IllegalArgumentException("疗程券不存在或已删除");
        }
        ServerCureTicket cureTicketEntity = BeanUtil.toBean(cureTicket, ServerCureTicket.class);
        baseMapper.updateById(cureTicketEntity);

        QueryWrapper<ServerCureTicketDetail> detailQuery = new QueryWrapper<>();
        detailQuery.eq("cure_ticket_id", cureTicketId);
        serverCureTicketDetailMapper.delete(detailQuery);

        List<CureTicketDetailInfoDTO> detailList = cureTicket.getCureTicketDetailInfoDTOList();
        if (!CollectionUtils.isEmpty(detailList)) {
            detailList.forEach(detailDTO -> {
                ServerCureTicketDetail detailEntity = BeanUtil.toBean(detailDTO, ServerCureTicketDetail.class);
                detailEntity.setCureTicketId(cureTicketId);
                detailEntity.setIsDelete(0);
                serverCureTicketDetailMapper.insert(detailEntity);
            });
        }
    }

    @Override
    public CureTicketInfoDTO getCureTicketInfo(Long id) {
        return getCureTicketInfoById(id);
    }

    @Override
    public List<CureTicketListDTO> getList(ServerCureTicketListQuery query) {
        return getCureTicketWithVipTickets(query);
    }
}