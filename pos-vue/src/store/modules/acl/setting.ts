// 设置配置仓库
import { defineStore } from 'pinia';

export const useSettingStore = defineStore('SettingStore', {
  state: () => {
    return {
      fold: false, // 控制菜单折叠还是收起控制
      refresh: false, // 控制刷新
      loading: false, // 加载状态控制
      loadingMsg: '加载中...', // 加载提示文字
    };
  },
  actions: {},
});

export default useSettingStore;
