package org.haut.server;

import com.github.xiaoymin.knife4j.annotations.Ignore;
import jakarta.annotation.Resource;
import org.haut.server.order.service.OrderSalesSummaryService;
import org.haut.server.task.ScheduledTaskService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;

/**
 * @author 丁铭瀚
 * @version 1.0
 */
@SpringBootTest
@Ignore
public class ScheduledTest {

    @Autowired
    private OrderSalesSummaryService orderSalesSummaryService;

    @Test
    public void test() {
        orderSalesSummaryService.executeSummaries();
    }
}
