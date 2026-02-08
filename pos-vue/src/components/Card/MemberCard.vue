<template>
  <!-- 会员卡 容器高度计算规则：padding (30 + 30 * 行数) px -->
  <div class="member-card">
    <div v-if="member?.id" class="member-card-main">
      <!-- <div v-if="true" class="member-card-main"> -->
      <div class="item-info">
        <h1>会员：{{ member.name }}</h1>
        <el-button
          v-if="showResetBtn"
          @click="reset"
          size="small"
          plain
          style="background-color: transparent; color: var(--el-color-primary-light-5)"
        >
          重选会员
        </el-button>
      </div>
      <div class="item-info">电话：{{ member.phoneNumber }}</div>
      <div class="item-info">
        <EllipsisText :content="vipCode" />
      </div>
      <div class="item-info">
        <span>门店余额：{{ member.balance || 0 }} 元&nbsp;&nbsp;</span>
        <el-button v-if="showGoRechargeBtn" @click="goRecharge" color="#000" type="primary" icon="Promotion" link>
          去充值
        </el-button>
      </div>
      <div v-if="showRemark" class="item-info remark-row">
        <span>备注：</span>
        <DynamicInput :value="member.remark" :params="member || {}" btnColor="#000" @update="updateRemark" />
      </div>
    </div>
    <div v-else class="member-card-empty">未选择会员</div>
  </div>
</template>

<script setup lang="ts">
import Message from '@/components/Message';
import { computed } from 'vue';
import { useRouter } from 'vue-router';
import { VipLevel, vipLevelMap } from '@/enums';
import { reqUpdateMemberRemark } from '@/api/member/member/index';

// 声明路由
const router = useRouter();

/**
 * 会员数据接口
 */
interface Member {
  id: string | number;
  name: string;
  phoneNumber?: string;
  cardNumber?: string;
  identity?: string;
  balance: number;
  remark: string;
}

interface Props {
  member: Member;
  showResetBtn?: boolean;
  showGoRechargeBtn?: boolean;
  showRemark?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  showResetBtn: true,
  showGoRechargeBtn: true,
  showRemark: false,
});

const emit = defineEmits<{
  (e: 'reset'): void;
  (e: 'goRecharge', member: Member): void;
}>();

const vipCode = computed(() => {
  return props.member.cardNumber
    ? `卡号：${props.member.cardNumber}(${vipLevelMap.get(Number(props.member.identity)) || '未知'})`
    : '无卡号';
});
const reset = () => {
  emit('reset');
};

const goRecharge = () => {
  router.push({
    path: '/member/memberRecharge',
    query: {
      vipId: props.member.id,
    },
  });
};

/** 更新会员备注 */
const updateRemark = async (remark: string, member: any) => {
  try {
    const res = await reqUpdateMemberRemark(member.id, remark);
    member.remark = remark;
    Message.success('更新会员备注成功');
  } catch (error) {
    Message.error('更新会员备注失败');
  } finally {
  }
};
</script>

<style lang="scss" scoped>
// 会员卡
.member-card {
  --width: 320px;
  --height: 160px;
  --line-height: 30px;

  min-height: var(--height);
  width: var(--width);
  border-radius: 8px;
  color: #eee;
  padding: 15px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  box-shadow: 0 0 10px #d4b2eb;
  background: linear-gradient(to right top, rgb(144, 108, 156), rgb(138, 140, 247));

  .member-card-main {
    display: flex;
    flex-wrap: nowrap;
    justify-content: space-between;
    flex-direction: column;
    // gap: 3px;

    .item-info {
      height: var(--line-height);
      line-height: var(--line-height);
      display: flex;
      align-items: center;
    }
    .remark-row {
      width: 100%;
      // overflow: hidden;
      > span:first-child {
        display: inline-block;
        width: 50px;
      }
      > div {
        width: calc(100% - 50px);
      }
    }

    > div:first-child {
      justify-content: space-between;
      > h1 {
        flex: 1;
      }
    }
  }

  .member-card-empty {
    font-size: 18px;
  }
}
</style>
