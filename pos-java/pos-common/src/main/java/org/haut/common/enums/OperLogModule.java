package org.haut.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 操作日志模块编码枚举
 */
@Getter
@AllArgsConstructor
public enum OperLogModule {

    SYSTEM("system", "系统管理"),
    ORDER("order", "订单管理"),
    VIP("vip", "会员管理"),
    STOCK("stock", "库存管理"),
    PAYMENT("payment", "支付管理"),
    SERVER("server", "服务管理"),
    ROOM("room", "房间管理"),
    KPI("kpi", "绩效管理"),
    ;

    private final String code;
    private final String name;
}
