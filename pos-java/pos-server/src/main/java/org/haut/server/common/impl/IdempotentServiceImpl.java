package org.haut.server.common.impl;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.haut.common.constant.RedisKey;
import org.haut.common.domain.vo.ResultStatus;
import org.haut.common.exception.BusinessException;
import org.haut.common.exception.IdempotentException;
import org.haut.server.common.IdempotentService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
@EnableConfigurationProperties
public class IdempotentServiceImpl implements IdempotentService {

    private final StringRedisTemplate redisTemplate;

    /**
     * 幂等性令牌有效期
     */
    @Value("${idempotent.timeout}")
    private Long timeout;

    /**
     * 创建幂等令牌
     * @return
     */
    @Override
    public String createToken() {
        String uuid = UUID.randomUUID().toString().replace("-", "");
        String key = String.format(RedisKey.IDEMPOTENT, uuid);
        redisTemplate.opsForValue().set(key, "1", timeout, TimeUnit.MINUTES);
        return uuid;
    }

    /**
     * 校验幂等令牌
     * @param request 请求参数
     * @return
     */
    @Override
    public String checkToken(HttpServletRequest request) {
        String token = request.getParameter("token");
        if (StringUtils.isBlank(token)){
            // 没有token，参数异常错误
            throw new IdempotentException(ResultStatus.PARAMS_INVALID.getMessage(),ResultStatus.PARAMS_INVALID.getCode());
        }
        if (redisTemplate.opsForValue().get(String.format(RedisKey.IDEMPOTENT, token)) == null){
            // token不存在，说明已经处理过了，抛出重复请求异常
            throw new IdempotentException(ResultStatus.REPETITIVE_OPERATION.getMessage(),ResultStatus.REPETITIVE_OPERATION.getCode());
        }
        // 将token进行删除
        Boolean deleted = redisTemplate.delete(String.format(RedisKey.IDEMPOTENT, token));
        //如果删除失败，说明token已经处理过了，抛出重复请求异常
        if (!deleted){
            throw new IdempotentException(ResultStatus.REPETITIVE_OPERATION.getMessage(),ResultStatus.REPETITIVE_OPERATION.getCode());
        }
        return ResultStatus.SUCCESS.getMessage();
    }
}
