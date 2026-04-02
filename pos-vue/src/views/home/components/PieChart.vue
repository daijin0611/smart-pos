<template>
  <div ref="chartRef" :class="className" :style="{ height, width }"></div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted, watch } from 'vue';
import * as echarts from 'echarts';
import { ElLoading } from 'element-plus';
import 'element-plus/es/components/loading/style/css';

// 定义组件属性
const props = defineProps({
  // 图表数据
  data: {
    type: Array as () => Array<{
      name: string;
      value: number;
      [key: string]: any;
    }>,
    required: true,
  },
  // 图表高度
  height: {
    type: String,
    default: '300px',
  },
  // 图表宽度
  width: {
    type: String,
    default: '100%',
  },
  // 自定义类名
  className: {
    type: String,
    default: '',
  },
  // 图表标题
  title: {
    type: String,
    default: '实收合计',
  },
  // 是否显示中心文本
  showCenterText: {
    type: Boolean,
    default: true,
  },
  // 中心文本
  centerText: {
    type: String,
    default: '',
  },
  // 单位
  unit: {
    type: String,
    default: '元',
  },
  // 是否显示图例
  showLegend: {
    type: Boolean,
    default: true,
  },
  // 图例位置
  legendPosition: {
    type: String,
    default: 'bottom',
  },
  // 是否显示加载状态
  showLoading: {
    type: Boolean,
    default: true,
  },
  // 是否可响应式调整
  responsive: {
    type: Boolean,
    default: true,
  },
  // 自定义配置项
  customOptions: {
    type: Object,
    default: () => ({}),
  },
});

// 定义组件事件
const emits = defineEmits(['chartClick', 'chartDblClick', 'chartReady']);

// 图表引用
const chartRef = ref<HTMLDivElement | null>(null);
// 图表实例
let chartInstance: echarts.ECharts | null = null;
// 加载实例
let loadingInstance: any = null;

// 初始化图表
const initChart = () => {
  if (!chartRef.value) return;

  // 创建图表实例
  chartInstance = echarts.init(chartRef.value);

  // 显示加载状态
  if (props.showLoading) {
    loadingInstance = ElLoading.service({
      target: chartRef.value,
      text: '加载中...',
      background: 'rgba(0, 0, 0, 0.1)',
    });
  }

  // 配置图表选项
  const options = generateOptions();

  // 设置图表选项
  chartInstance.setOption(options);

  // 隐藏加载状态
  if (loadingInstance) {
    setTimeout(() => {
      loadingInstance.close();
    }, 500);
  }

  // 绑定事件
  bindEvents();

  // 触发图表就绪事件
  emits('chartReady', chartInstance);
};

// 生成图表选项
const generateOptions = () => {
  const { data, title, showCenterText, centerText, showLegend, unit, legendPosition, customOptions } = props;

  // 计算总金额
  const total = data.reduce((sum, item) => sum + item.value, 0);
  const formattedTotal = `¥${total.toFixed(2)}`;

  // 基础配置
  const baseOptions: any = {
    title: {
      text: title,
      left: 'center',
      textStyle: {
        color: 'grey',
        fontSize: 16,
      },
    },
    tooltip: {
      trigger: 'item',
      formatter: `{a} <br/>{b}: {c}${unit} ({d}%)`,
    },
    legend: {
      show: showLegend,
      orient: 'horizontal',
      bottom: legendPosition,
      top: legendPosition,
      left: 'center',
      formatter: function (name: any) {
        const item: any = data.find((item) => item.name === name);
        return `${item.name}：${item.value}${unit}`;
      },
    },
    series: [
      {
        name: '提示',
        type: 'pie',
        radius: ['40%', '70%'],
        center: ['50%', '50%'],
        avoidLabelOverlap: true,
        itemStyle: {
          borderRadius: 8,
          borderColor: '#fff',
          borderWidth: 2,
        },
        label: {
          show: false,
          position: 'center',
        },
        emphasis: {
          label: {
            show: false,
            fontSize: '16',
            fontWeight: 'bold',
            formatter: `{b}: {c}${unit} ({d}%)`,
          },
        },
        labelLine: {
          show: false,
        },
        data: data.map((item) => ({
          name: item.name,
          value: item.value,
          itemStyle: {
            color: getColorByIndex(data.indexOf(item)),
          },
        })),
      },
    ],
  };

  // 添加中心文本
  if (showCenterText) {
    baseOptions.series[0].label = {
      show: true,
      position: 'center',
      formatter: centerText || `总实收\n${formattedTotal}`,
      fontSize: 16,
      fontWeight: 'bold',
      color: '#333',
    };
  }

  // 合并自定义配置
  return { ...baseOptions, ...customOptions };
};

// 根据索引获取颜色
const getColorByIndex = (index: number) => {
  const colors = [
    '#5b8ff9', // 蓝色
    '#5ad8a6', // 绿色
    '#5d7092', // 深蓝灰色
    '#f6bd16', // 黄色
    '#e8684a', // 橙色
    '#6dc8ec', // 浅蓝
    '#9270CA', // 紫色
    '#FF9D42', // 橙黄
    '#71EFA3', // 亮绿
    '#16C2A3', // 青蓝
  ];
  return colors[index % colors.length];
};

// 绑定图表事件
const bindEvents = () => {
  if (!chartInstance) return;

  // 点击事件
  chartInstance.on('click', (params) => {
    emits('chartClick', params);
  });

  // 双击事件
  chartInstance.on('dblclick', (params) => {
    emits('chartDblClick', params);
  });
};

// 调整图表大小
const resizeChart = () => {
  if (chartInstance) {
    chartInstance.resize();
  }
};

// 监听数据变化
watch(
  () => props.data,
  () => {
    if (chartInstance) {
      chartInstance.setOption(generateOptions());
    }
  },
  { deep: true },
);

// 监听窗口大小变化
const handleResize = () => {
  if (props.responsive) {
    resizeChart();
  }
};

// 组件挂载时
onMounted(() => {
  initChart();
  window.addEventListener('resize', handleResize);
});

// 组件卸载时
onUnmounted(() => {
  if (chartInstance) {
    chartInstance.dispose();
    chartInstance = null;
  }
  window.removeEventListener('resize', handleResize);
  if (loadingInstance) {
    loadingInstance.close();
  }
});
</script>

<script lang="ts">
export default {
  name: 'PieChart',
};
</script>

<style scoped>
:deep(.el-loading-spinner) {
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>
