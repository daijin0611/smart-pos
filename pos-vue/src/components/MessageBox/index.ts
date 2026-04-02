// messageBox.ts
import { ElMessageBox, ElMessage } from 'element-plus';
import type { ElMessageBoxOptions, Action } from 'element-plus';

// 定义消息类型
export type MessageType = 'success' | 'warning' | 'info' | 'error';

// 定义按钮配置
export interface ButtonConfig {
  text?: string;
  type?: 'primary' | 'success' | 'warning' | 'danger' | 'info' | 'text';
}

// 定义封装后的配置选项
export interface MessageBoxConfig extends Partial<ElMessageBoxOptions> {
  title?: string;
  message: string;
  type?: MessageType;
  showCancelButton?: boolean;
  confirmButtonText?: string;
  cancelButtonText?: string;
  confirmButton?: ButtonConfig;
  cancelButton?: ButtonConfig;
  showClose?: boolean;
  closeOnClickModal?: boolean;
  closeOnPressEscape?: boolean;
  beforeClose?: (action: Action, instance: any, done: () => void) => void;
}

class MessageBoxWrapper {
  // 默认配置
  private defaultConfig: Partial<MessageBoxConfig> = {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    showCancelButton: false,
    showClose: true,
    closeOnClickModal: false,
    closeOnPressEscape: true,
    center: false,
    roundButton: false,
  };

  // 私有方法：合并配置
  private mergeConfig(config: MessageBoxConfig): ElMessageBoxOptions {
    const mergedConfig = { ...this.defaultConfig, ...config };

    // 处理按钮配置
    if (mergedConfig.confirmButton) {
      mergedConfig.confirmButtonText = mergedConfig.confirmButton.text || mergedConfig.confirmButtonText;
      mergedConfig.confirmButtonClass = `el-button--${mergedConfig.confirmButton.type || 'primary'}`;
    }

    if (mergedConfig.cancelButton) {
      mergedConfig.cancelButtonText = mergedConfig.cancelButton.text || mergedConfig.cancelButtonText;
      mergedConfig.cancelButtonClass = `el-button--${mergedConfig.cancelButton.type || 'default'}`;
    }

    return mergedConfig as ElMessageBoxOptions;
  }

  // 通用弹窗方法
  async show(config: MessageBoxConfig): Promise<Action> {
    try {
      const finalConfig = this.mergeConfig(config);
      const result = await ElMessageBox(finalConfig);
      return result as Action;
    } catch (error) {
      return Promise.reject(error);
    }
  }

  // 确认弹窗
  async confirm(config: Omit<MessageBoxConfig, 'showCancelButton'>): Promise<boolean> {
    try {
      await this.show({
        ...config,
        showCancelButton: true,
        type: config.type || 'warning',
      });
      return true;
    } catch {
      return false;
    }
  }

  // 警告弹窗
  async alert(config: Omit<MessageBoxConfig, 'showCancelButton'>): Promise<void> {
    await this.show({
      ...config,
      showCancelButton: false,
      type: config.type || 'info',
    });
  }

  // 输入弹窗
  async prompt(
    config: MessageBoxConfig & {
      inputValue?: string;
      inputPlaceholder?: string;
      inputType?: string;
      inputPattern?: RegExp;
      inputValidator?: (value: string) => boolean | string;
      inputErrorMessage?: string;
    },
  ): Promise<{ value: string; action: Action }> {
    try {
      const result = await ElMessageBox.prompt(config.message, config.title, {
        ...this.mergeConfig(config),
        inputValue: config.inputValue || '',
        inputPlaceholder: config.inputPlaceholder || '请输入',
        inputType: config.inputType || 'text',
        inputPattern: config.inputPattern,
        inputValidator: config.inputValidator,
        inputErrorMessage: config.inputErrorMessage || '输入格式不正确',
      });
      return result;
    } catch (error) {
      return Promise.reject(error);
    }
  }

  // 成功确认
  async success(message: string, title: string = '成功'): Promise<boolean> {
    return this.confirm({
      title,
      message,
      type: 'success',
      confirmButton: { text: '确定', type: 'success' },
    });
  }

  // 错误确认
  async error(message: string, title: string = '错误'): Promise<boolean> {
    return this.confirm({
      title,
      message,
      type: 'error',
      confirmButton: { text: '确定', type: 'danger' },
    });
  }

  // 警告确认
  async warning(message: string, title: string = '警告'): Promise<boolean> {
    return this.confirm({
      title,
      message,
      type: 'warning',
      confirmButton: { text: '确定', type: 'warning' },
    });
  }

  // 信息提示
  async info(message: string, title: string = '提示'): Promise<void> {
    await this.alert({
      title,
      message,
      type: 'info',
    });
  }

  // 删除确认（常用场景）
  async confirmDelete(
    message: string = '此操作将永久删除该数据，是否继续？',
    title: string = '删除确认',
  ): Promise<boolean> {
    return this.confirm({
      title,
      message,
      type: 'warning',
      confirmButton: { text: '删除', type: 'danger' },
      cancelButton: { text: '取消', type: 'info' },
    });
  }

  // 保存确认（常用场景）
  async confirmSave(message: string = '是否保存当前修改？', title: string = '保存确认'): Promise<boolean> {
    return this.confirm({
      title,
      message,
      type: 'info',
      confirmButton: { text: '保存', type: 'primary' },
      cancelButton: { text: '取消', type: 'info' },
    });
  }

  // 退出确认（常用场景）
  async confirmExit(message: string = '有未保存的修改，确定要离开吗？', title: string = '离开确认'): Promise<boolean> {
    return this.confirm({
      title,
      message,
      type: 'warning',
      confirmButton: { text: '离开', type: 'warning' },
      cancelButton: { text: '取消', type: 'info' },
    });
  }

  // 设置全局默认配置
  setDefaultConfig(config: Partial<MessageBoxConfig>): void {
    this.defaultConfig = { ...this.defaultConfig, ...config };
  }
}

// 创建单例实例
export const messageBox = new MessageBoxWrapper();

// 导出类型和实例
export default messageBox;
