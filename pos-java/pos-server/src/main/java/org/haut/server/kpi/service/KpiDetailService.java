package org.haut.server.kpi.service;

import org.haut.common.domain.dto.kpi.KpiDetailCreateDTO;
import org.haut.server.kpi.entity.KpiDetail;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author daiji
* @description 针对表【kpi_detail(业绩明细)】的数据库操作Service
* @createDate 2025-08-25 16:35:17
*/
public interface KpiDetailService extends IService<KpiDetail> {

    void createKpiDetail(KpiDetailCreateDTO dto);
}
