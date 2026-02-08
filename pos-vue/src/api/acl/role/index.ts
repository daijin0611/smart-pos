import { get, post, put, ContentType } from '@/utils/request';

//枚举地址
enum API {
  LIST_URL = '/system/role/query-list',
  ADD_URL = '/system/role/add-role',
  UPDATE_URL = '/system/role/update-role',
  UPDATE_STATUS_URL = '/system/role/update-status',
  ALLOCATED_LIST_URL = '/system/role/query-allocated-list',
  UNALLOCATED_LIST_URL = '/system/role/query-unallocated-list',
  ADD_ALLOCATED_USER_URL = '/system/role/add-user',
  ADD_ALLOCATED_PERMISSION_URL = '/system/role/add-permission',
  QUERY_TREE_URL = '/system/role/query-tree',
}

export const reqList = (params: any) => get(API.LIST_URL, params);

export const reqAdd = (params: any) => post(API.ADD_URL, params);

export const reqUpdate = (params: any) => put(API.UPDATE_URL, params);

export const reqUpdateStatus = (params: any) => put(API.UPDATE_STATUS_URL, params, ContentType.URLencoded);

export const reqAllocatedList = (roleId: number) => get(API.ALLOCATED_LIST_URL, { roleId });

export const reqUnallocatedList = () => get(API.UNALLOCATED_LIST_URL);

export const reqAddAllocatedUser = (params: any) => post(API.ADD_ALLOCATED_USER_URL, params);

export const reqAddAllocatedPerm = (params: any) => post(API.ADD_ALLOCATED_PERMISSION_URL, params);

export const reqQueryTree = (params: any) => get(API.QUERY_TREE_URL, params);
