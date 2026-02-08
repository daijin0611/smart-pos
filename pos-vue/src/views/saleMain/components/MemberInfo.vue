<template>
  <!-- <div v-if="store.order.vipId" class="member-info"> -->
  <div class="member-info">
    <div class="member-card-container">
      <template v-if="store.order.customerType === CustomerType.Member">
        <MemberCard :member="store.member.vipInfoVO || {}" :show-reset-btn="false" :show-remark="true" />
      </template>
      <template v-if="store.order.customerType === CustomerType.Guest">
        <el-descriptions :column="1">
          <el-descriptions-item label="顾客姓名:">
            <el-input v-model="store.order.customerName" placeholder="请输入散客姓名" clearable />
          </el-descriptions-item>
          <el-descriptions-item label="应付总额:">
            <span class="price-text">{{ store.truePayAmount }} 元</span>
          </el-descriptions-item>
        </el-descriptions>
      </template>
    </div>
    <div v-if="store.order.customerType === CustomerType.Member" class="tag-container"></div>
    <!-- 资产信息 -->
    <el-scrollbar v-if="store.order.customerType === CustomerType.Member" class="property-container">
      <el-checkbox-group v-model="checkedList" @change="handleChange">
        <PropertyCard
          v-for="(item, index) in assetList"
          :key="item.id"
          :data="item"
          :index="index + 1"
          :amount="store.payAmount"
        />
      </el-checkbox-group>
    </el-scrollbar>
  </div>
  <!-- <div v-else class="member-info">
    <el-empty description="未选择会员" />
  </div> -->
</template>

<script setup lang="ts">
import MemberCard from '@/components/Card/MemberCard.vue';
import PropertyCard from './PropertyCard.vue';

import { ref, watch, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { CustomerType, DiscountType, discountTypeMap } from '@/enums/index';

import { useOrderStore } from '@/store/modules/order/index';
import { useMemberStore } from '@/store/modules/member/member';
import { useDataEnumStore } from '@/store/modules/enums';
const enumsStore = useDataEnumStore();
const memberStore = useMemberStore();
const store = useOrderStore();
const router = useRouter();

onMounted(() => {
  enumsStore.getOrgList();
});

const assetList: any = computed(() => store.member.vipAssetVOList || []);

const checkedList = ref<any>([]);

// 更新 store 资产列表
watch(
  () => checkedList.value,
  (newVal) => {
    const assetIds = newVal.map((e: string) => parseInt(e.split('-')[0]));
    store.checkedAssetInfo.assetIds = assetIds;
    // console.log('checkedList = ', newVal);
    // console.log('assetIds = ', assetIds);

    let assetTitle = '';
    let assetAmount = 0;
    for (const id of assetIds) {
      const asset = assetList.value.find((e: any) => e.id === id);
      if (asset) {
        assetTitle = getDiscountLabel(asset);
        assetAmount += asset.assetBalance;
      }
    }
    store.checkedAssetInfo.assetTitle = assetTitle;
    store.checkedAssetInfo.assetAmount = assetAmount;
  },
);

// 选择会员卡时触发
const handleChange = (val: any) => {
  // 没有选择会员卡时，将所有会员卡状态重置
  if (val.length === 0) {
    assetList.value.forEach((item: any) => {
      item.disabled = false;
    });
    return;
  } else {
    // 更新明细价格
    // const assetId = val[0].split('-')[0];
    // const asset = store.member.vipAssetVOList.find((item: any) => item.id == assetId);
    // console.log('当前选择资产：', asset);
    // updateOrderItemPrice(asset);
    store.updateOrderDetailPrice();
  }

  // 当值变化时，禁用值不同的复选款
  assetList.value.forEach((item: any) => {
    item.disabled = getDiscountValue(item.discountValue) !== getDiscountValue(val[0]);
    if (item.disabled) {
      // item.assetDiscountRate = 0;
    }
  });
};

// 获取折扣值
const getDiscountValue = (params: string) => {
  return params.substring(params.indexOf('-') + 1);
};

// const products = computed(async () => await enumsStore.getProductList());
// const serviceItems = computed(async () => await enumsStore.getServiceItemList());
// const treatmentCoupons = computed(async () => await enumsStore.getTreatmentCouponList());

/** 选择会员卡时更新明细价格 */
const updateOrderItemPrice = (asset: { assetDiscountBase: number; assetDiscountRate: number }) => {
  if (asset.assetDiscountRate === 100) {
    return;
  }
  const details = store.order.details;
  if (details && details.length > 0) {
    console.log('订单详情：', details);
    // console.log('products = ', products);
    // console.log('serviceItems = ', serviceItems);
    // console.log('treatmentCoupons = ', treatmentCoupons);

    for (const item of details) {
    }
  }
  console.log(store.order);
};

/**
 * 获取折扣相关标签（整合折扣类型、折扣力度、是否赠送等逻辑）
 */
const getDiscountLabel = (data: any): string => {
  // 处理数据为空的情况
  if (!data) return '标准价';

  // 提取基础折扣类型的显示文本（默认标准价）
  const baseLabel = discountTypeMap[data.assetDiscountBase as DiscountType] || '标准价';

  // 处理折扣率（需存在且有效才显示折扣信息）
  const { assetDiscountRate } = data;
  if (assetDiscountRate !== undefined && assetDiscountRate < 100 && assetDiscountRate > 0) {
    return `${baseLabel}(${assetDiscountRate / 10}折)`;
  }

  // 无有效折扣率时直接返回基础标签
  return baseLabel;
};
</script>

<style scoped lang="scss">
.member-info {
  height: calc(100% - 30px);
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 15px;
  width: 320px;
  margin: 30px auto 0 auto;
  overflow: auto;
  // border: 1px solid var(--el-border-color);

  .member-card-container {
    width: 100%;
  }
  .tag-container {
    height: 40px;
    width: 100%;
    // border: 1px solid var(--el-border-color);
  }
  .property-container {
    width: 100%;
    height: calc(100% - 250px);
  }
}
</style>
