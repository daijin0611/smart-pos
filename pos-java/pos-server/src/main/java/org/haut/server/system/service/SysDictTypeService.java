package org.haut.server.system.service;

import org.haut.server.system.entity.SysDictType;
import org.haut.common.domain.vo.system.DictTypeVO;
import org.haut.common.domain.dto.system.DictTypeCreateDTO;
import org.haut.common.domain.dto.system.DictTypeUpdateDTO;
import com.baomidou.mybatisplus.extension.service.IService;
import org.haut.common.domain.query.system.DictListQuery;

import java.util.List;

/**
* @author daiji
* @description 针对表【sys_dict_type(系统字典类型表)】的数据库操作Service
* @createDate 2025-07-21 10:30:12
*/
public interface SysDictTypeService extends IService<SysDictType> {

    /**
     * 获取字典列表（包含字典项）
     * @return 字典列表
     */
    List<DictTypeVO> getDictList(DictListQuery query);


    /**
     * 新增字典类型
     * @param dto 字典类型新增DTO
     */
    void addDictType(DictTypeCreateDTO dto);

    /**
     * 修改字典类型
     * @param dto 字典类型修改DTO
     */
    void updateDictType(DictTypeUpdateDTO dto);

}
