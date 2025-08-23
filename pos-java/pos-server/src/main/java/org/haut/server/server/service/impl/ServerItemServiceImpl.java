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
import org.haut.server.server.entity.ServerItem;
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

    /**
     * 查询服务项目列表
     *
     * @param query 查询条件
     * @return 服务项目列表
     */
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

    /**
     * 根据ID查询服务项目
     * @param id
     * @return
     */
    @Override
    public ServerItemVO queryById(Long id) {
        return serverItemConvert.toVO(this.getById(id));
    }

    /**
     * 添加服务项目
     * @param item
     */
    @Override
    public void addServerItem(ServerItemCreateDTO item) {
        ServerItem entity = toEntity(item);
        this.save(entity);
    }

    /**
     * 更新服务项目
     * @param item
     */
    @Override
    public void updateServerItem(ServerItemUpdateDTO item) {
        ServerItem entity = toEntity(item);
        this.updateById(entity);
    }

    /**
     * 将 ServerItemCreateDTO 转换为 ServerItem 实体
     * 并进行必要的校验
     * @param item
     * @return
     */
    private ServerItem toEntity(ServerItemCreateDTO item) {
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
        return entity;
    }

    /**
     * 将 ServerItemUpdateDTO 转换为 ServerItem 实体
     * @param item
     * @return
     */
    private ServerItem toEntity(ServerItemUpdateDTO item) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();

        // 校验服务项目编码是否已存在
        if (this.count(Wrappers.lambdaQuery(ServerItem.class)
                .eq(ServerItem::getItemEncode, item.getItemEncode())
                .eq(ServerItem::getOrgId, auth.getOrgId())
                .ne(ServerItem::getId, item.getId())) > 0) {
            throw new BusinessException("服务项目编码已存在");
        }

        // 校验服务项目名称是否已存在
        if (this.count(Wrappers.lambdaQuery(ServerItem.class)
                .eq(ServerItem::getItemName, item.getItemName())
                .eq(ServerItem::getOrgId, auth.getOrgId())
                .ne(ServerItem::getId, item.getId())) > 0) {
            throw new BusinessException("服务项目名称已存在");
        }
        return serverItemConvert.toEntity(item).setOrgId(auth.getOrgId());
    }
}