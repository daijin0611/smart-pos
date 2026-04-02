<template>
  <div class="main-container">
    <!-- 搜索操作 -->
    <Card flex="row" :gap="20">
      <div><BtnForm @submit="addRoom" btnText="添加房间" tipText="请输入房间名称" /></div>
      <div>
        <el-input
          v-model="store.searchParams.roomName"
          :prefix-icon="Search"
          @keydown.enter="search"
          @clear="search"
          placeholder="搜索房间名称"
          clearable
          class="search-input"
        >
          <template #append>
            <el-button type="primary" @click="search">搜索</el-button>
          </template>
        </el-input>
      </div>
    </Card>

    <!-- 房间列表 -->
    <Card
      v-loading="settingStore.loading && !drawerVisible"
      :element-loading-text="settingStore.loadingMsg"
      flex="row"
      :gap="30"
      class="room-list"
    >
      <Card v-for="room in store.roomList" wrap="nowrap" bgColor="#5cb3cc" class="room-card">
        <div class="card-top">
          <span class="name">{{ room.roomName }}</span>
          <el-button @click="editRoomInfo(room)" link size="small" style="color: #dff9fb">编辑</el-button>
        </div>
        <div class="card-bottom">
          <span>总床位：{{ room.bedCount }}</span>
          <span>空闲数：{{ room.freeBedCount }}</span>
        </div>
      </Card>
    </Card>
  </div>

  <!-- 抽屉 -->
  <keep-alive>
    <Drawer v-model="drawerVisible" title="房间信息">
      <div class="bed-list">
        <!-- 房间信息 -->
        <Card>
          <div class="room-name-area">
            <span>房间名：</span>
            <DynamicInput :value="editRoom.roomName" @update="updateRoomName" />
          </div>
          <div>床位数：{{ editRoom.bedCount }}</div>
          <div>空闲中：{{ editRoom.freeBedCount }}</div>
        </Card>

        <!-- 床位列表 -->
        <Card padding="10px">
          <div class="bed-list-header">
            <span>床位信息</span>
            <BtnForm @submit="addBed" btnText="添加床位" tipText="请输入床位名称" />
          </div>

          <!-- 床位列表 -->
          <Table
            :data="store.bedList"
            v-loading="settingStore.loading"
            :element-loading-text="settingStore.loadingMsg"
            :border="true"
            :row-class-name="getRowClassName"
          >
            <el-table-column prop="bedName" label="床位名" width="230">
              <template #default="{ row }">
                <DynamicInput :value="row.bedName" :params="row" @update="updateBedName" :width="120" :key="row.id" />
              </template>
            </el-table-column>
            <el-table-column prop="status" label="状态" :formatter="bedStatusMap" min-width="50" />
            <el-table-column label="操作" width="60">
              <template #default="{ row }">
                <template v-if="row.status !== 2">
                  <el-button @click="disabledBed(row)" :disabled="row.status === 1" link type="warning">停用</el-button>
                </template>
                <template v-else>
                  <el-button @click="enabledBed(row)" link type="primary">恢复</el-button>
                </template>
              </template>
            </el-table-column>
          </Table>
        </Card>
      </div>
    </Drawer>
  </keep-alive>
</template>

<script setup lang="ts">
import { Search } from '@element-plus/icons-vue';
import { ref, onMounted, inject } from 'vue';
import { bedStatusMap } from '@/utils/formatter';

// 导入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useRoomStore } from '@/store/modules/setGroup/room';
const settingStore = useSettingStore();
const store = useRoomStore();

const $MessageBox: any = inject('$MessageBox');

// 初始化
onMounted(() => {
  store.setRoomList();
});

// 搜索
const search = async () => {
  await store.setRoomList();
  if (store.searchParams.roomName) {
    store.roomList = store.roomList.filter((item: any) => {
      return item.roomName.toLocaleLowerCase().includes(store.searchParams.roomName.toLocaleLowerCase());
    });
  }
};

// 添加房间
const addRoom = (value: object) => {
  store.updateRoom({ roomName: value });
};

// 修改房间名
const updateRoomName = (value: string) => {
  store.updateRoom({ id: editRoom.value.id, roomName: value });
};

// 当前编辑的房间信息
const editRoom: any = ref({});
// 点击编辑获取当前房间的床位数据列表
const editRoomInfo = (room: { id: number }) => {
  editRoom.value = { ...room };
  store.setBedList(room.id);
  drawerVisible.value = true;
};

// 添加床位
const addBed = (value: string) => {
  store.updateBed({ roomId: editRoom.value.id, bedName: value });
};

// 修改床位名称
const updateBedName = (value: string, params: any) => {
  store.updateBed({ ...params, roomId: params.id, bedName: value });
};

// 停用
const disabledBed = async (row: any) => {
  const result = await $MessageBox.confirm({
    title: '确认操作',
    message: `你确定要禁用床位【${row.bedName}】吗？`,
    type: 'warning',
  });
  result && store.updateBedStatus(row);
};

// 启用
const enabledBed = (row: any) => {
  store.updateBedStatus(row);
};

// 控制抽屉
const drawerVisible = ref(false);
// 禁用行
const getRowClassName = ({ row }: { row: { status: number } }) => {
  return row.status === 2 ? 'disabled-row' : '';
};
</script>

<style scoped lang="scss">
.main-container {
  padding: $main-padding;

  // 房间
  .room-list {
    > div > div {
      width: 180px;
    }

    > div > div:hover {
      transform: translateY(-3px);
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
    }

    .room-card {
      color: white;

      .card-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 35px;
      }

      .card-bottom {
        display: flex;
        justify-content: space-between;
        font-size: 12px;
        line-height: 30px;
      }
    }
  }
}

// 床位
.bed-list {
  display: flex;
  flex-direction: column;
  gap: $main-padding;

  .room-name-area {
    display: flex;
    align-items: center;
    height: $main-padding * 2;
    line-height: $main-padding * 2;
    > div {
      flex: 1;
    }
  }

  .bed-list-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: $main-padding - 5px;
  }
}

:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
