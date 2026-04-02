<template>
  <div class="pagination-table-container" :style="{ height: props.containerHeight }">
    <!-- 表格部分 -->
    <div class="table-container">
      <el-table
        ref="tableRef"
        :height="tableHeight"
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
        class="pagination-table"
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
    </div>

    <!-- 分页部分 -->
    <div class="pagination-container" v-if="props.showPagination">
      <div>
        <slot name="total"></slot>
      </div>
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="props.pageSizes"
        :small="props.small"
        :background="props.background"
        :layout="props.layout"
        :total="props.total"
        :disabled="props.disabled"
        :hide-on-single-page="props.hideOnSinglePage"
        @size-change="handlePaginationSizeChange"
        @current-change="handlePaginationCurrentChange"
        @prev-click="handlePaginationPrevClick"
        @next-click="handlePaginationNextClick"
        size="small"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, withDefaults, onMounted, nextTick } from 'vue';
import type { ElTable } from 'element-plus';

// 定义事件
const $emit = defineEmits([
  // 表格事件
  'selection-change',
  'cell-mouse-enter',
  'cell-mouse-leave',
  'cell-click',
  'cell-dblclick',
  'cell-contextmenu',
  'row-click',
  'row-contextmenu',
  'row-dblclick',
  'header-click',
  'header-contextmenu',
  'sort-change',
  'filter-change',
  'current-change',
  'header-dragend',
  'expand-change',
  // 分页事件
  'update:currentPage',
  'update:pageSize',
  'size-change',
  'pagination-current-change',
  'prev-click',
  'next-click',
]);

// 定义属性和默认值
const props = withDefaults(
  defineProps<{
    // 表格数据
    data: any[];
    // 表格高度
    height?: string | number;
    // 容器高度
    containerHeight?: string | number;
    // 表格最大高度
    maxHeight?: string | number;
    // 是否为斑马纹表格
    stripe?: boolean;
    // 是否带有纵向边框
    border?: boolean;
    // 表格尺寸
    size?: 'large' | 'default' | 'small';
    // 列的宽度是否自撑开
    fit?: boolean;
    // 是否显示表头
    showHeader?: boolean;
    // 是否要高亮当前行
    highlightCurrentRow?: boolean;
    // 行的 className
    rowClassName?: string | ((params: { row: any; rowIndex: number }) => string);
    // 行的 style
    rowStyle?: object | ((params: { row: any; rowIndex: number }) => object);
    // 单元格的 className
    cellClassName?: string | ((params: { row: any; column: any; rowIndex: number; columnIndex: number }) => string);
    // 单元格的 style
    cellStyle?: object | ((params: { row: any; column: any; rowIndex: number; columnIndex: number }) => object);
    // 表头行的 className
    headerRowClassName?: string | ((params: { row: any; rowIndex: number }) => string);
    // 表头行的 style
    headerRowStyle?: object | ((params: { row: any; rowIndex: number }) => object);
    // 表头单元格的 className
    headerCellClassName?:
      | string
      | ((params: { row: any; column: any; rowIndex: number; columnIndex: number }) => string);
    // 表头单元格的 style
    headerCellStyle?: object | ((params: { row: any; column: any; rowIndex: number; columnIndex: number }) => object);
    // 行数据的 Key
    rowKey?: string | ((row: any) => string);
    // 空数据时显示的文本内容
    emptyText?: string;
    // 是否默认展开所有行
    defaultExpandAll?: boolean;
    // 渲染嵌套数据的配置选项
    treeProps?: { children: string; hasChildren: string };
    // 默认的排序列的 prop 和顺序
    defaultSort?: { prop: string; order: 'ascending' | 'descending' };
    // tooltip effect 属性
    tooltipEffect?: 'dark' | 'light';
    // 是否在表尾显示合计行
    showSummary?: boolean;
    // 合计行第一列的文本
    sumText?: string;
    // 自定义的合计计算方法
    summaryMethod?: (params: { columns: any[]; data: any[] }) => any[];
    // 自定义的合并单元格方法
    spanMethod?: (params: {
      row: any;
      column: any;
      rowIndex: number;
      columnIndex: number;
    }) => number[] | { rowspan: number; colspan: number };
    // 在多选为不确定状态时，点击行时的选择行为
    selectOnIndeterminate?: boolean;
    // 展示树形数据时，树节点的缩进
    indent?: number;
    // 是否懒加载子节点数据
    lazy?: boolean;
    // 加载子节点数据的函数
    load?: (row: any, treeNode: any, resolve: (data: any[]) => void) => void;
    // 表格的布局方式
    tableLayout?: 'fixed' | 'auto';

    // 分页相关属性
    // 是否显示分页
    showPagination?: boolean;
    // 当前页码
    currentPage?: number;
    // 每页显示条数
    pageSize?: number;
    // 每页显示条数选项
    pageSizes?: number[];
    // 分页组件布局
    layout?: string;
    // 总条目数
    total?: number;
    // 是否使用小型分页
    small?: boolean;
    // 是否为分页按钮添加背景色
    background?: boolean;
    // 是否禁用分页
    disabled?: boolean;
    // 只有一页时是否隐藏分页
    hideOnSinglePage?: boolean;
  }>(),
  {
    // 表格默认值
    data: () => [],
    height: '100%',
    containerHeight: '100%',
    maxHeight: 'auto',
    stripe: true,
    border: true,
    size: 'default',
    fit: true,
    showHeader: true,
    highlightCurrentRow: true,
    emptyText: '暂无数据',
    defaultExpandAll: false,
    tooltipEffect: 'dark',
    showSummary: false,
    selectOnIndeterminate: true,
    tableLayout: 'fixed',

    // 分页默认值
    showPagination: true,
    currentPage: 1,
    pageSize: 10,
    pageSizes: () => [10, 20, 30, 50, 100],
    layout: 'total, sizes, prev, pager, next, jumper',
    total: 0,
    small: false,
    background: true,
    disabled: false,
    hideOnSinglePage: false,
  },
);

// 内部状态
const tableRef = ref<InstanceType<typeof ElTable>>();
const currentPage = ref(props.currentPage);
const pageSize = ref(props.pageSize);

// 计算表格高度，确保表头和分页固定
const tableHeight = computed(() => {
  if (typeof props.height === 'number') {
    return props.height - (props.showPagination ? 44 : 0) + 'px';
  } else if (props.height === 'auto') {
    return 'auto';
  } else {
    return props.height;
  }
});

// 监听 props 变化
watch(
  () => props.currentPage,
  (newValue) => {
    currentPage.value = newValue;
  },
);

watch(
  () => props.pageSize,
  (newValue) => {
    pageSize.value = newValue;
  },
);

// 监听内部状态变化，通知父组件更新
watch(
  () => currentPage.value,
  (newValue) => {
    $emit('update:currentPage', newValue);
  },
);

watch(
  () => pageSize.value,
  (newValue) => {
    $emit('update:pageSize', newValue);
  },
);

// #region 表格事件处理函数
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
 * @param oldCurrentRow 旧的当前行数据
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

// #region 分页事件处理函数
/**
 * 当分页大小改变时触发的事件处理函数
 * @param val 新的分页大小
 */
const handlePaginationSizeChange = (val: number) => {
  pageSize.value = val;
  $emit('size-change', val);
};

/**
 * 当分页当前页改变时触发的事件处理函数
 * @param val 新的当前页
 */
const handlePaginationCurrentChange = (val: number) => {
  currentPage.value = val;
  $emit('pagination-current-change', val);
};

/**
 * 当点击上一页按钮时触发的事件处理函数
 * @param val 新的当前页
 */
const handlePaginationPrevClick = (val: number) => {
  $emit('prev-click', val);
};

/**
 * 当点击下一页按钮时触发的事件处理函数
 * @param val 新的当前页
 */
const handlePaginationNextClick = (val: number) => {
  $emit('next-click', val);
};
// #endregion

// 对外暴露方法和属性
defineExpose({
  // 表格实例
  tableRef,
  // 分页相关
  currentPage,
  pageSize,
});
</script>

<style lang="scss" scoped>
.pagination-table-container {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  position: relative;

  .table-container {
    flex: 1;
    overflow: hidden;
  }

  .pagination-container {
    padding: 10px;
    display: flex;
    flex-direction: row;
    justify-content: flex-end;
    z-index: 10;

    > div:first-child {
      flex: 1;
    }
  }
}

/* 使用深度选择器修改表格表头样式 */
:deep(.pagination-table .el-table__header-wrapper th) {
  background-color: $base-child-nav-bg;
}
</style>
