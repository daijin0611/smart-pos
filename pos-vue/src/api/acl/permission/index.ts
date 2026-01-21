import { get, post, put, ContentType } from '@/utils/request';

//枚举地址
enum API {
  LIST_URL = '/system/permission/query-list',
  ADD_URL = '/system/permission/add-permission',
  UPDATE_URL = '/system/permission/update-permission',
  UPDATE_STATUS_URL = '/system/permission/update-permission-status',
  QUERY_TREE_URL = '/system/permission/query-tree',
  QUERY_TREE_BY_ROLE_URL = '/system/permission/query-tree-by-role/{roleId}',
  QUERY_TREE_BY_USER_URL = '/system/permission/query-tree-by-user/{userId}',
}

/**
 * 获取权限列表
 * @param params 查询参数
 * @returns 权限列表
 */
export const reqPermList = (params: any) => get(API.LIST_URL, params);

/**
 * 添加权限
 * @param data 权限数据
 * @returns 添加结果
 */
export const reqAddPerm = (data: any) => post(API.ADD_URL, data);

/**
 * 更新权限
 * @param data 权限数据
 * @returns 更新结果
 */
export const reqUpdatePerm = (data: any) => put(API.UPDATE_URL, data);

/**
 * 更新权限状态
 * @param data 权限状态
 * @returns 更新结果
 */
export const reqUpdatePermStatus = (data: any) => put(API.UPDATE_STATUS_URL, data, ContentType.URLencoded);

/**
 * 获取权限树
 * @param params 查询参数
 * @returns 权限树
 */
export const reqQueryPermTree = (params: any) => get(API.QUERY_TREE_URL, params);

/**
 * 获取角色权限树
 * @param roleId 角色ID
 * @returns 角色权限树
 */
export const reqQueryPermTreeByRole = (roleId: number) =>
  get(API.QUERY_TREE_BY_ROLE_URL.replace('{roleId}', roleId.toString()));

/**
 * 获取用户权限树
 * @param userId 用户ID
 * @returns 用户权限树
 */
export const reqQueryPermTreeByUser = (userId: number) =>
  get(API.QUERY_TREE_BY_USER_URL.replace('{userId}', userId.toString()));
