<template>
  <div class="main-container">
    <!-- 数据筛选 -->
    <Card class="operation-card">
      <!-- 第一行 -->
      <div class="search-container">
        <!-- <div class="search-item" v-if="false">
          <label for="staffStatus">选择店铺：</label>
          <el-select v-model="store.searchParams.storeId" id="staffStatus" style="width: 120px" placeholder="选择店铺">
            <el-option
              v-for="item in paymentTypeOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </div> -->
        <div class="search-item">
          <label>
            开单时段：
            <DatePicker v-model="store.searchParams.date" style="width: 260px" />
          </label>
        </div>
        <div class="search-item">
          <label for="saleStaff">收银员：</label>
          <el-select
            v-model="store.searchParams.userId"
            clearable
            id="saleStaff"
            placeholder="选择收银员"
            style="width: 120px"
          >
            <el-option label="未指定" value="null" />
            <el-option v-for="item in staffList" :key="item.id" :label="item.userName" :value="item.id" />
          </el-select>
        </div>
        <div class="search-item">
          <el-switch v-model="store.searchParams.payZero" :active-value="0" :inactive-value="1" id="payZero" />
          <label for="payZero">&nbsp;仅查看支付为0的订单</label>
        </div>
      </div>

      <!-- 第二行 -->
      <div class="search-container">
        <div class="search-item">
          <label for="orderStatus">订单状态：</label>
          <el-select v-model="store.searchParams.status" clearable id="orderStatus" style="width: 120px">
            <el-option v-for="item in orderStatusOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </div>
        <div class="search-item">
          <label for="payType">支付类型：</label>
          <el-select
            v-model="store.searchParams.paymentType"
            clearable
            id="payType"
            placeholder="选择支付类型"
            style="width: 130px"
          >
            <el-option v-for="item in paymentTypeOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </div>
        <div class="search-item">
          <label for="memberInfo">会员信息：</label>
          <div>
            <el-input
              v-model="store.searchParams.vipInfoFiled"
              id="memberInfo"
              placeholder="会员卡号 | 手机号"
              clearable
            />
          </div>
        </div>
        <div class="search-item">
          <label for="orderID">订单号：</label>
          <div>
            <el-input v-model="store.searchParams.orderCode" id="orderID" placeholder="请输入销售单号" clearable />
          </div>
        </div>
        <div class="search-item">
          <el-button type="primary" @click="search">搜索</el-button>
        </div>
      </div>
    </Card>

    <!-- 数据列表 -->
    <Card padding="0">
      <PaginationTable
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.saleRecord.data"
        :total="store.saleRecord.total"
        v-model:pageNum="store.searchParams.pageNum"
        v-model:pageSize="store.searchParams.pageSize"
        @size-change="handleSizeChange"
        @pagination-current-change="handleCurrentChange"
      >
        <el-table-column type="index" label="序号" width="60" />
        <el-table-column prop="orderTime" label="开单日期" width="105" :formatter="dateFormatter" />
        <el-table-column prop="orderTime" label="开单时间" width="85" :formatter="timeFormatter" />
        <el-table-column prop="settleTime" label="结算时间" width="85" :formatter="timeFormatter" />
        <el-table-column prop="orderCode" label="销售单号" min-width="100" />
        <el-table-column label="顾客信息" width="160">
          <template #default="scope">
            <p>姓名：{{ scope.row.customerName }}</p>
            <p>卡号：{{ scope.row.vipCardNumber }}</p>
            <p>电话：{{ scope.row.vipPhoneNumber }}</p>
            <p>余额：{{ scope.row.afterBalance }}元</p>
          </template>
        </el-table-column>
        <el-table-column label="应收金额" min-width="60">
          <template #default="scope">￥{{ scope.row.totalAmount }}</template>
        </el-table-column>
        <el-table-column label="实收金额" min-width="80">
          <template #default="scope">实收：￥{{ scope.row.actualAmount }}</template>
        </el-table-column>
        <el-table-column label="优惠金额" min-width="60">
          <template #default="scope">￥{{ scope.row.discountAmount }}</template>
        </el-table-column>
        <el-table-column label="付款方式" min-width="100">
          <template #default="scope">
            <p v-for="item in scope.row.payments" :key="item.paymentType">
              {{ item.paymentName }}：￥{{ item.totalAmount }}
            </p>
          </template>
        </el-table-column>
        <el-table-column label="状态" min-width="80">
          <template #default="scope">
            <p>状态：{{ scope.row.orderStatusName }}</p>
            <p>收银：{{ scope.row.userName }}</p>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="115">
          <template #default="{ row }">
            <el-button @click="showDrawer(row)" link type="info">明细</el-button>
            <el-button :disabled="row.orderStatus !== OrderStatus.SETTLED" @click="reversal(row)" link type="danger">
              冲正
            </el-button>
            <br />
            <!-- <el-button :disabled="row.orderStatus !== OrderStatus.SETTLED" @click="showDialog(row)" link type="warning"> -->
            <el-button :disabled="true" @click="showDialog(row)" link type="warning">修改销售单据</el-button>
            <br />
            <el-button
              :disabled="row.orderStatus !== OrderStatus.SETTLED"
              @click="printReceipt(row)"
              link
              type="primary"
            >
              重打小票
            </el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <Drawer v-model="drawer.visible" :title="drawer.title">
    <OrderDetail :orderData="drawer.orderData" />
  </Drawer>
  <OrderModify v-model:visible="dialog.visible" :data="dialog.data" />
</template>

<script setup lang="ts">
import OrderDetail from './OrderDetail.vue';
import OrderModify from './OrderModify.vue';
import Message from '@/components/Message';
import { reactive, inject, onMounted, ref } from 'vue';
import { dateFormatter, timeFormatter } from '@/utils/formatter';
import { OrderStatus, OrderStatusMap, orderStatusOptions, paymentTypeOptions } from '@/enums';
import { LodopPrinter } from '@/utils/lodop';
import { isFullDaysSince } from '@/utils/time';
import { reqRollBackOrder } from '@/api/order';
import { parseResMsg } from '@/utils/parseResponse';
import { cloneDeep } from 'lodash';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useSaleStore } from '@/store/modules/dataGroup/saleData';
import { useDataEnumStore } from '@/store/modules/enums';
import { useOrgStore } from '@/store/modules/acl/org';
const orgStore = useOrgStore();
const settingStore = useSettingStore();
const store = useSaleStore();
const dataEnumStore = useDataEnumStore();

// 收银员列表
const staffList = ref([]);

// 引入消息弹框
const MessageBox: any = inject('$MessageBox');

// 初始化
onMounted(async () => {
  // 获取收银员列表
  staffList.value = await dataEnumStore.getStaffList();
  store.setSaleRecord();
});

// 搜索
const search = () => {
  store.setSaleRecord();
};

// 处理分页变化
const handleSizeChange = (val: number) => {
  store.searchParams.pageSize = val;
  store.setSaleRecord();
};

const handleCurrentChange = (val: number) => {
  store.searchParams.pageNum = val;
  store.setSaleRecord();
};

const reversal = async (row: any) => {
  if (isFullDaysSince(row.settleTime, 2)) {
    Message.warning('只能对两天以内的记录进行修改或冲正');
    return;
  }

  try {
    const prompt = await MessageBox.prompt({
      title: '销售订单-冲正',
      message: '冲正后，订单将退还“会员卡支付”的金额, 同时将不计算此单业绩，你确定要对此订单进行冲正吗？',
      inputValue: '',
      inputPlaceholder: '输入冲正原因',
      inputType: 'textarea',
    });
    const res = await reqRollBackOrder(row.id, prompt.value);
    parseResMsg(res);
    search();
  } catch (error) {}
};

const printer = new LodopPrinter();

const printReceipt = async (row: any) => {
  // 打印小票
  if (row.orderStatus !== OrderStatus.SETTLED) {
    Message.warning('订单未结算，无法打印小票！');
    return;
  }
  const org = await orgStore.getOrg();
  const data = { ...row, ...org };
  // printer.printReceipt(data, true);
  printer.printOrderByHTML(data, false);
};

// 抽屉
const drawer: any = reactive({
  title: '销售明细',
  visible: false,
  orderData: null, // 存储当前选中的订单数据
});

const showDrawer = (row: any) => {
  // 显示模态框
  drawer.visible = true;
  // 传递订单数据
  drawer.orderData = cloneDeep(row);
};

// 模态框
const dialog: any = reactive({
  visible: false,
  data: {},
});

const showDialog = (row: any) => {
  if (isFullDaysSince(row.settleTime, 2)) {
    Message.warning('只能对两天以内的记录进行修改或冲正');
    return;
  }

  // 显示模态框
  dialog.data = cloneDeep(row);
  dialog.visible = true;
  // 表单数据回显
  // store = row;
};
</script>

<style scoped lang="scss"></style>
