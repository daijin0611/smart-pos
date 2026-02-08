<template>
  <!-- <div> -->
  <el-table
    :height="props.height"
    :data="props.data"
    :max-height="props.maxHeight"
    :stripe="props.stripe"
    :border="props.border"
    :size="props.size"
    :fit="props.fit"
    :show-header="props.showHeader"
    :highlight-current-row="props.highlightCurrentRow"
    :row-class-name="props.rowClassName"
    :row-style="props.rowStyle"
    :cell-class-name="props.cellClassName"
    :cell-style="props.cellStyle"
    :header-row-class-name="props.headerRowClassName"
    :header-row-style="props.headerRowStyle"
    :header-cell-class-name="props.headerCellClassName"
    :header-cell-style="props.headerCellStyle"
    :row-key="props.rowKey"
    :empty-text="props.emptyText"
    :default-expand-all="props.defaultExpandAll"
    :tree-props="props.treeProps"
    :default-sort="props.defaultSort"
    :tooltip-effect="props.tooltipEffect"
    :show-summary="props.showSummary"
    :sum-text="props.sumText"
    :summary-method="props.summaryMethod"
    :span-method="props.spanMethod"
    :select-on-indeterminate="props.selectOnIndeterminate"
    :indent="props.indent"
    :lazy="props.lazy"
    :load="props.load"
    :table-layout="props.tableLayout"
    @select="handleSelect"
    @select-all="handleSelectAll"
    @selection-change="handleSelectionChange"
    @cell-mouse-enter="handleCellMouseEnter"
    @cell-mouse-leave="handleCellMouseLeave"
    @cell-click="handleCellClick"
    @cell-dblclick="handleCellDblclick"
    @cell-contextmenu="handleCellContextmenu"
    @row-click="handleRowClick"
    @row-contextmenu="handleRowContextmenu"
    @row-dblclick="handleRowDblclick"
    @header-click="handleHeaderClick"
    @header-contextmenu="handleHeaderContextmenu"
    @sort-change="handleSortChange"
    @filter-change="handleFilterChange"
    @current-change="handleCurrentChange"
    @header-dragend="handleHeaderDragend"
    @expand-change="handleExpandChange"
    class="custom-table"
  >
    <!-- 表格列 -->
    <slot></slot>

    <!-- 自定义空数据显示 -->
    <template #empty v-if="$slots.empty">
      <slot name="empty"></slot>
    </template>

    <!-- 自定义表尾合计行 -->
    <template #append v-if="$slots.append">
      <slot name="append"></slot>
    </template>
  </el-table>
  <!-- </div> -->
</template>

<script lang="ts" setup>
import { ref, withDefaults, onMounted } from 'vue';

/**
 * 定义表格组件事件
 * 所有事件都会透传给el-table组件
 */
const $emit = defineEmits([
  /** 当用户手动勾选数据行的 Checkbox 时触发 */
  'select',
  /** 当用户手动勾选全选 Checkbox 时触发 */
  'select-all',
  /** 当选择项发生变化时触发 */
  'selection-change',
  /** 当单元格 hover 进入时触发 */
  'cell-mouse-enter',
  /** 当单元格 hover 退出时触发 */
  'cell-mouse-leave',
  /** 当单元格被点击时触发 */
  'cell-click',
  /** 当单元格被双击时触发 */
  'cell-dblclick',
  /** 当单元格右键点击时触发 */
  'cell-contextmenu',
  /** 当某一行被点击时触发 */
  'row-click',
  /** 当某一行被右键点击时触发 */
  'row-contextmenu',
  /** 当某一行被双击时触发 */
  'row-dblclick',
  /** 当某一列的表头被点击时触发 */
  'header-click',
  /** 当某一列的表头被右键点击时触发 */
  'header-contextmenu',
  /** 当表格的排序条件发生变化时触发 */
  'sort-change',
  /** 当表格的筛选条件发生变化时触发 */
  'filter-change',
  /** 当表格的当前行发生变化时触发 */
  'current-change',
  /** 当拖动表头改变列的宽度时触发 */
  'header-dragend',
  /** 当展开行时触发 */
  'expand-change',
]);

/**
 * 表格组件属性接口定义
 */
interface TableProps {
  /** 显示的数据源 */
  data: any[];
  /** Table 的高度，默认为自动高度 */
  height?: string | number;
  /** Table 的最大高度 */
  maxHeight?: string | number;
  /** 是否为斑马纹表格 */
  stripe?: boolean;
  /** 是否带有纵向边框 */
  border?: boolean;
  /** Table 的尺寸 */
  size?: 'large' | 'default' | 'small';
  /** 列的宽度是否自撑开 */
  fit?: boolean;
  /** 是否显示表头 */
  showHeader?: boolean;
  /** 是否要高亮当前行 */
  highlightCurrentRow?: boolean;
  /** 行的 className 的回调方法，也可以使用字符串为所有行设置一个固定的 className */
  rowClassName?: string | ((params: { row: any; rowIndex: number }) => string);
  /** 行的 style 的回调方法，也可以使用一个固定的 Object 为所有行设置一样的 Style */
  rowStyle?: object | ((params: { row: any; rowIndex: number }) => object);
  /** 单元格的 className 的回调方法，也可以使用字符串为所有单元格设置一个固定的 className */
  cellClassName?: string | ((params: { row: any; column: any; rowIndex: number; columnIndex: number }) => string);
  /** 单元格的 style 的回调方法，也可以使用一个固定的 Object 为所有单元格设置一样的 Style */
  cellStyle?: object | ((params: { row: any; column: any; rowIndex: number; columnIndex: number }) => object);
  /** 表头行的 className 的回调方法，也可以使用字符串为所有表头行设置一个固定的 className */
  headerRowClassName?: string | ((params: { row: any; rowIndex: number }) => string);
  /** 表头行的 style 的回调方法，也可以使用一个固定的 Object 为所有表头行设置一样的 Style */
  headerRowStyle?: object | ((params: { row: any; rowIndex: number }) => object);
  /** 表头单元格的 className 的回调方法，也可以使用字符串为所有表头单元格设置一个固定的 className */
  headerCellClassName?: string | ((params: { row: any; column: any; rowIndex: number; columnIndex: number }) => string);
  /** 表头单元格的 style 的回调方法，也可以使用一个固定的 Object 为所有表头单元格设置一样的 Style */
  headerCellStyle?: object | ((params: { row: any; column: any; rowIndex: number; columnIndex: number }) => object);
  /** 行数据的 Key，用来优化 Table 的渲染 */
  rowKey?: string | ((row: any) => string);
  /** 空数据时显示的文本内容 */
  emptyText?: string;
  /** 是否默认展开所有行，当 Table 包含展开行时有效 */
  defaultExpandAll?: boolean;
  /** 渲染嵌套数据的配置选项 */
  treeProps?: { children: string; hasChildren: string };
  /** 默认的排序列的 prop 和顺序 */
  defaultSort?: { prop: string; order: 'ascending' | 'descending' };
  /** tooltip effect 属性 */
  tooltipEffect?: 'dark' | 'light';
  /** 是否在表尾显示合计行 */
  showSummary?: boolean;
  /** 合计行第一列的文本 */
  sumText?: string;
  /** 自定义的合计计算方法 */
  summaryMethod?: (params: { columns: any[]; data: any[] }) => any[];
  /** 自定义的合并单元格方法 */
  spanMethod?: (params: {
    row: any;
    column: any;
    rowIndex: number;
    columnIndex: number;
  }) => number[] | { rowspan: number; colspan: number };
  /** 在多选表格中，当仅有部分行被选中时，点击表头的多选框时的行为 */
  selectOnIndeterminate?: boolean;
  /** 展示树形数据时，树节点的缩进 */
  indent?: number;
  /** 是否懒加载子节点数据 */
  lazy?: boolean;
  /** 加载子节点数据的函数，lazy 为 true 时生效 */
  load?: (row: any, treeNode: any, resolve: (data: any[]) => void) => void;
  /** 表格的布局方式 */
  tableLayout?: 'fixed' | 'auto';
}

// 使用 withDefaults 添加默认值
const props = withDefaults(defineProps<TableProps>(), {
  data: () => [],
  height: '100%',
  maxHeight: 'auto',
  stripe: false,
  border: true,
  size: 'default',
  fit: true,
  showHeader: true,
  highlightCurrentRow: false,
  emptyText: '暂无数据',
  defaultExpandAll: false,
  tooltipEffect: 'dark',
  showSummary: false,
  sumText: '合计',
  selectOnIndeterminate: true,
  indent: 16,
  lazy: false,
  tableLayout: 'fixed',
});

// #region 表格事件处理函数
/**
 * 当用户手动勾选数据行的 Checkbox 时触发的事件处理函数
 * @param selection 已选择的行数据
 * @param row 当前选择的行数据
 */
const handleSelect = (selection: any[], row: any) => {
  $emit('select', selection, row);
};

/**
 * 当用户手动勾选全选 Checkbox 时触发的事件处理函数
 * @param selection 已选择的行数据
 */
const handleSelectAll = (selection: any[]) => {
  $emit('select-all', selection);
};

/**
 * 当选择项发生变化时触发的事件处理函数
 * @param selection 已选择的行数据
 */
const handleSelectionChange = (selection: any[]) => {
  $emit('selection-change', selection);
};

/**
 * 当单元格 hover 进入时触发的事件处理函数
 * @param row 行数据
 * @param column 列数据
 * @param cell 单元格DOM元素
 * @param event 事件对象
 */
const handleCellMouseEnter = (row: any, column: any, cell: HTMLElement, event: Event) => {
  $emit('cell-mouse-enter', row, column, cell, event);
};

/**
 * 当单元格 hover 退出时触发的事件处理函数
 * @param row 行数据
 * @param column 列数据
 * @param cell 单元格DOM元素
 * @param event 事件对象
 */
const handleCellMouseLeave = (row: any, column: any, cell: HTMLElement, event: Event) => {
  $emit('cell-mouse-leave', row, column, cell, event);
};

/**
 * 当单元格被点击时触发的事件处理函数
 * @param row 行数据
 * @param column 列数据
 * @param cell 单元格DOM元素
 * @param event 事件对象
 */
const handleCellClick = (row: any, column: any, cell: HTMLElement, event: Event) => {
  $emit('cell-click', row, column, cell, event);
};

/**
 * 当单元格被双击时触发的事件处理函数
 * @param row 行数据
 * @param column 列数据
 * @param cell 单元格DOM元素
 * @param event 事件对象
 */
const handleCellDblclick = (row: any, column: any, cell: HTMLElement, event: Event) => {
  $emit('cell-dblclick', row, column, cell, event);
};

/**
 * 当单元格右键点击时触发的事件处理函数
 * @param row 行数据
 * @param column 列数据
 * @param cell 单元格DOM元素
 * @param event 事件对象
 */
const handleCellContextmenu = (row: any, column: any, cell: HTMLElement, event: Event) => {
  $emit('cell-contextmenu', row, column, cell, event);
};

/**
 * 当某一行被点击时触发的事件处理函数
 * @param row 行数据
 * @param column 列数据
 * @param event 事件对象
 */
const handleRowClick = (row: any, column: any, event: Event) => {
  $emit('row-click', row, column, event);
};

/**
 * 当某一行被右键点击时触发的事件处理函数
 * @param row 行数据
 * @param column 列数据
 * @param event 事件对象
 */
const handleRowContextmenu = (row: any, column: any, event: Event) => {
  $emit('row-contextmenu', row, column, event);
};

/**
 * 当某一行被双击时触发的事件处理函数
 * @param row 行数据
 * @param column 列数据
 * @param event 事件对象
 */
const handleRowDblclick = (row: any, column: any, event: Event) => {
  $emit('row-dblclick', row, column, event);
};

/**
 * 当某一列的表头被点击时触发的事件处理函数
 * @param column 列数据
 * @param event 事件对象
 */
const handleHeaderClick = (column: any, event: Event) => {
  $emit('header-click', column, event);
};

/**
 * 当某一列的表头被右键点击时触发的事件处理函数
 * @param column 列数据
 * @param event 事件对象
 */
const handleHeaderContextmenu = (column: any, event: Event) => {
  $emit('header-contextmenu', column, event);
};

/**
 * 当表格的排序条件发生变化时触发的事件处理函数
 * @param params 排序参数对象，包含column、prop和order属性
 */
const handleSortChange = (params: { column: any; prop: string; order: string }) => {
  $emit('sort-change', params);
};

/**
 * 当表格的筛选条件发生变化时触发的事件处理函数
 * @param filters 筛选参数对象
 */
const handleFilterChange = (filters: any) => {
  $emit('filter-change', filters);
};

/**
 * 当表格的当前行发生变化时触发的事件处理函数
 * @param currentRow 当前行数据
 * @param oldCurrentRow 之前的当前行数据
 */
const handleCurrentChange = (currentRow: any, oldCurrentRow: any) => {
  $emit('current-change', currentRow, oldCurrentRow);
};

/**
 * 当拖动表头改变列的宽度时触发的事件处理函数
 * @param newWidth 新的宽度
 * @param oldWidth 旧的宽度
 * @param column 列数据
 * @param event 事件对象
 */
const handleHeaderDragend = (newWidth: number, oldWidth: number, column: any, event: Event) => {
  $emit('header-dragend', newWidth, oldWidth, column, event);
};

/**
 * 当展开行时触发的事件处理函数
 * @param row 行数据
 * @param expanded 是否展开
 */
const handleExpandChange = (row: any, expanded: boolean) => {
  $emit('expand-change', row, expanded);
};
// #endregion
</script>
<style lang="scss" scoped>
/* 使用深度选择器修改表格表头样式 */
:deep(.custom-table .el-table__header-wrapper th) {
  background-color: $base-child-nav-bg; // 使用自定义颜色变量
}
</style>
