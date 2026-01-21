import { ElMessage } from 'element-plus';
import type { MessageParams } from 'element-plus';

// 消息类型
type MessageType = 'success' | 'warning' | 'info' | 'error';

// 默认配置
const defaultOptions = {
  duration: 3000,
  showClose: true,
};

// 创建消息函数
const createMessage = (options: MessageParams) => {
  return ElMessage({
    ...defaultOptions,
    // @ts-ignore
    ...(options || {}),
  });
};

// 导出不同类型的消息方法
const Message = {
  // 基础方法
  create: createMessage,

  // 成功消息
  success: (message: string, options?: Partial<MessageParams>) => {
    return createMessage({
      type: 'success',
      message,
      ...(options ?? {}),
    });
  },

  // 警告消息
  warning: (message: string, options?: Partial<MessageParams>) => {
    return createMessage({
      type: 'warning',
      message,
      ...(options ?? {}),
    });
  },

  // 信息消息
  info: (message: string, options?: Partial<MessageParams>) => {
    return createMessage({
      type: 'info',
      message,
      ...(options ?? {}),
    });
  },

  // 错误消息
  error: (message: string, options?: Partial<MessageParams>) => {
    return createMessage({
      type: 'error',
      message,
      ...(options ?? {}),
    });
  },

  // 关闭所有消息
  closeAll: ElMessage.closeAll,
};

export default Message;
