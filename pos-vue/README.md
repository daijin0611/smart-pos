# LLD-CMS 后台管理系统

## 项目概述

基于 Vue3+TypeScript 构建的企业级后台管理系统，采用前后端分离架构，包含权限控制、组织架构管理、数据可视化等核心模块。

## 技术栈

- 前端框架：Vue 3.3 + Composition API
- 构建工具：Vite 5.x
- 状态管理：Pinia 2.x
- UI 组件：Element Plus
- 路由管理：Vue Router 4.x
- HTTP 请求：Axios 1.x + 自主封装
- 样式方案：SCSS + CSS 变量
- 代码规范：ESLint + Prettier + Husky

## 核心功能

✅ RBAC 权限控制系统
✅ 组织架构树形管理
✅ 动态路由加载机制
✅ 可视化数据看板
✅ 通用组件库封装
✅ 多环境部署配置
✅ 小票多页打印支持（Lodop）

## 项目结构

```
LLD_CMS/
├── src/                 # 核心代码
│   ├── api/            # 接口模块化封装
│   ├── components/     # 全局通用组件
│   ├── layout/         # 基础布局组件
│   ├── router/         # 路由配置及权限拦截
│   ├── store/          # Pinia状态管理
│   ├── styles/         # 全局样式体系
│   └── views/          # 业务页面模块
├── mock/               # Mock数据服务
├── .env.*              # 多环境配置
└── vite.config.ts      # Vite高级配置
```

## 开发指南

```bash
# 安装依赖
pnpm install

# 启动开发服务器
pnpm dev

# 构建生产版本
pnpm build

# 代码质量检查
pnpm lint
```

## 特别说明

1. 环境变量配置参考 `.env.example`
2. API 模块已封装自动错误处理机制
3. 组件命名遵循 `PascalCase` 规范
4. 样式使用 `BEM` 命名约定
