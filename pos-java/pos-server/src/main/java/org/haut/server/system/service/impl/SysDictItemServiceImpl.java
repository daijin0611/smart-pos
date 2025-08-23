package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.hutool.core.bean.BeanUtil;
import org.haut.server.system.entity.SysDictItem;
import org.haut.server.system.entity.SysDictType;
import org.haut.server.system.service.SysDictItemService;
import org.haut.server.system.mapper.SysDictItemMapper;
import org.haut.server.system.mapper.SysDictTypeMapper;
import org.haut.common.domain.dto.system.DictItemCreateDTO;
import org.haut.common.domain.dto.system.DictItemUpdateDTO;
import org.haut.common.domain.vo.system.DictItemVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;
import org.haut.common.constant.DictConst;

import java.util.Date;
import java.util.List;

/**
* @author daiji
* @description 针对表【sys_dict_item(系统字典内容表)】的数据库操作Service实现
* @createDate 2025-07-21 10:30:12
*/
@Service
@RequiredArgsConstructor
public class SysDictItemServiceImpl extends ServiceImpl<SysDictItemMapper, SysDictItem>
    implements SysDictItemService{

    private final SysDictTypeMapper sysDictTypeMapper;

    @Override
    @Transactional
    public void addDictItem(DictItemCreateDTO dto) {
        // 检查关联的字典类型是否存在
        LambdaQueryWrapper<SysDictType> typeWrapper = Wrappers.lambdaQuery(SysDictType.class)
                .eq(SysDictType::getDictCode, dto.getDictCode());
        if (sysDictTypeMapper.selectCount(typeWrapper) == 0) {
            throw new IllegalArgumentException(DictConst.DICT_TYPE_NOT_FOUND);
        }

        // 检查字典项标签在同一字典类型下是否已存在
        LambdaQueryWrapper<SysDictItem> wrapper = Wrappers.lambdaQuery(SysDictItem.class)
                .eq(SysDictItem::getDictCode, dto.getDictCode())
                .eq(SysDictItem::getItemLabel, dto.getItemLabel());
        if (this.count(wrapper) > 0) {
            throw new IllegalArgumentException(DictConst.DICT_ITEM_LABEL_EXISTS);
        }

        // 创建字典项实体
        SysDictItem dictItem = BeanUtil.copyProperties(dto, SysDictItem.class);
        dictItem.setCreateTime(new Date());
        dictItem.setUpdateTime(new Date());
        
        // 保存到数据库
        this.save(dictItem);
    }

    @Override
    @Transactional
    public void updateDictItem(DictItemUpdateDTO dto) {
        // 检查字典项是否存在
        SysDictItem existingDictItem = this.getById(dto.getDictItemId());
        if (existingDictItem == null) {
            throw new IllegalArgumentException(DictConst.DICT_ITEM_NOT_FOUND);
        }

        // 检查关联的字典类型是否存在
        LambdaQueryWrapper<SysDictType> typeWrapper = Wrappers.lambdaQuery(SysDictType.class)
                .eq(SysDictType::getDictCode, dto.getDictCode());
        if (sysDictTypeMapper.selectCount(typeWrapper) == 0) {
            throw new IllegalArgumentException(DictConst.DICT_TYPE_NOT_FOUND);
        }

        // 检查字典项标签在同一字典类型下是否已被其他字典项使用
        LambdaQueryWrapper<SysDictItem> wrapper = Wrappers.lambdaQuery(SysDictItem.class)
                .eq(SysDictItem::getDictCode, dto.getDictCode())
                .eq(SysDictItem::getItemLabel, dto.getItemLabel())
                .ne(SysDictItem::getId, dto.getDictItemId());
        if (this.count(wrapper) > 0) {
            throw new IllegalArgumentException(DictConst.DICT_ITEM_LABEL_EXISTS);
        }

        // 更新字典项实体
        SysDictItem dictItem = BeanUtil.copyProperties(dto, SysDictItem.class);
        dictItem.setId(dto.getDictItemId());
        dictItem.setUpdateTime(new Date());
        
        // 更新到数据库
        this.updateById(dictItem);
    }

    @Override
    public List<DictItemVO> queryItemsByDictCode(String dictCode) {
        // 检查字典类型是否存在
        LambdaQueryWrapper<SysDictType> typeWrapper = Wrappers.lambdaQuery(SysDictType.class)
                .eq(SysDictType::getDictCode, dictCode);
        if (sysDictTypeMapper.selectCount(typeWrapper) == 0) {
            throw new IllegalArgumentException(DictConst.DICT_TYPE_NOT_FOUND);
        }

        // 查询该字典类型下的所有字典项
        LambdaQueryWrapper<SysDictItem> wrapper = Wrappers.lambdaQuery(SysDictItem.class)
                .eq(SysDictItem::getDictCode, dictCode)
                .orderByAsc(SysDictItem::getSort);
        List<SysDictItem> dictItems = this.list(wrapper);

        // 转换为VO
        return dictItems.stream().map(dictItem -> {
            DictItemVO dictItemVO = BeanUtil.copyProperties(dictItem, DictItemVO.class);
            dictItemVO.setDictItemId(dictItem.getId());
            return dictItemVO;
        }).toList();
    }

}




