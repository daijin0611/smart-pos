package org.haut.common.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 业务编码工具类，提供一些常用的编码转换方法。
 * @author 丁铭瀚
 * @version 1.0
 */
public class CodeUtils {
    public static final AtomicInteger sequence = new AtomicInteger(0);
    public static final Random random = new Random();

    /**
     * 时间戳+随机数
     * @param prefix
     * @return
     */
    public static String generateByTime(String prefix) {
        // 获取当前时间
        int randomNum = random.nextInt(9999);
        return String.format("%s%d%04d", prefix, System.currentTimeMillis(), randomNum);
    }

    /**
     * 格式化时间 + 序列号策略（推荐订单编码）
     */
    public static String generateBySequence(String prefix) {
        LocalDateTime now = LocalDateTime.now();
        String timeStr = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        int seq = sequence.incrementAndGet() % 10000;
        return String.format("%s%s%04d", prefix, timeStr, seq);
    }

}
