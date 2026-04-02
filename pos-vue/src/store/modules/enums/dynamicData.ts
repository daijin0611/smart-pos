import { defineStore } from 'pinia';
import { reqTicketList } from '@/api/member/coupon/index';
import { reqActiveList } from '@/api/member/rechargeActivity/index';
import { reqUserList } from '@/api/staffMain/staff/index';
import { reqProductList } from '@/api/setGroup/product/index';
import { reqServiceItemList } from '@/api/setGroup/serviceItem/index';
import { reqPackageList } from '@/api/setGroup/package/index';
import { reqBedListAll } from '@/api/setGroup/room/index';
import { reqTreatmentCouponList } from '@/api/setGroup/treatmentCoupon/index';

// 定义接口配置类型
interface ApiConfig<Params = any, Result = any> {
  api: (params: Params) => Promise<Result>;
  key: string;
  defaultParams: Params;
}

// 定义每个接口的状态类型
interface ApiState<Params = any, Result = any> {
  data: Result | null;
  isLoading: boolean;
  error: string | null;
  lastParams: Params | null;
}

// 定义所有接口配置，明确每个接口的参数和返回值类型
const apiConfigs = {
  ticketList: {
    api: reqTicketList,
    key: 'ticketList',
    defaultParams: { status: 'all', page: 1, size: 20 } as const,
  },
  activeList: {
    api: reqActiveList,
    key: 'activeList',
    defaultParams: { activeName: '', activeStatus: 0 } as const,
  },
  userList: {
    api: reqUserList,
    key: 'userList',
    defaultParams: { userStatus: '在职', pageNum: 1, pageSize: 20 } as const,
  },
  productList: {
    api: reqProductList,
    key: 'productList',
    defaultParams: { category: '', page: 1, size: 15 } as const,
  },
  serviceItemList: {
    api: reqServiceItemList,
    key: 'serviceItemList',
    defaultParams: { enabled: true } as const,
  },
  packageList: {
    api: reqPackageList,
    key: 'packageList',
    defaultParams: { type: '', page: 1, size: 10 } as const,
  },
  bedListAll: {
    api: reqBedListAll,
    key: 'bedListAll',
    defaultParams: { status: 'available' } as const,
  },
  treatmentCouponList: {
    api: reqTreatmentCouponList,
    key: 'treatmentCouponList',
    defaultParams: { valid: true } as const,
  },
} satisfies Record<string, ApiConfig>;

// 提取接口名称类型
type ApiNames = keyof typeof apiConfigs;

// 获取特定接口的参数类型
type ParamsType<T extends ApiNames> = Parameters<(typeof apiConfigs)[T]['api']>[0];

// 获取特定接口的返回值类型
type ResultType<T extends ApiNames> = Awaited<ReturnType<(typeof apiConfigs)[T]['api']>>;

// 合并默认参数和传入参数
const mergeParams = <T extends Record<string, any>>(defaultParams: T, customParams: Partial<T> = {}): T => {
  return { ...defaultParams, ...customParams } as T;
};

// 定义状态类型
type DynamicDataState = {
  [K in ApiNames]: ApiState<ParamsType<K>, ResultType<K>>;
};

export const useDynamicDataStore = defineStore('dynamicData', {
  state: (): DynamicDataState => {
    const initialState = {} as DynamicDataState;

    (Object.entries(apiConfigs) as [ApiNames, ApiConfig][]).forEach(([name, config]) => {
      initialState[name] = {
        data: null,
        isLoading: false,
        error: null,
        lastParams: null,
      };
    });

    return initialState;
  },

  getters: {
    // 为每个接口创建带get前缀的getter
    ...Object.entries(apiConfigs).reduce((getters, [name, config]) => {
      const getterName = `get${name.charAt(0).toUpperCase() + name.slice(1)}` as keyof any;

      getters[getterName] = function (this: DynamicDataState) {
        return async (customParams: Partial<ParamsType<typeof name>> = {}) => {
          const stateItem = this[name];
          const params = mergeParams(config.defaultParams, customParams);

          const shouldFetch = !stateItem.data || JSON.stringify(stateItem.lastParams) !== JSON.stringify(params);

          if (shouldFetch && !stateItem.isLoading) {
            stateItem.isLoading = true;
            stateItem.error = null;

            try {
              const result = await config.api(params);
              stateItem.data = result;
              stateItem.lastParams = params;
              return result;
            } catch (err) {
              const errorMsg = err instanceof Error ? err.message : `获取${name}失败`;
              stateItem.error = errorMsg;
              console.error(`获取${name}错误:`, err);
              throw err;
            } finally {
              stateItem.isLoading = false;
            }
          }

          return stateItem.data;
        };
      };

      return getters;
    }, {} as Record<string, (this: DynamicDataState) => (...args: any[]) => Promise<any>>),
  },

  actions: {
    /**
     * 刷新指定接口的数据
     * @param name 接口名称
     * @param customParams 自定义参数
     * @param force 是否强制刷新
     * @returns 接口返回的数据
     */
    async refreshData<T extends ApiNames>(
      name: T,
      customParams: Partial<ParamsType<T>> = {},
      force = false,
    ): Promise<ResultType<T> | null> {
      if (!apiConfigs[name]) {
        throw new Error(`不存在的接口: ${name}`);
      }

      const config = apiConfigs[name];
      const stateItem = this[name];
      const params = mergeParams(config.defaultParams, customParams);

      if (force || JSON.stringify(stateItem.lastParams) !== JSON.stringify(params)) {
        stateItem.isLoading = true;
        stateItem.error = null;

        try {
          const result = await config.api(params);
          stateItem.data = result;
          stateItem.lastParams = params;
          return result;
        } catch (err) {
          const errorMsg = err instanceof Error ? err.message : `刷新${name}失败`;
          stateItem.error = errorMsg;
          throw err;
        } finally {
          stateItem.isLoading = false;
        }
      }

      return stateItem.data;
    },

    /**
     * 更新接口的默认参数
     * @param name 接口名称
     * @param newDefaultParams 新的默认参数
     */
    updateDefaultParams<T extends ApiNames>(name: T, newDefaultParams: Partial<ParamsType<T>>): void {
      if (!apiConfigs[name]) {
        throw new Error(`不存在的接口: ${name}`);
      }

      // 类型断言，实际项目中可根据需要调整
      (apiConfigs[name].defaultParams as ParamsType<T>) = {
        ...apiConfigs[name].defaultParams,
        ...newDefaultParams,
      };

      this.clearData(name);
    },

    /**
     * 清除指定接口的数据
     * @param name 接口名称
     */
    clearData<T extends ApiNames>(name: T): void {
      if (!apiConfigs[name]) {
        throw new Error(`不存在的接口: ${name}`);
      }

      this[name] = {
        ...this[name],
        data: null,
        lastParams: null,
      };
    },

    /**
     * 清除所有接口的数据
     */
    clearAllData(): void {
      (Object.keys(apiConfigs) as ApiNames[]).forEach((name) => {
        this[name] = {
          ...this[name],
          data: null,
          lastParams: null,
        };
      });
    },
  },
});

// 导出类型方便组件中使用
export type DynamicDataStore = ReturnType<typeof useDynamicDataStore>;
