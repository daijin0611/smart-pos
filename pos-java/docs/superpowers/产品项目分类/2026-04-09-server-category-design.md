# 项目/产品分类重构设计

## 背景

当前项目分类（item_category）和产品分类（product_category）使用字典表（sys_dict_item）管理，分类是全局的，所有门店共享相同的分类列表。客户要求分类管理支持关联到多门店，实现分类可见性控制。

## 需求

1. 分类从字典表迁移为独立实体，拥有自己的生命周期管理
2. 分类支持关联多门店，控制可见性
3. 项目分类和产品分类保持分开管理，但共用一张分类表（通过 type 字段区分）
4. 现有字典分类数据全量迁移到新表，并默认关联所有门店

## 数据模型

### 统一分类表 `server_category`

| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint auto_increment | 主键 |
| name | varchar(50) | 分类名称 |
| type | tinyint not null | 分类类型：1-项目分类 2-产品分类 |
| sort | int default 0 | 排序号 |
| status | tinyint default 1 | 状态 1-启用 0-禁用 |
| create_time | datetime | 创建时间 |
| update_time | datetime | 更新时间 |
| is_delete | tinyint default 0 | 逻辑删除 |

唯一约束：`(type, name, is_delete)` — 同类型下名称不重复（考虑软删除）。

### 门店关联

复用 `sys_org_relation` 中间表，新增 itemType 枚举值：
- `6` — 分类（SERVER_CATEGORY），不区分项目/产品分类（表内 type 字段区分）

在 `OrgRelationTypeEnum` 中添加：
```java
SERVER_CATEGORY(6, "分类");
```

### 产品/项目表变更

- `server_item.category`：从 `varchar(100)` 改为 `bigint`，引用 `server_category.id`
- `server_product.category`：从 `varchar(100)` 改为 `bigint`，引用 `server_category.id`

## API 接口

### 分类管理 API

新建 `ServerCategoryController`：

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/server/category/list` | 查询分类列表 |
| GET | `/server/category/info` | 查询分类详情 |
| POST | `/server/category/add` | 新增分类 |
| PUT | `/server/category/update` | 更新分类 |
| PUT | `/server/category/update-status` | 启用/禁用分类 |
| DELETE | `/server/category/delete` | 删除分类 |
| GET | `/server/category/org-list` | 查询分类关联的门店列表 |
| PUT | `/server/category/bind-orgs` | 绑定分类到门店 |

### 查询参数

- `type`（必传）：1-项目分类 2-产品分类
- `name`（可选）：模糊搜索
- `status`（可选）：状态筛选
- `orgId`（可选）：门店筛选，传入时只返回该门店可见的分类

### 产品/项目 API 变更

- 创建/更新产品或项目时，`category` 字段从字符串改为 Long 类型
- 校验分类 ID 存在、类型匹配、状态为启用

## 业务规则

### 分类 CRUD

- **新增**：同 type 下 name 不可重复，必须选择关联门店（至少 1 个）
- **更新**：可修改名称（同 type 下不重复）、排序、状态
- **删除**：软删除。如果分类下有产品/项目引用，禁止删除
- **启用/禁用**：禁用后，该分类在产品/项目选择列表中不可见，不影响已有数据

### 门店关联

- 新增分类时，必须关联至少 1 个门店
- 查询产品/项目列表时，根据当前门店自动过滤可见分类
- 分类关联门店变更时，不影响已关联到该分类的产品/项目

## 数据迁移

迁移脚本：`V1.0.11__migrate_category_to_server_category.sql`

步骤：
1. 创建 `server_category` 表
2. 从 `sys_dict_item` 中读取 `item_category`（type=1）和 `product_category`（type=2）的字典项，插入 `server_category`
3. 对每个新分类，在 `sys_org_relation` 中创建与所有现有门店的关联（item_type=6）
4. 将 `server_item.category` 从字典值更新为对应的 `server_category.id`
5. 将 `server_product.category` 从字典值更新为对应的 `server_category.id`
6. 修改 `server_item.category` 和 `server_product.category` 字段类型为 `bigint`
7. 删除 `sys_dict_item` 中 `item_category` 和 `product_category` 的字典项

## 代码变更范围

### 新增文件
- `ServerCategoryEntity` — 分类实体
- `ServerCategoryMapper` — Mapper 接口
- `ServerCategoryService` / `ServerCategoryServiceImpl` — Service 层
- `ServerCategoryController` — Controller 层
- DTO：`ServerCategoryCreateDTO`、`ServerCategoryUpdateDTO`
- VO：`ServerCategoryVO`、`ServerCategoryInfoVO`
- Query：`ServerCategoryQuery`
- SQL：`V1.0.11__migrate_category_to_server_category.sql`

### 修改文件
- `OrgRelationTypeEnum` — 新增 `SERVER_CATEGORY(6, "分类")`
- `ServerItem` — category 字段类型从 String 改为 Long
- `ServerProduct` — category 字段类型从 String 改为 Long
- 相关 DTO/VO/Query — category 字段类型同步修改
- `ServerItemServiceImpl` — 分类校验逻辑
- `ServerProductServiceImpl` — 分类校验逻辑
- `ServerItemController` — 无 API 变更，仅字段类型调整
- `ServerProductController` — 无 API 变更，仅字段类型调整
