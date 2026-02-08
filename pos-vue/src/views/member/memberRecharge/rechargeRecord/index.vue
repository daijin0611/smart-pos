<template>
  <div class="main-container">
    <!-- 数据筛选 -->
    <Card class="operation-card">
      <!-- 第一行 -->
      <div class="search-container">
        <div class="search-item">
          <label>
            充值时段：
            <DatePicker
              v-model="store.recordSearch.date"
              @change="search"
              @clear="search"
              clearable
              style="width: 260px"
            />
          </label>
        </div>
      </div>

      <!-- 第二行 -->
      <div class="search-container">
        <div class="search-item">
          <label for="rechargeStatus">
            <span>充值状态：</span>
            <el-select
              v-model="store.recordSearch.rechargeStatus"
              @change="search"
              @clear="search"
              clearable
              style="width: 120px"
            >
              <el-option
                v-for="item in rechargeStatusOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              />
            </el-select>
          </label>
        </div>
        <div class="search-item">
          <label>
            <span>支付类型：</span>
            <el-select
              v-model="store.recordSearch.paymentType"
              @change="search"
              @clear="search"
              clearable
              style="width: 120px"
            >
              <el-option v-for="item in paymentTypeOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </label>
        </div>
        <div class="search-item">
          <label>
            <span>销售人员：</span>
            <el-select
              v-model="store.recordSearch.userId"
              @change="search"
              @clear="search"
              clearable
              style="width: 120px"
            >
              <el-option key="未指定" label="未指定" :value="''" />
              <el-option v-for="item in staffList" :key="item.id" :label="item.userName" :value="item.id" />
            </el-select>
          </label>
        </div>
        <div class="search-item">
          <label>
            <span>会员信息：</span>
            <div>
              <el-input
                v-model="store.recordSearch.vipInfoFiled"
                clearable
                @clear="search"
                placeholder="姓名 | 卡号 | 手机号"
              />
            </div>
          </label>
        </div>
        <div class="search-item">
          <el-button type="primary" @click="search">搜索</el-button>
        </div>
        <div class="search-item">
          <el-button type="info" @click="store.resetRecordSearchParams">重置</el-button>
        </div>
      </div>
    </Card>

    <!-- 数据列表 -->
    <Card padding="0">
      <PaginationTable
        v-loading="settingStore.loading"
        :element-loading-text="settingStore.loadingMsg"
        :data="store.rechargeRecord.list"
        :total="store.rechargeRecord.total"
        :row-class-name="getRowClassName"
        v-model:currentPage="store.recordSearch.pageNum"
        v-model:pageSize="store.recordSearch.pageSize"
        :showPagination="false"
        @size-change="handleSizeChange"
        @pagination-current-change="handleCurrentChange"
      >
        <el-table-column type="index" label="序号" width="60" />
        <el-table-column prop="rechargeTime" label="充值时间" width="155" :formatter="datetimeFormatter" />
        <el-table-column prop="infoCardNumber" label="相关人员" min-width="80">
          <template #default="{ row }">
            <div>
              <div>
                <span>销售员：</span>
                <span>{{ row.userKpiList.map((e: any) => e.userName).join('、') }}</span>
              </div>
              <div>操作员：{{ row.userName }}</div>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="infoPhoneNumber" label="充值会员" width="180">
          <template #default="scope">
            <p>姓名：{{ scope.row.vipName }}</p>
            <p>卡号：{{ scope.row.vipCardNumber }}</p>
            <p>电话：{{ scope.row.vipPhoneNumber }}</p>
          </template>
        </el-table-column>
        <el-table-column prop="infoLastConsumptionTime" label="充值金额及资产编号" min-width="100">
          <template #default="{ row }">
            <p>充值：￥{{ row.rechargeValue }}({{ row.assetCode }})</p>
            <template v-if="row.ticketInfo">
              <p>赠券：{{ row.ticketInfo }}</p>
            </template>
            <template v-if="row.activeName">
              <p>活动：{{ row.activeName }}</p>
            </template>
          </template>
        </el-table-column>
        <el-table-column prop="infoLastRechargeTime" label="充值" min-width="60">
          <template #default="{ row }">
            <div>
              <div>类型：{{ row.rechargeType }}</div>
              <div v-for="(item, key) in row.paymentInfoList" :key="key">
                <span>{{ item.paymentName }}</span>
                <span>：￥{{ item.paymentAmount }}</span>
              </div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120">
          <template #default="{ row }">
            <el-button
              link
              type="primary"
              :disabled="row.rechargeStatus !== RechargeStatus.SUCCESS"
              @click="billReversal(row)"
            >
              冲正
            </el-button>
            <br />
            <el-button link type="primary" :disabled="true" @click="showDialog(row)">修改充值单据</el-button>
            <br />
            <el-button
              link
              type="primary"
              :disabled="row.rechargeStatus !== RechargeStatus.SUCCESS"
              @click="reprint(row)"
            >
              重打小票
            </el-button>
          </template>
        </el-table-column>
      </PaginationTable>
    </Card>
  </div>

  <OrderModify v-model:visible="dialog.visible" :data="dialog.data" />
</template>

<script setup lang="ts">
import OrderModify from './OrderModify.vue';
import MessageBox from '@/components/MessageBox/index';
import Message from '@/components/Message';

import { ref, reactive, onMounted } from 'vue';
import { datetimeFormatter } from '@/utils/formatter';
import { isFullDaysSince } from '@/utils/time';
import { reqRollBackRecharge } from '@/api/member/recharge/index';
import { RechargeStatus, rechargeStatusOptions, paymentTypeOptions } from '@/enums/index';
import { LodopPrinter } from '@/utils/lodop';
import { parseResMsg } from '@/utils/parseResponse';

// 引入数据仓库
import { useSettingStore } from '@/store/modules/acl/setting';
import { useRechargeStore } from '@/store/modules/member/recharge';
import { useDynamicDataStore } from '@/store/modules/enums/dynamicData';
import { useOrgStore } from '@/store/modules/acl/org';

const settingStore = useSettingStore();
const store = useRechargeStore();
const dynamicDataStore = useDynamicDataStore();
const orgStore = useOrgStore();

// 初始化
onMounted(() => {
  search();
  getStaffList();
});

// 销售员列表
const staffList = ref<any>([]);
const getStaffList = async () => {
  const res = await dynamicDataStore.getUserList();
  if (res && res.data && res.data.rows) {
    staffList.value = res.data.rows || [];
  }
};
// 搜索
const search = () => {
  store.setRechargeRecord();
};

// 处理分页变化
const handleSizeChange = (val: number) => {
  store.recordSearch.pageSize = val;
  store.setRechargeRecord();
};

const handleCurrentChange = (val: number) => {
  store.recordSearch.pageNum = val;
  store.setRechargeRecord();
};

const billReversal = async (row: any) => {
  if (isFullDaysSince(row.rechargeTime, 2)) {
    Message.warning('只能对两天以内的记录进行修改或冲正');
    return;
  }

  try {
    const prompt = await MessageBox.prompt({
      title: '充值记录-冲正',
      message: `冲正后，将不计算此单业绩，你确定要冲正会员“ ${row.vipName} ”这条充值记录吗？`,
      inputValue: '',
      inputPlaceholder: '输入冲正原因',
      inputType: 'textarea',
    });
    const res = await reqRollBackRecharge(row.historyCode, prompt.value);
    parseResMsg(res);
    search();
  } catch (error) {}
};

const printer = new LodopPrinter();
const reprint = async (row: any) => {
  // 打印小票
  if (row.rechargeStatus !== RechargeStatus.SUCCESS) {
    Message.warning('充值记录无效，无法打印小票！');
    return;
  }

  const org = await orgStore.getOrg();
  const data = { ...row, ...org };
  printer.printRechargeByHTML(data, false);
};

// 模态框
const dialog = reactive({
  title: '优惠券列表',
  visible: false,
  data: {},
});

// 打开模态框
const showDialog = (row: any) => {
  // if (isFullDaysSince(row.rechargeTime, 2)) {
  //   Message.warning('只能对两天以内的记录进行修改或冲正');
  //   return;
  // }

  // 显示模态框
  dialog.data = row;
  dialog.title = `修改单据`;
  dialog.visible = true;
  // 表单数据回显
  // store.formData = row;
};

// const isUpdate = (row: any) => {
//   const rechargeTime = new Date(row.rechargeTime);
//   const nowTime = new Date();
//   console.log();
//   return isFullDaysSince
// };

// 设置行样式
const getRowClassName = ({ row }: { row: { rechargeStatus: number } }) => {
  return row.rechargeStatus !== RechargeStatus.SUCCESS ? 'disabled-row' : '';
};
</script>

<style scoped lang="scss"></style>
