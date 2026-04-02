package org.haut.server.room.service;

import org.haut.common.domain.dto.room.RoomCreateDTO;
import org.haut.common.domain.dto.room.RoomUpdateDTO;
import org.haut.common.domain.vo.room.RoomInfoVO;
import org.haut.server.room.entity.RoomInfo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author daiji
* @description 针对表【room_info(房间表)】的数据库操作Service
* @createDate 2025-05-18 23:48:22
*/
public interface RoomInfoService extends IService<RoomInfo> {

    List<RoomInfoVO> getAllRooms();

    void addRoom(RoomCreateDTO dto);

    void updateRoom(RoomUpdateDTO dto);
}
