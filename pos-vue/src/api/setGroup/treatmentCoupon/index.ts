import { get, post, put, del } from '@/utils/request';

enum API {
  LIST_URL = '/server/cureTicket/query-list',
  INFO_URL = '/server/cureTicket/query-info',
  ADD_URL = '/server/cureTicket/add-cureTicket',
  UPDATE_URL = '/server/cureTicket/update-cureTicket',
  UPDATE_STATUS = '/server/cureTicket/update-status',
}

export const reqTreatmentCouponList = (params = {}) => get(API.LIST_URL, params);

export const reqTreatmentCouponInfo = (params = {}) => get(API.INFO_URL, params);

export const reqAddTreatmentCoupon = (data = {}) => post(API.ADD_URL, data);

export const reqUpdateTreatmentCoupon = (data = {}) => put(API.UPDATE_URL, data);

export const reqUpdateTreatmentCouponStatus = (data = {}) => put(API.UPDATE_STATUS, data);
