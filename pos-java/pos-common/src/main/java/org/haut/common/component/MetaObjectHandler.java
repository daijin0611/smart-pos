package org.haut.common.component;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;
import java.util.Date;

/**
 * Mybatis Plus 自动填充
 * @author 丁铭瀚
 */
@Slf4j
@Component
public class MetaObjectHandler implements com.baomidou.mybatisplus.core.handlers.MetaObjectHandler {
    @Override
    public void insertFill(MetaObject metaObject) {
        //插入创建时间
        this.strictInsertFill(metaObject, "createTime", Date.class, new Date());
        this.strictInsertFill(metaObject, "updateTime", Date.class, new Date());
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        //更新时间
        this.strictUpdateFill(metaObject, "updateTime", Date.class, new Date());
    }
}
