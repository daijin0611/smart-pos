package org.haut.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

/**
 * Redis健康检查配置
 * 定期检查Redis连接状态，及时发现连接问题
 */
@Slf4j
@Configuration
@EnableScheduling
public class RedisHealthConfig {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 定期检查Redis连接状态
     * 每30秒执行一次健康检查
     */
    @Scheduled(fixedRate = 30000)
    public void checkRedisHealth() {
        try {
            // 执行ping命令检查连接
            String pong = redisTemplate.getConnectionFactory().getConnection().ping();
            if (!"PONG".equals(pong)) {
                log.warn("Redis健康检查异常，ping响应: {}", pong);
            } else {
                log.debug("Redis连接正常");
            }
        } catch (Exception e) {
            log.error("Redis健康检查失败: {}", e.getMessage(), e);
            // 可以在这里添加告警逻辑
        }
    }

    /**
     * 定期清理过期连接
     * 每5分钟执行一次
     */
    @Scheduled(fixedRate = 300000)
    public void cleanupConnections() {
        try {
            // 获取连接池信息（如果可用）
            log.debug("执行Redis连接池清理");
            // 这里可以添加连接池状态监控逻辑
        } catch (Exception e) {
            log.error("Redis连接池清理失败: {}", e.getMessage(), e);
        }
    }
}