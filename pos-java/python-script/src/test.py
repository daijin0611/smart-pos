import http.client
import mimetypes
from codecs import encode

conn = http.client.HTTPSConnection("vip7.meiguanjia.net")
dataList = []
boundary = 'wL36Yn8afVp8Ag7AmP8qZ0SA4n1v9T'
dataList.append(encode('--' + boundary))
dataList.append(encode('Content-Disposition: form-data; name=jsonObj;'))

dataList.append(encode('Content-Type: {}'.format('text/plain')))
dataList.append(encode(''))

dataList.append(encode('''{
    \"searchType\": 0,
    \"keywordSearch\": \"\",
    \"shopids\": [
        1594232
    ],
    \"pageSize\": 10,
    \"pageNumber\": 0,
    \"parentShopId\": \"1594231\"
}'''))
dataList.append(encode('--' + boundary))
dataList.append(encode('Content-Disposition: form-data; name=shopid;'))

dataList.append(encode('Content-Type: {}'.format('text/plain')))
dataList.append(encode(''))

dataList.append(encode("1594232"))
dataList.append(encode('--'+boundary+'--'))
dataList.append(encode(''))
body = b'\r\n'.join(dataList)
payload = body
headers = {
   'Pragma': 'no-cache',
   'Cookie': 'shopId=1594232; userId=2282666; JSESSIONID=6952A70904F61802F5257604AE6A3E4D; token=4524ca87-dda3-4a41-af3a-6b7d9e4ba8d7; cacheShopId_4524ca87-dda3-4a41-af3a-6b7d9e4ba8d7=1594232; softgenre=2',
   'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NzU5MTg4MDAsInVzZXJJZCI6NSwiaWF0IjoxNzc1MzE0MDAwLCJqdGkiOiJjYTVkNDU0YS04ZDIyLTQwYzYtOWRkNy1lYTk0YWY2MGU2MGUiLCJ1c2VyQ29kZSI6Ik4xOTgyOTE0NzA3NCIsIm9yZ0lkIjozLCJhdXRob3JpdGllcyI6W119._XR-s8YtpO1trV369daqc5Jz73AcJnSnDQKaQ5nNUyA',
   'Content-type': 'multipart/form-data; boundary={}'.format(boundary)
}
conn.request("POST", "/shair/member!memberAdvancedSearch.action", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))
