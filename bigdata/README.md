# Smart POS 大数据平台

基于 **Hive 数据仓库 + Spark 数据分析** 的大数据平台，为 Smart POS 系统提供离线数据分析能力。

## 目录结构

```
bigdata/
├── hive/
│   └── ddl/
│       ├── ods_tables.hql        # ODS 层建表（原始数据）
│       ├── dwd_tables.hql        # DWD 层建表（明细宽表）
│       ├── dws_tables.hql        # DWS 层建表（汇总层）
│       └── ads_tables.hql        # ADS 层建表（应用层）
├── spark/
│   ├── etl/
│   │   ├── mysql_to_ods.py       # MySQL → ODS 数据同步
│   │   └── ods_to_dwd.py         # ODS → DWD 数据清洗
│   └── analysis/
│       ├── daily_sales_report.py     # 门店销售日报
│       ├── payment_type_analysis.py  # 支付方式分布分析
│       ├── kpi_monthly_ranking.py    # 技师月度绩效排行
│       ├── vip_rfm_analysis.py       # 会员 RFM 分析
│       └── service_popularity.py     # 服务/产品热度分析
└── scripts/
    ├── run_etl.sh                # 每日 ETL 调度（02:00 执行）
    └── run_analysis.sh           # 每日分析调度（02:30 执行）
```

## 快速开始

### 1. 环境准备

确保已安装并启动：
- Hadoop 3.3.x（HDFS + YARN）
- Hive 3.1.x（HiveServer2 + MetaStore）
- Spark 3.4.x（YARN 模式）
- Python 3.8+，已安装 `pyspark`

下载 MySQL JDBC 驱动：
```bash
wget https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar \
  -O /opt/jars/mysql-connector-j-8.0.33.jar
```

### 2. 初始化 Hive 数仓

```bash
# 创建所有层的数据库和表
hive -f bigdata/hive/ddl/ods_tables.hql
hive -f bigdata/hive/ddl/dwd_tables.hql
hive -f bigdata/hive/ddl/dws_tables.hql
hive -f bigdata/hive/ddl/ads_tables.hql
```

### 3. 配置环境变量

```bash
export POS_MYSQL_HOST=your-mysql-host
export POS_MYSQL_PORT=3306
export POS_MYSQL_DB=pos
export POS_MYSQL_USER=pos_reader
export POS_MYSQL_PASS=your-password
export SPARK_HOME=/opt/spark
```

### 4. 首次全量同步

```bash
spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --jars /opt/jars/mysql-connector-j-8.0.33.jar \
  bigdata/spark/etl/mysql_to_ods.py \
  --mode full \
  --dt $(date +"%Y-%m-%d")
```

### 5. 每日增量调度（Cron）

```cron
# 每日 02:00 运行 ETL
0 2 * * * /path/to/bigdata/scripts/run_etl.sh >> /var/log/smartpos-bigdata/cron.log 2>&1

# 每日 02:30 运行分析任务
30 2 * * * /path/to/bigdata/scripts/run_analysis.sh >> /var/log/smartpos-bigdata/cron.log 2>&1
```

## 数据流

```
MySQL (POS 业务库)
    │
    │  mysql_to_ods.py（每日增量）
    ▼
pos_ods.*（Hive ODS 层）
    │
    │  ods_to_dwd.py（清洗 + 维度补全）
    ▼
pos_dwd.*（Hive DWD 层）
    │
    │  Spark 分析作业
    ▼
pos_dws.* / pos_ads.*（汇总 + 应用层）
    │
    │  BI 工具（Superset / Grafana）
    ▼
    可视化报表
```

## 分析输出

| 报表 | 表名 | 更新频率 |
|------|------|----------|
| 门店销售日报 | `pos_ads.ads_sales_daily_report` | 每日 |
| 支付方式分布 | `pos_dws.dws_payment_type_stat` | 每日 |
| 技师月度绩效排行 | `pos_ads.ads_top_technician_monthly` | 每月 |
| 会员 RFM 分析 | `pos_ads.ads_vip_rfm_analysis` | 每周 |
| 服务/产品热度 | `pos_ads.ads_service_popularity` | 每日 |

## 详细设计文档

参见：`pos-java/docs/superpowers/大数据平台/2026-04-18-bigdata-platform-design.md`
