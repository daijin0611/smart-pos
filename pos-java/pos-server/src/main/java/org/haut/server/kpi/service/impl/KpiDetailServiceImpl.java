package org.haut.server.kpi.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.kpi.KpiDetailCreateDTO;
import org.haut.server.kpi.entity.KpiDetail;
import org.haut.server.kpi.service.KpiDetailService;
import org.haut.server.kpi.mapper.KpiDetailMapper;
import org.springframework.stereotype.Service;

/**
* @author daiji
* @description 针对表【kpi_detail(业绩明细)】的数据库操作Service实现
* @createDate 2025-08-25 16:35:17
*/
@Service
public class KpiDetailServiceImpl extends ServiceImpl<KpiDetailMapper, KpiDetail>
    implements KpiDetailService{

    /**
     * 创建业绩明细
     * @param dto 创建参数
     */
    @Override
    public void createKpiDetail(KpiDetailCreateDTO dto) {

    }
}




