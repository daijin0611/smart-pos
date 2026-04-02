package org.haut.server.system.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("sys_org_user")
public class SysOrgUser {
    private Long usrId;
    private Long orgId;
}
