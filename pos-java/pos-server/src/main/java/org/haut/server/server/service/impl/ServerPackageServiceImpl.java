
package org.haut.server.server.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.server.PackageDetailDTO;
import org.haut.common.domain.dto.server.PackageInfoDTO;
import org.haut.common.domain.dto.server.PackageListDTO;
import org.haut.common.domain.query.server.ServerPackageListQuery;
import org.haut.server.server.entity.ServerPackage;
import org.haut.server.server.entity.ServerPackageDetail;
import org.haut.server.server.mapper.ServerPackageDetailMapper;
import org.haut.server.server.mapper.ServerPackageMapper;
import org.haut.server.server.service.ServerPackageService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import static com.baomidou.mybatisplus.core.toolkit.IdWorker.getId;

@Service
public class ServerPackageServiceImpl extends ServiceImpl<ServerPackageMapper, ServerPackage>
        implements ServerPackageService {

    @Autowired
    private ServerPackageDetailMapper packageDetailMapper;

    // 1. 列表模糊查询（含关联详情）
    @Override
    public List<PackageListDTO> getPackageList(ServerPackageListQuery query) {
        // 构建主表查询条件
        QueryWrapper<ServerPackage> wrapper = new QueryWrapper<>();
        wrapper.like(query.getPackageName() != null, "package_name", query.getPackageName())
                .like(query.getPackageEncode() != null, "package_encode", query.getPackageEncode());

        // 查询主表
        List<ServerPackage> packageEntities = baseMapper.selectList(wrapper);
        if (packageEntities.isEmpty()) {
            return List.of();
        }

        // 批量查询详情表（通过 packageId 关联）
        List<Long> packageIds = packageEntities.stream().map(ServerPackage::getId).collect(Collectors.toList());
        QueryWrapper<ServerPackageDetail> detailWrapper = new QueryWrapper<>();
        detailWrapper.in("package_id", packageIds);
        List<ServerPackageDetail> detailEntities = packageDetailMapper.selectList(detailWrapper);

        // 组装结果（主表 + 详情）
        return packageEntities.stream().map(pkg -> {
            PackageListDTO dto = new PackageListDTO();
            BeanUtils.copyProperties(pkg, dto);

            // 过滤当前套餐的详情
            List<ServerPackageDetail> currentDetails = detailEntities.stream()
                    .filter(detail -> detail.getPackageId().equals(pkg.getId()))
                    .collect(Collectors.toList());

            // 转换为 DetailDTO（假设 PackageDetailDTO 与 ServerPackageDetail 字段对应）
            List<PackageDetailDTO> detailDTOList = currentDetails.stream()
                    .map(detail -> BeanUtil.toBean(detail, PackageDetailDTO.class))
                    .collect(Collectors.toList());

            dto.setPackageDetailDTOList(detailDTOList);
            return dto;
        }).collect(Collectors.toList());
    }

    // 2. 详情查询（通过ID，含关联详情）
    @Override
    public PackageInfoDTO getPackageInfoById(Long id) {
        // 查询主表
        ServerPackage packageEntity = baseMapper.selectById(id);
        if (packageEntity == null) {
            return null;
        }

        // 查询详情表
        QueryWrapper<ServerPackageDetail> detailWrapper = new QueryWrapper<>();
        detailWrapper.eq("package_id", id);
        List<ServerPackageDetail> detailEntities = packageDetailMapper.selectList(detailWrapper);

        // 组装详情DTO
        PackageInfoDTO infoDTO = new PackageInfoDTO();
        BeanUtils.copyProperties(packageEntity, infoDTO);
        infoDTO.setPackageDetailDTOList(detailEntities.stream()
                .map(detail -> BeanUtil.toBean(detail, PackageDetailDTO.class))
                .collect(Collectors.toList()));
        return infoDTO;
    }

    // 3. 新增套餐（含详情）- 事务保障一致性
    @Override
    @Transactional
    public void savePackage(PackageInfoDTO packageInfo) {
        // 1. 保存主表
        ServerPackage packageEntity = BeanUtil.toBean(packageInfo, ServerPackage.class);
        packageEntity.setCreateTime(new Date());
        baseMapper.insert(packageEntity);
        Long packageId = packageEntity.getId();

        // 2. 保存详情表（支持一对多，遍历列表）
        List<PackageDetailDTO> detailList = packageInfo.getPackageDetailDTOList();
        if (detailList != null && !detailList.isEmpty()) {
            detailList.forEach(detail -> {
                ServerPackageDetail detailEntity = BeanUtil.toBean(detail, ServerPackageDetail.class);
                detailEntity.setPackageId(packageId);
                detailEntity.setCreateTime(new Date());
                packageDetailMapper.insert(detailEntity);
            });
        }
    }

    // 4. 修改套餐（含详情）- 先删后增，确保数据一致性
    @Override
    @Transactional
    public void updatePackage(PackageInfoDTO packageInfo) {
        Long packageId = packageInfo.getId();
        // 1. 校验主表是否存在
        ServerPackage existPackage = baseMapper.selectById(packageId);
        if (existPackage == null) {
            throw new IllegalArgumentException("套餐不存在");
        }

        // 2. 更新主表
        ServerPackage updateEntity = BeanUtil.toBean(packageInfo, ServerPackage.class);
        updateEntity.setUpdateTime(new Date());
        baseMapper.updateById(updateEntity);

        // 3. 更新详情表（先删除旧数据，再插入新数据）
        QueryWrapper<ServerPackageDetail> deleteWrapper = new QueryWrapper<>();
        deleteWrapper.eq("package_id", packageId);
        packageDetailMapper.delete(deleteWrapper);  // 删除旧详情

        // 插入新详情
        List<PackageDetailDTO> detailList = packageInfo.getPackageDetailDTOList();
        if (detailList != null && !detailList.isEmpty()) {
            detailList.forEach(detail -> {
                ServerPackageDetail detailEntity = BeanUtil.toBean(detail, ServerPackageDetail.class);
                detailEntity.setPackageId(packageId);
                detailEntity.setUpdateTime(new Date());
                packageDetailMapper.insert(detailEntity);
            });
        }
    }
}