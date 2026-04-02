/**
 * 判断输入是否为有效的中国大陆手机号码
 * @param {string} phone - 待验证的手机号码
 * @returns {boolean} - 如果是有效手机号返回 true，否则返回 false
 */
export function validPhone(phone: string) {
  // 使用正则表达式验证手机号格式
  // 匹配 11 位数字，且以 1 开头，第二位为 3-9 之间的数字
  const pattern = /^1[3-9]\d{9}$/;
  return pattern.test(phone);
}

/**
 * 判断字符串是否是汉字
 * @param {string} str 待验证的字符串
 * @returns {boolean} 是汉字返回 true，否则返回 false
 */
export function validChinese(str: string) {
  if (isPureChinese(str)) {
    return true;
  }
  if (containsChineseCharacter(str)) {
    return true;
  }
  if (containsChinese(str)) {
    return true;
  }
  return false;
}

/**
 * 判断字符串中是否包含至少一个汉字
 * @param {string} str - 待验证的字符串
 * @returns {boolean} - 包含汉字返回 true，否则返回 false
 */
export function containsChinese(str: string) {
  const pattern = /[\u4e00-\u9fa5]/;
  return pattern.test(str);
}

/**
 * 判断字符串是否包含中文字符（包括简体、繁体和部分生僻字）
 * @param {string} str - 待验证的字符串
 * @returns {boolean} - 包含中文字符返回 true，否则返回 false
 */
export function containsChineseCharacter(str: string) {
  // 涵盖基本汉字、扩展A-F区、兼容汉字等
  const pattern = /[\u3400-\u4dbf\u4e00-\u9fa5\u{f900}-\ufa2d]/u;
  return pattern.test(str);
}

/**
 * 判断字符串是否完全由汉字组成
 * @param {string} str - 待验证的字符串
 * @returns {boolean} - 全是汉字返回 true，否则返回 false
 */
export function isPureChinese(str: string) {
  const pattern = /^[\u4e00-\u9fa5]+$/;
  return pattern.test(str);
}
