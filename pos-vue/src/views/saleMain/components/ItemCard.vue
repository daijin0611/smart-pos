<template>
  <div class="item-card">
    <div class="item item-title">
      <div class="title"><EllipsisText :content="getItemValue(data, config.nameKey || 'name')" /></div>
      <template v-if="config.isDiscountKey">
        <span
          v-if="getItemValue(data, config.isDiscountKey || 'isDiscount') == IsDiscount.discount"
          class="discount-tag discount"
        >
          {{ IsDiscountMap[IsDiscount.discount] }}
        </span>
        <span v-else class="discount-tag not-discount">{{ IsDiscountMap[IsDiscount.noDiscount] }}</span>
      </template>
    </div>
    <div class="item sub-title"><EllipsisText :content="getItemValue(data, config.codeKey || 'code')" /></div>
    <div
      v-if="getItemValue(data, config.retailPriceKey || 'retailPrice', undefined) !== undefined"
      class="item price-item"
    >
      <span>{{ firstPriceText }}：</span>
      <span class="guest">¥{{ getItemValue(data, config.retailPriceKey || 'retailPrice', 0) }}</span>
    </div>
    <div v-if="showSecondPrice" class="item price-item">
      <span>{{ secondPriceText }}：</span>
      <span class="member">¥{{ getItemValue(data, config.memberPriceKey || 'memberPrice', 0) }}</span>
    </div>
    <div class="item btn-item">
      <el-button type="primary" link @click="handleAdd" :disabled="disabled">添加</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IsDiscount, IsDiscountMap } from '@/enums';

/**
 * 自定义配置接口
 */
interface ItemCardConfig {
  nameKey?: string; // 名称属性键
  codeKey?: string; // 编码属性键
  retailPriceKey?: string; // 散客价属性键
  memberPriceKey?: string; // 会员价属性键
  isDiscountKey?: string; // 是否打折属性键
}

/**
 * 组件属性接口
 */
interface ItemCardProps {
  data: Record<string, any>; // 商品数据
  config?: ItemCardConfig; // 自定义配置
  disabled?: boolean; // 是否禁用
  firstPriceText?: string; // 第一价文本
  secondPriceText?: string; // 第二价文本
  showSecondPrice?: boolean; // 是否显示第二价
}

// 定义组件属性
const props = withDefaults(defineProps<ItemCardProps>(), {
  config: () => ({}),
  disabled: false,
  firstPriceText: '散客价',
  secondPriceText: '会员价',
  showSecondPrice: true, // 是否显示第二价
});

// 定义组件事件
const emit = defineEmits(['add']);

/**
 * 处理添加按钮点击事件
 */
const handleAdd = () => {
  if (!props.disabled) {
    emit('add', props.data);
  }
};

/**
 * 从商品数据中获取指定属性的值
 * @param data 商品数据对象
 * @param key 属性键名
 * @param defaultValue 默认值
 * @returns 属性值或默认值
 */
const getItemValue = (data: Record<string, any>, key: string, defaultValue: any = ''): any => {
  if (!data || typeof data !== 'object') {
    return defaultValue;
  }

  // 支持点号分隔的嵌套属性访问
  if (key.includes('.')) {
    const keys = key.split('.');
    let value = data;

    for (const k of keys) {
      if (value === null || value === undefined) {
        return defaultValue;
      }
      value = value[k];
    }

    return value !== undefined ? value : defaultValue;
  }

  return data[key] !== undefined ? data[key] : defaultValue;
};
</script>

<style scoped lang="scss">
.item-card {
  background: var(--el-bg-color);
  border-radius: 8px;
  padding: 10px;
  border: 1px solid var(--el-border-color);
  transition: all 0.3s ease;
  position: relative;
  display: inline-block;
  width: 170px;
  // height: 120px;
  margin: 10px 5px;

  &:hover {
    box-shadow: var(--el-box-shadow-lighter);
    transform: translateY(-2px);
  }

  &:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }

  .item {
    width: 100%;
    height: 22px;
    display: flex;
    align-items: center;
  }
  .item-title {
    justify-content: space-between;
    .title {
      width: 70%;
      display: inline-block;
    }

    .discount-tag {
      font-size: 12px;
      font-weight: 500;
      padding: 4px 4px;
      border-radius: 4px;
      text-align: center;
    }

    .discount {
      background: var(--el-color-danger);
      color: #fff;
    }

    .not-discount {
      background: var(--el-color-warning);
      color: #fff;
    }
  }
  .sub-title {
    font-size: 12px;
    height: 16px;
    color: var(--el-text-color-secondary);
  }
  .price-item {
    font-size: 12px;
    height: 18px;
    font-size: 14px;
    .guest {
      font-weight: 500;
      color: var(--el-color-info);
    }
    .member {
      font-weight: 500;
      color: var(--el-color-danger);
    }
  }
  .btn-item {
    display: flex;
    justify-content: flex-end;
  }
}
</style>
