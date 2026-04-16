"""
杨波采耳老系统会员数据导出脚本

通过 API 接口从老系统导出会员信息、会员卡和优惠券数据，
保存为 vip_info.json、vip_asset.json、vip_info_ticket.json 文件。

接口响应结构（经实际测试确认）:
  - 会员列表: { code, total, rows: [...] }
  - 会员卡:   { code, data: { memberId, memberOrgFinInfos: [...] } }
  - 优惠券:   { code, total, rows: [...] }
"""

import json
import time
import os
import requests

# ============ 配置 ============
BASE_URL = "https://syb.ddbtec.com/api/v2/sys"
TOKEN = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ7XCJhZGRyZXNzXCI6XCJcIixcImJhbmtOb1wiOlwiXCIsXCJiYW5rVHlwZVwiOlwiXCIsXCJiYXNpY1NhbGFyeVwiOjAuMCxcImNlbGxQaG9uZU5vXCI6XCIxNTkzOTc1OTI3MVwiLFwiY2VsbFBob25lTm9FeHRcIjpcIlwiLFwiY3JlYXRlVGltZVwiOjE3NDIyMTM4NDIwMDAsXCJkZXBhcnRtZW50XCI6MjQwMjUsXCJlbWVyZ2VuY3lDb250YWN0XCI6XCJcIixcImVtZXJnZW5jeVJlbGF0aW9uXCI6XCJcIixcImVtZXJnZW5jeVRlbE5vXCI6XCJcIixcImVudHJ5RGF0ZVwiOjE3NDIxNDA4MDAwMDAsXCJoZWFkZXJVcmxcIjpcIlwiLFwiaWRcIjo1NjAzMSxcImlkQ2FyZE5vXCI6XCJcIixcImxvZ2luQWNjZXNzXCI6MSxcImxvZ2luQWNjZXNzQXBwXCI6MSxcImxvZ2luQWNjZXNzTWdyQXBwXCI6MSxcImxvZ2luQ2xpVHlwZVwiOjEsXCJsb2dpblRpbWVcIjoxNzc2MzQ1NTk0LFwibG9naW5Vc2VyTmFtZVwiOlwiODg4XCIsXCJsb2dpblVzZXJQd2RcIjpcIjEyMzQ1NlwiLFwibWFycmlhZ2VTdGF0ZVwiOjEzLFwibWdyV3hMYXN0TG9naW5cIjowLFwib25Kb2JTdGF0dXNcIjoxMzksXCJvcmdJZFwiOjE0NTksXCJwb3N0VHlwZVwiOjIzOTk5LFwicmVtYXJrXCI6XCJcIixcInNleHVhbGl0eVwiOjk3LFwic3RhZmZOYW1lXCI6XCLlvIDlj5HmtYvor5XotKblj7dcIixcInN0YW5kYXJkT2ZDYWx0dXJlXCI6OTksXCJ0aXRsZVR5cGVcIjowLFwidG9rZW5UaW1lU3RhcnRcIjowLFwidXBkYXRlVGltZVwiOjE3NDkxNDAwMDAwMDAsXCJ1cGRhdGVVc2VyXCI6NDY3MTMsXCJ3eE9wZW5JZFwiOlwiXCIsXCJ3eFVuaXRJZFwiOlwiXCJ9IiwianRpIjoiODlmMzc1ZGEtMjM1NC00NTZlLWE4MzgtMmQ2ODgzYzYwZDI1IiwiaWF0IjoxNzc2MzQ1NTk0LCJleHAiOjE3NzY0MzE5OTR9.wLaCMLsuAwIvo_E7q-PnPrM6uYy3Dt-lAlnTYIZ6VkA"
ORG_ID = 1459
PAGE_SIZE = 10000
OUTPUT_DIR = os.path.dirname(os.path.abspath(__file__))

HEADERS = {
    "Accept": "application/json, text/plain, */*",
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
    "Authorization": TOKEN,
    "Connection": "keep-alive",
    "Content-Type": "application/json;charset=UTF-8",
    "Origin": "https://ybce.ddbtec.com",
    "Referer": "https://ybce.ddbtec.com/",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36",
}


def fetch_member_list(page=1):
    """查询会员列表 — 响应: { code, total, rows }"""
    url = f"{BASE_URL}/member/list"
    payload = {
        "current": page,
        "size": PAGE_SIZE,
        "orderBy": "linkNum",
        "sortAsc": False,
        "onlySelUnion": True,
        "orgId": ORG_ID,
    }
    resp = requests.post(url, json=payload, headers=HEADERS, timeout=100)
    resp.raise_for_status()
    result = resp.json()
    if result.get("code") != "200":
        raise ValueError(f"接口返回错误: code={result.get('code')}")
    return result.get("rows", []), result.get("total", 0)


def fetch_member_cards(member_id):
    """查询会员卡列表 — 响应: { code, data: { memberOrgFinInfos: [...] } }"""
    url = f"{BASE_URL}/member/get/org/fins/{member_id}"
    resp = requests.post(url, headers=HEADERS, timeout=30)
    resp.raise_for_status()
    result = resp.json()
    if result.get("code") != "200":
        raise ValueError(f"接口返回错误: code={result.get('code')}")
    data = result.get("data", {})
    if isinstance(data, dict):
        return data.get("memberOrgFinInfos", [])
    return []


def fetch_member_coupons(member_id):
    """查询会员优惠券列表 — 响应: { code, total, rows }"""
    url = f"{BASE_URL}/coupon/rec/list"
    payload = {"memberId": member_id, "isFilter": True}
    resp = requests.post(url, json=payload, headers=HEADERS, timeout=30)
    resp.raise_for_status()
    result = resp.json()
    if result.get("code") != "200":
        raise ValueError(f"接口返回错误: code={result.get('code')}")
    return result.get("rows", [])


def save_json(filename, data):
    """保存 JSON 文件"""
    filepath = os.path.join(OUTPUT_DIR, filename)
    with open(filepath, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    print(f"已保存: {filepath}")


def main():
    print("=" * 60)
    print("杨波采耳老系统 - 会员数据导出工具")
    print("=" * 60)

    # 1. 获取全部会员列表
    print("\n[1/3] 正在获取会员列表...")
    members, total = fetch_member_list(page=1)
    print(f"共获取 {len(members)} 条会员记录 (总计 {total})")

    if not members:
        print("未获取到会员数据，退出。")
        return

    save_json("vip_info.json", members)

    # 2. 逐个查询会员卡
    print(f"\n[2/3] 正在查询会员卡数据 ({len(members)} 个会员)...")
    all_cards = []
    fail_count = 0
    for i, member in enumerate(members):
        member_id = member.get("id")
        if not member_id:
            continue
        try:
            cards = fetch_member_cards(member_id)
            all_cards.extend(cards)
            count = len(cards)
        except Exception as e:
            count = -1
            fail_count += 1
            print(f"\n  警告: 会员 {member_id} 卡片查询失败: {e}")
        print(f"  [{i + 1}/{len(members)}] 会员 {member_id}: {count} 张卡", end="\r")
        # 控制请求频率
        if (i + 1) % 50 == 0:
            time.sleep(1)

    print(f"\n共获取 {len(all_cards)} 条会员卡记录 (失败 {fail_count} 个)")
    save_json("vip_asset.json", all_cards)

    # 3. 逐个查询会员优惠券
    print(f"\n[3/3] 正在查询优惠券数据 ({len(members)} 个会员)...")
    all_coupons = []
    fail_count = 0
    for i, member in enumerate(members):
        member_id = member.get("id")
        if not member_id:
            continue
        try:
            coupons = fetch_member_coupons(member_id)
            all_coupons.extend(coupons)
            count = len(coupons)
        except Exception as e:
            count = -1
            fail_count += 1
            print(f"\n  警告: 会员 {member_id} 优惠券查询失败: {e}")
        print(f"  [{i + 1}/{len(members)}] 会员 {member_id}: {count} 张券", end="\r")
        # 控制请求频率
        if (i + 1) % 50 == 0:
            time.sleep(1)

    print(f"\n共获取 {len(all_coupons)} 条优惠券记录 (失败 {fail_count} 个)")
    save_json("vip_info_ticket.json", all_coupons)

    # 汇总
    print("\n" + "=" * 60)
    print("导出完成")
    print("=" * 60)
    print(f"会员信息 (vip_info.json):       {len(members)} 条")
    print(f"会员卡   (vip_asset.json):      {len(all_cards)} 条")
    print(f"优惠券   (vip_info_ticket.json): {len(all_coupons)} 条")
    print("=" * 60)


if __name__ == "__main__":
    main()
