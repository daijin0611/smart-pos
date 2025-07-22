package org.haut.common.utils;

import org.haut.common.domain.dto.system.UserDTO;

/**
 * 用户上下文持有者，用于在当前线程中存储和获取用户信息
 * @author 丁铭瀚
 * @version 1.0
 */
public class UserContextHolder {

    private static final ThreadLocal<UserDTO> user = new ThreadLocal<UserDTO>();

    public static void setUser(UserDTO userDTO) {
        user.set(userDTO);
    }

    public static UserDTO getUser() {
        return user.get();
    }

    public static void clearUser() {
        user.remove();
    }
}
