package org.haut;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;

@SpringBootTest
@Slf4j
public class RedisTest {

    @Autowired
    private RedisTemplate redisTemplate;

    @Test
    public void testRedis() {
        // 测试Redis连接
        redisTemplate.opsForValue().set("testKey", "testValue");
        String value = (String) redisTemplate.opsForValue().get("testKey");
        log.info("Redis连接测试：{}", value);
    }


}
