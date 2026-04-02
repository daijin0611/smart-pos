import { get, post, put, ContentType } from '@/utils/request';

// 项目用户相关的请求地址
enum API {
  LOGIN_URL = '/auth/login',
  USERINFO_URL = '/system/user/query-info',
  LOGOUT_URL = '/auth/logout',
  UPDATE_URL = '/system/user/update-user',
  UPDATE_PWD_URL = '/system/user/update-pwd',
}

/**
 * 登录接口
 * @param data 登录参数
 * @returns 登录结果
 */
export const reqLogin = (data: any) => post(API.LOGIN_URL, data, ContentType.URLencoded);

/**
 * 获取用户信息
 * @returns 用户信息
 */
export const reqUserInfo = (id: number) => get(API.USERINFO_URL, { id });

/**
 * 退出登录
 * @returns 退出登录结果
 */
export const reqLogout = (data: any) => post(API.LOGOUT_URL, data, ContentType.URLencoded);

/**
 * 更新用户信息
 * @param data 更新用户信息参数
 * @returns 更新用户信息结果
 */
export const reqUpdate = (data: any) => put(API.UPDATE_URL, data);

/**
 * 更新密码
 * @param data 更新密码参数
 * @returns 更新密码结果
 */
export const reqUpdatePwd = (data: any) => post(API.UPDATE_PWD_URL, data);
