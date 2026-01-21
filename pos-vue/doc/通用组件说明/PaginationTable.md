# PaginationTable 分页表格组件

## 组件介绍

PaginationTable 是一个集成了表格和分页功能的通用组件，基于 Element Plus 的 el-table 和 el-pagination 组件封装而成。该组件实现了表头和分页固定的功能，使得在处理大量数据时，用户体验更加友好。

## 特性

- **表头固定**：表格的表头会固定在顶部，不随滚动而移动
- **分页固定**：分页组件固定在底部，不随滚动而移动
- **高度自适应**：可以通过 height 属性设置表格的高度，分页会自动适应
- **v-model 支持**：支持 v-model:currentPage 和 v-model:pageSize 进行双向绑定
- **完整继承**：继承了 el-table 和 el-pagination 的所有属性和事件

## 使用方法

### 基础用法

```vue
<template>
  <div class="table-container">
    <PaginationTable
      :data="tableData"
      :total="total"
      v-model:currentPage="currentPage"
      v-model:pageSize="pageSize"
      height="500px"
      @size-change="handleSizeChange"
      @pagination-current-change="handleCurrentChange"
    >
      <el-table-column type="selection" width="55" />
      <el-table-column type="index" label="序号" width="80" />
      <el-table-column prop="date" label="日期" width="180" />
      <el-table-column prop="name" label="姓名" width="180" />
      <el-table-column prop="address" label="地址" />
    </PaginationTable>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

// 分页相关
const currentPage = ref(1);
const pageSize = ref(10);
const total = ref(100);

// 模拟数据
const tableData = ref(
  Array.from({ length: 10 }).map((_, index) => ({
    date: `2023-01-${index + 1}`,
    name: `用户${index + 1}`,
    address: `北京市朝阳区某某街道第${index + 1}号`,
  })),
);

// 处理分页变化
const handleSizeChange = (val: number) => {
  console.log(`每页 ${val} 条`);
  // 这里可以调用接口重新获取数据
};

const handleCurrentChange = (val: number) => {
  console.log(`当前页: ${val}`);
  // 这里可以调用接口重新获取数据
};
</script>
```

### 自定义高度和布局

```vue
<template>
  <PaginationTable
    :data="tableData"
    :total="total"
    v-model:currentPage="currentPage"
    v-model:pageSize="pageSize"
    height="calc(100vh - 200px)"
    <!--
    使用计算高度
    --
  >
    border stripe :layout="'total, sizes, prev, pager, next'"
    <!-- 自定义分页布局 -->
    >
    <!-- 表格列配置 -->
  </PaginationTable>
</template>
```

### 不显示分页

```vue
<template>
  <PaginationTable :data="tableData" :showPagination="false" <!-- 不显示分页 -->
    height="400px" >
    <!-- 表格列配置 -->
  </PaginationTable>
</template>
```

## 属性

### 表格属性

PaginationTable 组件继承了 el-table 的所有属性，主要包括：

| 属性名                | 说明                      | 类型                             | 默认值                                               |
| --------------------- | ------------------------- | -------------------------------- | ---------------------------------------------------- |
| data                  | 显示的数据                | array                            | []                                                   |
| height                | 表格高度                  | string / number                  | 'auto'                                               |
| max-height            | 表格最大高度              | string / number                  | 'auto'                                               |
| stripe                | 是否为斑马纹表格          | boolean                          | false                                                |
| border                | 是否带有纵向边框          | boolean                          | true                                                 |
| size                  | 表格尺寸                  | 'large' / 'default' / 'small'    | 'default'                                            |
| fit                   | 列的宽度是否自撑开        | boolean                          | true                                                 |
| show-header           | 是否显示表头              | boolean                          | true                                                 |
| highlight-current-row | 是否要高亮当前行          | boolean                          | false                                                |
| row-class-name        | 行的 className 的回调方法 | Function({row, rowIndex})/String | -                                                    |
| row-style             | 行的 style 的回调方法     | Function({row, rowIndex})/Object | -                                                    |
| row-key               | 行数据的 Key              | Function(row)/String             | -                                                    |
| empty-text            | 空数据时显示的文本内容    | String                           | '暂无数据'                                           |
| default-expand-all    | 是否默认展开所有行        | boolean                          | false                                                |
| tree-props            | 渲染嵌套数据的配置选项    | Object                           | { children: 'children', hasChildren: 'hasChildren' } |
| table-layout          | 表格的布局方式            | 'fixed' / 'auto'                 | 'fixed'                                              |

### 分页属性

PaginationTable 组件继承了 el-pagination 的所有属性，主要包括：

| 属性名              | 说明                     | 类型    | 默认值                                    |
| ------------------- | ------------------------ | ------- | ----------------------------------------- |
| show-pagination     | 是否显示分页             | boolean | true                                      |
| current-page        | 当前页码                 | number  | 1                                         |
| page-size           | 每页显示条数             | number  | 10                                        |
| page-sizes          | 每页显示条数选项         | array   | [10, 20, 30, 50]                          |
| layout              | 分页组件布局             | string  | 'total, sizes, prev, pager, next, jumper' |
| total               | 总条目数                 | number  | 0                                         |
| small               | 是否使用小型分页         | boolean | false                                     |
| background          | 是否为分页按钮添加背景色 | boolean | true                                      |
| disabled            | 是否禁用分页             | boolean | false                                     |
| hide-on-single-page | 只有一页时是否隐藏分页   | boolean | false                                     |

## 事件

### 表格事件

PaginationTable 组件继承了 el-table 的所有事件，主要包括：

| 事件名             | 说明                           | 参数                              |
| ------------------ | ------------------------------ | --------------------------------- |
| selection-change   | 当选择项发生变化时触发         | selection                         |
| cell-mouse-enter   | 当单元格 hover 进入时触发      | row, column, cell, event          |
| cell-mouse-leave   | 当单元格 hover 退出时触发      | row, column, cell, event          |
| cell-click         | 当单元格被点击时触发           | row, column, cell, event          |
| cell-dblclick      | 当单元格被双击时触发           | row, column, cell, event          |
| cell-contextmenu   | 当单元格右键点击时触发         | row, column, cell, event          |
| row-click          | 当某一行被点击时触发           | row, column, event                |
| row-contextmenu    | 当某一行被右键点击时触发       | row, column, event                |
| row-dblclick       | 当某一行被双击时触发           | row, column, event                |
| header-click       | 当某一列的表头被点击时触发     | column, event                     |
| header-contextmenu | 当某一列的表头被右键点击时触发 | column, event                     |
| sort-change        | 当表格的排序条件发生变化时触发 | { column, prop, order }           |
| filter-change      | 当表格的筛选条件发生变化时触发 | filters                           |
| current-change     | 当表格的当前行发生变化时触发   | currentRow, oldCurrentRow         |
| header-dragend     | 当拖动表头改变列的宽度时触发   | newWidth, oldWidth, column, event |
| expand-change      | 当展开行时触发                 | row, expanded                     |

### 分页事件

PaginationTable 组件继承了 el-pagination 的所有事件，主要包括：

| 事件名                    | 说明                   | 参数         |
| ------------------------- | ---------------------- | ------------ |
| size-change               | 当分页大小改变时触发   | 新的每页条数 |
| pagination-current-change | 当分页当前页改变时触发 | 新的当前页   |
| prev-click                | 当点击上一页按钮时触发 | 新的当前页   |
| next-click                | 当点击下一页按钮时触发 | 新的当前页   |

## 插槽

### 默认插槽

默认插槽用于放置 el-table-column 组件，定义表格的列。

```vue
<PaginationTable :data="tableData">
  <el-table-column prop="name" label="姓名" />
  <el-table-column prop="age" label="年龄" />
</PaginationTable>
```

### empty 插槽

用于自定义表格空数据时的显示内容。

```vue
<PaginationTable :data="tableData">
  <template #empty>
    <div class="empty-block">
      <p>暂无数据，请先添加数据</p>
      <el-button type="primary">添加数据</el-button>
    </div>
  </template>
  <!-- 表格列 -->
</PaginationTable>
```

### append 插槽

用于在表格尾部插入内容，例如添加合计行。

```vue
<PaginationTable :data="tableData">
  <!-- 表格列 -->
  <template #append>
    <tr>
      <td colspan="2">合计</td>
      <td>{{ totalAmount }}</td>
    </tr>
  </template>
</PaginationTable>
```

## 方法

PaginationTable 组件通过 defineExpose 暴露了以下方法和属性：

| 名称        | 说明                                   | 类型                              |
| ----------- | -------------------------------------- | --------------------------------- |
| tableRef    | 表格实例，可以调用 el-table 的所有方法 | Ref<InstanceType<typeof ElTable>> |
| currentPage | 当前页码                               | Ref<number>                       |
| pageSize    | 每页显示条数                           | Ref<number>                       |

使用示例：

```vue
<template>
  <div>
    <PaginationTable ref="paginationTableRef" :data="tableData">
      <!-- 表格列 -->
    </PaginationTable>
    <el-button @click="clearSelection">清除选择</el-button>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const paginationTableRef = ref();
const tableData = ref([]);

// 调用表格方法
const clearSelection = () => {
  paginationTableRef.value.tableRef.clearSelection();
};
</script>
```

## 注意事项

1. 当设置了 `height` 属性时，表格会自动计算内容区域的高度，确保表头和分页固定。
2. 如果需要表格高度自适应容器，可以设置容器的高度，并将表格的 `height` 设置为 '100%'。
3. 当数据量较大时，建议设置合适的 `page-size` 值，以提高页面性能。
4. 组件内部会监听 `currentPage` 和 `pageSize` 的变化，但不会自动获取数据，需要在事件处理函数中手动获取。

## 示例

完整的使用示例可以参考 `demo.vue` 文件。
