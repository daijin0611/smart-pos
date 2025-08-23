package org.haut.server.room.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.hutool.core.bean.BeanUtil;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.dto.room.RoomUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.vo.room.RoomInfoVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.room.entity.RoomInfo;
import org.haut.server.room.service.RoomInfoService;
import org.haut.server.room.mapper.RoomInfoMapper;
import org.springframework.stereotype.Service;
import org.haut.common.domain.dto.room.RoomCreateDTO;

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
    @Override
    public void addRoom(RoomCreateDTO dto) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();

        //检查房间名是否存在
        LambdaQueryWrapper<RoomInfo> queryWrapper = Wrappers.lambdaQuery(RoomInfo.class)
                        .eq(RoomInfo::getRoomName, dto.getRoomName())
                        .eq(RoomInfo::getOrgId, auth.getOrgId());
        long count = this.count(queryWrapper);
        if (count > 0) {
            throw new BusinessException("房间名称已存在");
        }

        //执行新增
        RoomInfo roomInfo = new RoomInfo();
        BeanUtil.copyProperties(dto, roomInfo);
        roomInfo.setOrgId(auth.getOrgId());
        boolean save = this.save(roomInfo);
        if (!save) {
            throw new BusinessException("房间创建失败");
        }
    }

    @Override
    public void updateRoom(RoomUpdateDTO dto) {
        //校验名称在同一个店下是否重复
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        isRoomNameExists(dto.getRoomName(), auth.getOrgId());

        //执行更新
        LambdaUpdateWrapper<RoomInfo> updateWrapper = Wrappers.lambdaUpdate(RoomInfo.class)
                .set(StringUtils.isNotBlank(dto.getRoomName()),RoomInfo::getRoomName, dto.getRoomName())
                .set(StringUtils.isNotBlank(dto.getRemark()),RoomInfo::getRemark, dto.getRemark())
                .eq(RoomInfo::getId, dto.getId());
        boolean update = this.update(updateWrapper);
        if (!update) {
            throw new BusinessException("房间更新失败");
        }
    }

    /**
     * 检查房间名称是否已存在
     * @param roomName
     * @return
     */
    private void isRoomNameExists(String roomName, Long orgId) {
        long count = this.count(Wrappers.lambdaQuery(RoomInfo.class)
                .eq(RoomInfo::getRoomName, roomName)
                .eq(orgId != null, RoomInfo::getOrgId, orgId));
        if (count > 0) {
            throw new BusinessException("房间名称已存在");
        }
    }
}