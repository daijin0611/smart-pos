package org.haut.server.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.server.entity.RoomInfo;
import org.haut.server.service.RoomInfoService;
import org.haut.server.mapper.RoomInfoMapper;
import org.springframework.stereotype.Service;

/**
* @author daiji
* @description 针对表【room_info(房间表)】的数据库操作Service实现
* @createDate 2025-05-18 23:48:22
*/
@Service
public class RoomInfoServiceImpl extends ServiceImpl<RoomInfoMapper, RoomInfo>
    implements RoomInfoService{

}




