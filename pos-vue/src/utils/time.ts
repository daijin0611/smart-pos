//封装一个函数:获取一个结果:当前早上|上午|下午|晚上
export const getTime = () => {
  let message = '';
  //通过内置构造函数Date
  const hours = new Date().getHours();
  //情况的判断
  if (hours <= 9) {
    message = '早上';
  } else if (hours <= 12) {
    message = '上午';
  } else if (hours <= 18) {
    message = '下午';
  } else {
    message = '晚上';
  }
  return message;
};

/**
 * 计算有效期剩余天数
 * @param {string} createTime - 创建时间字符串，格式如 "2025-08-19 22:24:53"
 * @param {number} validDays - 有效天数（正整数）
 * @returns {number} 剩余天数（可能为负数，表示已过期）
 */
export function getRemainingDays(createTime: string, validDays: number) {
  if (validDays === -1) {
    return '长期有效';
  }
  // 1. 解析创建时间为Date对象
  const createDate = new Date(createTime);
  if (isNaN(createDate.getTime())) {
    throw new Error("创建时间格式错误，请使用 'YYYY-MM-DD HH:mm:ss' 格式");
  }

  // 2. 计算有效期截止时间（创建时间 + 有效天数）
  const deadline: Date = new Date(createDate);
  deadline.setDate(deadline.getDate() + validDays); // 加N天

  // 3. 计算当前时间与截止时间的差值（毫秒）
  const now: Date = new Date();
  const diffMs: number = deadline.getTime() - now.getTime();

  // 4. 转换为天数（向上取整，不足1天按1天算）
  const remainingDays: number = Math.ceil(diffMs / (1000 * 60 * 60 * 24));

  return remainingDays;
}

/**
 * 格式化时间字符串
 * @param {Date} date 需要格式化的时间
 * @param {String} format 时间格式
 * @returns 指定格式的时间字符串
 */
export const formatDateTime = (date: Date, format = 'YYYY-MM-DD HH:mm:ss') => {
  // 验证传入的 date 是否为有效的 Date 对象
  if (!(date instanceof Date) || isNaN(date.getTime())) {
    throw new Error('传入的参数 date 不是有效的 Date 对象');
  }
  // 验证传入的 format 是否为有效的字符串
  if (typeof format !== 'string') {
    throw new Error('传入的参数 format 不是有效的字符串');
  }
  // 创建 replacements 对象，把占位符和对应的值关联起来。
  const replacements: any = {
    YYYY: date.getFullYear(),
    MM: String(date.getMonth() + 1).padStart(2, '0'),
    DD: String(date.getDate()).padStart(2, '0'),
    HH: String(date.getHours()).padStart(2, '0'),
    mm: String(date.getMinutes()).padStart(2, '0'),
    ss: String(date.getSeconds()).padStart(2, '0'),
  };
  // 利用正则表达式 /YYYY|MM|DD|HH|mm|ss/g 匹配 format 字符串里的所有占位符，然后用 replacements 对象中的对应值替换
  return format.replace(/YYYY|MM|DD|HH|mm|ss/g, (match) => replacements[match]);
};

/**
 * 格式化日期字符串
 * @param {Date} date 需要格式化的日期
 * @param {String} format 日期格式
 * @returns 指定格式的日期字符串
 */
export const formatDate = (date: Date, format = 'YYYY-MM-DD') => {
  // 验证传入的 date 是否为有效的 Date 对象
  if (!(date instanceof Date) || isNaN(date.getTime())) {
    throw new Error('传入的参数 date 不是有效的 Date 对象');
  }
  // 验证传入的 format 是否为有效的字符串
  if (typeof format !== 'string') {
    throw new Error('传入的参数 format 不是有效的字符串');
  }
  // 创建 replacements 对象，把占位符和对应的值关联起来。
  const replacements: any = {
    YYYY: date.getFullYear(),
    MM: String(date.getMonth() + 1).padStart(2, '0'),
    DD: String(date.getDate()).padStart(2, '0'),
  };
  // 利用正则表达式 /YYYY|MM|DD|HH|mm|ss/g 匹配 format 字符串里的所有占位符，然后用 replacements 对象中的对应值替换
  return format.replace(/YYYY|MM|DD/g, (match) => replacements[match]);
};

/**
 * 判定类型：精准模式（含时分秒）/ 宽松模式（仅比较日期）
 */
type JudgeMode = 'strict' | 'loose';

/**
 * 判断给定时间到当前时间是否满指定天数
 * @param targetTime 目标时间（支持 Date 对象、毫秒时间戳、ISO 时间字符串等）
 * @param days 目标天数（必须是正整数，如 2、7、30）
 * @param mode 判定模式：strict（精准，含时分秒）/ loose（宽松，仅比日期），默认 strict
 * @returns 满指定天数返回 true，否则返回 false（输入无效也返回 false）
 */
export function isFullDaysSince(targetTime: Date | number | string, days: number, mode: JudgeMode = 'strict'): boolean {
  // 1. 校验天数合法性（必须是正整数）
  if (!Number.isInteger(days) || days <= 0) {
    console.warn('天数必须是正整数（如 1、2、7），当前输入:', days);
    return false;
  }

  // 2. 计算目标天数对应的毫秒数（days * 24h * 60min * 60s * 1000ms）
  const TARGET_DAYS_MS = days * 86400000;

  // 3. 统一转换目标时间为毫秒级时间戳（处理多输入格式）
  let targetTimestamp: number;
  if (targetTime instanceof Date) {
    targetTimestamp = targetTime.getTime();
  } else if (typeof targetTime === 'number') {
    // 兼容 10 位秒级时间戳 → 转为 13 位毫秒级
    targetTimestamp = targetTime.toString().length === 10 ? targetTime * 1000 : targetTime;
  } else if (typeof targetTime === 'string') {
    targetTimestamp = new Date(targetTime).getTime();
  } else {
    console.warn('不支持的时间格式，当前输入:', targetTime);
    return false;
  }

  // 4. 校验时间戳有效性（Invalid Date 的 getTime() 返回 NaN）
  if (isNaN(targetTimestamp)) {
    console.warn('无效的时间输入:', targetTime);
    return false;
  }

  // 5. 根据模式计算时间差
  const nowTimestamp = Date.now();
  let timeDiff: number;

  if (mode === 'loose') {
    // 宽松模式：忽略时分秒，仅比较日期（如 1 月 1 日 23:59 到 1 月 3 日 00:00 视为满 2 天）
    const targetDate = new Date(targetTimestamp);
    const nowDate = new Date(nowTimestamp);

    // 重置时分秒为 0，只保留日期部分
    targetDate.setHours(0, 0, 0, 0);
    nowDate.setHours(0, 0, 0, 0);

    timeDiff = nowDate.getTime() - targetDate.getTime();
  } else {
    // 精准模式：包含时分秒（如 1 月 1 日 10:00 到 1 月 3 日 10:00 才视为满 2 天）
    timeDiff = nowTimestamp - targetTimestamp;
  }

  // 6. 判定：时间差 ≥ 目标天数毫秒数，且目标时间不晚于当前时间
  return timeDiff >= TARGET_DAYS_MS;
}

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
  return formatDate(new Date(cellValue)) || cellValue;
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
