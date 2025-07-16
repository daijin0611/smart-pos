package org.haut.server.system.utils;

import org.haut.server.system.entity.SysUser;

public class UserContext {

    private static final ThreadLocal<SysUser> currentUser = new ThreadLocal<>();

    public static void setCurrentUser(SysUser user) {
        currentUser.set(user);
    }

    public static SysUser getCurrentUser() {
        return currentUser.get();
    }

    public static void clearCurrentUser() {
        currentUser.remove();
    }
} 