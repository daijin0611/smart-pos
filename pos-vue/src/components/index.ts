// 引入项目中全部的全局组件
import SvgIcon from './SvgIcon/index.vue';
import Pagination from './Pagination/index.vue';
import Dialog from './Dialog/index.vue';
import Drawer from './Drawer/index.vue';
import Table from './Table/index.vue';
import PaginationTable from './PaginationTable/index.vue';
import Form from './Form/index.vue';
import Card from './Card/index.vue';
import BtnForm from './BtnForm/index.vue';
import DynamicInput from './DynamicInput/index.vue';
import DatePicker from './DatePicker/index.vue';
import MultipleSelect from './MultipleSelect/index.vue';
import EllipsisText from './EllipsisText/index.vue';
import Empty from './Empty/index.vue';
import Message from './Message';
import MessageBox from './MessageBox';
import Notification from './Notification';

// 引入element-plus提供全部图标组件
import * as ElementPlusIconsVue from '@element-plus/icons-vue';

// 全局对象
const allGlobalComponent: any = {
  SvgIcon,
  Pagination,
  Dialog,
  Drawer,
  Table,
  PaginationTable,
  Form,
  Card,
  BtnForm,
  DynamicInput,
  DatePicker,
  MultipleSelect,
  EllipsisText,
  Empty,
};

// 对外暴露插件对象
export default {
  // 务必叫做install方法
  install(app: any) {
    // 注册项目全部的全局组件
    Object.keys(allGlobalComponent).forEach((key) => {
      // 注册为全局组件
      app.component(key, allGlobalComponent[key]);
    });

    // 将element-plus提供图标注册为全局组件
    for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
      app.component(key, component);
    }

    // 添加全局属性
    app.provide('$Message', Message);
    app.provide('$MessageBox', MessageBox);
    app.provide('$Notification', Notification);
  },
};
