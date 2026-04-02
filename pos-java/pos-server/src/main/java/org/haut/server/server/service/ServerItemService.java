package org.haut.server.server.service;

import org.haut.common.domain.dto.server.ServerItemCreateDTO;
import org.haut.common.domain.dto.server.ServerItemUpdateDTO;
import org.haut.common.domain.query.server.ServerItemQuery;
import org.haut.server.server.entity.ServerItem;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.vo.server.ServerItemVO;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_item(服务项目)】的数据库操作Service
* @createDate 2025-04-30 09:46:20
*/
public interface ServerItemService extends IService<ServerItem> {

    List<ServerItemVO> getList(ServerItemQuery query);

    ServerItemVO queryById(Long id);

    void addServerItem(ServerItemCreateDTO item);

    void updateServerItem(ServerItemUpdateDTO item);
}
