<template>
  <div class="top-content">
    <div class="top-item"></div>
    <div class="top-item search">
      <SearchMember v-model="inputValue" size="default" :showSearchButton="false" @selected="handleSelect" />
    </div>
    <div class="top-item"></div>
    <div class="top-item bed">
      <div class="bed-info" v-show="orderStore.order.bedId">
        <div>
          <span>床位：</span>
          <span>{{ orderStore.order.bedName }}</span>
          <span>&nbsp;{{ getBedStatus }}</span>
        </div>
        <div @click="clearBed" class="hover-pointer">
          <el-icon :size="24"><Close /></el-icon>
        </div>
      </div>
    </div>
    <div class="top-item"></div>
    <div class="top-item">
      <el-dropdown placement="bottom" trigger="click" @command="selectBed">
        <el-button plain>选择床位订单</el-button>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item :command="bed" v-for="bed in bedList" :key="bed.id">
              <span>{{ bed.bedName }}</span>
              &nbsp;&nbsp;
              <span :style="{ color: bed.status === 0 ? 'green' : 'red' }">
                {{ bed.status === 0 ? '空闲' : '占用' }}
              </span>
            </el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
    <div class="top-item"></div>
  </div>
  <div class="main-content">
    <div class="main-item">
      <div class="left-tab">
        <el-radio-group v-model="tabSwitch">
          <el-radio-button :value="0" :border="true" size="large">添加产品、疗程</el-radio-button>
          <el-radio-button :value="1" :border="true" size="large">会员卡详情</el-radio-button>
        </el-radio-group>
      </div>
      <div class="left-tab-content">
        <el-tabs
          v-show="tabSwitch === 0"
          tab-position="left"
          type="border-card"
          style="height: 100%"
          class="scale-tabs"
        >
          <el-tab-pane label="产品">
            <ProductList />
          </el-tab-pane>
          <el-tab-pane label="项目">
            <ServiceItemList />
          </el-tab-pane>
          <el-tab-pane label="疗程">
            <TreatmentCouponList />
          </el-tab-pane>
        </el-tabs>
        <MemberInfo v-show="tabSwitch === 1" />
      </div>
    </div>
    <div class="main-item">
      <OrderList />
    </div>
  </div>
</template>

<script setup lang="ts">
import SearchMember from '@/components/Input/SearchMember.vue';
import ProductList from './components/ProductList.vue';
import ServiceItemList from './components/ServiceItemList.vue';
import TreatmentCouponList from './components/TreatmentCouponList.vue';
import MemberInfo from './components/MemberInfo.vue';
import OrderList from './components/OrderList.vue';
import MessageBox from '@/components/MessageBox';

import { ref, watch, computed, onMounted, onUnmounted, nextTick } from 'vue';
import { useRouter } from 'vue-router';
import { CustomerType, BedStatus, BedStatusMap } from '@/enums/index';
import { useSettingStore } from '@/store/modules/acl/setting';
import { useMemberStore } from '@/store/modules/member/member';
import { useRechargeStore } from '@/store/modules/member/recharge';
import { useRoomStore } from '@/store/modules/setGroup/room';
import { useOrderStore } from '@/store/modules/order/index';
import { useDataEnumStore } from '@/store/modules/enums/index';
const orderStore = useOrderStore();
const roomStore = useRoomStore();
const settingStore = useSettingStore();
const memberStore = useMemberStore();
const store = useRechargeStore();
const dataEnumStore = useDataEnumStore();
const router = useRouter();

const initByBedId = () => {
  // 从路由参数中获取床位ID
  const bedId = Number(router.currentRoute.value.query.bedId || 0);
  console.log(' 床位ID:', bedId);
  if (bedId) {
    orderStore.setOrderByBed(bedId);
  }
};

const getBedStatus = computed(() => {
  const bed = bedList.value.find((item: any) => item.id === orderStore.order.bedId);
  console.log('床位', bed);

  if (!bed) {
    return '';
  }
  return BedStatusMap[bed.status as BedStatus];
});

const bedList: any = ref([]);
const selectBed = (params: any) => {
  console.log('选择床位', params);
  MessageBox.warning('切换床位，将清除床位对应的所有明细，你确定切换床位吗？', '提示').then(() => {
    orderStore.reset();
    if (params.status === BedStatus.Occupied) {
      orderStore.setOrderByBed(params.id);
    } else if (params.status === BedStatus.Available) {
      orderStore.order.bedId = params.id;
      orderStore.order.bedName = params.bedName;
    }
  });
};

const clearBed = () => {
  MessageBox.warning('清空床位信息将清空订单信息，是否继续？', '提示').then(() => {
    orderStore.reset();
  });
};

onMounted(async () => {
  initByBedId();
  bedList.value = await roomStore.getAllBedList();
  await dataEnumStore.getStaffList();
  setTimeout(() => {
    orderStore.initServiceMap();
  }, 500);
});

// 搜索会员
const inputValue = ref('');

// 选中会员
const handleSelect = (item: Record<string, any>) => {
  orderStore.resetCheckedAssetInfo();
  console.log('会员', item);
  orderStore.order.vipId = item.id;
  orderStore.order.customerType = CustomerType.Member;
  orderStore.getMemberAsset(item.id);
  tabSwitch.value = 1;
};

// 获取会员资产
const getMemberAsset = async (id: number) => {
  const asset = await memberStore.getMemberAssetList(id);
  if (asset && asset?.vipAssetVOList) {
    asset.vipAssetVOList = asset.vipAssetVOList.map((item: any, index: number) => ({
      ...item,
      disabled: false,
      discountValue: `${item.id}-${item?.assetDiscountBase}-${item?.assetDiscountRate}`,
    }));
  }
  console.log('会员资产', asset);
  orderStore.member = { ...asset.vipInfoVO, ...asset };
};

const tabSwitch = ref(0);

onUnmounted(() => {
  orderStore.reset();
});
</script>

<style scoped lang="scss">
.top-content {
  height: 70px;
  display: grid;
  grid-template-columns: repeat(9, 1fr);
  grid-template-rows: 1fr;
  border-bottom: 1px solid var(--el-border-color);

  .top-item {
    // border: 1px red solid;
    // height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .top-item.search {
    grid-column: 2 / 4;
  }
  .top-item.bed {
    grid-column: 5 / 7;
    .bed-info {
      height: 45px;
      line-height: 45px;
      width: 100%;
      font-weight: 600;
      color: var(--el-text-color-secondary);
      background-color: $base-bg;
      border-radius: 5px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0 10px;

      > div:first-child {
        flex: 1;
        text-align: center;
      }
      > div:last-child {
        display: flex;
        align-items: center;
      }
    }
  }
}

.main-content {
  height: calc(100% - 70px);
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: 1fr;
  .main-item {
    height: 100%;
    padding: 10px;
    overflow: hidden;

    .left-tab {
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 10px;
    }
    .left-tab-content {
      height: calc(100% - 50px);
      .scale-tabs {
        height: 100%;
        > :deep(.el-tabs__content) {
          height: 100%;
          > div {
            height: 100%;
          }
        }
      }
    }
  }

  .main-item:last-child {
    padding: 0;
    border-left: 1px solid var(--el-border-color);
  }
}

:deep(.el-input-group__append .el-button--primary) {
  @include primary-button;
}
</style>
