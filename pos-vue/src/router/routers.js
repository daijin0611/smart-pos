export const asyncRoute = [
  // 默认首页
  {
    path: '/',
    component: () => import('@/layout/index.vue'),
    name: 'layout',
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
    path: '/bedStatus',
    component: () => import('@/layout/index.vue'),
    name: 'BedStatus',
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
    path: '/saleMain',
    component: () => import('@/layout/index.vue'),
    name: 'SaleMain',
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
    path: '/staffMain',
    component: () => import('@/layout/index.vue'),
    name: 'StaffMain',
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
    path: '/orgMgr',
    component: () => import('@/layout/index.vue'),
    name: 'OrgMgr',
    meta: {
      title: '门店',
      icon: 'Shop',
    },
    redirect: '/orgMgr',
    children: [
      {
        path: '/orgMgr',
        component: () => import('@/views/orgMgr/index.vue'),
        name: 'OrgMgr',
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
        },
      },
      {
        path: '/member/memberRecharge',
        component: () => import('@/views/member/memberRecharge/index.vue'),
        name: 'MemberRecharge',
        meta: {
          title: '会员卡充值 ',
          icon: 'Coin',
        },
      },
      {
        path: '/member/memberCoupon',
        component: () => import('@/views/member/memberCoupon/index.vue'),
        name: 'MemberCoupon',
        meta: {
          title: '会员优惠券',
          icon: 'Ticket',
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
        },
      },
      {
        path: '/dataGroup/staffPerformance',
        component: () => import('@/views/dataGroup/staffPerformance/index.vue'),
        name: 'StaffPerformance',
        meta: {
          title: '人员绩效 ',
          icon: 'Management',
        },
      },
      {
        path: '/dataGroup/payData',
        component: () => import('@/views/dataGroup/payData/index.vue'),
        name: 'PayData',
        meta: {
          title: '支付数据',
          icon: 'DataLine',
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
        path: '/setGroup/stockSet',
        component: () => import('@/views/setGroup/stockSet/index.vue'),
        name: 'StockSet',
        meta: {
          title: '库存设定 ',
          icon: 'List',
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
      title: '权限',
      icon: 'Lock',
    },
    redirect: '/acl/user',
    children: [
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
          title: '菜单管理',
          icon: 'Menu',
        },
      },
    ],
  },
];

// 遍历路由输出路由名字,title和path

const fn = (arr) => {
  return arr.reduce((pre, item) => {
    if (item.children) {
      pre = pre.concat(fn(item.children));
    }
    pre.push({
      name: item.name,
      title: item.meta.title,
      path: item.path,
    });
    return pre;
  }, []);
};
const result = fn(asyncRoute);
console.log(result);

// prettier-ignore
const routerSimple = [
  { name: 'DataView', title: '概览', path: '/dataView' },
  { name: 'layout', title: '首页', path: '/' },
  { name: 'BedStatus', title: '房态', path: '/bedStatus' },
  { name: 'BedStatus', title: '房态', path: '/bedStatus' },
  { name: 'SaleMain', title: '收银', path: '/saleMain' },
  { name: 'SaleMain', title: '收银', path: '/saleMain' },
  { name: 'StaffMain', title: '人事', path: '/staffMain' },
  { name: 'StaffMain', title: '人事', path: '/staffMain' },
  { name: 'OrgMgr', title: '门店', path: '/orgMgr' },
  { name: 'OrgMgr', title: '门店', path: '/orgMgr' },
  { name: 'MemberCard', title: '电子会员卡', path: '/member/memberCard' },
  { name: 'MemberRecharge', title: '会员卡充值 ', path: '/member/memberRecharge'},
  { name: 'MemberCoupon', title: '会员优惠券', path: '/member/memberCoupon' },
  { name: 'Member', title: '会员', path: '/member' },
  { name: 'SaleData', title: '销售数据', path: '/dataGroup/saleData' },
  { name: 'StaffPerformance', title: '人员绩效 ', path: '/dataGroup/staffPerformance' },
  { name: 'PayData', title: '支付数据', path: '/dataGroup/payData' },
  { name: 'DataGroup', title: '数据', path: '/dataGroup' },
  { name: 'PsMain', title: '品项设定', path: '/setGroup/psMain' },
  { name: 'RoomBed', title: '房间设定 ', path: '/setGroup/roomBed' },
  { name: 'StockSet', title: '库存设定 ', path: '/setGroup/stockSet' },
  { name: 'SetGroup', title: '设定', path: '/setGroup' },
  { name: 'User', title: '用户管理', path: '/acl/user' },
  { name: 'Role', title: '角色管理', path: '/acl/role' },
  { name: 'Permission', title: '菜单管理', path: '/acl/permission' },
  { name: 'Acl', title: '权限', path: '/acl' },
];
