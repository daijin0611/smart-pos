"""
美管家系统会员卡数据导入脚本

将美管家系统导出的会员卡 JSON 数据转换为 SQL INSERT 语句，用于导入 POS 系统数据库。
生成 vip_info（会员信息）和 vip_asset（会员卡资产）两张表的 INSERT 语句。
"""

import json
import os
import sys
from datetime import datetime
from collections import defaultdict
from tkinter import Tk, filedialog


def select_json_file():
    """弹窗选择 JSON 数据文件"""
    root = Tk()
    root.withdraw()
    file_path = filedialog.askopenfilename(
        title="选择美管家会员卡 JSON 数据文件",
        filetypes=[("JSON 文件", "*.json"), ("所有文件", "*.*")]
    )
    root.destroy()
    if not file_path:
        print("未选择文件，退出。")
        sys.exit(0)
    return file_path


def load_json(file_path):
    """加载 JSON 数据"""
    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    content = data.get("content", [])
    if not content:
        print("JSON 数据中未找到 content 数组或数据为空，退出。")
        sys.exit(0)
    return content


def group_by_member(cards):
    """按 memberid 分组"""
    groups = defaultdict(list)
    for card in cards:
        member_id = card.get("memberid")
        if member_id:
            groups[member_id].append(card)
    return groups


def convert_sex(sex):
    """转换性别：F->1, M->0"""
    if sex == "F":
        return 1
    elif sex == "M":
        return 0
    return None


def ts_to_sql_datetime(ts):
    """时间戳（毫秒）转 SQL datetime 字符串"""
    if ts is None:
        return None
    try:
        dt = datetime.fromtimestamp(int(ts) / 1000)
        return dt.strftime("%Y-%m-%d %H:%M:%S")
    except (ValueError, TypeError, OSError):
        return None


def ts_to_sql_date(ts):
    """时间戳（毫秒）转 SQL date 字符串"""
    if ts is None:
        return None
    try:
        dt = datetime.fromtimestamp(int(ts) / 1000)
        return dt.strftime("%Y-%m-%d")
    except (ValueError, TypeError, OSError):
        return None


def escape_sql(value):
    """转义 SQL 字符串中的特殊字符"""
    if value is None:
        return None
    return str(value).replace("\\", "\\\\").replace("'", "\\'")


def generate_vip_info_sql(member_groups, org_id):
    """
    生成 vip_info INSERT 语句
    按 memberid 聚合会员信息
    """
    columns = [
        "name", "gender", "card_number", "phone_number", "balance",
        "last_consumption_time", "create_time", "update_time",
        "pwd", "org_id", "is_delete", "remark", "old_vip_json"
    ]
    col_str = ", ".join(columns)

    all_values = []
    for member_id, cards in member_groups.items():
        # 按 opendate 排序，取最新卡作为会员主信息
        cards_sorted = sorted(cards, key=lambda c: c.get("opendate") or 0, reverse=True)
        latest_card = cards_sorted[0]

        name = escape_sql(latest_card.get("name"))
        gender = convert_sex(latest_card.get("sex"))
        raw_phone = str(latest_card.get("mobile") or "")
        phone_number = escape_sql(raw_phone[:11])  # varchar(11) 限制

        # 余额 = 所有卡的 cardfee 之和
        balance = sum(float(c.get("cardfee", 0) or 0) for c in cards)

        # 最晚消费时间
        consume_times = [c.get("lastconsumetime") for c in cards if c.get("lastconsumetime")]
        last_consume_ts = max(consume_times) if consume_times else None
        last_consumption_time = ts_to_sql_date(last_consume_ts)

        # 最早开卡时间
        open_times = [c.get("opendate") for c in cards if c.get("opendate")]
        create_ts = min(open_times) if open_times else None
        create_time = ts_to_sql_datetime(create_ts)

        # 拼接所有卡的 cardRemark 作为备注（去重去空）
        remarks = []
        for c in cards:
            cr = c.get("cardRemark")
            if cr and cr.strip():
                remarks.append(cr.strip())
        remark_str = "美管家导入"
        if remarks:
            unique_remarks = list(dict.fromkeys(remarks))  # 去重保持顺序
            remark_str += " " + "; ".join(unique_remarks)

        # old_vip_json：保存该会员所有卡的原始数据
        old_vip_json = escape_sql(json.dumps(cards, ensure_ascii=False))

        values = [
            f"'{name}'" if name else "NULL",
            str(gender) if gender is not None else "NULL",
            f"'{escape_sql(str(member_id))}'",
            f"'{phone_number}'" if phone_number else "NULL",
            f"{balance:.2f}",
            f"'{last_consumption_time}'" if last_consumption_time else "NULL",
            f"'{create_time}'" if create_time else "NOW()",
            "NOW()",
            "'123456'",
            str(org_id),
            "0",
            f"'{escape_sql(remark_str)}'",
            f"'{old_vip_json}'"
        ]
        all_values.append(f"({', '.join(values)})")

    return columns, all_values


def generate_vip_asset_sql(cards, org_id):
    """
    生成 vip_asset INSERT 语句
    每条卡生成 1 条充值金记录，presentfee > 0 时额外生成 1 条赠送金记录
    """
    columns = [
        "asset_num", "asset_name", "asset_balance", "asset_type",
        "asset_discount_base", "asset_discount_rate", "asset_is_cross_store",
        "asset_card_number", "vip_card_number", "card_type_id",
        "vip_id", "org_id", "create_time", "update_time",
        "is_delete", "version", "remark"
    ]
    col_str = ", ".join(columns)

    recharge_values = []
    gift_values = []

    for card in cards:
        card_id = escape_sql(card.get("cardid", ""))
        card_type_name = escape_sql(card.get("cardtypename", ""))
        shop_name = escape_sql(card.get("shopname", ""))
        card_fee = float(card.get("cardfee", 0) or 0)
        present_fee = float(card.get("presentfee", 0) or 0)
        discount = float(card.get("discount", 0) or 0)
        card_type_id = escape_sql(str(card.get("cardtypeid", "")))
        member_id = escape_sql(str(card.get("memberid", "")))
        open_ts = card.get("opendate")
        create_time = ts_to_sql_datetime(open_ts)

        # 折扣率转换：美管家 * 10（如 6.9 -> 69），0 视为无折扣即 100
        discount_rate = discount * 10 if discount > 0 else 100

        # 充值金记录
        remark = f"美管家系统迁移-{shop_name}-{card_type_name}-{discount_rate:.0f}-否"

        recharge_vals = [
            f"'{card_id}'",
            f"'{card_type_name}'",
            f"{card_fee:.2f}",
            "0",  # asset_type: 充值金
            "0",  # asset_discount_base: 标准价
            f"{discount_rate:.0f}",
            "1",  # asset_is_cross_store: 允许
            "''",
            f"'{member_id}'",
            f"'{card_type_id}'",
            "NULL",  # vip_id
            str(org_id),
            f"'{create_time}'" if create_time else "NOW()",
            "NOW()",
            "0",
            "0",
            f"'{escape_sql(remark)}'"
        ]
        recharge_values.append(f"({', '.join(recharge_vals)})")

        # 赠送金记录（仅 presentfee > 0 时）
        if present_fee > 0:
            gift_remark = f"美管家系统迁移-{shop_name}-{card_type_name}-{discount_rate:.0f}-是"

            gift_vals = [
                f"'{card_id}_gift'",
                f"'{card_type_name}'",
                f"{present_fee:.2f}",
                "1",  # asset_type: 赠送金
                "0",  # asset_discount_base: 标准价
                f"{discount_rate:.0f}",  # 赠送金折扣率与充值金一致
                "1",  # asset_is_cross_store: 允许
                "''",
                f"'{member_id}'",
                f"'{card_type_id}'",
                "NULL",
                str(org_id),
                f"'{create_time}'" if create_time else "NOW()",
                "NOW()",
                "0",
                "0",
                f"'{escape_sql(gift_remark)}'"
            ]
            gift_values.append(f"({', '.join(gift_vals)})")

    return columns, recharge_values, gift_values


def batch_insert_sql(table, columns, values_list, batch_size=500):
    """生成批量 INSERT SQL，每 batch_size 条一组"""
    col_str = ", ".join(columns)
    sql_parts = []
    for i in range(0, len(values_list), batch_size):
        batch = values_list[i:i + batch_size]
        sql_parts.append(
            f"INSERT INTO {table} ({col_str}) VALUES\n"
            + ",\n".join(batch)
            + ";\n"
        )
    return sql_parts


def main():
    print("=" * 60)
    print("美管家系统会员卡数据导入工具")
    print("=" * 60)

    # 1. 选择文件
    json_file = select_json_file()
    print(f"已选择文件: {json_file}")

    # 2. 输入门店 ID
    org_id = input("请输入门店 org_id: ").strip()
    if not org_id:
        print("org_id 不能为空，退出。")
        sys.exit(1)

    # 3. 输出文件路径
    output_file = input("请输入输出 SQL 文件路径 (默认: ./import_vip.sql): ").strip()
    if not output_file:
        output_file = "./import_vip.sql"

    # 4. 加载数据
    print("\n正在加载数据...")
    cards = load_json(json_file)
    print(f"读取到 {len(cards)} 条会员卡记录")

    # 5. 按 memberid 分组
    member_groups = group_by_member(cards)
    print(f"识别到 {len(member_groups)} 个唯一会员")

    # 6. 生成 VIP 信息 SQL
    print("\n正在生成 SQL...")
    info_columns, info_values = generate_vip_info_sql(member_groups, org_id)

    # 7. 生成 VIP 资产 SQL
    asset_columns, recharge_values, gift_values = generate_vip_asset_sql(cards, org_id)

    # 8. 组装 SQL 文件
    now_str = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    sql_lines = [
        f"-- 美管家系统会员卡数据导入 SQL",
        f"-- 生成时间: {now_str}",
        f"-- 源文件: {os.path.basename(json_file)}",
        f"-- 门店 org_id: {org_id}",
        f"-- 原始卡片数: {len(cards)}",
        f"-- 会员数: {len(member_groups)}",
        f"-- 充值金资产数: {len(recharge_values)}",
        f"-- 赠送金资产数: {len(gift_values)}",
        "",
        "START TRANSACTION;",
        "",
        "-- ============================================",
        "-- 会员信息 (vip_info)",
        "-- ============================================",
        "",
    ]

    # vip_info INSERT
    info_sqls = batch_insert_sql("vip_info", info_columns, info_values)
    sql_lines.extend(info_sqls)

    sql_lines.extend([
        "",
        "-- ============================================",
        "-- 会员卡资产 - 充值金 (vip_asset)",
        "-- ============================================",
        "",
    ])

    # vip_asset 充值金 INSERT
    recharge_sqls = batch_insert_sql("vip_asset", asset_columns, recharge_values)
    sql_lines.extend(recharge_sqls)

    if gift_values:
        sql_lines.extend([
            "",
            "-- ============================================",
            "-- 会员卡资产 - 赠送金 (vip_asset)",
            "-- ============================================",
            "",
        ])
        gift_sqls = batch_insert_sql("vip_asset", asset_columns, gift_values)
        sql_lines.extend(gift_sqls)

    sql_lines.extend([
        "",
        "COMMIT;",
        ""
    ])

    # 9. 写入文件
    with open(output_file, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_lines))

    # 10. 输出统计
    print("\n" + "=" * 60)
    print("导入统计")
    print("=" * 60)
    print(f"原始卡片数:       {len(cards)}")
    print(f"会员 (vip_info):  {len(info_values)} 条")
    print(f"充值金 (asset):   {len(recharge_values)} 条")
    print(f"赠送金 (asset):   {len(gift_values)} 条")
    print(f"资产总计:         {len(recharge_values) + len(gift_values)} 条")
    print(f"\nSQL 文件已生成: {os.path.abspath(output_file)}")
    print("=" * 60)


if __name__ == "__main__":
    main()
