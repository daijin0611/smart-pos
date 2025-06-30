package org.haut.common.utils;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.xml.crypto.Data;
import java.time.Instant;
import java.util.Calendar;
import java.util.Date;

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

    public Date expireTime() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.HOUR, expire*24); // 设置过期时间为7天
        return calendar.getTime();
    }
}
