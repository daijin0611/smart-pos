// 进行axios二次封装:
import axios from 'axios';

// 引入消息提示
import $Message from '@/components/Message/index';

// 业务状态码
import { ResponseCode } from '@/enums/response';

// 引入用户相关的仓库
import useUserStore from '@/store/modules/acl/user';
// 引入配置相关的仓库
import { useSettingStore } from '@/store/modules/acl/setting';

// 创建axios实例
const request = axios.create({
  baseURL: import.meta.env.VITE_APP_BASE_API, // 基础路径
  timeout: 1000 * 10, // 超时时间
});

// 添加请求拦截器
request.interceptors.request.use((config) => {
  // 如果用户登录成功,则会携带token
  const userStore = useUserStore();
  if (userStore.token) {
    config.headers.Authorization = userStore.token;
  }
  //返回配置对象
  return config;
});

// 添加响应拦截器
request.interceptors.response.use(
  (response) => {
    const res = response.data;
    if (response.config.url !== '/auth/login' && res.code === ResponseCode.UNAUTHORIZED) {
      logout();
    }
    // if (res.code === ResponseCode.SUCCESS) {
    //   return res;
    // }
    // return Promise.reject(res);
    return res;
  },
  (error) => {
    errorHandler(error);
    return Promise.reject(error);
  },
);

/**
 * 登出操作
 */
const logout = () => {
  $Message.error('登录失效，请重新登录！');
  const userStore = useUserStore();
  userStore.clearUserInfo();
  // window.location.reload();
  window.location.href = '/#/login';
};

/**
 * 错误处理函数
 * @param error 错误对象
 */
const errorHandler = (error: any) => {
  // 关闭加载状态
  const settingStore = useSettingStore();
  settingStore.loading = false;

  // 失败回调：处理http网络错误的
  try {
    let message = '';
    const status = error.response?.status || 0;
    console.log('响应错误 = ', error);

    switch (status) {
      case 400:
        message = '请求参数错误';
        break;
      case 401:
        logout();
        break;
      case 403:
        message = '无权访问';
        break;
      case 404:
        message = '请求地址错误';
        break;
      case 500:
        message = '服务器出现问题';
        if (error.response.data.code === ResponseCode.UNAUTHORIZED) {
          logout();
        } else {
          window.location.href = '/#/500';
        }
        break;
      default:
        message = '网络出现问题';
        break;
    }
    //提示错误信息
    $Message.error(message);
  } catch (error: any) {
    console.error(error);
    $Message.error('网络出现问题');
  }
};

/**
 * 封装GET请求
 * @param url 请求地址
 * @param params 请求参数
 * @param config 请求配置
 * @returns 响应数据
 */
export const get = (url: string, params = {}, config = {}) => {
  return request({
    method: 'GET',
    url,
    params,
    ...config,
  });
};

/**
 * 封装POST请求
 * @param url 请求地址
 * @param data 请求数据
 * @param config 请求配置
 * @returns 响应数据
 */
export const post = (url: string, data = {}, config = {}) => {
  return request({
    method: 'POST',
    url,
    data,
    ...config,
  });
};

/**
 * 封装PUT请求
 * @param url 请求地址
 * @param data 请求数据
 * @param config 请求配置
 * @returns 响应数据
 */
export const put = (url: string, data = {}, config = {}) => {
  return request({
    method: 'PUT',
    url,
    data,
    ...config,
  });
};

/**
 * 封装DELETE请求
 * @param url 请求地址
 * @param data 请求数据
 * @param config 请求配置
 * @returns 响应数据
 */
export const del = (url: string, params = {}, config = {}) => {
  return request({
    method: 'DELETE',
    url,
    params,
    ...config,
  });
};

/**
 * 封装PATCH请求
 * @param url 请求地址
 * @param data 请求数据
 * @param config 请求配置
 * @returns 响应数据
 */
export const patch = (url: string, data = {}, config = {}) => {
  return request({
    method: 'PATCH',
    url,
    data,
    ...config,
  });
};

// 统一导出所有方法
export { get as GET, post as POST, put as PUT, del as DELETE, patch as PATCH };

/**
 * Content-Type 类型枚举
 */
export const ContentType = {
  JSON: { headers: { 'Content-Type': 'application/json' } },
  FormData: { headers: { 'Content-Type': 'multipart/form-data' } },
  URLencoded: { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } },
};

// 对外暴露原始request实例
export default request;
