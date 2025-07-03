package org.haut.common.utils;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@Component
public class JwtUtils {

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
            DecodedJWT verify = jwtVerifier.verify(token);
            // 获取JWT令牌的过期时间
            Date expiresAt = verify.getExpiresAt();
            return new Date().after(expiresAt) ? null : verify;
        } catch (JWTVerificationException e) {
            // 如果验证失败，返回null
            return null;
        }
    }

    /**
     * 生成JWT令牌
     * @param userDetails
     * @param id
     * @param username
     * @return
     */
    public String createJwt(UserDetails userDetails, int id, String username) {
        //加密算法
        Algorithm algorithm = Algorithm.HMAC256(key);
        Date expire = expireTime();
        return JWT.create()
                .withClaim("id", id)// 用户ID
                .withClaim("username", username) // 用户名
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
        String username = claims.get("username").asString();
        int id = claims.get("id").asInt();
        String password = claims.get("password").asString();
        return User
                .withUsername(username)
                .password("******")
                .authorities(claims.get("authorities").asArray(String.class))
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
            return null;
        }
        return headerToken.substring(7);
    }
}
