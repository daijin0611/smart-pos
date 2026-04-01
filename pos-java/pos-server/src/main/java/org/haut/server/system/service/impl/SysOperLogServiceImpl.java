package org.haut.server.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.domain.query.system.OperLogQuery;
import org.haut.common.domain.vo.system.SysOperLogVO;
import org.haut.common.utils.AuthContextHolder;
import org.haut.server.system.entity.SysOperLog;
import org.haut.server.system.mapper.SysOperLogMapper;
import org.haut.server.system.service.SysOperLogService;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SysOperLogServiceImpl extends ServiceImpl<SysOperLogMapper, SysOperLog>
        implements SysOperLogService {

    private final SysOperLogMapper sysOperLogMapper;

    @Async
    @Override
    public void saveLog(SysOperLog sysOperLog) {
        this.save(sysOperLog);
    }

    @Override
    public PageDTO<SysOperLogVO> queryPage(OperLogQuery query) {
        AuthInfoDTO auth = AuthContextHolder.getAuth();
        LambdaQueryWrapper<SysOperLog> queryWrapper = Wrappers.lambdaQuery(SysOperLog.class)
                .eq(auth.getOrgId() != null, SysOperLog::getOrgId, auth.getOrgId())
                .eq(StringUtils.isNotBlank(query.getModule()), SysOperLog::getModule, query.getModule())
                .like(StringUtils.isNotBlank(query.getOperatorName()), SysOperLog::getOperatorName, query.getOperatorName())
                .eq(query.getStatus() != null, SysOperLog::getStatus, query.getStatus())
                .gt(query.getStartTime() != null, SysOperLog::getCreateTime, query.getStartTime())
                .lt(query.getEndTime() != null, SysOperLog::getCreateTime, query.getEndTime())
                .orderByDesc(SysOperLog::getCreateTime);
        Page<SysOperLog> page = new Page<>(query.getPageNum(), query.getPageSize());
        this.page(page, queryWrapper);
        return PageDTO.create(page, SysOperLogVO.class);
    }
}