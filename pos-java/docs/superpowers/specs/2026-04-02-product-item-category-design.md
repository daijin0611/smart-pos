# 产品和服务项分类功能设计

## 概述

为产品(ServerProduct)和服务项(ServerItem)添加分类功能，基于现有字典表(sys_dict_type / sys_dict_item)实现，无需新建业务表。

## 需求

- **分类对象**：产品(ServerProduct) + 服务项(ServerItem)
- **分类层级**：单层，无父子关系
- **分类存储**：共用字典表，通过 dict_code 区分产品分类和服务分类
- **管理范围**：全局共享，不按组织隔离

## 数据库变更

### 1. 新增字典类型

在 `sys_dict_type` 表插入两条记录：

| dict_name | dict_code | sort |
|---|---|---|
| 产品分类 | product_category | 0 |
| 服务分类 | item_category | 0 |

### 2. 新增分类字段

**server_product** 表新增字段：
```sql
ALTER TABLE server_product ADD COLUMN category varchar(100) DEFAULT NULL COMMENT '分类(字典项item_value)';
```

**server_item** 表新增字段：
```sql
ALTER TABLE server_item ADD COLUMN category varchar(100) DEFAULT NULL COMMENT '分类(字典项item_value)';
```

## 代码变更

### Entity 层

- `ServerProduct` 新增 `category` (String) 字段
- `ServerItem` 新增 `category` (String) 字段

### DTO/VO 层

在产品和服务项相关的创建、更新、查询 DTO/VO 中添加 `category` 字段。

### 数据库迁移

新建迁移脚本 `sql/V1.0.9__add_category_to_product_item.sql`，包含：
1. ALTER TABLE 语句为两张表加字段
2. INSERT 语句插入字典类型初始数据

## 分类管理

复用现有字典管理接口 `/system/dict`：
- 新增分类：`POST /system/dict/add-item`，指定 dictCode 为 product_category 或 item_category
- 查询分类列表：`GET /system/dict/query-items-by-code?dictCode=product_category`
- 修改分类：`PUT /system/dict/update-item`
- 删除分类：`PUT /system/dict/delete-item`
