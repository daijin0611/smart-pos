import { defineStore } from 'pinia';
// 引入接口
import { reqLogin, reqUserInfo, reqLogout, reqUpdate } from '@/api/user';
// 引入操作本地存储的工具方法
import {
  setUserInfo,
  getUserInfo,
  removeUserInfo,
  setToken,
  getToken,
  removeToken,
  setOrgInfo,
  removeOrgInfo,
} from '@/utils/localStorageTools';
// 引入相应枚举
import { ResponseCode } from '@/enums/response';
// 引入路由(常量路由)
import { constantRoute, asyncRoute, anyRoute } from '@/router/routes';
// 引入项目设置
import setting from '@/setting';
// 引入消息提示组件
import $Message from '@/components/Message';
// 引入深拷贝方法
import cloneDeep from 'lodash/cloneDeep';
// 引入路由
import router from '@/router';
import { parseResObj } from '@/utils/parseResponse';

import { usePermissionStore } from '@/store/modules/acl/permission';
import { useOrgStore } from '@/store/modules/acl/org';
import { useDataEnumStore } from '@/store/modules/enums/index';
import { useDynamicDataStore } from '@/store/modules/enums/dynamicData';
import { isEmpty } from 'lodash';

// 用于过滤当前用户需要展示的异步路由
function filterAsyncRoute(asyncRoute: any, routes: any) {
  return asyncRoute.filter((item: any) => {
    if (routes.includes(item.name)) {
      if (item.children && item.children.length > 0) {
        item.children = filterAsyncRoute(item.children, routes);
      }
      return true;
    }
  });
}

const useUserStore = defineStore('User', {
  state: () => {
    return {
      user: <any>{},
      userId: 0,
      username: '',
      nickname: '',
      avatar: setting.logo || '',
      token: getToken() || '', // 用户唯一标识token
      buttons: <string[]>[], // 存储当前用户是否包含某一个按钮
      menuRoutes: <object[]>[], // 仓库存储生成菜单需要数组(路由)
      tabs: <string[]>[],
    };
  },
  actions: {
    // 登录
    async login(data: any) {
      const res: any = await reqLogin(data);
      const isSuccess = res.code === ResponseCode.SUCCESS;
      if (isSuccess) {
        const result = res.data;
        this.setUserInfo(result);
        setToken(this.token);
        setUserInfo(result);
        this.userInfo();
        this.storageOrgInfo();
      } else {
        $Message.error(res.message);
      }
      return isSuccess;
    },

    setUserInfo(user: any) {
      this.userId = user.userId;
      this.nickname = user.userName;
      this.username = user.userCode;
      this.token = `Bearer ${user.token}`;
    },

    // 获取用户信息
    async userInfo() {
      try {
        const permStore = usePermissionStore();
        const user = getUserInfo();
        if (isEmpty(user)) {
          return;
        }
        this.setUserInfo(user);

        // this.buttons = result.data.buttons;
        if (this.menuRoutes.length === 0) {
          const perms = await permStore.getPermTreeByUserId(this.userId);
          const routes = perms.treeMap((item) => item.component);
          this.buttons = perms
            .treeMap((item) => item.permCode)
            .filter((item: string) => {
              const btnCode = ['add', 'update', 'disabled'];
              for (const code of btnCode) {
                if (item.includes(code)) {
                  return true;
                }
              }
            });
          this.tabs = perms.treeMap((item) => item.remark && [...item.children.map((child: any) => child.name)]).flat();
          const userAsyncRoute = filterAsyncRoute(cloneDeep(asyncRoute), routes);
          this.menuRoutes = [...constantRoute, ...userAsyncRoute, anyRoute];
        }

        this.menuRoutes.forEach((route: any) => {
          router.addRoute(route);
        });
      } catch (error) {
        console.error(`获取用户信息出错：${error}`);
      }
    },

    async storageOrgInfo() {
      const orgStore = useOrgStore();
      const org = await orgStore.getOrg();
      setOrgInfo(org);
    },

    // 退出登录
    async userLogout() {
      const params = { username: this.username };
      const res: any = await reqLogout(params);
      if (res.code === ResponseCode.SUCCESS) {
        router.push({ path: '/login' });
        // $Message.success('退出登录成功');
        this.clearUserInfo();
      } else {
        $Message.error('退出登录失败');
      }
    },

    clearUserInfo() {
      this.token = '';
      this.username = '';
      this.nickname = '';
      this.userId = 0;
      this.menuRoutes = [];
      this.buttons = [];
      removeToken();
      removeUserInfo();
      removeOrgInfo();
      useDataEnumStore().$reset();
      useDynamicDataStore().clearAllData();
    },

    async getUserInfo() {
      this.user = parseResObj(await reqUserInfo(this.userId)) || {};
      if (this.user?.role?.id) {
        this.user.roleId = this.user.role.id;
      }
      return this.user;
    },

    async updatePwd(data: any) {
      const params = this.user;
      params.userPassword = data.newPwd;
      const res: any = await reqUpdate(params);
      const isSuccess = res.code === ResponseCode.SUCCESS;
      if (isSuccess) {
        $Message.success('修改密码成功');
        this.userLogout();
      } else {
        $Message.error('修改密码失败，原因：' + res.message);
      }
      return isSuccess;
    },
  },
  getters: {},
});

export default useUserStore;
