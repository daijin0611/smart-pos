<template>
  <div class="bed-status-container">
    <h1>床位状态</h1>
    <div v-loading="settingStore.loading" :element-loading-text="settingStore.loadingMsg" class="bed-status-content">
      <div v-for="item in bedList" :key="item.id" class="bed-card-box">
        <div class="bed-card">
          <!-- 卡片头部 -->
          <div class="card-header">
            <div class="card-header-left">
              <span>{{ item.bedName }}</span>
            </div>
            <div v-if="item.status === 1" class="card-header-right">
              <!-- <ModifyBed :bill="{}" /> -->
            </div>
          </div>

          <!-- 空闲状态 -->
          <div v-if="item.status === 0" class="card-bottom bed-status-free">
            <div class="card-info">
              <div class="card-info-left">
                <span>空闲中...</span>
              </div>
            </div>
            <div class="card-option">
              <el-button @click="showDialog(item)" type="primary" plain size="small">开单</el-button>
            </div>
          </div>

          <!-- 服务状态 -->
          <el-tooltip v-if="item.status === 1" placement="bottom" effect="light">
            <template #content>
              <!-- <BillSummary /> -->
            </template>
            <div class="card-bottom bed-status-svr">
              <div class="card-info">
                <div class="card-info-left">
                  <span>即将上钟：</span>
                </div>
                <div class="card-progress">
                  <el-progress type="circle" :percentage="percentage2" :color="colors" :striped-flow="true" :width="71">
                    <template #default>
                      <span style="color: #fff">140分钟</span>
                    </template>
                  </el-progress>
                </div>
              </div>
              <div class="card-option">
                <el-button @click="showDialog(item)" type="primary" plain size="small">账单</el-button>
                <el-button @click="checkout(item)" type="primary" plain size="small">去结账</el-button>
              </div>
            </div>
          </el-tooltip>
        </div>
      </div>
    </div>

    <Drawer v-model="dialog.visible" :title="dialog.title" @closed="closeDrawer" size="550px" style="max-width: 600px">
      <CreateOrder
        :type="dialog.type"
        @close="dialog.visible = false"
        @refresh="getBedList"
        @checkout="checkout"
      ></CreateOrder>
    </Drawer>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { BedStatus, BedStatusMap } from '@/enums/index';

import BillSummary from './OrderSummary.vue';
import ModifyBed from './ModifyBed.vue';
import CreateOrder from './CreateOrder.vue';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useDataEnumStore } from '@/store/modules/enums/index';
import { useOrderStore } from '@/store/modules/order/index';
const settingStore = useSettingStore();
const dataEnumStore = useDataEnumStore();
const orderStore = useOrderStore();

const router = useRouter();

onMounted(async () => {
  getBedList();
});

const bedList: any = ref([]);
const getBedList = async () => {
  settingStore.loading = true;
  bedList.value = await dataEnumStore.getAllBedList();
  settingStore.loading = false;
};

/**
 * 去结账
 * @param data 账单数据
 */
const checkout = (data: any) => {
  router.push({
    path: '/saleMain',
    query: {
      bedId: data.id,
    },
  });
};

const createOrder = (item: any) => {
  orderStore.orderForm.bedId = item.id;
  orderStore.orderForm.bedName = item.bedName;
};
const previewOrder = async (item: any) => {
  const order = await orderStore.getOrder(item.id);
  console.log('预览订单:', order);
  if (order) {
    orderStore.orderForm = order;
  }
};

// 模态框
const dialog: any = reactive({
  title: '开单',
  type: 'add',
  visible: false,
});

const showDialog = (item: any) => {
  orderStore.initServiceMap();

  if (item.status === BedStatus.Available) {
    dialog.title = '开单';
    dialog.type = 'add';
    createOrder(item);
  } else if (item.status === BedStatus.Occupied) {
    dialog.title = '账单';
    dialog.type = 'view';
    previewOrder(item);
  }
  dialog.visible = true;
};

const closeDrawer = () => {
  orderStore.reset();
};

/**
 * 计算时间差
 * @param createTime 开始时间
 * @returns 时间差（分钟）
 */
const calcTime = (createTime: Date) => {
  const now = new Date();
  const diff = now.getTime() - createTime.getTime();
  const diffMinutes = diff / (1000 * 60);
  return diffMinutes;
};

/**
 * 根据当前服务时间计算百分比
 * @param total 总时间
 * @param current 当前时间
 */
const calcPercentage = (total: number, current: number) => {
  return (current / total) * 100;
};

const percentage2 = ref(calcPercentage(140, 0));

const colors = [
  { color: '#e74c3c', percentage: 100 },
  { color: '#E6A23C', percentage: 80 },
  { color: '#9b59b6', percentage: 60 },
  { color: '#409EFF', percentage: 40 },
  { color: '#67C23A', percentage: 20 },
];
</script>

<style scoped lang="scss">
.bed-status-container {
  display: flex;
  flex-direction: column;

  > h1 {
    color: #fff;
    font-size: 18px;
    text-align: center;
    font-weight: bold;
    height: $base-tabbar-height;
    line-height: $base-tabbar-height;
    background-color: var(--el-color-primary-light-5);
    margin-bottom: $main-padding;
  }

  .bed-status-content {
    max-height: calc(100vh - $base-tabbar-height * 2 - $main-padding * 4);
    overflow: auto;
    padding: 0 $main-padding;
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-start;

    .bed-card-box {
      color: #fff;
      width: 230px;
      height: 150px;
      margin: 10px 10px 30px 10px;
      border-radius: 5px;
      overflow: hidden;
      transition: all 0.3s;

      &:hover {
        box-shadow: 0 0 10px #68afff;
        transform: translateY(-1px);
      }

      .card-header {
        height: 30px;
        line-height: 30px;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        padding: 0 10px;
        background-image: linear-gradient(to right top, #68afff, #b3d6ff);
      }

      .card-bottom {
        font-size: 14px;
        height: 120px;
        padding: 10px;
        line-height: 20px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;

        .card-info {
          flex: 1;
          display: flex;
          .card-info-left {
            flex: 1;
            display: flex;
            flex-direction: column;
          }
        }
        .card-option {
          height: 24px;
        }
      }
    }
  }
}

.bed-status-free {
  background-image: linear-gradient(to right top, #68afff, #b3d6ff);
}

.bed-status-waitclear {
  background-image: linear-gradient(to right top, #ffa551, #ffcb9b);
}

.bed-status-clearing {
  background-image: linear-gradient(to right top, #c5e0d1, #c5e0d1);
}

.bed-status-disable {
  background-image: linear-gradient(to right top, #383a3a, #a3a5a4);
}

.bed-status-svr {
  background-image: linear-gradient(to right top, #ca2321 30%, #50730d);
}

.bed-status-svr {
  background-image: linear-gradient(to right top, #68afff, #e280f3);
}
</style>
