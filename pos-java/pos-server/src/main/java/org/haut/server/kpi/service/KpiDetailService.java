package org.haut.server.kpi.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.kpi.KpiDetailCreateDTO;
import org.haut.common.domain.query.kpi.KpiListQuery;
import org.haut.common.domain.vo.kpi.KpiListVO;
import org.haut.server.kpi.entity.KpiDetail;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author daiji
* @description 针对表【kpi_detail(业绩明细)】的数据库操作Service
* @createDate 2025-08-25 16:35:17
*/
public interface KpiDetailService extends IService<KpiDetail> {

    boolean createKpiDetail(KpiDetailCreateDTO kpiDetailCreateDTO);

    /**
     * 获取员工业绩明细分页列表
     *
     * @param query 查询条件
     * @return KPI分页列表
     */
    PageDTO<KpiListVO> getKpiList(KpiListQuery query);
}
