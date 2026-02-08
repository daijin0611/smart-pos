<template>
  <ChildNav :navList="navList" />
</template>

<script setup lang="ts">
import { ref, markRaw } from 'vue';
import { useRoute } from 'vue-router';
import { useRechargeStore } from '@/store/modules/member/recharge';
import { useMemberStore } from '@/store/modules/member/member';

import ChildNav from '@/components/ChildNav/index.vue';
import Recharge from './recharge/index.vue';
import RechargeRecord from './rechargeRecord/index.vue';
import RechargeActivity from './rechargeActivity/index.vue';
import useUserStore from '@/store/modules/acl/user';

const route = useRoute();
const rechargeStore = useRechargeStore();
const memberStore = useMemberStore();
const vipId = route.query.vipId;

if (vipId) {
  localStorage.setItem('activeTab', '会员充值');
  memberStore.getMemberInfo(parseInt(vipId as string)).then((res) => {
    if (res) {
      rechargeStore.member = res;
    }
  });
}

const originalNavList = ref([
  { label: '会员充值', icon: '', component: markRaw(Recharge) },
  { label: '充值记录', icon: '', component: markRaw(RechargeRecord) },
  { label: '充值活动', icon: '', component: markRaw(RechargeActivity) },
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
