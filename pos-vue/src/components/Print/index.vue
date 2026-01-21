<template>
  <div class="print-container">
    <el-button type="primary" @click="handlePrint">打印消费单</el-button>
    <el-button @click="handlePreview">打印预览</el-button>

    <div style="width: 80mm; font-family: 'SimHei', Arial; padding: 10px">
      <!-- 标题区域 -->
      <h2 style="text-align: center; margin: 0; font-size: 16px; font-weight: bold">郑州棉纺路店</h2>
      <p style="text-align: center; margin: 0; font-size: 14px">消费单</p>
      <br />

      <!-- 时间区域 -->
      <p style="margin: 0">账务时间: 2025-11-10 23:33:15</p>
      <p style="margin: 0">买单时间: 2025-11-10 23:34:46</p>
      <br />

      <!-- 项目表格 -->
      <table style="width: 100%; border-collapse: collapse; font-size: 12px">
        <thead>
          <tr style="border-bottom: 1px solid #000">
            <th style="text-align: left; padding: 5px 0">项目/标准价</th>
            <th style="text-align: left; padding: 5px 0">技师</th>
            <th style="text-align: left; padding: 5px 0">数量</th>
            <th style="text-align: left; padding: 5px 0">金额</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>套餐五选二￥138</td>
            <td>李园园-轮</td>
            <td>1</td>
            <td>￥106.5</td>
          </tr>
          <tr>
            <td>套餐五选二￥138</td>
            <td>李小展-轮</td>
            <td>1</td>
            <td>￥106.5</td>
          </tr>
          <tr>
            <td>水洗头￥128</td>
            <td>李园园-加</td>
            <td>1</td>
            <td>￥69</td>
          </tr>
          <tr>
            <td>水洗头￥128</td>
            <td>李小展-加</td>
            <td>1</td>
            <td>￥69</td>
          </tr>
          <tr>
            <td>一次性工具￥15</td>
            <td>李小展</td>
            <td>1</td>
            <td>￥10</td>
          </tr>
          <tr>
            <td>一次性工具￥15</td>
            <td>李园园</td>
            <td>1</td>
            <td>￥10</td>
          </tr>
        </tbody>
      </table>
      <hr style="border: 1px solid #000; margin: 10px 0" />

      <!-- 房间信息 -->
      <p style="margin: 0">房间编号: 卡5</p>
      <br />

      <!-- 支付明细 -->
      <p style="font-weight: bold; margin: 0">支付明细</p>
      <p style="margin: 0; text-indent: 2em">微信支付: ￥20</p>
      <p style="margin: 0; text-indent: 2em">支付宝支付: ￥69</p>
      <p style="margin: 0; text-indent: 2em">银行卡支付: ￥282</p>
      <hr style="border: 1px solid #000; margin: 10px 0" />

      <!-- 金额统计 -->
      <p style="margin: 0">原价总计: ￥562</p>
      <p style="margin: 0">实付总计: ￥371</p>
      <p style="margin: 0">节省总计: ￥191</p>
      <br />

      <!-- 系统信息 -->
      <p style="margin: 0">系统单号: 125111014590018</p>
      <p style="margin: 0">收银员: 刘</p>
      <p style="margin: 0">开单时间: 2025-11-10 23:33:15</p>
      <br />

      <!-- 顾客签名 -->
      <p style="margin: 0">顾客签名: ______________</p>
      <br />

      <!-- 感谢语 -->
      <p style="text-align: center; margin: 0">恭侯您下次光临</p>
      <br />

      <!-- 门店信息 -->
      <p style="margin: 0">服务电话: 16697771407</p>
      <p style="margin: 0">门店地址: 郑州市中原区盈润锦绣城西苑18-154号</p>
      <br />

      <!-- 加盟信息 -->
      <p style="text-align: center; margin: 0">加盟门店 自主经营</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { LodopPrinter, type OrderData } from '@/utils/lodop';
import { ref, onMounted } from 'vue';

const printer = new LodopPrinter();

// 构造匹配的数据结构（需与后端返回对齐，此处模拟数据）
const orderData: OrderData = {
  orgName: '郑州棉纺路店',
  servicePhone: '16697771407',
  orgAddress: '郑州市中原区盈润锦绣城西苑18-154号',
  orderCode: 'ORD17628461058279941',
  orderTime: '2025-11-10 23:33:15',
  settleTime: '2025-11-10 23:34:46',
  totalAmount: 562,
  actualAmount: 371,
  discountAmount: 191,
  bedName: '卡5',
  userName: '刘',
  orderDetails: [
    { businessName: '套餐五选二', userName: '李园园', stdPrice: 138, quantity: 1, truePrice: 106.5, serverType: 0 },
    { businessName: '套餐五选二', userName: '李小展', stdPrice: 138, quantity: 1, truePrice: 106.5, serverType: 0 },
    { businessName: '水洗头', userName: '李园园', stdPrice: 128, quantity: 1, truePrice: 69, serverType: 1 },
    { businessName: '水洗头', userName: '李小展', stdPrice: 128, quantity: 1, truePrice: 69, serverType: 1 },
    { businessName: '一次性工具', userName: '李小展', stdPrice: 15, quantity: 1, truePrice: 10, serverType: 0 },
    { businessName: '一次性工具', userName: '李园园', stdPrice: 15, quantity: 1, truePrice: 10, serverType: 0 },
  ],
  payments: [
    { paymentName: '微信', totalAmount: 20 },
    { paymentName: '支付宝', totalAmount: 69 },
    { paymentName: '银行卡', totalAmount: 282 },
  ],
};

const handlePrint = () => {
  printer.printOrderByHTML(orderData, false);
};

const handlePreview = () => {
  printer.printOrderByHTML(orderData, true);
};
</script>

<style>
.print-container {
}
</style>
