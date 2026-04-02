<template>
  <div class="vip-info-container">
    <!-- 会员基本信息 -->
    <div class="left-content">
      <!-- 会员卡 -->
      <div class="member-card">
        <div>
          <h1>{{ store.formData.name }}</h1>
          <span>{{ store.formData.gender === 1 ? '先生' : '女士' }}</span>
        </div>
        <div>普通会员</div>
        <div>{{ store.formData.cardNumber }}</div>
      </div>

      <!-- 基本信息 -->
      <div class="item-card">
        <p>
          <span>微信：</span>
          <span>
            <el-button type="primary" link icon="Promotion">去绑定</el-button>
          </span>
        </p>
        <p>
          <span>生日：</span>
          <span>{{ store.formData.birthday }}</span>
        </p>
        <p>
          <span>电话：</span>
          <span>{{ store.formData.phoneNumber }}</span>
        </p>
        <p>
          <span>地址：</span>
          <span class="text-overflow" :title="store.formData.address">{{ store.formData.address }}</span>
        </p>
        <p>
          <span>备注：</span>
          <span class="text-overflow" :title="store.formData.remark">{{ store.formData.remark }}</span>
        </p>
      </div>

      <!-- 资产信息 -->
      <div class="item-card">
        <p>
          <span>本店余额：</span>
          <span>
            <span>￥{{ store.formData.balance }} 元&nbsp;</span>
            <el-button @click="handleRecharge" type="primary" link icon="Promotion">去充值</el-button>
          </span>
        </p>
        <p>
          <span>可用余额：</span>
          <span>￥{{ store.formData.balance }} 元</span>
        </p>
        <p>
          <span>本店可用优惠券：</span>
          <span>0 张</span>
        </p>
      </div>

      <!-- 标签 -->
      <div class="item-card">
        <h1 class="tab-list-title">郑州棉纺路店</h1>
        <div class="tag-list-container">
          <el-tag v-for="tag in 30" :key="tag" closable :disable-transitions="false" @close="">标签{{ tag }}</el-tag>
          <el-button size="small" plain icon="Plus">标签</el-button>
        </div>
      </div>
    </div>

    <!-- 资产明细 -->
    <div class="right-content">
      <div>
        <span>时间段：</span>
        <DatePicker @selectDate="selectDate" :default="defaultDate" style="width: 260px; margin-right: 10px" />
        <el-button type="primary">查询</el-button>
      </div>
      <div>
        <PropertyDetail />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import PropertyDetail from './property/index.vue';
import { useRouter } from 'vue-router';

import { useMemberStore } from '@/store/modules/member/member';
import { useRechargeStore } from '@/store/modules/member/recharge';
const store = useMemberStore();
const rechargeStore = useRechargeStore();

// 路由
const router = useRouter();

// 默认最近一月日期
const defaultDate = computed(() => {
  const end = new Date();
  const start = new Date();
  start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
  return [start, end];
});

const selectDate = (start: string, end: string) => {
  console.log('选择的日期范围:', start, end);
};

const handleRecharge = () => {
  rechargeStore.member = store.formData;
  router.push({ path: '/member/memberRecharge' });
};
</script>

<style lang="scss" scoped>
.vip-info-container {
  height: 650px;
  display: flex;
  gap: $main-padding;

  > div {
    height: 100%;
    background-color: #fff;
    border-radius: 10px;
    padding: 15px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }

  // 左侧-会员信息
  .left-content {
    width: 350px;

    // 卡片项
    .item-card {
      width: 100%;
      border-radius: 10px;
      padding: 15px;
      margin-top: 15px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      > p {
        height: 25px;
        line-height: 25px;
        display: flex;
        > span:last-child {
          flex: 1;
        }
      }

      // 底部标签项
      &:last-child {
        height: calc(100% - 465px);
      }
      .tab-list-title {
        height: 20px;
        line-height: 20px;
        margin-bottom: 10px;
      }
      .tag-list-container {
        height: calc(100% - 30px);
        overflow: auto;
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
      }
    }
  }

  // 右侧-资产信息
  .right-content {
    flex: 1;

    > div:first-child {
      margin: 10px;
      width: 100%;
    }
    > div:last-child {
      height: calc(100% - 52px);
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }
  }
}

// 会员卡片
.member-card {
  height: 160px;
  width: 320px;
  border-radius: 8px;
  color: #eee;
  padding: 15px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  box-shadow: 0 0 10px #d4b2eb;
  background: linear-gradient(to right top, rgb(144, 108, 156), rgb(138, 140, 247));

  > div:first-child {
    display: flex;
    gap: 5px;
    h1 {
      font-weight: bold;
      font-size: 24px;
    }
    span {
      align-self: flex-end;
    }
  }
}
</style>
