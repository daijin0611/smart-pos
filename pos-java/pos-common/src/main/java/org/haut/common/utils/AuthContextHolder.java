package org.haut.common.utils;

import org.haut.common.domain.dto.system.AuthInfoDTO;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
public class AuthContextHolder {

    private static final ThreadLocal<AuthInfoDTO> currentUser = new ThreadLocal<>();

    public static void setAuth(AuthInfoDTO info) {
        currentUser.set(info);
    }

    public static AuthInfoDTO getAuth() {
        return currentUser.get();
    }

    public static void clearAuth() {
        currentUser.remove();
    }
}
