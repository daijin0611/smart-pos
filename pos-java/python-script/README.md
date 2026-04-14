# Python 数据迁移脚本

本目录包含从美管家系统向 POS 系统迁移数据的 Python 脚本，将美管家系统导出的 JSON 数据转换为可执行的 SQL INSERT 语句。

## 目录结构

```
python-script/
├── src/
│   ├── vip_import.py          # 会员卡数据导入
│   └── cure_ticket_import.py  # 次卡数据导入
├── spec/
│   └── map_card_type.txt      # 卡类型折扣率映射说明
├── data/                      # JSON 源数据存放目录
├── config/                    # 配置文件目录
├── sql/                       # 辅助 SQL 脚本目录
├── import_vip.sql             # vip_import.py 生成的 SQL 输出
└── import_cure_ticket.sql     # cure_ticket_import.py 生成的 SQL 输出
```

## 脚本一：会员卡导入 (`src/vip_import.py`)

### 功能

将美管家系统导出的会员卡 JSON 数据转换为 SQL，导入 `vip_info`（会员信息）和 `vip_asset`（会员卡资产）两张表。

### 数据转换逻辑

| 源数据 | 目标表 | 转换规则 |
|--------|--------|----------|
| 按 `memberid` 分组的卡记录 | `vip_info` | 按 `opendate` 取最新卡作为会员主信息；余额为所有卡 `cardfee` 之和；密码默认 `123456`；原始 JSON 存入 `old_vip_json` |
| 每条卡记录 | `vip_asset`（充值金） | `asset_type=0`，折扣率 = `discount * 10`（如 6.9 → 69，0 → 100），备注格式：`美管家系统迁移-{店铺}-{卡名}-{折扣率}-否` |
| `presentfee > 0` 的卡记录 | `vip_asset`（赠送金） | `asset_type=1`，资产编号加 `_gift` 后缀，备注格式：`美管家系统迁移-{店铺}-{卡名}-{折扣率}-是` |

### 使用方式

```bash
cd python-script
python src/vip_import.py
```

1. 弹窗选择 JSON 数据文件
2. 输入门店 `org_id`
3. 输入输出 SQL 文件路径（默认 `./import_vip.sql`）

### 生成的 SQL 结构

```sql
START TRANSACTION;

-- 会员信息 (vip_info)
INSERT INTO vip_info (...) VALUES (...);

-- 会员卡资产 - 充值金 (vip_asset)
INSERT INTO vip_asset (...) VALUES (...);

-- 会员卡资产 - 赠送金 (vip_asset)  -- 仅 presentfee > 0 时生成
INSERT INTO vip_asset (...) VALUES (...);

COMMIT;
```

---

## 脚本二：次卡导入 (`src/cure_ticket_import.py`)

### 功能

将美管家系统导出的次卡 JSON 数据转换为 SQL，采用**方案三：迁移剩余权益 + 快照历史**，导入以下数据：

| 目标表 | 说明 |
|--------|------|
| `vip_ticket` | 通用次卡迁移模板优惠券（每门店一个，幂等创建） |
| `sys_org_relation` | 模板券与门店的关联关系 |
| `vip_ticket_detail` | 模板券关联门店所有服务项目 |
| `vip_info` | 缺失会员自动补创建（`INSERT ... SELECT ... WHERE NOT EXISTS`） |
| `vip_info_ticket` | 按 `leaveTimes`（剩余次数）生成对应数量的券实例，`amount` 为美管家单次金额 |
| `vip_migrate_card_snapshot` | 保存美管家完整数据快照 |

### 数据转换逻辑

- 每条次卡记录的 `leaveTimes` 决定生成多少张券实例（使用 `SELECT UNION ALL` 数字序列展开）
- 券实例备注格式：`美管家系统迁移-{店铺}-{次卡名}-{单次金额}`
- 券实例的 `ticket_code` 格式：`MG{oldCardId}_{序号}`
- `source_type = 3`（迁移导入）
- 会员不存在时自动跳过（`SELECT` 返回空集）
- 快照记录保存所有原始数据，含购买金额、剩余金额、销售员工等
- 券实例 `amount` 字段设置为美管家系统的 `onceMoney`（单次金额）

### 使用方式

```bash
cd python-script
python src/cure_ticket_import.py
```

1. 弹窗选择 JSON 数据文件
2. 输入门店 `org_id`
3. 输入输出 SQL 文件路径（默认 `./import_cure_ticket.sql`）

### 生成的 SQL 结构

```sql
START TRANSACTION;

-- 通用次卡模板优惠券 (vip_ticket) + 门店关联 + 服务项目关联
INSERT INTO vip_ticket ...;
INSERT IGNORE INTO sys_org_relation ...;
INSERT IGNORE INTO vip_ticket_detail ...;

-- 补创建缺失会员 (vip_info)
INSERT INTO vip_info ... SELECT ... WHERE NOT EXISTS (...);

-- 会员券实例 (vip_info_ticket)  -- 按 leaveTimes 展开
INSERT INTO vip_info_ticket ... SELECT ... CROSS JOIN (SELECT 1 UNION ALL SELECT 2 ...) nums;

-- 迁移快照 (vip_migrate_card_snapshot)
INSERT INTO vip_migrate_card_snapshot (...) VALUES (...);

COMMIT;
```

---

## 共同特点

- **输入**：美管家系统导出的 JSON 文件（结构为 `{ "content": [...] }`）
- **输出**：完整的 SQL 文件，包含 `START TRANSACTION` / `COMMIT` 事务包裹
- **批量插入**：每 500 条记录一批，避免单条 SQL 过长
- **幂等设计**：会员创建使用 `WHERE NOT EXISTS`，门店关联使用 `INSERT IGNORE`
- **SQL 转义**：对单引号和反斜杠进行转义，防止 SQL 注入
- **时间转换**：支持毫秒时间戳 → SQL datetime/date 格式
- **交互方式**：Tkinter 文件选择弹窗 + 命令行输入 org_id

## 运行环境

- Python 3.x
- 无第三方依赖（仅使用标准库：`json`、`datetime`、`tkinter`）
