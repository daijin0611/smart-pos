<template>
  <el-tooltip :visible="visible" placement="bottom" effect="light" trigger="click">
    <template #content>
      <div class="modify-bed-container">
        <h1>切换或合并床位</h1>
        <el-form @submit.prevent="submitForm" ref="form">
          <el-form-item>
            <el-autocomplete
              v-model="value"
              :fetch-suggestions="querySearch"
              placeholder="请输入床位名称"
              @select="handleSelect"
              clearable
            >
              <template #default="{ item }">
                <div class="option" :style="{ cursor: item.status === 1 ? 'not-allowed' : 'pointer' }">
                  <span>{{ item.bedName }}</span>
                  <template v-if="item.status === 0">
                    <el-tag type="success" size="small">空闲</el-tag>
                  </template>
                  <template v-if="item.status === 1">
                    <el-tag type="danger" size="small">服务中</el-tag>
                  </template>
                </div>
              </template>
            </el-autocomplete>
          </el-form-item>
          <div class="submit-area">
            <el-button type="primary" size="small" link @click="visible = false">取消</el-button>
            <el-button type="primary" size="small" native-type="submit">确认</el-button>
          </div>
        </el-form>
      </div>
    </template>
    <el-button @click="visible = true" type="primary" link size="small" style="color: #db4aff; font-weight: 600">
      换/合并床位
    </el-button>
  </el-tooltip>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';

// 引入数据仓库
import { useRoomStore } from '@/store/modules/setGroup/room';
const roomStore = useRoomStore();

const props = defineProps<{
  order?: object;
}>();

const visible = ref(false);
const value = ref('');
const selected = ref({});
const bedList = ref([]);

onMounted(async () => {
  await roomStore.setAllBedList();
  bedList.value = roomStore.allBedList.map((item: any) => ({ ...item, value: item.bedName }));
});

const submitForm = (e: any) => {
  console.log('selected = ', selected.value);
  console.log('order = ', props.order);

  // $emit('submit', value.value);
  // visible.value = false;
};

/**
 * 选择框选择方法 - 将选择的内容添加到已选择数组
 * @param item 选择的内容
 */
const handleSelect = (item: any) => {
  selected.value = item;
};

/**
 * 选择框搜索方法 - 过滤数据列表
 * @param queryString 搜索字符串
 * @param cb 回调函数
 */
const querySearch = (queryString: string, cb: Function) => {
  const results = queryString ? bedList.value.filter(createFilter(queryString)) : bedList.value;
  // 返回过滤过的数据
  cb(results);
};

/**
 * 搜索方法 - 过滤数据列表
 * @param queryString 搜索字符串
 */
const createFilter = (queryString: string) => {
  return (item: any) => {
    return item.bedName.toLowerCase().includes(queryString.toLowerCase());
  };
};
</script>
<style scoped lang="scss">
.modify-bed-container {
  display: flex;
  flex-direction: column;
  padding: 5px;
  gap: 15px;
  width: 180px;

  h1 {
    color: var(--el-text-color-regular);
    font-size: 14px;
  }

  .submit-area {
    display: flex;
    justify-content: center;
  }
}

.option {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
