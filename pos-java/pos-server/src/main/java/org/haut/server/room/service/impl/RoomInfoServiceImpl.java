package org.haut.server.room.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.vo.room.RoomInfoVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.room.entity.RoomInfo;
import org.haut.server.room.service.RoomInfoService;
import org.haut.server.room.mapper.RoomInfoMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author daiji
* @description 针对表【room_info(房间表)】的数据库操作Service实现
* @createDate 2025-05-18 23:48:22
*/
@Service
@RequiredArgsConstructor
public class RoomInfoServiceImpl extends ServiceImpl<RoomInfoMapper, RoomInfo>
    implements RoomInfoService{
    private final RoomInfoMapper roomInfoMapper;
    @Override
    public List<RoomInfoVO> getAllRooms() {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        return roomInfoMapper.getAllRooms(auth.getOrgId());
    }
}




