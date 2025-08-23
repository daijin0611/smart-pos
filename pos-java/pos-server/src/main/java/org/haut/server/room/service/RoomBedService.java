package org.haut.server.room.service;

import org.haut.server.room.entity.RoomBed;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author daiji
* @description 针对表【room_bed(床位表)】的数据库操作Service
* @createDate 2025-05-18 23:48:22
*/
public interface RoomBedService extends IService<RoomBed> {

    List<RoomBed> getAllBeds();
}
