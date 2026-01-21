<template>
  <ChildNav :navList="navList" />
</template>

<script setup lang="ts">
import ChildNav from '@/components/ChildNav/index.vue';
import InStock from './inStock/index.vue';
import OutStock from './outStock/index.vue';
import StockLog from './stockLog/index.vue';
import useUserStore from '@/store/modules/acl/user';

import { ref, markRaw } from 'vue';

const originalNavList = ref([
  { label: '入库', icon: '', component: markRaw(InStock) },
  { label: '出库', icon: '', component: markRaw(OutStock) },
  { label: '库存流水', icon: '', component: markRaw(StockLog) },
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
