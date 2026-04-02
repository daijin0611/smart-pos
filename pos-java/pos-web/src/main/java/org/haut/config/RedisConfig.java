package org.haut.config;

import io.lettuce.core.ClientOptions;
import io.lettuce.core.SocketOptions;
import io.lettuce.core.TimeoutOptions;
import io.lettuce.core.cluster.ClusterClientOptions;
import io.lettuce.core.cluster.ClusterTopologyRefreshOptions;
import org.springframework.boot.autoconfigure.data.redis.LettuceClientConfigurationBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.*;

import java.time.Duration;

/**
 * Redis配置类
 * 解决连接重置问题的优化配置
 */
@Configuration
public class RedisConfig{

    /**
     * 自定义Lettuce客户端配置
     * 主要解决连接重置和超时问题
     */
    @Bean
    public LettuceClientConfigurationBuilderCustomizer lettuceClientConfigurationBuilderCustomizer() {
        return clientConfigurationBuilder -> {
            // Socket选项配置
            SocketOptions socketOptions = SocketOptions.builder()
                    .keepAlive(true)  // 启用TCP Keep-Alive
                    .tcpNoDelay(true)  // 禁用Nagle算法，减少延迟
                    .connectTimeout(Duration.ofSeconds(10))  // 连接超时
                    .build();

            // 超时选项配置
            TimeoutOptions timeoutOptions = TimeoutOptions.builder()
                    .fixedTimeout(Duration.ofSeconds(10))  // 固定超时时间
                    .build();

            // 集群拓扑刷新选项
            ClusterTopologyRefreshOptions topologyRefreshOptions = ClusterTopologyRefreshOptions.builder()
                    .enablePeriodicRefresh(Duration.ofSeconds(30))  // 定期刷新拓扑
                    .enableAllAdaptiveRefreshTriggers()  // 启用所有自适应刷新触发器
                    .adaptiveRefreshTriggersTimeout(Duration.ofSeconds(30))  // 自适应刷新超时
                    .build();

            // 客户端选项配置
            ClientOptions clientOptions = ClusterClientOptions.builder()
                    .socketOptions(socketOptions)
                    .timeoutOptions(timeoutOptions)
                    .topologyRefreshOptions(topologyRefreshOptions)
                    .autoReconnect(true)  // 自动重连
                    .pingBeforeActivateConnection(true)  // 激活连接前ping
                    .disconnectedBehavior(ClientOptions.DisconnectedBehavior.REJECT_COMMANDS)  // 断开连接时拒绝命令
                    .build();

            clientConfigurationBuilder
                    .clientOptions(clientOptions)
                    .commandTimeout(Duration.ofSeconds(10));
        };
    }

    /**
     * 配置RedisTemplate
     * 优化序列化器配置
     */
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(connectionFactory);
        
        // 使用String序列化器作为key的序列化器
        StringRedisSerializer stringRedisSerializer = new StringRedisSerializer();
        redisTemplate.setKeySerializer(stringRedisSerializer);
        redisTemplate.setHashKeySerializer(stringRedisSerializer);
        
        // 使用JSON序列化器作为value的序列化器（更高效且可读性好）
        GenericJackson2JsonRedisSerializer jsonRedisSerializer = new GenericJackson2JsonRedisSerializer();
        redisTemplate.setValueSerializer(jsonRedisSerializer);
        redisTemplate.setHashValueSerializer(jsonRedisSerializer);
        
        // 启用事务支持
        redisTemplate.setEnableTransactionSupport(true);
        
        redisTemplate.afterPropertiesSet();
        return redisTemplate;
    }

}