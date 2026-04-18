"""
Smart POS 大数据平台 - 支付方式分布分析
Spark 分析任务：按门店+日期统计各支付方式的交易笔数和金额，写入 DWS 层

输出表：pos_dws.dws_payment_type_stat

使用方式：
  spark-submit \
    --master yarn \
    --deploy-mode cluster \
    payment_type_analysis.py \
    --dt 2026-04-18
"""

import argparse
import logging
from datetime import datetime, timedelta

from pyspark.sql import SparkSession
from pyspark.sql import functions as F

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
logger = logging.getLogger(__name__)


def create_spark_session() -> SparkSession:
    return (
        SparkSession.builder
        .appName("SmartPOS_Payment_Type_Analysis")
        .config("spark.sql.hive.convertMetastoreOrc", "true")
        .enableHiveSupport()
        .getOrCreate()
    )


def build_payment_type_stat(spark: SparkSession, dt: str) -> None:
    """按支付方式+门店+日期汇总支付数据"""
    logger.info("开始生成支付方式统计，日期: %s", dt)

    result = (
        spark.table("pos_dwd.dwd_payment_detail")
        .filter(F.col("dt") == dt)
        .groupBy("org_id", "org_name", "payment_type", "payment_name")
        .agg(
            F.count("id").alias("transaction_count"),
            F.sum("total_amount").alias("total_amount"),
        )
        .withColumn("total_amount", F.round(F.col("total_amount"), 2))
    )

    (
        result
        .withColumn("dt", F.lit(dt))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("dt")
        .saveAsTable("pos_dws.dws_payment_type_stat")
    )
    logger.info("dws_payment_type_stat 写入完成，日期: %s", dt)


def run(dt: str) -> None:
    spark = create_spark_session()
    try:
        build_payment_type_stat(spark, dt)
    except Exception as e:
        logger.error("支付方式分析失败: %s", e, exc_info=True)
        raise
    finally:
        spark.stop()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Smart POS 支付方式分布分析")
    parser.add_argument("--dt", default=None, help="数据日期 YYYY-MM-DD（默认昨天）")
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    dt = args.dt or (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
    run(dt=dt)
