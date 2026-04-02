package org.haut.server.room.mapper;

import org.haut.common.domain.vo.room.RoomInfoVO;
import org.haut.server.room.entity.RoomInfo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author daiji
* @description 针对表【room_info(房间表)】的数据库操作Mapper
* @createDate 2025-05-18 23:48:22
* @Entity org.haut.server.room.entity.RoomInfo
*/
public interface RoomInfoMapper extends BaseMapper<RoomInfo> {

    List<RoomInfoVO> getAllRooms(Long orgId);
}




