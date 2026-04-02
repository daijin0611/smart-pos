import { get, post, put, ContentType } from '@/utils/request';

enum API {
  LIST_URL = '/server/item/query-list',
  INFO_URL = '/server/item/query-info',
  ADD_URL = '/server/item/add-item',
  UPDATE_URL = '/server/item/update-item',
  UPDATE_STATUS_URL = '/server/item/update-status',
}

export const reqServiceItemList = (params = {}) => get(API.LIST_URL, params);

export const reqServiceItemInfo = (id: number) => get(API.INFO_URL, { id });

export const reqAddServiceItem = (data = {}) => post(API.ADD_URL, data);

export const reqUpdateServiceItem = (data = {}) => put(API.UPDATE_URL, data);

export const reqUpdateServiceItemStatus = (data = {}) => put(API.UPDATE_STATUS_URL, data, ContentType.URLencoded);
