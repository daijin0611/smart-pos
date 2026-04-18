"""
Smart POS 大数据平台 - ODS → DWD 数据清洗
ETL 脚本：读取 Hive ODS 层数据，进行清洗和维度补全，写入 DWD 层

清洗内容：
  - 过滤已删除记录（is_delete = 1）
  - 枚举字段转文本（customer_type、detail_type、server_type、payment_type 等）
  - 关联门店、员工维度补全名称字段
  - 生成计算字段（line_total、order_status_name 等）

使用方式：
  spark-submit \
    --master yarn \
    --deploy-mode cluster \
    ods_to_dwd.py \
    --dt 2026-04-18
"""

import argparse
import logging
from datetime import datetime, timedelta

from pyspark.sql import SparkSession, DataFrame
from pyspark.sql import functions as F
from pyspark.sql.types import StringType

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
logger = logging.getLogger(__name__)

# -------------------------------------------------------
# 枚举映射
# -------------------------------------------------------
ORDER_STATUS_MAP = {
    0: "待结算",
    1: "已结算",
    2: "已取消",
    3: "退单",
}

CUSTOMER_TYPE_MAP = {
    0: "会员",
    1: "散客",
}

DETAIL_TYPE_MAP = {
    0: "产品",
    1: "服务",
    2: "套餐",
}

SERVER_TYPE_MAP = {
    0: "点钟",
    1: "加钟",
    2: "轮牌",
}

PAYMENT_TYPE_MAP = {
    0: "微信支付",
    1: "支付宝",
    2: "现金",
    3: "会员卡",
    4: "POS机",
    5: "银行卡",
    6: "电子优惠券",
}

ACTIVE_TYPE_MAP = {
    1: "订单消费",
    2: "退单",
    3: "会员充值",
}

SERVICE_TYPE_MAP = {
    1: "服务项目",
    2: "产品销售",
    3: "充值",
}

ITEM_TYPE_MAP = {
    0: "点钟",
    1: "加钟",
    2: "轮牌",
    3: "其他",
}


def create_spark_session() -> SparkSession:
    return (
        SparkSession.builder
        .appName("SmartPOS_ODS_to_DWD")
        .config("spark.sql.hive.convertMetastoreOrc", "true")
        .config("spark.sql.sources.partitionOverwriteMode", "dynamic")
        .enableHiveSupport()
        .getOrCreate()
    )


def map_enum(df: DataFrame, src_col: str, new_col: str, mapping: dict) -> DataFrame:
    """将整型枚举列映射为中文名称列"""
    mapping_expr = F.create_map([F.lit(x) for pair in mapping.items() for x in pair])
    return df.withColumn(new_col, mapping_expr[F.col(src_col).cast("int")])


def build_dwd_order_detail(spark: SparkSession, dt: str) -> None:
    """构建订单明细宽表 dwd_order_detail"""
    logger.info("开始构建 dwd_order_detail，日期: %s", dt)

    # 读取 ODS 数据
    order_info = (
        spark.table("pos_ods.ods_order_info")
        .filter(F.col("dt") == dt)
        .filter(F.col("is_delete") == 0)
        .select(
            F.col("id").alias("order_id"),
            "order_no", "order_time", "settle_time", "order_status",
            "customer_type", "total_amount", "actual_amount", "discount_amount",
            "vip_id", "vip_name", "vip_card_number",
            F.col("user_id").alias("cashier_id"),
            F.col("user_name").alias("cashier_name"),
            "bed_id", "bed_name", "org_id",
        )
    )

    order_detail = (
        spark.table("pos_ods.ods_order_detail")
        .filter(F.col("dt") == dt)
        .filter(F.col("is_delete") == 0)
        .select(
            F.col("id").alias("detail_id"),
            F.col("order_id"),
            F.col("user_id").alias("technician_id"),
            "detail_type", "server_id", "server_type",
            "std_price", "vip_price", "true_price", "quantity",
            "timer_minutes",
        )
    )

    org_dim = (
        spark.table("pos_ods.ods_sys_org")
        .filter(F.col("is_delete") == 0)
        .select(F.col("id").alias("org_id"), F.col("org_name"))
    )

    user_dim = (
        spark.table("pos_ods.ods_sys_user")
        .filter(F.col("is_delete") == 0)
        .select(
            F.col("id").alias("user_id"),
            F.col("user_name").alias("dim_user_name"),
        )
    )

    # 关联
    df = (
        order_detail
        .join(order_info, "order_id", "left")
        .join(org_dim, "org_id", "left")
        .join(
            user_dim.alias("technician"),
            F.col("technician_id") == F.col("technician.user_id"),
            "left"
        )
        .withColumnRenamed("dim_user_name", "technician_name")
    )

    # 枚举映射
    df = map_enum(df, "order_status", "order_status_name", ORDER_STATUS_MAP)
    df = map_enum(df, "customer_type", "customer_type_name", CUSTOMER_TYPE_MAP)
    df = map_enum(df, "detail_type", "detail_type_name", DETAIL_TYPE_MAP)
    df = map_enum(df, "server_type", "server_type_name", SERVER_TYPE_MAP)

    # 计算行小计
    df = df.withColumn(
        "line_total",
        F.coalesce(F.col("true_price"), F.lit(0)) * F.coalesce(F.col("quantity"), F.lit(1))
    )

    # 选择输出列
    output_cols = [
        "order_id", "order_no", "order_time", "settle_time",
        "order_status", "order_status_name", "customer_type", "customer_type_name",
        "total_amount", "actual_amount", "discount_amount",
        "vip_id", "vip_name", "vip_card_number",
        "cashier_id", "cashier_name", "bed_id", "bed_name",
        "org_id", "org_name",
        "detail_id", "detail_type", "detail_type_name",
        "server_id", "server_type", "server_type_name",
        "technician_id", "technician_name",
        "std_price", "vip_price", "true_price", "quantity", "line_total",
        "timer_minutes",
    ]

    (
        df.select(*output_cols)
        .withColumn("dt", F.lit(dt))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("dt")
        .saveAsTable("pos_dwd.dwd_order_detail")
    )
    logger.info("dwd_order_detail 构建完成")


def build_dwd_payment_detail(spark: SparkSession, dt: str) -> None:
    """构建支付明细宽表 dwd_payment_detail"""
    logger.info("开始构建 dwd_payment_detail，日期: %s", dt)

    payment = (
        spark.table("pos_ods.ods_payment_detail")
        .filter(F.col("dt") == dt)
        .filter(F.col("is_delete") == 0)
    )

    org_dim = (
        spark.table("pos_ods.ods_sys_org")
        .filter(F.col("is_delete") == 0)
        .select(F.col("id").alias("org_id"), F.col("org_name"))
    )

    df = payment.join(org_dim, "org_id", "left")
    df = map_enum(df, "active_type", "active_type_name", ACTIVE_TYPE_MAP)
    df = map_enum(df, "payment_type", "payment_name_calc", PAYMENT_TYPE_MAP)

    # payment_name 优先使用原始字段，为 null 时用枚举映射
    df = df.withColumn(
        "payment_name",
        F.coalesce(F.col("payment_name"), F.col("payment_name_calc"))
    )

    output_cols = [
        "id", "create_time",
        "active_type", "active_type_name", "active_code", "active_name",
        "payment_type", "payment_name", "total_amount", "payment_status",
        "org_id", "org_name",
    ]

    (
        df.select(*output_cols)
        .withColumn("dt", F.lit(dt))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("dt")
        .saveAsTable("pos_dwd.dwd_payment_detail")
    )
    logger.info("dwd_payment_detail 构建完成")


def build_dwd_kpi_detail(spark: SparkSession, dt: str) -> None:
    """构建绩效明细宽表 dwd_kpi_detail"""
    logger.info("开始构建 dwd_kpi_detail，日期: %s", dt)

    kpi = (
        spark.table("pos_ods.ods_kpi_detail")
        .filter(F.col("dt") == dt)
        .filter(F.col("is_delete") == 0)
    )

    org_dim = (
        spark.table("pos_ods.ods_sys_org")
        .filter(F.col("is_delete") == 0)
        .select(F.col("id").alias("org_id"), F.col("org_name"))
    )

    user_dim = (
        spark.table("pos_ods.ods_sys_user")
        .filter(F.col("is_delete") == 0)
        .select(
            F.col("id").alias("user_id"),
            F.col("user_position"),
        )
    )

    df = (
        kpi
        .join(org_dim, "org_id", "left")
        .join(user_dim, "user_id", "left")
    )

    df = map_enum(df, "service_type", "service_type_name", SERVICE_TYPE_MAP)
    df = map_enum(df, "item_type", "item_type_name", ITEM_TYPE_MAP)

    output_cols = [
        "id", "create_time",
        "service_code", "service_name", "service_type", "service_type_name",
        "item_type", "item_type_name",
        "user_id", "user_name", "user_position",
        "performance", "commission",
        "org_id", "org_name",
    ]

    (
        df.select(*output_cols)
        .withColumn("dt", F.lit(dt))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("dt")
        .saveAsTable("pos_dwd.dwd_kpi_detail")
    )
    logger.info("dwd_kpi_detail 构建完成")


def build_dwd_vip_order(spark: SparkSession, dt: str) -> None:
    """构建会员消费明细宽表 dwd_vip_order"""
    logger.info("开始构建 dwd_vip_order，日期: %s", dt)

    order_info = (
        spark.table("pos_ods.ods_order_info")
        .filter(F.col("dt") == dt)
        .filter(F.col("is_delete") == 0)
        .filter(F.col("customer_type") == 0)  # 仅会员订单
        .filter(F.col("order_status") == 1)    # 仅已结算
    )

    vip_dim = (
        spark.table("pos_ods.ods_vip_info")
        .filter(F.col("is_delete") == 0)
        .select(
            F.col("id").alias("vip_id"),
            F.col("phone_number").alias("vip_phone_number"),
            F.col("create_time").alias("vip_register_time"),
            F.col("balance").alias("vip_balance"),
        )
        # 取最新分区（全量表取最新快照）
        .filter(F.col("dt") == dt)
    )

    org_dim = (
        spark.table("pos_ods.ods_sys_org")
        .filter(F.col("is_delete") == 0)
        .select(F.col("id").alias("org_id"), F.col("org_name"))
    )

    df = (
        order_info
        .join(vip_dim, "vip_id", "left")
        .join(org_dim, "org_id", "left")
        .select(
            F.col("id").alias("order_id"),
            "order_no", "order_time", "settle_time", "actual_amount",
            "vip_id", "vip_name", "vip_card_number",
            "vip_phone_number", "vip_register_time", "vip_balance",
            "org_id", "org_name",
        )
    )

    (
        df.withColumn("dt", F.lit(dt))
        .write
        .format("orc")
        .mode("overwrite")
        .partitionBy("dt")
        .saveAsTable("pos_dwd.dwd_vip_order")
    )
    logger.info("dwd_vip_order 构建完成")


def run(dt: str) -> None:
    spark = create_spark_session()
    logger.info("ODS → DWD 清洗开始，日期: %s", dt)

    tasks = [
        ("dwd_order_detail", build_dwd_order_detail),
        ("dwd_payment_detail", build_dwd_payment_detail),
        ("dwd_kpi_detail", build_dwd_kpi_detail),
        ("dwd_vip_order", build_dwd_vip_order),
    ]

    for table_name, task_fn in tasks:
        try:
            task_fn(spark, dt)
        except Exception as e:
            logger.error("构建 %s 失败: %s", table_name, e, exc_info=True)

    logger.info("ODS → DWD 清洗完成")
    spark.stop()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Smart POS ODS → DWD 数据清洗")
    parser.add_argument(
        "--dt",
        default=None,
        help="数据日期，格式 YYYY-MM-DD（默认为昨天）"
    )
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    dt = args.dt or (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
    run(dt=dt)
