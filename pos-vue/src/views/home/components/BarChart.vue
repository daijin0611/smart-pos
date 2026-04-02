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
    default: '400px',
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
    default: '',
  },
  // x轴名称
  xAxisName: {
    type: String,
    default: '',
  },
  // y轴名称
  yAxisName: {
    type: String,
    default: '',
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
  const { data, title, xAxisName, yAxisName, customOptions } = props;

  // 基础配置
  const baseOptions = {
    title: {
      text: title,
      left: 'center',
      textStyle: {
        color: 'grey',
        fontSize: 16,
      },
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'shadow',
      },
      formatter: '{b}: ￥{c}元',
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true,
    },
    xAxis: {
      type: 'category',
      data: data.map((item) => item.name),
      name: xAxisName,
      axisLabel: {
        interval: 0,
        rotate: 30,
      },
    },
    yAxis: {
      type: 'value',
      name: yAxisName,
      axisLabel: {
        formatter: '{value}',
      },
    },
    series: [
      {
        data: data.map((item) => ({
          value: item.value,
          itemStyle: {
            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
              { offset: 0, color: '#5b8ff9' },
              { offset: 1, color: '#3b76e3' },
            ]),
          },
        })),
        type: 'bar',
        barWidth: '60%',
        label: {
          show: true,
          position: 'top',
          formatter: '￥{c}',
        },
      },
    ],
  };

  // 合并自定义配置
  return { ...baseOptions, ...customOptions };
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
  name: 'BarChart',
};
</script>

<style scoped>
:deep(.el-loading-spinner) {
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>
