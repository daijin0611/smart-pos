package org.haut.server.kpi.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.kpi.KpiDetailCreateDTO;
import org.haut.common.domain.query.kpi.KpiListQuery;
import org.haut.common.domain.vo.kpi.KpiListVO;
import org.haut.server.kpi.entity.KpiDetail;
import org.haut.server.kpi.service.KpiDetailService;
import org.haut.server.kpi.mapper.KpiDetailMapper;
import org.springframework.beans.BeanUtils;
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
     * @param kpiDetailCreateDTO 创建参数
     */
    @Override
    public boolean createKpiDetail(KpiDetailCreateDTO kpiDetailCreateDTO) {
        KpiDetail kpiDetail = new KpiDetail();
        BeanUtils.copyProperties(kpiDetailCreateDTO, kpiDetail);
        return this.save(kpiDetail);
    }

    @Override
    public PageDTO<KpiListVO> getKpiList(KpiListQuery query) {
        //处理空指针异常
        int pageNum = (query.getPageNum() == null || query.getPageNum() <= 0) ? 1 : query.getPageNum();
        int pageSize = (query.getPageSize() == null || query.getPageSize() <= 0) ? 20 : query.getPageSize();

        Page<KpiListVO> page = new Page<>(pageNum, pageSize);

        //调用Mapper方法，接收返回的IPage对象
        IPage<KpiListVO> iPage = baseMapper.selectKpiList(page, query);

        //直接调用静态方法create来创建并返回 PageDTO
        return PageDTO.create((Page<KpiListVO>) iPage);
    }
}




