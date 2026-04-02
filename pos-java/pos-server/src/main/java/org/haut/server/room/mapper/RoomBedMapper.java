package org.haut.server.room.mapper;

import org.haut.server.room.entity.RoomBed;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author daiji
* @description 针对表【room_bed(床位表)】的数据库操作Mapper
* @createDate 2025-05-18 23:48:22
* @Entity org.haut.server.room.entity.RoomBed
*/
public interface RoomBedMapper extends BaseMapper<RoomBed> {

    List<RoomBed> getAllBeads(Long orgId);
}




