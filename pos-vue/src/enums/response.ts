export enum ResponseCode {
  UNAUTHORIZED = 401,
  FORBIDDEN = 403,
  SERVER_ERROR = 9994,
  PARAMS_INVALID = 9995,
  CONTENT_TYPE_ERR = 9996,
  API_UN_IMPL = 9997,
  SERVER_BUSY = 9998,
  FAIL = 9999,
  SUCCESS = 10000,
}

export enum ResponseCodeMeaning {
  UNAUTHORIZED = '暂未登录或TOKEN已经过期',
  FORBIDDEN = '没有相关权限',
  SERVER_ERROR = '服务器错误',
  PARAMS_INVALID = '上传参数异常',
  CONTENT_TYPE_ERR = 'ContentType错误',
  API_UN_IMPL = '功能尚未实现',
  SERVER_BUSY = '服务器繁忙',
  FAIL = '操作失败',
  SUCCESS = '操作成功',
}
