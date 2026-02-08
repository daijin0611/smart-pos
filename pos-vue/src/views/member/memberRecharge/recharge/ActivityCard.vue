<template>
  <div>
    <div :class="cardClass" @click="handleClick">
      <div class="activity-card__content">
        <div class="activity-card__title">
          <EllipsisText :content="title" />
        </div>
        <div class="activity-card__subtitle" v-if="subtitle">
          <EllipsisText :content="subtitle" />
        </div>
      </div>
      <div :class="statusBarClass">
        <EllipsisText :content="statusText" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, PropType } from 'vue';

// 活动状态类型
type ActivityStatus = 'active' | 'selected' | 'expired';

// 组件 Props
interface Props {
  id: number;
  title: string;
  subtitle?: string;
  status?: string;
  endDate?: string;
}

const props = withDefaults(defineProps<Props>(), {
  subtitle: '',
  status: 'active',
  endDate: '',
});

const status = ref(props.status || 'active');

// 组件 Emits
interface Emits {
  (e: 'click', data: {}): void;
}

const emit = defineEmits<Emits>();

// 计算状态文本
const statusText = computed(() => {
  switch (props.status) {
    case 'active':
      return props.endDate ? `活动截止：${props.endDate}` : '活动进行中';
    case 'selected':
      return '已选活动';
    case 'expired':
      return '活动已过期';
    default:
      return '';
  }
});

// 计算卡片样式类
const cardClass = computed(() => {
  return ['activity-card', `activity-card--${props.status}`];
});

// 计算状态栏样式类
const statusBarClass = computed(() => {
  return ['activity-card__status', `activity-card__status--${props.status}`];
});

// 处理点击事件
const handleClick = () => {
  if (props.status !== 'expired') {
    emit('click', props);
  }
};
</script>

<style scoped>
/* 活动卡片样式 */
.activity-card {
  width: 180px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: all 0.3s ease;
  overflow: hidden;
  position: relative;
}

.activity-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

/* 活动状态样式 */
.activity-card--active {
  border: 2px solid #e6e8eb;
}

.activity-card--active:hover {
  border-color: #a855f7;
}

.activity-card--selected {
  border: 2px solid #a855f7;
}

.activity-card--expired {
  opacity: 0.6;
  cursor: not-allowed;
}

.activity-card--expired:hover {
  transform: none;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

/* 卡片内容区域 */
.activity-card__content {
  padding: 10px;
  text-align: center;
}

.activity-card__title {
  font-size: 16px;
  font-weight: 500;
  color: #333;
  margin-bottom: 5px;
  line-height: 1.4;
}

.activity-card__subtitle {
  padding: 5px;
  font-size: 14px;
  color: #a855f7;
  font-weight: 500;
}

/* 状态栏样式 */
.activity-card__status {
  padding: 10px;
  text-align: center;
  font-size: 14px;
  font-weight: 500;
  color: #fff;
}

.activity-card__status--active {
  background: linear-gradient(135deg, #a855f7 0%, #8b5cf6 100%);
}

.activity-card__status--selected {
  background: linear-gradient(135deg, #a855f7 0%, #8b5cf6 100%);
}

.activity-card__status--expired {
  background: linear-gradient(135deg, #9ca3af 0%, #6b7280 100%);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .activity-card {
    width: 100%;
    max-width: 320px;
  }
}

/* 加载动画 */
.activity-card {
  animation: slideInUp 0.5s ease-out;
}

@keyframes slideInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 选中状态的特殊效果 */
.activity-card--selected::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(168, 85, 247, 0.1) 0%, rgba(139, 92, 246, 0.1) 100%);
  pointer-events: none;
}

/* 过期状态的灰色覆盖 */
.activity-card--expired::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(255, 255, 255, 0.3);
  pointer-events: none;
}
</style>
