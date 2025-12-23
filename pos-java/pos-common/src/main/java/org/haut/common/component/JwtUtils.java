package org.haut.common.component;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import lombok.extern.slf4j.Slf4j;
import org.haut.common.constant.RedisKey;
import org.haut.common.domain.dto.system.AuthInfoDTO;
import org.haut.common.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Slf4j
@Component
public class JwtUtils {
    @Autowired
    private StringRedisTemplate redisTemplate;
    @Autowired
    private BCryptPasswordEncoder encoder;

    /**
     * JWT密钥
     */
    @Value("${spring.security.jwt.key}")
    String key;

    /**
     * JWT过期时间（单位：天）
     */
    @Value("${spring.security.jwt.expire}")
    int expire;



    /**
     * 失效JWT令牌
     * @param headerToken
     * @return 是否失效成功
     */
    public boolean invalidateJwt(String headerToken) {
        //解析请求头中的JWT令牌
        String token = convertToken(headerToken);
        if (token == null) return false;
        Algorithm algorithm = Algorithm.HMAC256(key);
        // 创建JWT验证器
        JWTVerifier jwtVerifier = JWT.require(algorithm).build();
        try {
            //验证JWT令牌是否合法
            DecodedJWT jwt = jwtVerifier.verify(token);
            String jwtId= jwt.getId();
            return deleteToken(jwtId, jwt.getExpiresAt());
        } catch (JWTVerificationException e) {
            return false;
        }
    }

    /**
     * 解析请求头中的JWT令牌
     * @param headerToken
     * @return
     */
    public DecodedJWT resoleJwt(String headerToken) {
        //解析请求头中的JWT令牌
        String token = convertToken(headerToken);
        if (token == null) return null;
        Algorithm algorithm = Algorithm.HMAC256(key);
        // 创建JWT验证器
        JWTVerifier jwtVerifier = JWT.require(algorithm).build();
        try {
            //验证JWT令牌是否合法
            DecodedJWT jwt = jwtVerifier.verify(token);
            // 检查JWT ID是否在黑名单中
            if (isInvalidToken(jwt.getId())) return null;
            // 获取JWT令牌的过期时间
            Date expiresAt = jwt.getExpiresAt();
            return new Date().after(expiresAt) ? null : jwt;
        } catch (JWTVerificationException e) {
            // 如果验证失败，返回null
            return null;
        }
    }

    /**
     * 生成JWT令牌
     *
     * @param userDetails 用户详情
     * @param userId 用户ID
     * @param userCode 用户编号
     * @param orgId 组织ID
     * @return
     */
    public String createJwt(UserDetails userDetails, Long userId, String userCode, Long orgId) {
        //加密算法
        Algorithm algorithm = Algorithm.HMAC256(key);
        Date expire = expireTime();
        return JWT.create()
                .withJWTId(UUID.randomUUID().toString()) // JWT ID
                .withClaim("userId", userId)// 用户ID
                .withClaim("userCode", userCode) // 用户名
                .withClaim("orgId", orgId) // 组织ID
                .withClaim("authorities", userDetails
                        .getAuthorities()
                        .stream()
                        .map(GrantedAuthority::getAuthority).toList()) // 用户权限
                .withExpiresAt(expire)// 过期时间
                .withIssuedAt(new Date())// 签发时间
                .sign(algorithm);//签名
    }

    /**
     * 获取JWT过期时间
     * @return
     */
    public Date expireTime() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.HOUR, expire*24); // 设置过期时间为7天
        return calendar.getTime();
    }

    /**
     * 将DecodedJWT转换为UserDetails对象
     * @param jwt 解析后的JWT令牌
     * @return UserDetails对象
     */
    public UserDetails toUser(DecodedJWT jwt) {
        Map<String, Claim> claims = jwt.getClaims();
        // 从JWT中获取用户ID、用户名和权限
        String username = claims.get("userCode").asString();
        return User
                .withUsername(username)
                .password(encoder.encode("dummyPassword")) // 密码可以是任意值，因为JWT不需要验证密码
                .authorities(claims.get("authorities").asArray(String.class))
                .build();
    }

    public AuthInfoDTO toAuthInfo(DecodedJWT jwt) {
        Map<String, Claim> claims = jwt.getClaims();
        // 从JWT中获取用户ID、用户名和权限
        Long userId = claims.get("userId").asLong();
        Long orgId = claims.get("orgId").asLong();
        if (userId == null || orgId == null) {
            log.warn("JWT令牌中缺少用户ID或组织ID");
            throw new BusinessException("JWT令牌中缺少用户ID或组织ID");
        }
        return AuthInfoDTO.builder()
                .userId(userId)
                .orgId(orgId)
                .build();
    }


    /**
     * 从请求头中获取JWT令牌
     * @param headerToken 请求头中的令牌
     * @return 解析后的JWT令牌
     */
    private String convertToken(String headerToken) {
        //判断请求头是否包含Bearer前缀
        if (headerToken == null || !headerToken.startsWith("Bearer ")) {
//            log.warn("JWT令牌为空或格式不正确");
            return null;
        }
        return headerToken.substring(7);
    }

    private boolean deleteToken(String jwtId, Date expireTime) {
        if (isInvalidToken(jwtId)) return false;
        Date now = new Date();
        // 如果当前时间已经超过过期时间，则不需要设置黑名单
        long expire = Math.max(expireTime.getTime() - now.getTime(), 0);
        redisTemplate.opsForValue().set(RedisKey.JWT_BLACK_LIST + jwtId, "", expire, TimeUnit.MICROSECONDS);
        // 返回true表示设置黑名单成功
        return true;
    }

    /**
     * 检查JWT令牌是否在黑名单中(是否失效)
     * @param jwtId JWT ID
     * @return 如果JWT ID在黑名单中，则返回true，否则返回false
     */
    private boolean isInvalidToken(String jwtId) {
        Boolean isInvalid = redisTemplate.hasKey(RedisKey.JWT_BLACK_LIST + jwtId);
        if (isInvalid) log.info("JWT令牌已失效，ID: {}", jwtId);
        return isInvalid;
    }
}
