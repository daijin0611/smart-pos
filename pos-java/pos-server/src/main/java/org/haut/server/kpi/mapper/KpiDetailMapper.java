package org.haut.server.kpi.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.lettuce.core.dynamic.annotation.Param;
import org.haut.common.domain.query.kpi.KpiListQuery;
import org.haut.common.domain.query.kpi.KpiSummaryQuery;
import org.haut.common.domain.vo.kpi.KpiListVO;
import org.haut.common.domain.vo.kpi.KpiSummaryVO;
import org.haut.server.kpi.entity.KpiDetail;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author daiji
* @description 针对表【kpi_detail(业绩明细)】的数据库操作Mapper
* @createDate 2025-08-25 16:35:17
* @Entity org.haut.server.kpi.entity.KpiDetail
*/
public interface KpiDetailMapper extends BaseMapper<KpiDetail> {

    /**
     * 返回值 IPage<KpiListVO>
     * 根据条件查询员工业绩明细列表（分页）
     *
     * @param page 分页参数
     * @param query 查询条件
     * @return KPI分页列表
     */
    IPage<KpiListVO> selectKpiList(Page<KpiListVO> page, @Param("query") KpiListQuery query);

    /**
     * 获取绩效总结统计数据
     *
     * @param query 查询条件
     * @return 绩效总结列表
     */
    List<KpiSummaryVO> selectKpiSummary(@Param("query") KpiSummaryQuery query);

}




