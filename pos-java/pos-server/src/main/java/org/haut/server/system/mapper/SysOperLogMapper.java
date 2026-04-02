package org.haut.server.system.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.haut.server.system.entity.SysOperLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

@Mapper
public interface SysOperLogMapper extends BaseMapper<SysOperLog> {
}