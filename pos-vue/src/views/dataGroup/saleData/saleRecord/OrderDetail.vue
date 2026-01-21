<template>
  <div class="detail-container">
    <!-- 上方信息区域 -->
    <div class="info-section">
      <div class="detail-item">
        <span>销售门店：</span>
        <span>{{ orgInfo.orgName || order.orgId }}</span>
      </div>
      <div class="detail-item">
        <span>销售单号：</span>
        <span>{{ order.orderCode }}</span>
      </div>
      <div class="detail-item">
        <span>会员姓名：</span>
        <span>{{ order.vipName }}</span>
      </div>
      <div class="detail-item">
        <span>门店余额：</span>
        <span>{{ order.afterBalance }} 元</span>
      </div>
      <div class="detail-item">
        <span>联盟余额：</span>
        <span>{{ order.afterBalance }} 元</span>
      </div>
      <div class="detail-item">
        <span>开单时间：</span>
        <span>{{ order.orderTime }}</span>
      </div>
      <div class="detail-item">
        <span>结算时间：</span>
        <span>{{ order.settleTime }}</span>
      </div>
      <div class="detail-item">
        <span>实收总额：</span>
        <span>{{ order.actualAmount }} 元</span>
      </div>
      <div class="detail-item">
        <span>支付方式：</span>
        <span class="highlight" v-for="(item, index) in order.payments" :key="index">
          {{ item.paymentName }} ￥{{ item.totalAmount }}&nbsp;&nbsp;
        </span>
      </div>
      <!-- <div class="detail-item">
        <span>使用的优惠券：</span>
        <span>{{ order.discountAmount }}</span>
      </div> -->
      <div class="detail-item">
        <span>消费资产明细：</span>
        <div class="asset-tag">
          <el-tag v-for="(item, index) in order.payments" :key="index">
            <span>{{ item.assetCode }}: ￥{{ item.totalAmount }}</span>
          </el-tag>
        </div>
      </div>
    </div>
    <!-- 下方表格区域 -->
    <div class="table-area">
      <el-table :data="order.orderDetails" :border="true" height="100%" size="small" stripe>
        <el-table-column prop="businessName" label="名称/标准价" min-width="120">
          <template #default="scope">
            <div>{{ scope.row.businessName }}</div>
            <div>标准价：{{ scope.row.stdPrice }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="truePrice" label="价格/数量" min-width="120">
          <template #default="scope">
            <div>单价：{{ scope.row.truePrice }} 元</div>
            <div>数量：{{ scope.row.quantity }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="bedName" label="床位" min-width="80">
          <template #default="scope">
            <div>{{ order.bedName }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="技师/销售" min-width="120">
          <template #default="scope">
            <div>
              {{ scope.row.userName }}
              <span v-if="scope.row.detailType === 1" class="tag" :style="{ color: scope.row.tagColor }">
                [{{ ServiceTypeMap[scope.row.serverType] || scope.row.serverType }}]
              </span>
            </div>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="btn-area">
      <el-button
        type="primary"
        :disabled="orderData.orderStatus !== OrderStatus.SETTLED"
        :loading="loading"
        @click="reconcileOrder"
      >
        对单
      </el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed, watch } from 'vue';
import { ServiceTypeMap } from '@/enums';
import { useOrgStore } from '@/store/modules/acl/org';
import { reqReconcileOrder } from '@/api/order/index';
import { parseResMsg } from '@/utils/parseResponse';
import { OrderStatus } from '@/enums';
import MessageBox from '@/components/MessageBox';

// 定义 props 接收父组件传递的数据
const props = defineProps<{
  orderData?: any;
}>();

// 门店store
const orgStore = useOrgStore();

// 门店信息
const orgInfo = ref<any>({});

// 获取门店详情
const getOrgDetail = async (orgId: number) => {
  if (orgId) {
    try {
      orgInfo.value = await orgStore.getOrgInfo(orgId);
    } catch (error) {
      console.error('获取门店详情失败:', error);
      orgInfo.value = {};
    }
  }
};

// 使用计算属性，优先使用传入的数据，否则使用默认数据
const order = computed(() => {
  return props.orderData || {};
});

// 监听订单数据变化，获取门店详情
watch(
  () => order.value.orgId,
  (newOrgId) => {
    if (newOrgId) {
      getOrgDetail(newOrgId);
    }
  },
);

// 组件挂载时获取门店详情
onMounted(() => {
  if (order.value.orgId) {
    getOrgDetail(order.value.orgId);
  }
});

// 对单按钮 loading
const loading = ref(false);
/** 对单 */
const reconcileOrder = async () => {
  try {
    const prompt = await MessageBox.prompt({
      message: '输入对单备注',
      inputValue: '',
      inputPlaceholder: '输入对单备注',
      inputType: 'textarea',
    });

    loading.value = true;
    const res = await reqReconcileOrder(props.orderData.id, prompt.value);
    const result = parseResMsg(res);
    // console.log('对单结果：', res);
  } catch (error) {}
  loading.value = false;
};
</script>

<style scoped lang="scss">
.detail-container {
  height: 100%;

  .info-section {
    border-radius: 5px;
    font-size: 14px;
    padding: $main-padding;
    color: var(--el-text-color-regular);
    border: 1px solid var(--el-border-color);
    overflow: scroll;
    height: 270px;

    .detail-item {
      display: flex;
      align-items: center;
      line-height: 24px;

      > span:last-child {
        flex: 1;
      }

      .highlight {
        font-weight: bold;
      }
    }

    .asset-tag {
      flex: 1;
      display: flex;
      flex-wrap: wrap;
      gap: 5px;
    }
  }

  .table-area {
    margin-top: 15px;
    height: calc(100% - 270px - 50px - 15px);
  }

  .btn-area {
    height: 50px;
    line-height: 50px;
    text-align: center;
  }
}

.tag {
  display: inline-block;
  padding: 2px 6px;
  border-radius: 4px;
  color: #259ce0;
}
</style>
