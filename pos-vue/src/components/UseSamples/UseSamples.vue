<template>
  <div class="test-container">
    <h2>通用组件使用示例</h2>

    <!-- 卡片组件 -->
    <section class="component-section">
      <h3>卡片组件</h3>
      <div class="card-examples">
        <Card shadow="always" bgColor="#ffffff" class="card-example">
          <template #header>
            <div class="card-header">总是显示阴影的卡片</div>
          </template>
          <div>这是一个背景为白色，总是显示阴影的卡片</div>
          <template #footer>
            <div class="card-footer">卡片底部</div>
          </template>
        </Card>

        <Card shadow="hover" bgColor="#f0f9eb" class="card-example">
          <template #header>
            <div class="card-header">鼠标悬停显示阴影的卡片</div>
          </template>
          <div>这是一个背景为浅绿色，鼠标悬停时显示阴影的卡片</div>
        </Card>

        <Card shadow="never" bgColor="#fef0f0" class="card-example">
          <div>这是一个背景为浅红色，从不显示阴影的卡片（无header和footer）</div>
        </Card>

        <Card shadow="always" bgColor="#ecf5ff" shadowColor="0 4px 12px 0 rgba(64, 158, 255, 0.4)" class="card-example">
          <template #header>
            <div class="card-header">自定义阴影颜色的卡片</div>
          </template>
          <div>这是一个背景为浅蓝色，使用自定义蓝色阴影的卡片</div>
          <template #footer>
            <div class="card-footer">自定义阴影效果</div>
          </template>
        </Card>

        <Card shadow="hover" bgColor="#fdf6ec" shadowColor="0 4px 12px 0 rgba(230, 162, 60, 0.4)" class="card-example">
          <template #header>
            <div class="card-header">悬停时显示自定义阴影</div>
          </template>
          <div>这是一个背景为浅橙色，悬停时显示自定义橙色阴影的卡片</div>
        </Card>
      </div>
    </section>

    <!-- 时间选择器 -->
    <section class="component-section">
      <h3>时间选择器</h3>
      <DatePicker @selectDate="selectDate" :title="title" :size="size" />
    </section>

    <!-- 抽屉组件 -->
    <section class="component-section">
      <h3>抽屉组件</h3>
      <el-button type="primary" @click="drawerVisible = true">打开抽屉</el-button>
      <Drawer v-model="drawerVisible" title="这是一个抽屉" @close="handleDrawerClose">
        <div style="padding: 20px">抽屉内容</div>
        <template #footer>
          <div style="text-align: right">
            <el-button @click="drawerVisible = false">取消</el-button>
            <el-button type="primary" @click="drawerVisible = false">确定</el-button>
          </div>
        </template>
      </Drawer>
    </section>

    <!-- 对话框组件 -->
    <section class="component-section">
      <h3>对话框组件</h3>
      <el-button type="primary" @click="dialogVisible = true">打开对话框</el-button>
      <Dialog v-model="dialogVisible" title="这是一个对话框" width="30%" @close="handleDialogClose">
        <div style="padding: 20px">对话框内容</div>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取消</el-button>
            <el-button type="primary" @click="dialogVisible = false">确定</el-button>
          </span>
        </template>
      </Dialog>
    </section>

    <!-- 消息和通知组件 -->
    <section class="component-section">
      <h3>消息和通知组件</h3>
      <div class="button-group">
        <el-button @click="showMessage('success')">成功消息</el-button>
        <el-button @click="showMessage('warning')">警告消息</el-button>
        <el-button @click="showMessage('info')">信息消息</el-button>
        <el-button @click="showMessage('error')">错误消息</el-button>
      </div>
      <div class="button-group">
        <el-button @click="showNotification('success')">成功通知</el-button>
        <el-button @click="showNotification('warning')">警告通知</el-button>
        <el-button @click="showNotification('info')">信息通知</el-button>
        <el-button @click="showNotification('error')">错误通知</el-button>
      </div>
    </section>

    <!-- 表格组件 -->
    <section class="component-section">
      <h3>表格组件</h3>
      <Table
        :data="tableData"
        :border="true"
        :stripe="true"
        :pagination="true"
        :total="100"
        @page-change="handlePageChange"
        @size-change="handleSizeChange"
      >
        <el-table-column prop="date" label="日期" width="180" />
        <el-table-column prop="name" label="姓名" width="180" />
        <el-table-column prop="address" label="地址" />
        <el-table-column label="操作">
          <template #default="scope">
            <el-button size="small" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="small" type="danger" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </Table>
    </section>

    <!-- 分页组件 -->
    <section class="component-section">
      <h3>分页组件</h3>
      <Pagination
        v-model:currentPage="currentPage"
        v-model:pageSize="pageSize"
        :total="100"
        @current-change="handlePaginationChange"
      />
    </section>

    <!-- 表单组件 -->
    <section class="component-section">
      <h3>表单组件</h3>
      <Form :model="formData" :rules="formRules" @submit="handleFormSubmit" @reset="handleFormReset">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="formData.username" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="formData.password" type="password" placeholder="请输入密码"></el-input>
        </el-form-item>
      </Form>
    </section>

    <!-- 文本溢出省略组件 -->
    <section class="component-section">
      <h3>文本溢出省略组件</h3>

      <div class="ellipsis-examples">
        <div class="example-group">
          <h4>基础用法 - 自动检测溢出</h4>
          <div class="ellipsis-container">
            <div class="ellipsis-box">
              <p class="label">未溢出的文本:</p>
              <EllipsisText content="这是一个不会溢出的短文本" />
            </div>
            <div class="ellipsis-box">
              <p class="label">会溢出的长文本:</p>
              <EllipsisText
                content="这是一个非常长的文本内容，当容器宽度不够时会自动显示省略号，并且鼠标悬停时会通过tooltip显示完整内容"
              />
            </div>
          </div>
        </div>

        <div class="example-group">
          <h4>不同宽度的容器</h4>
          <div class="ellipsis-container">
            <div class="ellipsis-box narrow">
              <p class="label">窄容器:</p>
              <EllipsisText content="这是一个在窄容器中的文本内容" />
            </div>
            <div class="ellipsis-box medium">
              <p class="label">中等宽度容器:</p>
              <EllipsisText content="这是一个在中等宽度容器中的文本内容" />
            </div>
            <div class="ellipsis-box wide">
              <p class="label">宽容器:</p>
              <EllipsisText content="这是一个在宽容器中的文本内容" />
            </div>
          </div>
        </div>

        <div class="example-group">
          <h4>不同的提示位置</h4>
          <div class="ellipsis-container">
            <div class="ellipsis-box narrow">
              <p class="label">顶部提示:</p>
              <EllipsisText content="这是一个提示显示在顶部的文本" placement="top" />
            </div>
            <div class="ellipsis-box narrow">
              <p class="label">底部提示:</p>
              <EllipsisText content="这是一个提示显示在底部的文本" placement="bottom" />
            </div>
            <div class="ellipsis-box narrow">
              <p class="label">左侧提示:</p>
              <EllipsisText content="这是一个提示显示在左侧的文本" placement="left" />
            </div>
            <div class="ellipsis-box narrow">
              <p class="label">右侧提示:</p>
              <EllipsisText content="这是一个提示显示在右侧的文本" placement="right" />
            </div>
          </div>
        </div>

        <div class="example-group">
          <h4>强制使用省略号</h4>
          <div class="ellipsis-container">
            <div class="ellipsis-box">
              <p class="label">即使未溢出也显示提示:</p>
              <EllipsisText
                content="这是一个不会自然溢出的短文本，但通过forceEllipsis属性强制使用tooltip"
                force-ellipsis
              />
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import Card from '@/components/Card/index.vue';

// 引入 Message 和 Notification
import { inject } from 'vue';
const $message: any = inject('$message');
const $notification: any = inject('$notification');

// DatePicker 相关
const title = ref('选择日期');
const size = ref<'default' | 'large' | 'small'>('large');
const selectDate = (start: string, end: string) => {
  console.log('选择的日期范围:', start, end);
};

// Drawer 相关
const drawerVisible = ref(false);
const handleDrawerClose = () => {
  console.log('抽屉关闭事件触发');
};

// Dialog 相关
const dialogVisible = ref(false);
const handleDialogClose = () => {
  console.log('对话框关闭事件触发');
};

// #region Message 和 Notification 相关
const showMessage = (type: 'success' | 'warning' | 'info' | 'error') => {
  switch (type) {
    case 'success':
      $message.success('这是一条成功消息');
      break;
    case 'warning':
      $message.warning('这是一条警告消息');
      break;
    case 'info':
      $message.info('这是一条信息消息');
      break;
    case 'error':
      $message.error('这是一条错误消息');
      break;
  }
};

const showNotification = (type: 'success' | 'warning' | 'info' | 'error') => {
  switch (type) {
    case 'success':
      $notification.success('操作成功', '成功');
      break;
    case 'warning':
      $notification.warning('请注意', '警告');
      break;
    case 'info':
      $notification.info('请查看', '信息');
      break;
    case 'error':
      $notification.error('操作失败', '错误');
      break;
  }
};

// #endregion

// #region Table 相关
const tableData = ref([
  {
    date: '2023-05-01',
    name: '张三',
    address: '北京市朝阳区',
  },
  {
    date: '2023-05-02',
    name: '李四',
    address: '上海市浦东新区',
  },
  {
    date: '2023-05-03',
    name: '王五',
    address: '广州市天河区',
  },
]);

const handleEdit = (row: any) => {
  console.log('编辑行:', row);
};

const handleDelete = (row: any) => {
  console.log('删除行:', row);
};

const handlePageChange = (page: number) => {
  console.log('页码变化:', page);
};

const handleSizeChange = (size: number) => {
  console.log('每页条数变化:', size);
};

// Pagination 相关
const currentPage = ref(1);
const pageSize = ref(10);
const handlePaginationChange = (page: number) => {
  console.log('分页组件页码变化:', page);
};

// #endregion

// #region Form 相关
const formData = ref({
  username: '',
  password: '',
});

const formRules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' },
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur' },
  ],
};

const handleFormSubmit = (model: any) => {
  console.log('表单提交:', model);
};

const handleFormReset = () => {
  console.log('表单重置');
};

// #endregion
</script>

<style scoped>
.test-container {
  padding: 20px;
  overflow: scroll;
}

.component-section {
  margin-bottom: 30px;
  padding: 20px;
  border: 1px solid #ebeef5;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.button-group {
  margin-bottom: 10px;
}

.button-group .el-button {
  margin-right: 10px;
}

.card-examples {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.card-example {
  width: 300px;
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.card-footer {
  text-align: right;
  color: #909399;
  font-size: 13px;
}

/* 文本溢出省略组件示例样式 */
.ellipsis-examples {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.example-group {
  margin-bottom: 15px;
}

.example-group h4 {
  margin-bottom: 10px;
  font-size: 16px;
  font-weight: 500;
  color: #303133;
}

.ellipsis-container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.ellipsis-box {
  border: 1px solid #ebeef5;
  border-radius: 4px;
  padding: 15px;
  min-width: 250px;
  flex: 1;
  background-color: #fafafa;
}

.ellipsis-box.narrow {
  max-width: 150px;
}

.ellipsis-box.medium {
  max-width: 250px;
}

.ellipsis-box.wide {
  max-width: 400px;
}

.ellipsis-box .label {
  margin: 0 0 8px 0;
  font-size: 13px;
  color: #909399;
}
</style>
