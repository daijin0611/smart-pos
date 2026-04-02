package org.haut.server.server.service;

import org.haut.common.domain.dto.server.PackageInfoDTO;
import org.haut.common.domain.dto.server.PackageListDTO;
import org.haut.common.domain.query.server.ServerPackageListQuery;
import org.haut.server.server.entity.ServerPackage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Cdh
* @description 针对表【server_package(服务套餐表)】的数据库操作Service
* @createDate 2025-05-12 15:30:31
*/
public interface ServerPackageService extends IService<ServerPackage> {

    List<PackageListDTO> getPackageList(ServerPackageListQuery query);

    PackageInfoDTO getPackageInfoById(Long id);

    void savePackage(PackageInfoDTO packageInfo);

    void updatePackage(PackageInfoDTO packageInfo);
}
