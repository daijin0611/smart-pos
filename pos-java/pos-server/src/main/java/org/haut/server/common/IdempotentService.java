package org.haut.server.common;

import jakarta.servlet.http.HttpServletRequest;
import org.haut.common.domain.vo.JsonVO;

/**
 * 幂等性服务
 */
public interface IdempotentService {
    /**
     * 创建token
     * @return token
     */
    String createToken();

    /**
     * 校验token
     * @param request 请求参数
     * @return 校验结果
     */
    String checkToken(HttpServletRequest request);
}
