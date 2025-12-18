import requests
import json

url = "https://api.coze.cn/v1/workflow/run"

payload = json.dumps({
   "workflow_id": "7584772212822556713",
   "app_id": "7584745354521051182",
   "parameters": {
      "password": "jy123123",
      "username": "锦艺城2店",
      "org_id": 8
   }
})
headers = {
   'Authorization': 'Bearer pat_ZwgEQmYEOie6TwcgdGitfnTRJZTF1jqV74z57MFtxWEqrBNXDeBrxHMNSoYr4AmG',
   'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)

data = json.loads(response.text)['data']


vip_asset_list = json.loads(data)['vip_asset_list']
vip_asset_json = json.dumps(vip_asset_list, ensure_ascii=False, indent=2)
output_path = '../data/vip_asset.json'
with open(output_path, 'w', encoding='utf-8') as f:
    f.write(vip_asset_json)
print(f"Successfully exported {len(vip_asset_list)} VIP assets to {output_path}")


vip_info_list = json.loads(data)['vip_info_list']
vip_info_json = json.dumps(vip_info_list, ensure_ascii=False, indent=2)
output_path = '../data/vip_info.json'
with open(output_path, 'w', encoding='utf-8') as f:
    f.write(vip_info_json)
print(f"Successfully exported {len(vip_info_list)} VIP assets to {output_path}")