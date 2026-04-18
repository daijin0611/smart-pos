# Smart POS 大数据平台架构设计

## 1. 背景与目标

Smart POS 系统目前已积累了大量的门店运营数据，包括订单、支付、会员、绩效等核心业务数据。
为支撑多维度的数据分析与决策，需要搭建一套基于 **Hive 数据仓库 + Spark 数据分析** 的大数据平台。

### 核心目标
- 将 MySQL 中的业务数据定期同步至 Hive 数据仓库，实现历史数据的长期存储与分析
- 利用 Spark 进行复杂的离线分析，提供销售趋势、会员洞察、绩效排名等数据报表
- 以分层架构（ODS → DWD → DWS → ADS）组织数据，保证数据质量与复用性

---

## 2. 技术选型

| 组件 | 版本 | 说明 |
|------|------|------|
| Hadoop | 3.3.x | 分布式存储基础（HDFS） |
| Hive | 3.1.x | 数据仓库，基于 HDFS 的结构化查询 |
| Spark | 3.4.x | 分布式计算引擎，用于 ETL 与分析 |
| MySQL | 8.x | POS 系统业务数据库（数据源） |
| PySpark | 3.4.x | Python Spark API，编写 ETL 与分析任务 |
| Sqoop / JDBC | — | MySQL → HDFS 数据同步（或直接 Spark JDBC） |
| Airflow（可选） | 2.x | 任务调度与编排 |

---

## 3. 数据仓库分层架构

```
MySQL（业务库）
    │
    ▼  全量/增量同步（每日凌晨）
┌─────────────────────────────────────────────────────────────┐
│  ODS 层（Operational Data Store）                           │
│  • 原始镜像数据，按业务表1:1同步                            │
│  • 按日期分区（dt=YYYY-MM-DD）                              │
│  • 分区格式：Parquet / ORC                                  │
└─────────────────────────────────────────────────────────────┘
    │
    ▼  清洗、去重、字段规范化
┌─────────────────────────────────────────────────────────────┐
│  DWD 层（Data Warehouse Detail）                            │
│  • 明细宽表，关联维度数据                                   │
│  • 过滤已删除记录（is_delete=1）                            │
│  • 标准化枚举字段（如 payment_type、customer_type）         │
└─────────────────────────────────────────────────────────────┘
    │
    ▼  聚合、汇总
┌─────────────────────────────────────────────────────────────┐
│  DWS 层（Data Warehouse Summary）                           │
│  • 按门店 / 日期 / 员工 / 会员等多维度汇总                 │
│  • 粒度：日、周、月                                         │
└─────────────────────────────────────────────────────────────┘
    │
    ▼  面向应用的数据集市
┌─────────────────────────────────────────────────────────────┐
│  ADS 层（Application Data Store）                           │
│  • 销售日报、会员分析、绩效排名等报表数据                   │
│  • 可直接对接 BI 工具（如 Superset、Grafana）               │
└─────────────────────────────────────────────────────────────┘
```

---

## 4. 核心业务表映射

### 4.1 ODS 层（原始数据）

| Hive ODS 表 | 对应 MySQL 表 | 说明 |
|-------------|---------------|------|
| `ods_order_info` | `order_info` | 订单主表 |
| `ods_order_detail` | `order_detail` | 订单明细（服务/产品项目） |
| `ods_payment_detail` | `payment_detail` | 支付明细 |
| `ods_kpi_detail` | `kpi_detail` | 技师绩效明细 |
| `ods_vip_info` | `vip_info` | 会员信息 |
| `ods_vip_asset` | `vip_asset` | 会员卡资产（储值/赠送金） |
| `ods_vip_recharge_history` | `vip_recharge_history` | 会员充值记录 |
| `ods_sys_user` | `sys_user` | 员工信息 |
| `ods_sys_org` | `sys_org` | 门店信息 |

### 4.2 DWD 层（明细宽表）

| Hive DWD 表 | 说明 |
|-------------|------|
| `dwd_order_detail` | 订单明细宽表（关联门店、员工、服务项等） |
| `dwd_payment_detail` | 支付明细宽表（含支付方式中文名） |
| `dwd_kpi_detail` | 绩效明细宽表（关联员工、门店） |
| `dwd_vip_order` | 会员消费明细（关联会员信息与订单） |

### 4.3 DWS 层（汇总层）

| Hive DWS 表 | 说明 |
|-------------|------|
| `dws_daily_sales_org` | 按门店+日期汇总的销售数据 |
| `dws_daily_kpi_user` | 按员工+日期汇总的绩效数据 |
| `dws_monthly_vip_stat` | 按会员+月份汇总的消费统计 |
| `dws_payment_type_stat` | 按支付方式+日期汇总 |

### 4.4 ADS 层（应用层）

| Hive ADS 表 | 说明 |
|-------------|------|
| `ads_sales_daily_report` | 销售日报（供 BI 展示） |
| `ads_top_technician_monthly` | 月度技师业绩 TOP 排行 |
| `ads_vip_rfm_analysis` | 会员 RFM 分析（最近消费/消费频次/消费金额） |
| `ads_service_popularity` | 服务/产品热度分析 |

---

## 5. 数据同步策略

### 5.1 全量同步（首次 & 历史回刷）

- 适用表：维度表（`sys_org`、`sys_user`）及数据量较小的表
- 方式：`Spark JDBC` 全量读取 → 写入 Hive ODS 分区

### 5.2 增量同步（每日定时）

- 适用表：`order_info`、`order_detail`、`payment_detail`、`kpi_detail`、`vip_recharge_history`
- 依据字段：`create_time`（按当日日期过滤）
- 方式：`Spark JDBC` 增量读取 → Append 写入 Hive ODS 当日分区

---

## 6. Spark 分析任务规划

| 任务名称 | 脚本 | 调度频率 | 输出 |
|----------|------|----------|------|
| 门店销售日报 | `analysis/daily_sales_report.py` | 每日 02:00 | `ads_sales_daily_report` |
| 支付方式分布 | `analysis/payment_type_analysis.py` | 每日 02:00 | `dws_payment_type_stat` |
| 技师月度绩效 | `analysis/kpi_monthly_ranking.py` | 每月 1 日 03:00 | `ads_top_technician_monthly` |
| 会员 RFM 分析 | `analysis/vip_rfm_analysis.py` | 每周一 04:00 | `ads_vip_rfm_analysis` |
| 服务热度分析 | `analysis/service_popularity.py` | 每日 02:30 | `ads_service_popularity` |

---

## 7. 目录结构

```
bigdata/
├── hive/
│   └── ddl/
│       ├── ods_tables.hql        # ODS 层建表语句
│       ├── dwd_tables.hql        # DWD 层建表语句
│       ├── dws_tables.hql        # DWS 层建表语句
│       └── ads_tables.hql        # ADS 层建表语句
├── spark/
│   ├── etl/
│   │   ├── mysql_to_ods.py       # MySQL → ODS 全量/增量同步
│   │   └── ods_to_dwd.py         # ODS → DWD 数据清洗
│   └── analysis/
│       ├── daily_sales_report.py     # 门店销售日报
│       ├── payment_type_analysis.py  # 支付方式分布分析
│       ├── kpi_monthly_ranking.py    # 技师绩效月度排行
│       ├── vip_rfm_analysis.py       # 会员 RFM 分析
│       └── service_popularity.py     # 服务/产品热度分析
└── scripts/
    ├── run_etl.sh                # 每日 ETL 调度脚本
    └── run_analysis.sh           # 每日分析任务调度脚本
```

---

## 8. 部署要求

### 最低硬件配置（开发/测试环境）

| 节点 | 角色 | CPU | 内存 | 磁盘 |
|------|------|-----|------|------|
| node1 | NameNode + ResourceManager + HiveServer2 | 4 核 | 8 GB | 100 GB |
| node2 | DataNode + NodeManager | 4 核 | 8 GB | 500 GB |
| node3 | DataNode + NodeManager | 4 核 | 8 GB | 500 GB |

### 软件依赖

```
Hadoop 3.3.x
Hive 3.1.x（MetaStore 使用独立 MySQL）
Spark 3.4.x（YARN 模式部署）
JDK 11+
Python 3.8+
PySpark 3.4.x
MySQL Connector/J 8.x（JDBC 驱动）
```

---

## 9. 数据安全

- Hive 表按门店（`org_id`）做行级权限管理（Apache Ranger 可选）
- ETL 脚本中的 MySQL 连接信息通过环境变量注入，禁止硬编码密码
- HDFS 数据目录设置适当的 ACL 权限
