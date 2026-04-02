// 表格数据格式化工具
import { formatDateTime, formatDate } from '@/utils/time';
// import {} from '@/enums/index';

/**
 * 床位状态枚举映射
 * @param row
 * @param column
 * @param cellValue
 * @param index
 * @returns
 */
export const bedStatusMap = (row: any, column: any, cellValue: number, index: number) => {
  let bedStatus = ['空闲中', '服务中', '暂停使用'];
  return bedStatus[cellValue] || '';
};

/**
 * 性别枚举映射器
 * @param row
 * @param column
 * @param cellValue
 * @param index
 * @returns
 */
export const sexMap = (row: any, column: any, cellValue: number, index: number) => {
  let result = '未知';
  cellValue === 0 && (result = '男');
  cellValue === 1 && (result = '女');
  return result;
};

/**
 * 是否参与打折枚举映射器
 * @param row
 * @param column
 * @param cellValue
 * @param index
 * @returns
 */
export const isDiscountMap = (row: any, column: any, cellValue: number, index: number) => {
  let result = '未知';
  cellValue === 0 && (result = '允许');
  cellValue === 1 && (result = '不允许');
  return result;
};

/**
 * 优惠券类型枚举映射
 * @param row
 * @param column
 * @param cellValue
 * @param index
 * @returns
 */
export const couponTypeMap = (row: any, column: any, cellValue: number, index: number) => {
  let couponType = ['实体券', '线上领取', '地推活动领取', '手动赠送', '充值活动获赠', '', '', '疗程项目获得'];
  return couponType[cellValue] || '';
};

/**
 * 金额格式化器
 * @param row
 * @param column
 * @param cellValue
 * @param index
 * @returns
 */
export const amountFormatter = (row: any, column: any, cellValue: number, index: number) => {
  return `¥ ${typeof cellValue === 'number' ? cellValue : ''}`;
};

/**
 * 表格时间格式化器
 * @param row
 * @param column
 * @param cellValue
 * @param index
 * @returns
 */
export const datetimeFormatter = (row: any, column: any, cellValue: string, index: number) => {
  return formatDateTime(new Date(cellValue)) || cellValue;
};

/**
 * 表格日期格式化器
 * @param row
 * @param column
 * @param cellValue
 * @param index
 * @returns
 */
export const dateFormatter = (row: any, column: any, cellValue: string, index: number) => {
  let result = '';
  cellValue && (result = formatDate(new Date(cellValue)));
  return result;
};

/**
 * 表格时间格式化器
 * @param row
 * @param column
 * @param cellValue
 * @param index
 * @returns
 */
export const timeFormatter = (row: any, column: any, cellValue: string, index: number) => {
  return formatDateTime(new Date(cellValue), 'HH:mm:ss') || cellValue;
};
