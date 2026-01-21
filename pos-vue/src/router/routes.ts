// 对外暴露配置路由(常量路由): 全部用户都可以访问到的路由
export const constantRoute = [
  // 登录
  {
    path: '/login',
    component: () => import('@/views/login/index.vue'),
    name: 'login',
    meta: {
      title: '登录', // 菜单标题
      hidden: true, // 代表路由标题在菜单中是否隐藏  true: 隐藏 false: 不隐藏
    },
  },

  // 404
  {
    path: '/404',
    component: () => import('@/views/404/index.vue'),
    name: '404',
    meta: {
      title: '404',
      hidden: true,
      icon: 'DocumentDelete',
    },
  },

  // 500
  {
    path: '/500',
    component: () => import('@/views/500/index.vue'),
    name: '500',
    meta: {
      title: '500',
      hidden: true,
      icon: 'DocumentDelete',
    },
  },
  {
    path: '/samples',
    component: () => import('@/components/UseSamples/index.vue'),
    name: 'samples',
    meta: {
      title: 'samples',
      hidden: true,
      icon: 'DocumentDelete',
    },
  },
];

// 异步路由
export const asyncRoute = [
  // 默认首页
  {
    path: '/',
    component: () => import('@/layout/index.vue'),
    name: 'HomeLayout',
    meta: {
      title: '首页',
      icon: 'HomeFilled',
    },
    redirect: '/dataView',
    children: [
      {
        path: '/dataView',
        name: 'DataView',
        component: () => import('@/views/home/dataView/index.vue'),
        meta: {
          title: '概览',
          icon: 'Help',
        },
      },
    ],
  },

  // 房态
  {
    path: '/bed',
    component: () => import('@/layout/index.vue'),
    name: 'BedLayout',
    meta: {
      title: '房态',
      icon: 'Grid',
    },
    redirect: '/bedStatus',
    children: [
      {
        path: '/bedStatus',
        component: () => import('@/views/bedStatus/index.vue'),
        name: 'BedStatus',
        meta: {
          title: '房态',
          icon: 'Grid',
        },
      },
    ],
  },

  // 收银
  {
    path: '/sale',
    component: () => import('@/layout/index.vue'),
    name: 'SaleLayout',
    meta: {
      title: '收银',
      icon: 'Coin',
    },
    redirect: '/saleMain',
    children: [
      {
        path: '/saleMain',
        component: () => import('@/views/saleMain/index.vue'),
        name: 'SaleMain',
        meta: {
          title: '收银',
          icon: 'Coin',
        },
      },
    ],
  },

  // 人事
  {
    path: '/staff',
    component: () => import('@/layout/index.vue'),
    name: 'StaffLayout',
    meta: {
      title: '人事',
      icon: 'UserFilled',
    },
    redirect: '/staffMain',
    children: [
      {
        path: '/staffMain',
        component: () => import('@/views/staffMain/index.vue'),
        name: 'StaffMain',
        meta: {
          title: '人事',
          icon: 'UserFilled',
        },
      },
    ],
  },

  // 门店
  {
    path: '/org',
    component: () => import('@/layout/index.vue'),
    name: 'OrgLayout',
    meta: {
      title: '门店',
      icon: 'Shop',
    },
    redirect: '/org',
    children: [
      {
        path: '/org',
        component: () => import('@/views/orgMgr/index.vue'),
        name: 'Org',
        meta: {
          title: '门店',
          icon: 'Shop',
        },
      },
    ],
  },

  // 会员
  {
    path: '/member',
    component: () => import('@/layout/index.vue'),
    name: 'Member',
    meta: {
      title: '会员',
      icon: 'TrendCharts',
    },
    redirect: '/member/memberCard',
    children: [
      {
        path: '/member/memberCard',
        component: () => import('@/views/member/memberCard/index.vue'),
        name: 'MemberCard',
        meta: {
          title: '电子会员卡',
          icon: 'CreditCard',
          tabs: ['会员列表', '会员统计', '会员活跃分析', '资产转移'],
        },
      },
      {
        path: '/member/memberRecharge',
        component: () => import('@/views/member/memberRecharge/index.vue'),
        name: 'MemberRecharge',
        meta: {
          title: '会员卡充值 ',
          icon: 'Coin',
          tabs: ['会员充值', '充值记录', '充值活动'],
        },
      },
      {
        path: '/member/memberCoupon',
        component: () => import('@/views/member/memberCoupon/index.vue'),
        name: 'MemberCoupon',
        meta: {
          title: '会员优惠券',
          icon: 'Ticket',
          tabs: ['优惠券管理', '优惠券统计', '优惠券汇总'],
        },
      },
    ],
  },

  // 数据
  {
    path: '/dataGroup',
    component: () => import('@/layout/index.vue'),
    name: 'DataGroup',
    meta: {
      title: '数据',
      icon: 'Histogram',
    },
    redirect: '/dataGroup/saleData',
    children: [
      {
        path: '/dataGroup/saleData',
        component: () => import('@/views/dataGroup/saleData/index.vue'),
        name: 'SaleData',
        meta: {
          title: '销售数据',
          icon: 'ScaleToOriginal',
          tabs: ['销售记录', '销售汇总', '销售明细', '跨店消费'],
        },
      },
      {
        path: '/dataGroup/staffPerformance',
        component: () => import('@/views/dataGroup/staffPerformance/index.vue'),
        name: 'StaffPerformance',
        meta: {
          title: '人员绩效 ',
          icon: 'Management',
          tabs: ['业绩明细', '业绩汇总'],
        },
      },
    ],
  },

  // 设定
  {
    path: '/setGroup',
    component: () => import('@/layout/index.vue'),
    name: 'SetGroup',
    meta: {
      title: '设定',
      icon: 'Tools',
    },
    redirect: '/setGroup/psMain',
    children: [
      {
        path: '/setGroup/psMain',
        component: () => import('@/views/setGroup/psMain/index.vue'),
        name: 'PsMain',
        meta: {
          title: '品项设定',
          icon: 'GoodsFilled',
          tabs: ['产品管理', '项目管理', '疗程券管理', '套餐管理', '充值提成规则'],
        },
      },
      {
        path: '/setGroup/roomBed',
        component: () => import('@/views/setGroup/roomBed/index.vue'),
        name: 'RoomBed',
        meta: {
          title: '房间设定 ',
          icon: 'Box',
        },
      },
      {
        path: '/setGroup/stock',
        component: () => import('@/views/setGroup/stock/index.vue'),
        name: 'Stock',
        meta: {
          title: '库存管理',
          icon: 'List',
          tabs: ['入库', '出库', '库存流水'],
        },
      },
    ],
  },

  // 权限管理
  {
    path: '/acl',
    component: () => import('@/layout/index.vue'),
    name: 'Acl',
    meta: {
      title: '系统设置',
      icon: 'Setting',
    },
    redirect: '/acl/orgMgr',
    children: [
      {
        path: '/acl/orgMgr',
        component: () => import('@/views/acl/orgMgr/index.vue'),
        name: 'OrgMgr',
        meta: {
          title: '门店管理',
          icon: 'Shop',
        },
      },
      {
        path: '/acl/user',
        component: () => import('@/views/acl/user/index.vue'),
        name: 'User',
        meta: {
          title: '用户管理',
          icon: 'User',
        },
      },
      {
        path: '/acl/role',
        component: () => import('@/views/acl/role/index.vue'),
        name: 'Role',
        meta: {
          title: '角色管理',
          icon: 'UserFilled',
        },
      },
      {
        path: '/acl/permission',
        component: () => import('@/views/acl/permission/index.vue'),
        name: 'Permission',
        meta: {
          title: '权限管理',
          icon: 'Lock',
        },
      },
      {
        path: '/acl/enum',
        component: () => import('@/views/acl/enum/index.vue'),
        name: 'Enum',
        meta: {
          title: '字典管理',
          icon: 'List',
        },
      },
    ],
  },
];

// 任意路由
export const anyRoute = {
  path: '/:pathMatch(.*)*',
  redirect: '/404',
  name: 'Any',
  meta: {
    title: '任意路由',
    hidden: true,
    icon: 'DataLine',
  },
};
