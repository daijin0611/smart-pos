"""
Smart POS 大数据平台 - MySQL → Hive ODS 层数据同步
ETL 脚本：使用 Spark JDBC 从 MySQL 读取业务数据，写入 Hive ODS 层

支持两种同步模式：
  - full：全量同步（维度表、首次初始化）
  - incremental：增量同步（事务表，按 create_time 当日过滤）

使用方式：
  spark-submit \
    --master yarn \
    --deploy-mode cluster \
    --jars /opt/jars/mysql-connector-j-8.0.33.jar \
    mysql_to_ods.py \
    --mode incremental \
    --dt 2026-04-18
"""

import argparse
import logging
import os
from datetime import datetime, timedelta

from pyspark.sql import SparkSession
from pyspark.sql import functions as F

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
logger = logging.getLogger(__name__)

# -------------------------------------------------------
# MySQL 连接配置（从环境变量读取，禁止硬编码密码）
# -------------------------------------------------------
MYSQL_HOST = os.environ.get("POS_MYSQL_HOST", "localhost")
MYSQL_PORT = os.environ.get("POS_MYSQL_PORT", "3306")
MYSQL_DB   = os.environ.get("POS_MYSQL_DB", "pos")
MYSQL_USER = os.environ.get("POS_MYSQL_USER", "pos_reader")
MYSQL_PASS = os.environ.get("POS_MYSQL_PASS", "")

JDBC_URL = f"jdbc:mysql://{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DB}?useSSL=false&serverTimezone=Asia/Shanghai&characterEncoding=utf8mb4"
JDBC_PROPS = {
    "user": MYSQL_USER,
    "password": MYSQL_PASS,
    "driver": "com.mysql.cj.jdbc.Driver",
    "fetchsize": "10000",
}

# -------------------------------------------------------
# 表同步配置
# -------------------------------------------------------
# 增量同步表（按 create_time 过滤当日数据）
INCREMENTAL_TABLES = [
    "order_info",
    "order_detail",
    "payment_detail",
    "kpi_detail",
    "vip_recharge_history",
]

# 全量同步表（维度表，每次全量覆盖）
FULL_TABLES = [
    "sys_user",
    "sys_org",
    "vip_info",
    "vip_asset",
]

# MySQL 表 → Hive ODS 表名映射
TABLE_MAP = {
    "order_info":           "pos_ods.ods_order_info",
    "order_detail":         "pos_ods.ods_order_detail",
    "payment_detail":       "pos_ods.ods_payment_detail",
    "kpi_detail":           "pos_ods.ods_kpi_detail",
    "vip_info":             "pos_ods.ods_vip_info",
    "vip_asset":            "pos_ods.ods_vip_asset",
    "vip_recharge_history": "pos_ods.ods_vip_recharge_history",
    "sys_user":             "pos_ods.ods_sys_user",
    "sys_org":              "pos_ods.ods_sys_org",
}


def create_spark_session() -> SparkSession:
    """创建 SparkSession，启用 Hive 支持"""
    return (
        SparkSession.builder
        .appName("SmartPOS_MySQL_to_ODS")
        .config("spark.sql.hive.convertMetastoreOrc", "true")
        .config("spark.sql.orc.impl", "native")
        .config("spark.sql.sources.partitionOverwriteMode", "dynamic")
        .enableHiveSupport()
        .getOrCreate()
    )


def read_mysql_table(spark: SparkSession, table: str, dt: str = None) -> "pyspark.sql.DataFrame":
    """
    从 MySQL 读取指定表数据。
    若指定 dt，则过滤 create_time 在该日期范围内的记录（增量模式）。
    """
    if dt:
        query = (
            f"(SELECT * FROM `{table}` "
            f"WHERE DATE(create_time) = '{dt}') AS t"
        )
        logger.info("增量读取 MySQL 表 %s，日期过滤: %s", table, dt)
    else:
        query = f"(SELECT * FROM `{table}`) AS t"
        logger.info("全量读取 MySQL 表 %s", table)

    df = (
        spark.read
        .format("jdbc")
        .option("url", JDBC_URL)
        .option("dbtable", query)
        .option("user", MYSQL_USER)
        .option("password", MYSQL_PASS)
        .option("driver", JDBC_PROPS["driver"])
        .option("fetchsize", JDBC_PROPS["fetchsize"])
        .load()
    )
    logger.info("表 %s 读取完成，行数: %d", table, df.count())
    return df


def sync_incremental_table(spark: SparkSession, mysql_table: str, dt: str) -> None:
    """将 MySQL 增量数据写入 Hive ODS 分区"""
    hive_table = TABLE_MAP[mysql_table]
    df = read_mysql_table(spark, mysql_table, dt=dt)

    if df.rdd.isEmpty():
        logger.warning("表 %s 在 %s 无增量数据，跳过写入", mysql_table, dt)
        return

    # 将所有时间类型列转为字符串，避免 Hive 类型兼容问题
    for col_name, col_type in df.dtypes:
        if col_type in ("timestamp", "date"):
            df = df.withColumn(col_name, F.col(col_name).cast("string"))

    # 写入 Hive 分区（覆盖当日分区）
    (
        df.withColumn("dt", F.lit(dt))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("dt")
        .saveAsTable(hive_table)
    )
    logger.info("增量写入完成: %s -> %s (分区 dt=%s)", mysql_table, hive_table, dt)


def sync_full_table(spark: SparkSession, mysql_table: str, dt: str) -> None:
    """全量同步 MySQL 表到 Hive ODS（带日期分区的表写当日分区，无分区表直接覆盖）"""
    hive_table = TABLE_MAP[mysql_table]
    df = read_mysql_table(spark, mysql_table, dt=None)

    if df.rdd.isEmpty():
        logger.warning("表 %s 无数据，跳过写入", mysql_table)
        return

    # 将时间类型转为字符串
    for col_name, col_type in df.dtypes:
        if col_type in ("timestamp", "date"):
            df = df.withColumn(col_name, F.col(col_name).cast("string"))

    # 无分区的维度表（sys_user / sys_org）直接覆盖写入
    no_partition_tables = {"sys_user", "sys_org"}
    if mysql_table in no_partition_tables:
        (
            df.write
            .format("orc")
            .mode("overwrite")
            .saveAsTable(hive_table)
        )
    else:
        # 带分区表：写入当日分区
        (
            df.withColumn("dt", F.lit(dt))
            .write
            .format("orc")
            .mode("overwrite")
            .partitionBy("dt")
            .saveAsTable(hive_table)
        )
    logger.info("全量写入完成: %s -> %s", mysql_table, hive_table)


def run(mode: str, dt: str) -> None:
    """
    主流程：
    - mode=full：同步所有表（全量 + 当日增量表全量）
    - mode=incremental：仅同步增量表当日数据；维度表若需要刷新需单独调 full
    """
    spark = create_spark_session()
    spark.conf.set("spark.sql.sources.partitionOverwriteMode", "dynamic")
    logger.info("ETL 开始，模式: %s，日期: %s", mode, dt)

    if mode == "full":
        # 全量同步所有表
        for table in FULL_TABLES:
            try:
                sync_full_table(spark, table, dt)
            except Exception as e:
                logger.error("全量同步表 %s 失败: %s", table, e, exc_info=True)

        for table in INCREMENTAL_TABLES:
            try:
                sync_full_table(spark, table, dt)
            except Exception as e:
                logger.error("全量同步表 %s 失败: %s", table, e, exc_info=True)

    elif mode == "incremental":
        # 增量同步事务表
        for table in INCREMENTAL_TABLES:
            try:
                sync_incremental_table(spark, table, dt)
            except Exception as e:
                logger.error("增量同步表 %s 失败: %s", table, e, exc_info=True)

        # 全量刷新维度表（每日同步一次保证维度最新）
        for table in FULL_TABLES:
            try:
                sync_full_table(spark, table, dt)
            except Exception as e:
                logger.error("维度表同步 %s 失败: %s", table, e, exc_info=True)
    else:
        raise ValueError(f"不支持的同步模式: {mode}，请使用 full 或 incremental")

    logger.info("ETL 完成")
    spark.stop()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Smart POS MySQL → Hive ODS ETL")
    parser.add_argument(
        "--mode",
        choices=["full", "incremental"],
        default="incremental",
        help="同步模式：full=全量, incremental=增量（默认）"
    )
    parser.add_argument(
        "--dt",
        default=None,
        help="数据日期，格式 YYYY-MM-DD（默认为昨天）"
    )
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    dt = args.dt or (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
    run(mode=args.mode, dt=dt)
