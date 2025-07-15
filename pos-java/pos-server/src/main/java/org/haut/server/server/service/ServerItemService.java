package org.haut.server.server.service;

import org.haut.common.domain.dto.server.ServerItemListDTO;
import org.haut.common.domain.query.server.ServerItemListQuery;
import org.haut.server.server.entity.ServerItem;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_item(服务项目)】的数据库操作Service
* @createDate 2025-04-30 09:46:20
*/
public interface ServerItemService extends IService<ServerItem> {

    List<ServerItemListDTO> getList(ServerItemListQuery query);
}
