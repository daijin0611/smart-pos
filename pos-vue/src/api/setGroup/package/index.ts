import { get, post, put, del } from '@/utils/request';

enum API {
  LIST_URL = '/server/package/query-list',
  INFO_URL = '/server/package/query-info',
  ADD_URL = '/server/package/add-package',
  UPDATE_URL = '/server/package/update-package',
}

export const reqPackageList = (params = {}) => get(API.LIST_URL, params);

export const reqPackageInfo = (params = {}) => get(API.INFO_URL, params);

export const reqAddPackage = (data = {}) => post(API.ADD_URL, data);

export const reqUpdatePackage = (data = {}) => put(API.UPDATE_URL, data);
