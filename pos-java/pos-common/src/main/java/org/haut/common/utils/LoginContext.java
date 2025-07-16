package org.haut.common.utils;

import org.haut.common.domain.dto.system.LoginInfoDTO;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
public class LoginContext {

    private static final ThreadLocal<LoginInfoDTO> currentUser = new ThreadLocal<>();

    public static void setCurrentUser(LoginInfoDTO info) {
        currentUser.set(info);
    }

    public static LoginInfoDTO getCurrentUser() {
        return currentUser.get();
    }

    public static void clearCurrentUser() {
        currentUser.remove();
    }
}
