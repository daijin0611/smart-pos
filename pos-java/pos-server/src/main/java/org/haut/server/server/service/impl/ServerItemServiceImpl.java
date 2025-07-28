package org.haut.server.server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.dto.server.ServerItemCreateDTO;
import org.haut.common.domain.dto.server.ServerItemUpdateDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.server.ServerItemQuery;
import org.haut.common.domain.entity.server.ServerItem;
import org.haut.common.domain.vo.server.ServerItemVO;
import org.haut.common.exception.BusinessException;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.server.mapper.ServerItemMapper;
import org.haut.server.server.service.ServerItemService;
import org.mapstruct.Mapper;
import org.springframework.stereotype.Service;

import java.util.List;
@Mapper(componentModel = "spring")
interface ServerItemConvert{

    List<ServerItemVO> toVOList(List<ServerItem> serverItems);

    ServerItemVO toVO(ServerItem serverItem);

    ServerItem toEntity(ServerItemCreateDTO item);

    ServerItem toEntity(ServerItemUpdateDTO item);
}

/**
 * 服务项目
 */
@Service
@RequiredArgsConstructor
public class ServerItemServiceImpl extends ServiceImpl<ServerItemMapper, ServerItem>
        implements ServerItemService {
    private final ServerItemConvert serverItemConvert;

    @Override
    public List<ServerItemVO> getList(ServerItemQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        // 构建条件查询器
        LambdaQueryWrapper<ServerItem> queryWrapper = Wrappers.lambdaQuery(ServerItem.class)
                .and(StringUtils.isNotBlank(query.getKeyWord()),
                        w -> w.like(ServerItem::getItemName, query.getKeyWord())
                                .or()
                                .like(ServerItem::getItemEncode, query.getKeyWord()))
                .eq(query.getItemStatus() != null, ServerItem::getItemStatus, query.getItemStatus())
                .eq(ServerItem::getOrgId, auth.getOrgId());
        // 查询数据库
        List<ServerItem> serverItems = this.list(queryWrapper);

        // 转化为 DTO
        return serverItemConvert.toVOList(serverItems);
    }

    @Override
    public ServerItemVO queryById(Long id) {
        return serverItemConvert.toVO(this.getById(id));
    }

    @Override
    public void addServerItem(ServerItemCreateDTO item) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();

        // 校验服务项目编码是否已存在
        if (this.count(Wrappers.lambdaQuery(ServerItem.class)
                .eq(ServerItem::getItemEncode, item.getItemEncode())
                .eq(ServerItem::getOrgId, auth.getOrgId())) > 0) {
            throw new BusinessException("服务项目编码已存在");
        }

        // 校验服务项目名称是否已存在
        if (this.count(Wrappers.lambdaQuery(ServerItem.class)
                .eq(ServerItem::getItemName, item.getItemName())
                .eq(ServerItem::getOrgId, auth.getOrgId())) > 0) {
            throw new BusinessException("服务项目名称已存在");
        }

        ServerItem entity = serverItemConvert.toEntity(item);
        entity.setOrgId(auth.getOrgId());
        this.save(entity);
    }
}