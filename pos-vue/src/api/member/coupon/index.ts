import { get, post, put, ContentType } from '@/utils/request';

// 优惠券管理模块接口地址
enum API {
  LIST_URL = '/vip/ticket/ticket-list',
  ADD_URL = '/vip/ticket/add-ticket',
  UPDATE_URL = '/vip/ticket/update-ticket',
  UPDATE_STATUS_URL = '/vip/ticket/update-status',
  COUNT_URL = '/vip/ticket/count-ticket',
}

export const reqTicketList = (params = {}) => get(API.LIST_URL, params);

export const reqAddTicket = (data = {}) => post(API.ADD_URL, data);

export const reqUpdateTicket = (data = {}) => put(API.UPDATE_URL, data);

export const reqUpdateTicketStatus = (data = {}) => put(API.UPDATE_STATUS_URL, data, ContentType.URLencoded);

export const reqCountTicket = (params = {}) => get(API.COUNT_URL, params);
