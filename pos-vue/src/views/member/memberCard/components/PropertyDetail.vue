<template>
  <div class="coupon-list-container">
    <div>
      <PaginationTable
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="coupons"
        :showPagination="false"
      >
        <el-table-column prop="finNo" label="资产编号" min-width="100" />
        <el-table-column prop="totalBalance" label="余额" min-width="80" />
        <el-table-column prop="fromType" label="资产类型" min-width="80">
          <template #default="{ row }">
            <el-tag effect="light">充值</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="discountBaseType" label="折扣基础" min-width="80" />
        <el-table-column prop="discountRate" label="折扣率" min-width="80">
          <template #default="{ row }">{{ row.discountRate / 10 }}折</template>
        </el-table-column>
        <el-table-column prop="allowCrossStore" label="跨店消费" min-width="80" />
      </PaginationTable>
    </div>
    <div>
      <el-button type="default" plain @click="closeDialog">关闭</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watchEffect } from 'vue';

// 导入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useMemberStore } from '@/store/modules/member/member';
const settingStore = useSettingStore();
const store = useMemberStore();

const props = defineProps({
  memberId: {
    type: Number,
    default: 0,
  },
});

const emit = defineEmits(['close-dialog']);

const closeDialog = () => {
  emit('close-dialog');
};

watchEffect(() => {
  console.log('会员资产详情 = ', props.memberId);
});

const coupons: any = ref([]);
coupons.value = new Array(20).fill({
  finId: 4857495,
  finNo: '004A1E97',
  linkMemId: 576570,
  memberId: 546280,
  totalBalance: 23.92,
  cardType: '',
  entityCardNo: '',
  rechargeAmount: 680,
  awardedAmount: 0,
  discountBaseType: '标准价',
  discountRate: 79,
  allowCrossStore: '允许',
  awardedFin: 0,
  finStatus: 1,
  createTime: '2024-10-08',
  orgId: 1459,
  orgName: '郑州棉纺路店',
  brandId: 0,
  memCouponNum: 1,
});
</script>
<script lang="ts">
export default {
  name: 'PropertyDetail',
};
</script>

<style lang="scss" scoped>
.coupon-list-container {
  height: 500px;
  display: flex;
  flex-direction: column;
  gap: $main-padding;
  padding: 0 20px;

  > div:first-child {
    flex: 1;
    height: calc(60vh - 47px);
  }

  > div:last-child {
    display: flex;
    justify-content: flex-end;
  }
}
</style>
