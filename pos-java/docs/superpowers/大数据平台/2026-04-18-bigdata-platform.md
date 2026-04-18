# Smart POS Hive+Spark 大数据平台 实现计划

## 背景

现有 Smart POS 系统（Spring Boot + MySQL）已积累大量业务数据，包括订单、支付、会员、绩效等。
本需求在系统外围搭建一套 **Hive 数据仓库 + Spark 数据分析** 大数据平台，
实现历史数据的长期存储、多维分析与报表输出，不侵入现有业务代码。

---

## File Structure

```
bigdata/
├── README.md
├── hive/
│   └── ddl/
│       ├── ods_tables.hql
│       ├── dwd_tables.hql
│       ├── dws_tables.hql
│       └── ads_tables.hql
├── spark/
│   ├── etl/
│   │   ├── mysql_to_ods.py
│   │   └── ods_to_dwd.py
│   └── analysis/
│       ├── daily_sales_report.py
│       ├── payment_type_analysis.py
│       ├── kpi_monthly_ranking.py
│       ├── vip_rfm_analysis.py
│       └── service_popularity.py
└── scripts/
    ├── run_etl.sh
    └── run_analysis.sh
```

---

## 实现任务清单

### Task 1: 架构设计文档

**Files:**
- Create: `docs/superpowers/大数据平台/2026-04-18-bigdata-platform-design.md`

- [x] **Step 1: 编写大数据平台架构设计文档**

  内容包括：
  - 技术选型（Hadoop/Hive/Spark 版本）
  - 数据仓库四层架构（ODS/DWD/DWS/ADS）
  - 核心业务表映射
  - 数据同步策略（全量/增量）
  - 分析任务规划
  - 部署要求与数据安全

---

### Task 2: Hive DDL 建表脚本

**Files:**
- Create: `bigdata/hive/ddl/ods_tables.hql`
- Create: `bigdata/hive/ddl/dwd_tables.hql`
- Create: `bigdata/hive/ddl/dws_tables.hql`
- Create: `bigdata/hive/ddl/ads_tables.hql`

- [x] **Step 1: ODS 层建表（9张表，含日期分区）**

  对应 MySQL 业务表：`order_info`、`order_detail`、`payment_detail`、`kpi_detail`、
  `vip_info`、`vip_asset`、`vip_recharge_history`、`sys_user`、`sys_org`

- [x] **Step 2: DWD 层建表（4张明细宽表）**

  宽表关联门店、员工维度，枚举字段增加文本列：
  - `dwd_order_detail`（订单+明细+门店+技师）
  - `dwd_payment_detail`（支付+门店）
  - `dwd_kpi_detail`（绩效+员工+门店）
  - `dwd_vip_order`（会员消费明细）

- [x] **Step 3: DWS 层建表（4张汇总表）**

  - `dws_daily_sales_org`（门店日销售汇总）
  - `dws_daily_kpi_user`（员工日绩效汇总）
  - `dws_monthly_vip_stat`（会员月消费汇总）
  - `dws_payment_type_stat`（支付方式日汇总）

- [x] **Step 4: ADS 层建表（4张应用表）**

  - `ads_sales_daily_report`（销售日报）
  - `ads_top_technician_monthly`（技师月度排行）
  - `ads_vip_rfm_analysis`（会员 RFM 分析）
  - `ads_service_popularity`（服务热度分析）

---

### Task 3: ETL 脚本

**Files:**
- Create: `bigdata/spark/etl/mysql_to_ods.py`
- Create: `bigdata/spark/etl/ods_to_dwd.py`

- [x] **Step 1: MySQL → ODS 同步脚本（mysql_to_ods.py）**

  - 支持 `full`（全量）和 `incremental`（增量）两种模式
  - 增量模式按 `create_time` 过滤当日数据
  - 全量模式用于首次初始化和维度表日常刷新
  - MySQL 连接信息通过环境变量注入，安全无硬编码

- [x] **Step 2: ODS → DWD 数据清洗脚本（ods_to_dwd.py）**

  - 过滤已删除记录（`is_delete=1`）
  - 枚举字段映射为中文文本
  - 关联门店（`sys_org`）和员工（`sys_user`）维度
  - 生成计算字段（`line_total`、`order_status_name` 等）

---

### Task 4: Spark 分析作业

**Files:**
- Create: `bigdata/spark/analysis/daily_sales_report.py`
- Create: `bigdata/spark/analysis/payment_type_analysis.py`
- Create: `bigdata/spark/analysis/kpi_monthly_ranking.py`
- Create: `bigdata/spark/analysis/vip_rfm_analysis.py`
- Create: `bigdata/spark/analysis/service_popularity.py`

- [x] **Step 1: 门店销售日报（daily_sales_report.py）**

  整合订单汇总、支付方式明细、充值数据、新增会员、最热服务、最高绩效技师

- [x] **Step 2: 支付方式分布分析（payment_type_analysis.py）**

  按门店+支付方式+日期汇总笔数和金额

- [x] **Step 3: 技师月度绩效排行（kpi_monthly_ranking.py）**

  按门店+月份汇总技师业绩，生成门店内排名

- [x] **Step 4: 会员 RFM 分析（vip_rfm_analysis.py）**

  计算近 90 天 R/F/M 三个维度得分，按分位数分段打分（1-5），生成八类会员分层标签

- [x] **Step 5: 服务/产品热度分析（service_popularity.py）**

  统计近 N 天服务销售次数、数量、收入，按门店内和全局分别排名

---

### Task 5: 调度脚本

**Files:**
- Create: `bigdata/scripts/run_etl.sh`
- Create: `bigdata/scripts/run_analysis.sh`

- [x] **Step 1: ETL 调度脚本（run_etl.sh）**

  按顺序执行：MySQL → ODS → DWD，支持日期参数，记录日志

- [x] **Step 2: 分析任务调度脚本（run_analysis.sh）**

  每日执行销售日报、支付分析、服务热度；
  每周一执行 RFM 分析；
  每月 1 日执行月度技师绩效排行

---

### Task 6: 文档与 README

**Files:**
- Create: `bigdata/README.md`

- [x] **Step 1: 编写 bigdata 模块 README**

  包含：目录结构、快速开始、数据流说明、分析输出表清单

---

## 后续可扩展方向

- **实时分析**：引入 Kafka + Spark Streaming / Flink，实现订单实时监控
- **BI 可视化**：对接 Apache Superset 或 Grafana，基于 ADS 层建表盘
- **任务调度**：迁移至 Apache Airflow，支持依赖管理、重试、告警
- **数据质量**：引入 Great Expectations 对 DWD 层数据做校验
- **多租户权限**：引入 Apache Ranger，按门店做 Hive 行级权限控制
