import { get } from '@/utils/request';

enum API {
  INCOME_URL = '/',
  PERFORMANCE_URL = '/',
  BUSINESS_URL = '/',
  RECHARGE_URL = '/',
  PRODUCT_URL = '/',
  PROJECT_URL = '/',
}

export const reqIncomeTotal = (params = {}) => get(API.INCOME_URL, params);

export const reqPerformanceTotal = (params = {}) => get(API.PERFORMANCE_URL, params);

export const reqBusinessTotal = (params = {}) => get(API.BUSINESS_URL, params);

export const reqRechargeTotal = (params = {}) => get(API.RECHARGE_URL, params);

export const reqProductTotal = (params = {}) => get(API.PRODUCT_URL, params);

export const reqProjectTotal = (params = {}) => get(API.PROJECT_URL, params);
