# 系统操作日志设计文档

## 概述

为 POS 系统新增通用操作日志功能，通过 AOP + 自定义注解方式记录关键业务操作，支持分页条件查询。

## 需求

- 仅记录关键业务操作（通过注解标记）
- 记录基础信息：操作人、时间、操作描述、IP、请求参数、响应结果
- 支持按操作人、时间范围、操作类型、模块等条件分页查询
- 数据存储在 MySQL 中

## 技术方案

**AOP + 自定义注解**，与项目已有的 `@Idempotent` 注解风格一致。切面利用已有的 `AuthContextHolder` 获取用户信息，异步写入数据库避免影响业务性能。

## 数据库设计

### sys_oper_log 表

```sql
CREATE TABLE sys_oper_log (
    id              BIGINT UNSIGNED AUTO_INCREMENT COMMENT '主键',
    module          VARCHAR(50)     NOT NULL COMMENT '操作模块（order/vip/payment等）',
    description     VARCHAR(255)    NOT NULL COMMENT '操作描述',
    operator_id     BIGINT          NULL COMMENT '操作人ID',
    operator_name   VARCHAR(50)     NULL COMMENT '操作人姓名',
    request_method  VARCHAR(10)     NULL COMMENT 'HTTP方法',
    request_url     VARCHAR(255)    NULL COMMENT '请求路径',
    request_params  TEXT            NULL COMMENT '请求参数（JSON）',
    response_result TEXT            NULL COMMENT '响应结果（JSON，截取前2000字符）',
    ip              VARCHAR(50)     NULL COMMENT '操作IP',
    status          TINYINT         NOT NULL DEFAULT 0 COMMENT '操作状态（0成功 1失败）',
    error_msg       TEXT            NULL COMMENT '错误信息',
    cost_time       BIGINT          NULL COMMENT '耗时（毫秒）',
    org_id          BIGINT          NOT NULL DEFAULT 1 COMMENT '机构ID',
    create_time     DATETIME        NULL COMMENT '创建时间',
    PRIMARY KEY (id),
    INDEX idx_module (module),
    INDEX idx_operator_id (operator_id),
    INDEX idx_create_time (create_time),
    INDEX idx_org_id (org_id)
) COMMENT '系统操作日志表';
```

注意：日志表只增不改不删，不设 `update_time` 和 `is_delete` 字段。

## 代码结构

### 新增文件

```
pos-common/
├── annotation/OperLog.java                         — 自定义注解
├── domain/vo/system/SysOperLogVO.java               — 查询 VO

pos-server/
├── entity/system/SysOperLog.java                    — 实体类
├── mapper/system/SysOperLogMapper.java              — Mapper
├── service/system/SysOperLogService.java            — Service 接口
├── service/system/impl/SysOperLogServiceImpl.java   — Service 实现

pos-web/
├── aspect/OperLogAspect.java                        — AOP 切面
├── controller/system/SysOperLogController.java      — 查询接口
```

### @OperLog 注解

```java
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface OperLog {
    String module();                              // 模块名
    String description();                         // 操作描述
    boolean saveResponse() default true;          // 是否记录响应
}
```

使用示例：

```java
@PostMapping("/create")
@OperLog(module = "order", description = "创建订单")
public JsonVO<OrderVO> createOrder(@RequestBody OrderDTO dto) { ... }
```

### AOP 切面流程

1. `@Around` 环绕通知拦截 `@OperLog` 标注的方法
2. 从 `AuthContextHolder` 获取当前用户信息
3. 从 `HttpServletRequest` 获取 IP、URL、HTTP 方法、请求参数
4. 执行目标方法，记录耗时
5. 成功/失败均记录日志
6. 异步写入数据库

### 查询接口

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/system/oper-log/page` | 分页条件查询日志列表 |

查询参数：

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| module | String | 否 | 按模块筛选 |
| operatorName | String | 否 | 按操作人模糊搜索 |
| status | Integer | 否 | 按状态筛选（0成功/1失败） |
| startTime | DateTime | 否 | 开始时间 |
| endTime | DateTime | 否 | 结束时间 |
| orgId | Long | 否 | 按机构筛选 |
| pageNum | Integer | 否 | 页码，默认1 |
| pageSize | Integer | 否 | 每页条数，默认10 |
