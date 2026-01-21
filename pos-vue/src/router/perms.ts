// 异步路由（修正id和parentId后）
export const asyncRoute = [
  // 默认首页
  {
    path: '/home',
    name: 'layout',
    meta: {
      id: 1, // 根节点起始id=1
      title: '首页',
    },
    children: [
      {
        path: '/dataView',
        name: 'DataView',
        meta: {
          id: 2, // 子节点id递增
          title: '概览',
          parentId: 1, // 父节点为id=1
        },
      },
    ],
  },

  // 房态
  {
    path: '/bedStatus',
    name: 'BedStatus',
    meta: {
      id: 3, // 根节点id=3
      title: '房态',
    },
    children: [
      {
        path: '/bedStatus',
        name: 'BedStatus',
        meta: {
          id: 4,
          title: '房态',
          parentId: 3, // 父节点为id=3
        },
      },
    ],
  },

  // 收银
  {
    path: '/saleMain',
    name: 'SaleMain',
    meta: {
      id: 5, // 根节点id=5
      title: '收银',
    },
    children: [
      {
        path: '/saleMain',
        name: 'SaleMain',
        meta: {
          id: 6,
          title: '收银',
          parentId: 5, // 父节点为id=5
        },
      },
    ],
  },

  // 人事
  {
    path: '/staffMain',
    name: 'StaffMain',
    meta: {
      id: 7, // 根节点id=7
      title: '人事',
    },
    children: [
      {
        path: '/staffMain',
        name: 'StaffMain',
        meta: {
          id: 8,
          title: '人事',
          parentId: 7, // 父节点为id=7
        },
        children: [
          {
            path: '/staffMain/add',
            name: 'StaffAdd',
            meta: {
              id: 9,
              title: '添加员工',
              parentId: 8, // 父节点为id=8
            },
          },
          {
            path: '/staffMain/update',
            name: 'StaffUpdate',
            meta: {
              id: 10,
              title: '修改员工',
              parentId: 8,
            },
          },
          {
            path: '/staffMain/disabled',
            name: 'StaffDisabled',
            meta: {
              id: 11,
              title: '禁用员工',
              parentId: 8,
            },
          },
        ],
      },
    ],
  },

  // 门店
  {
    path: '/org',
    name: 'Org',
    meta: {
      id: 12, // 根节点id=12
      title: '门店',
    },
    redirect: '/org',
    children: [
      {
        path: '/org',
        name: 'Org',
        meta: {
          id: 13,
          title: '门店',
          parentId: 12, // 父节点为id=12
        },
      },
    ],
  },

  // 会员
  {
    path: '/member',
    name: 'Member',
    meta: {
      id: 14, // 根节点id=14
      title: '会员',
    },
    children: [
      {
        path: '/member/memberCard',
        name: 'MemberCard',
        meta: {
          id: 15,
          parentId: 14, // 父节点为id=14
          title: '电子会员卡',
          tabs: ['会员列表', '会员统计', '会员活跃分析', '资产转移'],
        },
        children: [
          {
            path: '/member/memberCard/memberList',
            name: 'MemberList',
            meta: {
              id: 16,
              title: '会员列表',
              parentId: 15, // 父节点为id=15
            },
            children: [
              {
                path: '/member/memberCard/memberList/add',
                name: 'MemberAdd',
                meta: {
                  id: 17,
                  title: '添加会员',
                  parentId: 16, // 父节点为id=16
                },
              },
              {
                path: '/member/memberCard/memberList/update',
                name: 'MemberUpdate',
                meta: {
                  id: 18,
                  title: '修改会员',
                  parentId: 16,
                },
              },
              {
                path: '/member/memberCard/memberList/disabled',
                name: 'MemberDisabled',
                meta: {
                  id: 19,
                  title: '禁用会员',
                  parentId: 16,
                },
              },
            ],
          },
          {
            path: '/member/memberCard/memberCount',
            name: 'MemberCount',
            meta: {
              id: 20,
              title: '会员统计',
              parentId: 15,
            },
          },
          {
            path: '/member/memberCard/activityAnalysis',
            name: 'ActivityAnalysis',
            meta: {
              id: 21,
              title: '会员活跃分析',
              parentId: 15,
            },
          },
          {
            path: '/member/memberCard/assetTransfer',
            name: 'AssetTransfer',
            meta: {
              id: 22,
              title: '资产转移',
              parentId: 15,
            },
          },
        ],
      },
      {
        path: '/member/memberRecharge',
        name: 'MemberRecharge',
        meta: {
          id: 23,
          parentId: 14, // 父节点为id=14
          title: '会员卡充值 ',
          tabs: ['会员充值', '充值记录', '充值活动'],
        },
        children: [
          {
            path: '/member/memberRecharge/recharge',
            name: 'Recharge',
            meta: {
              id: 24,
              title: '会员充值',
              parentId: 23, // 父节点为id=23
            },
          },
          {
            path: '/member/memberRecharge/rechargeRecord',
            name: 'RechargeRecord',
            meta: {
              id: 25,
              title: '充值记录',
              parentId: 23,
            },
          },
          {
            path: '/member/memberRecharge/rechargeActivity',
            name: 'RechargeActivity',
            meta: {
              id: 26,
              title: '充值活动',
              parentId: 23,
            },
            children: [
              {
                path: '/member/memberRecharge/rechargeActivity/add',
                name: 'ActivityAdd',
                meta: {
                  id: 27,
                  title: '添加充值活动',
                  parentId: 26, // 父节点为id=26
                },
              },
              {
                path: '/member/memberRecharge/rechargeActivity/update',
                name: 'ActivityUpdate',
                meta: {
                  id: 28,
                  title: '修改充值活动',
                  parentId: 26,
                },
              },
              {
                path: '/member/memberRecharge/rechargeActivity/disabled',
                name: 'ActivityDisabled',
                meta: {
                  id: 29,
                  title: '禁用充值活动',
                  parentId: 26,
                },
              },
            ],
          },
        ],
      },
      {
        path: '/member/memberCoupon',
        name: 'MemberCoupon',
        meta: {
          id: 30,
          parentId: 14, // 父节点为id=14
          title: '会员优惠券',
          tabs: ['优惠券管理', '优惠券统计', '优惠券汇总'],
        },
        children: [
          {
            path: '/member/memberCoupon/couponManager',
            name: 'CouponManager',
            meta: {
              id: 31,
              title: '优惠券管理',
              parentId: 30, // 父节点为id=30
            },
            children: [
              {
                path: '/member/memberCoupon/couponManager/add',
                name: 'CouponAdd',
                meta: {
                  id: 32,
                  title: '添加优惠券',
                  parentId: 31,
                },
              },
              {
                path: '/member/memberCoupon/couponManager/update',
                name: 'CouponUpdate',
                meta: {
                  id: 33,
                  title: '修改优惠券',
                  parentId: 31,
                },
              },
              {
                path: '/member/memberCoupon/couponManager/disabled',
                name: 'CouponDisabled',
                meta: {
                  id: 34,
                  title: '禁用优惠券',
                  parentId: 31,
                },
              },
            ],
          },
          {
            path: '/member/memberCoupon/couponCount',
            name: 'CouponCount',
            meta: {
              id: 35,
              title: '优惠券统计',
              parentId: 30,
            },
          },
          {
            path: '/member/memberCoupon/couponOverview',
            name: 'CouponOverview',
            meta: {
              id: 36,
              title: '优惠券汇总',
              parentId: 30,
            },
          },
        ],
      },
    ],
  },

  // 数据
  {
    path: '/dataGroup',
    name: 'DataGroup',
    meta: {
      id: 37, // 根节点id=37
      title: '数据',
    },
    children: [
      {
        path: '/dataGroup/saleData',
        name: 'SaleData',
        meta: {
          id: 38,
          parentId: 37, // 父节点为id=37
          title: '销售数据',
          tabs: ['销售记录', '销售汇总', '销售明细', '跨店消费'],
        },
        children: [
          {
            path: '/dataGroup/saleData/saleRecord',
            name: 'SaleRecord',
            meta: {
              id: 39,
              parentId: 38, // 父节点为id=38
              title: '销售记录',
            },
          },
          {
            path: '/dataGroup/saleData/saleDetail',
            name: 'SaleDetail',
            meta: {
              id: 40,
              parentId: 38,
              title: '销售明细',
            },
          },
          {
            path: '/dataGroup/saleData/saleSummary',
            name: 'SaleSummary',
            meta: {
              id: 41,
              parentId: 38,
              title: '销售汇总',
            },
          },
          {
            path: '/dataGroup/saleData/crossStoreConsumption',
            name: 'CrossStoreConsumption',
            meta: {
              id: 42,
              parentId: 38,
              title: '跨店消费',
            },
          },
        ],
      },
      {
        path: '/dataGroup/staffPerformance',
        name: 'StaffPerformance',
        meta: {
          id: 43,
          parentId: 37, // 父节点为id=37
          title: '人员绩效 ',
          tabs: ['业绩明细', '业绩汇总'],
        },
        children: [
          {
            path: '/dataGroup/staffPerformance/performanceDetail',
            name: 'PerformanceDetail',
            meta: {
              id: 44,
              parentId: 43, // 父节点为id=43
              title: '业绩明细',
            },
          },
          {
            path: '/dataGroup/staffPerformance/performanceOverview',
            name: 'PerformanceOverview',
            meta: {
              id: 45,
              parentId: 43,
              title: '业绩汇总',
            },
          },
        ],
      },
    ],
  },

  // 设定
  {
    path: '/setGroup',
    name: 'SetGroup',
    meta: {
      id: 46, // 根节点id=46
      title: '设定',
    },
    children: [
      {
        path: '/setGroup/psMain',
        name: 'PsMain',
        meta: {
          id: 47,
          parentId: 46, // 父节点为id=46
          title: '品项设定',
          tabs: ['产品管理', '项目管理', '套餐管理', '充值提成规则'],
        },
        children: [
          {
            path: '/setGroup/psMain/productManager',
            name: 'ProductManager',
            meta: {
              id: 48,
              parentId: 47, // 父节点为id=47
              title: '产品管理',
            },
            children: [
              {
                path: '/setGroup/psMain/productManager/add',
                name: 'ProductAdd',
                meta: {
                  id: 49,
                  parentId: 48,
                  title: '添加产品',
                },
              },
              {
                path: '/setGroup/psMain/productManager/update',
                name: 'ProductUpdate',
                meta: {
                  id: 50,
                  parentId: 48,
                  title: '修改产品',
                },
              },
              {
                path: '/setGroup/psMain/productManager/disabled',
                name: 'ProductDisabled',
                meta: {
                  id: 51,
                  parentId: 48,
                  title: '禁用产品',
                },
              },
            ],
          },
          {
            path: '/setGroup/psMain/serviceItemManager',
            name: 'ServiceItemManager',
            meta: {
              id: 52,
              parentId: 47,
              title: '项目管理',
            },
            children: [
              {
                path: '/setGroup/psMain/serviceItemManager/add',
                name: 'ServiceItemAdd',
                meta: {
                  id: 53,
                  parentId: 52,
                  title: '添加项目',
                },
              },
              {
                path: '/setGroup/psMain/serviceItemManager/update',
                name: 'ServiceItemUpdate',
                meta: {
                  id: 54,
                  parentId: 52,
                  title: '修改项目',
                },
              },
              {
                path: '/setGroup/psMain/serviceItemManager/disabled',
                name: 'ServiceItemDisabled',
                meta: {
                  id: 55,
                  parentId: 52,
                  title: '禁用项目',
                },
              },
            ],
          },
          {
            path: '/setGroup/psMain/packageManager',
            name: 'PackageManager',
            meta: {
              id: 56,
              parentId: 47,
              title: '套餐管理',
            },
            children: [
              {
                path: '/setGroup/psMain/packageManager/add',
                name: 'PackageAdd',
                meta: {
                  id: 57,
                  parentId: 56,
                  title: '添加套餐',
                },
              },
              {
                path: '/setGroup/psMain/packageManager/update',
                name: 'PackageUpdate',
                meta: {
                  id: 58,
                  parentId: 56,
                  title: '修改套餐',
                },
              },
              {
                path: '/setGroup/psMain/packageManager/disabled',
                name: 'PackageDisabled',
                meta: {
                  id: 59,
                  parentId: 56,
                  title: '禁用套餐',
                },
              },
            ],
          },
          {
            path: '/setGroup/psMain/treatmentCouponManager',
            name: 'TreatmentCouponManager',
            meta: {
              id: 56,
              parentId: 47,
              title: '疗程券管理',
            },
            children: [
              {
                path: '/setGroup/psMain/treatmentCouponManager/add',
                name: 'TreatmentCouponAdd',
                meta: {
                  id: 57,
                  parentId: 56,
                  title: '添加疗程券',
                },
              },
              {
                path: '/setGroup/psMain/treatmentCouponManager/update',
                name: 'TreatmentCouponUpdate',
                meta: {
                  id: 58,
                  parentId: 56,
                  title: '修改疗程券',
                },
              },
              {
                path: '/setGroup/psMain/treatmentCouponManager/disabled',
                name: 'TreatmentCouponDisabled',
                meta: {
                  id: 59,
                  parentId: 56,
                  title: '禁用疗程券',
                },
              },
            ],
          },
          {
            path: '/setGroup/psMain/rechargeCommission',
            name: 'RechargeCommission',
            meta: {
              id: 60,
              parentId: 47,
              title: '充值提成规则',
            },
            children: [
              {
                path: '/setGroup/psMain/rechargeCommission/add',
                name: 'RechargeCommissionAdd',
                meta: {
                  id: 61,
                  parentId: 60,
                  title: '添加充值提成规则',
                },
              },
              {
                path: '/setGroup/psMain/rechargeCommission/update',
                name: 'RechargeCommissionUpdate',
                meta: {
                  id: 62,
                  parentId: 60,
                  title: '修改充值提成规则',
                },
              },
              {
                path: '/setGroup/psMain/rechargeCommission/disabled',
                name: 'RechargeCommissionDisabled',
                meta: {
                  id: 63,
                  parentId: 60,
                  title: '禁用充值提成规则',
                },
              },
            ],
          },
        ],
      },
      {
        path: '/setGroup/roomBed',
        name: 'RoomBed',
        meta: {
          id: 64,
          parentId: 46, // 父节点为id=46
          title: '房间设定 ',
          icon: 'Box',
        },
        children: [
          {
            path: '/setGroup/roomBed/add',
            name: 'RoomAdd',
            meta: {
              id: 65,
              parentId: 64,
              title: '添加房间',
            },
          },
          {
            path: '/setGroup/roomBed/update',
            name: 'RoomUpdate',
            meta: {
              id: 66,
              parentId: 64,
              title: '修改房间',
            },
          },
        ],
      },
      {
        path: '/setGroup/stock',
        name: 'Stock',
        meta: {
          id: 67,
          parentId: 46, // 父节点为id=46
          title: '库存管理',
          tabs: ['入库', '出库', '库存流水'],
        },
        children: [
          {
            path: '/setGroup/stock/inStock',
            name: 'InStock',
            meta: {
              id: 68,
              parentId: 67,
              title: '入库',
            },
          },
          {
            path: '/setGroup/stock/outStock',
            name: 'OutStock',
            meta: {
              id: 69,
              parentId: 67,
              title: '出库',
            },
          },
          {
            path: '/setGroup/stock/stockLog',
            name: 'StockLog',
            meta: {
              id: 70,
              parentId: 67,
              title: '库存流水',
            },
          },
        ],
      },
    ],
  },

  // 权限管理
  {
    path: '/acl',
    name: 'Acl',
    meta: {
      id: 71, // 根节点id=71
      title: '系统设置',
    },
    children: [
      {
        path: '/acl/orgMgr',
        name: 'OrgMgr',
        meta: {
          id: 72,
          parentId: 71, // 父节点为id=71
          title: '门店管理',
        },
        children: [
          {
            path: '/acl/orgMgr/add',
            name: 'OrgAdd',
            meta: {
              id: 73,
              parentId: 72,
              title: '添加门店',
            },
          },
          {
            path: '/acl/orgMgr/update',
            name: 'OrgUpdate',
            meta: {
              id: 74,
              parentId: 72,
              title: '修改门店',
            },
          },
          {
            path: '/acl/orgMgr/disabled',
            name: 'OrgDisabled',
            meta: {
              id: 75,
              parentId: 72,
              title: '禁用门店',
            },
          },
        ],
      },
      {
        path: '/acl/user',
        name: 'User',
        meta: {
          id: 76,
          parentId: 71,
          title: '用户管理',
          icon: 'User',
        },
        children: [
          {
            path: '/acl/user/add',
            name: 'UserAdd',
            meta: {
              id: 77,
              parentId: 76,
              title: '添加用户',
            },
          },
          {
            path: '/acl/user/update',
            name: 'UserUpdate',
            meta: {
              id: 78,
              parentId: 76,
              title: '修改用户',
            },
          },
          {
            path: '/acl/user/disabled',
            name: 'UserDisabled',
            meta: {
              id: 79,
              parentId: 76,
              title: '禁用用户',
            },
          },
        ],
      },
      {
        path: '/acl/role',
        name: 'Role',
        meta: {
          id: 80,
          parentId: 71,
          title: '角色管理',
          icon: 'UserFilled',
        },
        children: [
          {
            path: '/acl/role/add',
            name: 'RoleAdd',
            meta: {
              id: 81,
              parentId: 80,
              title: '添加角色',
            },
          },
          {
            path: '/acl/role/update',
            name: 'RoleUpdate',
            meta: {
              id: 82,
              parentId: 80,
              title: '修改角色',
            },
          },
          {
            path: '/acl/role/disabled',
            name: 'RoleDisabled',
            meta: {
              id: 83,
              parentId: 80,
              title: '禁用角色',
            },
          },
          {
            path: '/acl/role/allocated',
            name: 'RoleAllocated',
            meta: {
              id: 84,
              parentId: 80,
              title: '权限分配',
            },
          },
        ],
      },
      {
        path: '/acl/permission',
        name: 'Permission',
        meta: {
          id: 85,
          parentId: 71,
          title: '权限管理',
          icon: 'Lock',
        },
        children: [
          {
            path: '/acl/permission/add',
            name: 'PermissionAdd',
            meta: {
              id: 86,
              parentId: 85,
              title: '添加权限',
            },
          },
          {
            path: '/acl/permission/update',
            name: 'PermissionUpdate',
            meta: {
              id: 87,
              parentId: 85,
              title: '修改权限',
            },
          },
          {
            path: '/acl/permission/disabled',
            name: 'PermissionDisabled',
            meta: {
              id: 88,
              parentId: 85,
              title: '禁用权限',
            },
          },
        ],
      },
      {
        path: '/acl/enum',
        name: 'Enum',
        meta: {
          id: 89,
          parentId: 71,
          title: '枚举管理',
        },
        children: [
          {
            path: '/acl/enum/add',
            name: 'EnumAdd',
            meta: {
              id: 90,
              parentId: 89,
              title: '添加枚举',
            },
          },
          {
            path: '/acl/enum/update',
            name: 'EnumUpdate',
            meta: {
              id: 91,
              parentId: 89,
              title: '修改枚举',
            },
          },
          {
            path: '/acl/enum/disabled',
            name: 'EnumDisabled',
            meta: {
              id: 92,
              parentId: 89,
              title: '禁用枚举',
            },
          },
        ],
      },
    ],
  },
  // 登录
  {
    path: '/login',
    name: 'login',
    meta: {
      id: 93, // 根节点id=93
      title: '登录',
      hidden: true,
    },
  },

  // 404
  {
    path: '/404',
    name: '404',
    meta: {
      id: 94, // 根节点id=94
      title: '404',
      hidden: true,
      icon: 'DocumentDelete',
    },
  },
];
