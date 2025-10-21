package org.haut.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

import java.util.concurrent.Executors;

/**
 * 定时任务配置类
 * 启用Spring的定时任务功能，并配置线程池
 * 
 * @author mhding
 * @version 1.0
 * @since 2025-10-21
 */
@Configuration
@EnableScheduling
public class SchedulingConfig implements SchedulingConfigurer {

    /**
     * 配置定时任务的线程池
     * 使用固定大小的线程池来执行定时任务，避免任务阻塞
     * 
     * @param taskRegistrar 任务注册器
     */
    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        // 设置线程池大小为5，可根据实际需求调整
        taskRegistrar.setScheduler(Executors.newScheduledThreadPool(5));
    }
}