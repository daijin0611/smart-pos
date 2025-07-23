package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.hutool.core.bean.BeanUtil;
import org.haut.common.constant.DictConst;
import org.haut.server.system.entity.SysDictType;
import org.haut.server.system.entity.SysDictItem;
import org.haut.server.system.service.SysDictTypeService;
import org.haut.server.system.service.SysDictItemService;
import org.haut.server.system.mapper.SysDictTypeMapper;
import org.haut.common.domain.vo.system.DictTypeVO;
import org.haut.common.domain.vo.system.DictItemVO;
import org.haut.common.domain.dto.system.DictTypeCreateDTO;
import org.haut.common.domain.dto.system.DictTypeUpdateDTO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;
import org.haut.common.domain.query.system.DictListQuery;
import org.apache.commons.lang3.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
* @author daiji
* @description 针对表【sys_dict_type(系统字典类型表)】的数据库操作Service实现
* @createDate 2025-07-21 10:30:12
*/
@Service
@RequiredArgsConstructor
public class SysDictTypeServiceImpl extends ServiceImpl<SysDictTypeMapper, SysDictType>
    implements SysDictTypeService{

    private final SysDictItemService sysDictItemService;

    @Override
    public List<DictTypeVO> getDictList(DictListQuery query) {
        // 查询所有字典类型
        LambdaQueryWrapper<SysDictType> typeWrapper = Wrappers.lambdaQuery(SysDictType.class)
                .like(StringUtils.isNotBlank(query.getDictCode()),SysDictType::getDictCode, query.getDictCode())
                .like(StringUtils.isNotBlank(query.getDictName()),SysDictType::getDictName, query.getDictName())
                .orderByAsc(SysDictType::getSort);
        List<SysDictType> dictTypes = this.list(typeWrapper);

        // 转换为VO并设置字典项列表
        return dictTypes.stream().map(dictType -> {
            DictTypeVO dictTypeVO = BeanUtil.copyProperties(dictType, DictTypeVO.class);
            dictTypeVO.setDictTypeId(dictType.getId());
            
            // 查询该字典类型下的所有字典项
            LambdaQueryWrapper<SysDictItem> itemWrapper = Wrappers.lambdaQuery(SysDictItem.class)
                    .eq(SysDictItem::getDictCode, dictType.getDictCode())
                    .orderByAsc(SysDictItem::getSort);
            List<SysDictItem> dictItems = sysDictItemService.list(itemWrapper);
            
            // 转换字典项为VO
            List<DictItemVO> dictItemVOs = dictItems.stream().map(item -> {
                DictItemVO itemVO = BeanUtil.copyProperties(item, DictItemVO.class);
                itemVO.setDictItemId(item.getId());
                return itemVO;
            }).collect(Collectors.toList());
            
            dictTypeVO.setDictItems(dictItemVOs);
            return dictTypeVO;
        }).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void addDictType(DictTypeCreateDTO dto) {
        // 检查字典编码是否已存在
        LambdaQueryWrapper<SysDictType> wrapper = Wrappers.lambdaQuery(SysDictType.class)
                .eq(SysDictType::getDictCode, dto.getDictCode());
        if (this.count(wrapper) > 0) {
            throw new IllegalArgumentException(DictConst.DICT_CODE_EXISTS);
        }

        // 创建字典类型实体
        SysDictType dictType = BeanUtil.copyProperties(dto, SysDictType.class);
        dictType.setCreateTime(new Date());
        dictType.setUpdateTime(new Date());
        
        // 保存到数据库
        this.save(dictType);
    }

    @Override
    @Transactional
    public void updateDictType(DictTypeUpdateDTO dto) {
        // 检查字典类型是否存在
        SysDictType existingDictType = this.getById(dto.getDictTypeId());
        if (existingDictType == null) {
            throw new IllegalArgumentException(DictConst.DICT_TYPE_NOT_FOUND);
        }

        // 检查字典编码是否已被其他字典类型使用
        LambdaQueryWrapper<SysDictType> wrapper = Wrappers.lambdaQuery(SysDictType.class)
                .eq(SysDictType::getDictCode, dto.getDictCode())
                .ne(SysDictType::getId, dto.getDictTypeId());
        if (this.count(wrapper) > 0) {
            throw new IllegalArgumentException(DictConst.DICT_CODE_EXISTS);
        }

        // 更新字典类型实体
        SysDictType dictType = BeanUtil.copyProperties(dto, SysDictType.class);
        dictType.setId(dto.getDictTypeId());
        dictType.setUpdateTime(new Date());
        
        // 更新到数据库
        this.updateById(dictType);

        // 如果字典编码发生变化，需要同步更新所有关联的字典项
        if (!existingDictType.getDictCode().equals(dto.getDictCode())) {
            LambdaQueryWrapper<SysDictItem> itemWrapper = Wrappers.lambdaQuery(SysDictItem.class)
                    .eq(SysDictItem::getDictCode, existingDictType.getDictCode());
            List<SysDictItem> dictItems = sysDictItemService.list(itemWrapper);
            
            for (SysDictItem item : dictItems) {
                item.setDictCode(dto.getDictCode());
                item.setUpdateTime(new Date());
            }
            
            if (!dictItems.isEmpty()) {
                sysDictItemService.updateBatchById(dictItems);
            }
        }
    }

}




