import { ElNotification } from 'element-plus';
import type { NotificationParams } from 'element-plus';

// 通知类型
type NotificationType = 'success' | 'warning' | 'info' | 'error';

// 默认配置
const defaultOptions = {
  duration: 3000,
  position: 'top-right',
  showClose: true,
};

// 创建通知函数
const createNotification = (options: NotificationParams) => {
  return ElNotification({
    ...defaultOptions,
    // @ts-ignore
    ...(options || {}),
  });
};

// 导出不同类型的通知方法
const Notification = {
  // 基础方法
  create: createNotification,

  // 成功通知
  success: (message: string, title?: string, options?: Partial<NotificationParams>) => {
    return createNotification({
      type: 'success',
      message,
      // @ts-ignore
      ...(options || {}),
    });
  },

  // 警告通知
  warning: (message: string, title?: string, options?: Partial<NotificationParams>) => {
    return createNotification({
      type: 'warning',
      message,
      // @ts-ignore
      ...(options || {}),
    });
  },

  // 信息通知
  info: (message: string, title?: string, options?: Partial<NotificationParams>) => {
    return createNotification({
      type: 'info',
      message,
      // @ts-ignore
      ...(options || {}),
    });
  },

  // 错误通知
  error: (message: string, title?: string, options?: Partial<NotificationParams>) => {
    return createNotification({
      type: 'error',
      message,
      // @ts-ignore
      ...(options || {}),
    });
  },

  // 关闭所有通知
  closeAll: ElNotification.closeAll,
};

export default Notification;
