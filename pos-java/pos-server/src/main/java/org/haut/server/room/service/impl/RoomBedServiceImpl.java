package org.haut.server.room.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.room.entity.RoomBed;
import org.haut.server.room.service.RoomBedService;
import org.haut.server.room.mapper.RoomBedMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author daiji
* @description 针对表【room_bed(床位表)】的数据库操作Service实现
* @createDate 2025-05-18 23:48:22
*/
@Service
@RequiredArgsConstructor
public class RoomBedServiceImpl extends ServiceImpl<RoomBedMapper, RoomBed>
    implements RoomBedService{
    private final RoomBedMapper roomBedMapper;

    @Override
    public List<RoomBed> getAllBeds() {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        return roomBedMapper.getAllBeads(auth.getOrgId());
    }
}




