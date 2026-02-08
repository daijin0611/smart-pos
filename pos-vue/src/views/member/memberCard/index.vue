<template>
  <ChildNav :navList="navList" />
</template>

<script setup lang="ts">
import ChildNav from '@/components/ChildNav/index.vue';
import MemberList from './memberList/index.vue';
import MemberCount from './memberCount/index.vue';
import ActiveAnalysis from './activeAnalysis/index.vue';
import AssetTransfer from './assetTransfer/index.vue';
import useUserStore from '@/store/modules/acl/user';

import { ref, markRaw } from 'vue';

const originalNavList: any = ref([
  { label: '会员列表', icon: '', component: markRaw(MemberList) },
  { label: '会员统计', icon: '', component: markRaw(MemberCount) },
  { label: '会员活跃分析', icon: '', component: markRaw(ActiveAnalysis) },
  { label: '资产转移', icon: '', component: markRaw(AssetTransfer) },
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
