package org.haut.server.system.service;

import org.haut.server.system.entity.SysDictItem;
import org.haut.common.domain.dto.system.DictItemCreateDTO;
import org.haut.common.domain.dto.system.DictItemUpdateDTO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author daiji
* @description 针对表【sys_dict_item(系统字典内容表)】的数据库操作Service
* @createDate 2025-07-21 10:30:12
*/
public interface SysDictItemService extends IService<SysDictItem> {

    /**
     * 新增字典项
     * @param dto 字典项新增DTO
     */
    void addDictItem(DictItemCreateDTO dto);

    /**
     * 修改字典项
     * @param dto 字典项修改DTO
     */
    void updateDictItem(DictItemUpdateDTO dto);

}
