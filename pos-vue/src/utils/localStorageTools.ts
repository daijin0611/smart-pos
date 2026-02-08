// 封装本地存储存储数据与读取数据方法

interface Key {
  USER_INFO: string;
  TOKEN: string;
  ORG_INFO: string;
}

/**
 * 本地存储的键
 */
const Key: Key = {
  USER_INFO: 'USER_INFO',
  TOKEN: 'TOKEN',
  ORG_INFO: 'ORG_INFO',
};

/**
 * 本地存储数据
 * @param key 键
 * @param data 值
 */
export const setLocalStorage = (key: string, data: any) => {
  try {
    localStorage.setItem(key, JSON.stringify(data));
  } catch (error) {
    console.error(`【${key}】本地存储失败：`, error);
  }
};

/**
 * 获取本地存储数据
 * @param key 键
 * @returns 值
 */
export const getLocalStorage = (key: string) => {
  try {
    const data = localStorage.getItem(key);
    if (data) {
      return JSON.parse(data);
    }
  } catch (error) {
    console.error(`【${key}】获取本地存储失败：`, error);
  }
  return null;
};

/**
 * 删除本地存储数据
 * @param key 键
 */
export const removeLocalStorage = (key: string) => {
  try {
    localStorage.removeItem(key);
  } catch (error) {
    console.error(`【${key}】删除本地存储失败：`, error);
  }
};

/**
 * 本地存储用户信息
 * @param userInfo 用户信息
 */
export const setUserInfo = (userInfo: any) => setLocalStorage(Key.USER_INFO, userInfo);

/**
 * 获取本地存储用户信息
 * @returns 用户信息
 */
export const getUserInfo = () => getLocalStorage(Key.USER_INFO);

/**
 * 删除本地存储用户信息
 */
export const removeUserInfo = () => removeLocalStorage(Key.USER_INFO);

/**
 * 本地存储token
 * @param token token
 */
export const setToken = (token: string) => localStorage.setItem(Key.TOKEN, token);

/**
 * 获取本地存储token
 * @returns token
 */
export const getToken = () => localStorage.getItem(Key.TOKEN);

/**
 * 删除本地存储token
 */
export const removeToken = () => removeLocalStorage(Key.TOKEN);

/**
 * 本地存储门店信息
 * @param orgInfo 门店信息
 */
export const setOrgInfo = (orgInfo: any) => setLocalStorage(Key.ORG_INFO, orgInfo);

/**
 * 获取本地存储门店信息
 * @returns 门店信息
 */
export const getOrgInfo = () => getLocalStorage(Key.ORG_INFO) || {};

/**
 * 删除本地存储门店信息
 */
export const removeOrgInfo = () => removeLocalStorage(Key.ORG_INFO);
