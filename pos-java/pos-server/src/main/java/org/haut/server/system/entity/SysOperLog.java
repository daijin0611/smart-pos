package org.haut.server.system.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

@Data
@TableName(value = "sys_oper_log")
public class SysOperLog {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String module;

    private String description;

    private Long operatorId;

    private String operatorName;

    private String requestMethod;

    private String requestUrl;

    private String requestParams;

    private String responseResult;

    private String ip;

    private Integer status;

    private String errorMsg;

    private Long costTime;

    private Long orgId;

    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
}