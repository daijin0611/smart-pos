<template>
  <ChildNav :navList="navList" />
</template>

<script setup lang="ts">
import ChildNav from '@/components/ChildNav/index.vue';
import CouponManager from './couponManager/index.vue';
import CouponCount from './couponCount/index.vue';
import CouponOverview from './couponOverview/index.vue';
import useUserStore from '@/store/modules/acl/user';

import { ref, markRaw } from 'vue';

const originalNavList = ref([
  { label: '优惠券管理', icon: '', component: markRaw(CouponManager) },
  { label: '优惠券统计', icon: '', component: markRaw(CouponCount) },
  { label: '优惠券汇总', icon: '', component: markRaw(CouponOverview) },
]);

const navList: any = ref([]);

const userStore = useUserStore();
for (const item of originalNavList.value) {
  if (userStore.tabs.includes(item.label)) {
    navList.value.push(item);
  }
}
</script>

<style scoped lang="scss"></style>
