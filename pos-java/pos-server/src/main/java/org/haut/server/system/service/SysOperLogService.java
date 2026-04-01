package org.haut.server.system.service;

import org.haut.common.domain.dto.PageDTO;
import org.haut.common.domain.query.system.OperLogQuery;
import org.haut.common.domain.vo.system.SysOperLogVO;
import org.haut.server.system.entity.SysOperLog;
import com.baomidou.mybatisplus.extension.service.IService;

public interface SysOperLogService extends IService<SysOperLog> {

    /**
     * 异步保存操作日志
     */
    void saveLog(SysOperLog sysOperLog);

    /**
     * 分页查询操作日志
     */
    PageDTO<SysOperLogVO> queryPage(OperLogQuery query);
}