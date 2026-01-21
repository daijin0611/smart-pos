<template>
  <div class="product-list">
    <el-scrollbar>
      <ItemCard
        v-for="item in enumStore.serviceItemList"
        :key="item.id"
        :data="item"
        :config="customConfig"
        :disabled="item.itemStatus !== 0"
        @add="handleAddItem"
      />
    </el-scrollbar>
  </div>
</template>

<script setup lang="ts">
import ItemCard from './ItemCard.vue';
import Message from '@/components/Message';
import { OrderDetailType, ServiceType } from '@/enums/index';
import { ref, watch, onMounted } from 'vue';
import { useDataEnumStore } from '@/store/modules/enums/index';
import { useOrderStore } from '@/store/modules/order/index';
const enumStore = useDataEnumStore();
const orderStore = useOrderStore();

onMounted(async () => {
  await enumStore.getServiceItemList(true);
});

const handleAddItem = (item: any) => {
  item.detailType = OrderDetailType.Service;
  item.serverType = ServiceType.Point;
  item.bid = item.id;
  orderStore.addOrderItem(item);
};

const customConfig = ref({
  nameKey: 'itemName',
  codeKey: 'itemEncode',
  retailPriceKey: 'itemPrice',
  memberPriceKey: 'vipItemPrice',
  isDiscountKey: 'isDiscounts',
});
</script>

<style lang="scss" scoped>
.product-list {
  height: 100%;
  // overflow: hidden;
  :deep(.el-scrollbar__wrap) {
    height: 100%;
    > div {
      overflow: auto;
      height: 100%;
    }
  }
}
</style>
