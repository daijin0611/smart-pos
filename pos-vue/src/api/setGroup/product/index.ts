import { get, post, put, ContentType } from '@/utils/request';

enum API {
  LIST_URL = '/server/product/query-list',
  INFO_URL = '/server/product/query-info',
  ADD_URL = '/server/product/add-product',
  UPDATE_URL = '/server/product/update-product',
  UPDATE_STATUS_URL = '/server/product/update-status',
}

export const reqProductList = (params = {}) => get(API.LIST_URL, params);

export const reqProductInfo = (params = {}) => get(API.INFO_URL, params);

export const reqAddProduct = (data = {}) => post(API.ADD_URL, data);

export const reqUpdateProduct = (data = {}) => put(API.UPDATE_URL, data);

export const reqUpdateStatus = (data = {}) => put(API.UPDATE_STATUS_URL, data, ContentType.URLencoded);
