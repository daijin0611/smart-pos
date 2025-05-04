package org.haut.server.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.server.ServerItemListDTO;
import org.haut.common.domain.query.ServerItemListQuery;
import org.haut.server.entity.ServerItem;
import org.haut.server.mapper.ServerItemMapper;
import org.haut.server.service.ServerItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServerItemServiceImpl extends ServiceImpl<ServerItemMapper, ServerItem>
        implements ServerItemService {

    @Autowired
    private ServerItemMapper serverItemMapper;

    @Override
    public List<ServerItemListDTO> getList(ServerItemListQuery query) {
        // 构建条件查询器
        QueryWrapper<ServerItem> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(StringUtils.isNotBlank(query.getItemName()), "item_name", query.getItemName())
                .like(StringUtils.isNotBlank(query.getItemEncode()), "item_encode", query.getItemEncode());

        // 查询数据库
        List<ServerItem> serverItems = serverItemMapper.selectList(queryWrapper);

        // 转化为 DTO
        return BeanUtil.copyToList(serverItems, ServerItemListDTO.class);
    }
}