import { get, post, put, del } from '@/utils/request';

enum API {
  PERFORMANCE_RECORD = '/kpi/list',
  PERFORMANCE_SUMMARY = '/kpi/summary',
}

export const reqPerformanceRecord = (data = {}) => post(API.PERFORMANCE_RECORD, data);

export const reqPerformanceSummary = (data = {}) => post(API.PERFORMANCE_SUMMARY, data);
