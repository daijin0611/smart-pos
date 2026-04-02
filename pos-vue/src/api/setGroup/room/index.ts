import { get, post, put, ContentType } from '@/utils/request';

enum API {
  // 房间
  LIST_URL = '/room/list',
  ADD_URL = '/room/add',
  UPDATE_URL = '/room/update',

  // 床位
  BED_LIST_ALL = '/room/bed/query-all',
  BED_LIST = '/room/bed/list',
  BED_ADD = '/room/bed/add',
  BED_UPDATE = '/room/bed/update-name',
  BED_UPDATE_STATUS = '/room/bed/update-status',
}

// 房间管理模块接口方法
export const reqRoomList = (params = {}) => get(API.LIST_URL, params);

export const reqAddRoom = (data = {}) => post(API.ADD_URL, data);

export const reqUpdateRoom = (data = {}) => put(API.UPDATE_URL, data);

// 床位管理模块接口方法
export const reqBedListAll = () => get(API.BED_LIST_ALL);

export const reqBedList = (params = {}) => get(API.BED_LIST, params);

export const reqAddBed = (data = {}) => post(API.BED_ADD, data);

export const reqUpdateBed = (data = {}) => put(API.BED_UPDATE, data, ContentType.URLencoded);

export const reqUpdateBedStatus = (data = {}) => put(API.BED_UPDATE_STATUS, data, ContentType.URLencoded);
