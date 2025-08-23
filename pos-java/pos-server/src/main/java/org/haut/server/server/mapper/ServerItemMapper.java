package org.haut.server.server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.server.server.entity.ServerItem;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
* @author Cdh
* @description 针对表【server_item(服务项目)】的数据库操作Mapper
* @createDate 2025-04-30 09:46:20
* @Entity org.haut.server.server.entity.ServerItem
*/
@Mapper
public interface ServerItemMapper extends BaseMapper<ServerItem> {

}




