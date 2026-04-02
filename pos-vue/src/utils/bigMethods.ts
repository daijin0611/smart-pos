// src/utils/bigMethods.ts
import Big from 'big.js';

/**
 * 加法运算（a + b）
 * @param a 数值1（支持 Number 或 String，推荐 String 避免精度丢失）
 * @param b 数值2（支持 Number 或 String）
 * @returns 计算结果（ number 类型）
 */
export const add = (a: number | string, b: number | string): number => {
  return new Big(a).plus(b).toNumber();
};

/**
 * 减法运算（a - b）
 * @param a 被减数（支持 Number 或 String）
 * @param b 减数（支持 Number 或 String）
 * @returns 计算结果（ number 类型）
 */
export const sub = (a: number | string, b: number | string): number => {
  return new Big(a).minus(b).toNumber();
};

/**
 * 乘法运算（a × b）
 * @param a 数值1（支持 Number 或 String）
 * @param b 数值2（支持 Number 或 String）
 * @returns 计算结果（ number 类型）
 */
export const mul = (a: number | string, b: number | string): number => {
  return new Big(a).times(b).toNumber();
};

/**
 * 除法运算（a ÷ b）
 * @param a 被除数（支持 Number 或 String）
 * @param b 除数（支持 Number 或 String，不可为 0）
 * @param precision 保留小数位数（默认 2 位，四舍五入）
 * @returns 计算结果（String 类型）
 */
export const div = (a: number | string, b: number | string, precision = 2): string => {
  if (Number(b) === 0) {
    console.error('除数不能为 0');
    return '0'; // 或抛出异常，根据业务需求调整
  }
  return new Big(a).div(b).toFixed(precision);
};

/**
 * 保留指定小数位数（四舍五入）
 * @param num 待处理数值（支持 Number 或 String）
 * @param precision 保留小数位数（默认 2 位）
 * @returns 处理后结果（String 类型）
 */
export const toFixed = (num: number | string, precision = 2): string => {
  return new Big(num).toFixed(precision);
};
