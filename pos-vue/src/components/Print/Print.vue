<template>
  <div class="clodop-printer">
    <div class="controls">
      <h2>C-Lodop 小票打印</h2>

      <div class="connection-status">
        C-Lodop 状态:
        <span :class="isLodopReady ? 'connected' : 'disconnected'">
          {{ isLodopReady ? `已就绪 (v${lodopVersion})` : '未加载' }}
        </span>
        <button @click="checkLodopStatus" class="check-btn">检查状态</button>
      </div>

      <div class="printer-selection" v-if="isLodopReady">
        <label>选择打印机:</label>
        <select v-model="selectedPrinter">
          <option v-for="printer in printerList" :value="printer" :key="printer">
            {{ printer }}
          </option>
        </select>
      </div>

      <div class="order-info">
        <h3>订单信息</h3>
        <div class="form-group">
          <label>订单号:</label>
          <input v-model="orderNo" type="text" />
        </div>

        <div class="items">
          <div class="item-header">
            <span>商品</span>
            <span>数量</span>
            <span>单价</span>
          </div>

          <div v-for="(item, index) in items" :key="index" class="item-row">
            <input v-model="item.name" type="text" />
            <input v-model.number="item.quantity" type="number" min="1" />
            <input v-model.number="item.price" type="number" min="0" step="0.01" />
          </div>

          <button @click="addItem" class="add-btn">+ 添加商品</button>
        </div>

        <div class="total">总计: ¥{{ calculateTotal().toFixed(2) }}</div>

        <button @click="printWithCLodop" class="print-btn" :disabled="!isLodopReady">
          <i class="fa fa-print"></i>
          打印小票
        </button>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue';

// 定义C-Lodop控件类型
declare global {
  interface Window {
    CLodop: any;
    getCLodop: () => any;
  }
}

export default defineComponent({
  name: 'CLodopReceiptPrinter',
  setup() {
    // 状态
    const isLodopReady = ref(false);
    const lodopVersion = ref('');
    const printerList = ref<string[]>([]);
    const selectedPrinter = ref('');

    // 订单数据
    const orderNo = ref(`ORD-${new Date().getTime()}`);
    const items = ref([
      { name: '可乐', quantity: 2, price: 3.5 },
      { name: '汉堡', quantity: 1, price: 15.0 },
    ]);

    // 检查C-Lodop状态
    const checkLodopStatus = () => {
      try {
        // 获取C-Lodop实例
        const LODOP = window.getCLodop();

        if (LODOP) {
          isLodopReady.value = true;
          lodopVersion.value = LODOP.VERSION;

          // 获取打印机列表
          const count = LODOP.GET_PRINTER_COUNT();
          const printers: string[] = [];
          for (let i = 0; i < count; i++) {
            printers.push(LODOP.GET_PRINTER_NAME(i));
          }
          printerList.value = printers;

          // 默认选择第一个打印机
          if (printers.length > 0) {
            selectedPrinter.value = printers[0];
          }
        } else {
          isLodopReady.value = false;
          alert('C-Lodop控件未安装，请先安装控件');
        }
      } catch (error) {
        isLodopReady.value = false;
        console.error('C-Lodop错误:', error);
        alert('获取C-Lodop控件失败');
      }
    };

    // 计算总金额
    const calculateTotal = () => {
      return items.value.reduce((total, item) => {
        return total + item.quantity * item.price;
      }, 0);
    };

    // 添加商品
    const addItem = () => {
      items.value.push({ name: '', quantity: 1, price: 0 });
    };

    // 使用C-Lodop打印
    const printWithCLodop = () => {
      if (!isLodopReady.value) return;

      const LODOP = window.getCLodop();
      if (!LODOP) return;

      // 清空打印任务
      LODOP.PRINT_INITA(0, 0, 300, 800, '小票打印'); // 300px宽度，适合80mm纸

      // 选择打印机
      if (selectedPrinter.value) {
        LODOP.SET_PRINTER_INDEX(selectedPrinter.value);
      }

      // 设计小票内容
      let yPos = 10; // Y轴起始位置
      const xLeft = 10; // 左侧边距
      const xRight = 290; // 右侧边距

      // 标题
      LODOP.ADD_PRINT_TEXT(xLeft, yPos, xRight - xLeft, 30, 'XX商店');
      LODOP.SET_PRINT_STYLEA(0, 'FontSize', 16);
      LODOP.SET_PRINT_STYLEA(0, 'Align', 2); // 居中对齐
      yPos += 35;

      // 商店信息
      LODOP.ADD_PRINT_TEXT(xLeft, yPos, xRight - xLeft, 20, '地址：北京市朝阳区XX街XX号');
      LODOP.SET_PRINT_STYLEA(0, 'FontSize', 10);
      LODOP.SET_PRINT_STYLEA(0, 'Align', 2);
      yPos += 20;

      LODOP.ADD_PRINT_TEXT(xLeft, yPos, xRight - xLeft, 20, '电话：010-12345678');
      LODOP.SET_PRINT_STYLEA(0, 'FontSize', 10);
      LODOP.SET_PRINT_STYLEA(0, 'Align', 2);
      yPos += 25;

      // 分隔线
      LODOP.ADD_PRINT_LINE(xLeft, yPos, xRight, yPos, 0.5);
      yPos += 10;

      // 订单信息
      LODOP.ADD_PRINT_TEXT(xLeft, yPos, 150, 20, `订单号：${orderNo.value}`);
      LODOP.SET_PRINT_STYLEA(0, 'FontSize', 10);

      LODOP.ADD_PRINT_TEXT(160, yPos, 130, 20, `日期：${new Date().toLocaleString()}`);
      LODOP.SET_PRINT_STYLEA(0, 'FontSize', 10);
      yPos += 20;

      // 分隔线
      LODOP.ADD_PRINT_LINE(xLeft, yPos, xRight, yPos, 0.5);
      yPos += 10;

      // 商品表头
      LODOP.ADD_PRINT_TEXT(xLeft, yPos, 120, 20, '商品');
      LODOP.ADD_PRINT_TEXT(130, yPos, 50, 20, '数量');
      LODOP.ADD_PRINT_TEXT(180, yPos, 60, 20, '单价');
      LODOP.ADD_PRINT_TEXT(240, yPos, 50, 20, '金额');
      LODOP.SET_PRINT_STYLEA(0, 'FontSize', 10);
      LODOP.SET_PRINT_STYLEA(0, 'Bold', 1);
      yPos += 20;

      // 商品列表
      items.value.forEach((item) => {
        if (!item.name || item.price <= 0) return;

        const amount = item.quantity * item.price;

        LODOP.ADD_PRINT_TEXT(xLeft, yPos, 120, 20, item.name);
        LODOP.ADD_PRINT_TEXT(130, yPos, 50, 20, item.quantity.toString());
        LODOP.ADD_PRINT_TEXT(180, yPos, 60, 20, `¥${item.price.toFixed(2)}`);
        LODOP.ADD_PRINT_TEXT(240, yPos, 50, 20, `¥${amount.toFixed(2)}`);
        LODOP.SET_PRINT_STYLEA(0, 'FontSize', 10);
        yPos += 20;
      });

      // 分隔线
      LODOP.ADD_PRINT_LINE(xLeft, yPos, xRight, yPos, 0.5);
      yPos += 15;

      // 总计
      LODOP.ADD_PRINT_TEXT(150, yPos, 130, 30, `总计：¥${calculateTotal().toFixed(2)}`);
      LODOP.SET_PRINT_STYLEA(0, 'FontSize', 14);
      LODOP.SET_PRINT_STYLEA(0, 'Bold', 1);
      yPos += 35;

      // 结束语
      LODOP.ADD_PRINT_TEXT(xLeft, yPos, xRight - xLeft, 20, '感谢惠顾，欢迎下次光临！');
      LODOP.SET_PRINT_STYLEA(0, 'FontSize', 10);
      LODOP.SET_PRINT_STYLEA(0, 'Align', 2);
      yPos += 30;

      // 执行打印（直接打印，无预览）
      LODOP.PRINT();

      // 如果需要预览，使用：
      // LODOP.PREVIEW();
    };

    // 初始化
    onMounted(() => {
      // 页面加载后检查C-Lodop状态
      checkLodopStatus();
    });

    return {
      isLodopReady,
      lodopVersion,
      printerList,
      selectedPrinter,
      orderNo,
      items,
      checkLodopStatus,
      calculateTotal,
      addItem,
      printWithCLodop,
    };
  },
});
</script>

<style lang="scss" scoped>
.clodop-printer {
  max-width: 800px;
  margin: 20px auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.controls {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

h2 {
  color: #333;
  margin-top: 0;
  text-align: center;
}

.connection-status {
  margin: 15px 0;
  padding: 10px;
  background: #f5f5f5;
  border-radius: 4px;
  display: flex;
  align-items: center;
  gap: 10px;
}

.connected {
  color: #4caf50;
  font-weight: bold;
}

.disconnected {
  color: #f44336;
}

.check-btn {
  margin-left: auto;
  padding: 5px 10px;
  background: #2196f3;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.printer-selection {
  margin: 15px 0;
  display: flex;
  align-items: center;
  gap: 10px;

  select {
    padding: 6px 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    flex: 1;
    max-width: 300px;
  }
}

.order-info {
  margin-top: 20px;

  h3 {
    color: #555;
    border-bottom: 1px solid #eee;
    padding-bottom: 8px;
  }
}

.form-group {
  margin: 15px 0;
  display: flex;
  align-items: center;
  gap: 10px;

  label {
    width: 80px;
    color: #666;
  }

  input {
    flex: 1;
    padding: 8px 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }
}

.items {
  margin: 20px 0;
  border: 1px solid #ddd;
  border-radius: 4px;
  overflow: hidden;
}

.item-header,
.item-row {
  display: flex;
  padding: 10px;

  span,
  input {
    flex: 1;
    text-align: center;
    padding: 5px;
  }
}

.item-header {
  background: #f5f5f5;
  font-weight: bold;
  border-bottom: 1px solid #ddd;
}

.item-row {
  border-bottom: 1px solid #f5f5f5;

  &:last-child {
    border-bottom: none;
  }
}

.add-btn {
  margin: 10px 0;
  padding: 8px 15px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.total {
  text-align: right;
  font-size: 16px;
  font-weight: bold;
  color: #e53935;
  margin: 15px 0;
  padding-right: 10px;
}

.print-btn {
  display: block;
  width: 100%;
  padding: 10px;
  background: #2196f3;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
  margin-top: 20px;

  &:disabled {
    background: #ccc;
    cursor: not-allowed;
  }

  i {
    margin-right: 8px;
  }
}
</style>
