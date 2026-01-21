import { OrderData, Config } from './types';

const LODOP_UNIT = 10; // LODOP单位是0.1mm，所以需要将毫米乘以10
const DIVISION_ROW = 1 * LODOP_UNIT;
const DIVISION_LINE = '-------------------------------------';

export const DEFAULT_CONFIG = { width: 58, height: 80 };

export const orderTemplate = (lodop: LODOP, data: OrderData, config: Config = DEFAULT_CONFIG): void => {
  // LODOP的单位是0.1mm，所以需要将毫米乘以10
  const width = (config.width - 10) * LODOP_UNIT; // 58mm宽（XP-58打印机）
  const height = config.height * LODOP_UNIT; // 转换为LODOP单位
  const lineHeight = 2.5 * LODOP_UNIT; // 2mm行高

  lodop.PRINT_INITA(0, 0, `${width}mm`, `${height}mm`, `${data.orderCode}-${data.orgName}消费单`);

  // y 位置从 DIVISION_ROW 开始
  let yPos = DIVISION_ROW;

  // 全局配置
  lodop.SET_PRINT_STYLE('FontName', '黑体');

  // 标题栏
  lodop.ADD_PRINT_TEXT(yPos, 0, width, 4 * LODOP_UNIT, `${data.orgName}消费单`);
  lodop.SET_PRINT_STYLEA(0, 'FontSize', 12);
  lodop.SET_PRINT_STYLEA(0, 'Bold', 1);
  // lodop.SET_PRINT_STYLEA(0, 'Alignment', 2);
  yPos += 4 * LODOP_UNIT;

  // 时间信息
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `账务时间: ${data.orderTime}`);
  yPos += lineHeight;
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `买单时间: ${data.settleTime}`);
  yPos += lineHeight;

  // 构建HTML表格内容
  const tableHtml = `
    <table border="1" cellpadding="1" cellspacing="0"
      style="width:${width / LODOP_UNIT - 1}mm;border-collapse:collapse;font-size: 2.8mm;table-layout: fixed;">
      <thead>
        <tr style="font-weight:bold;">
          <td style="width: 45%;">项目/标准价</td>
          <td style="width: 20%;">技师</td>
          <td style="width: 15%;" align="center">数量</td>
          <td style="width: 20%;">金额</td>
        </tr>
      </thead>
      <tbody>
        ${data.orderDetails
          .map((item) => {
            return `
            <tr>
              <td style="word-break:break-all;width: 45%;">${item.businessName} ¥${item.stdPrice}</td>
              <td style="word-break:break-all;width: 20%;">${item.userName}</td>
              <td style="width: 15%;" align="center">${item.quantity}</td>
              <td style="width: 20%;">¥${item.truePrice.toFixed(2)}</td>
            </tr>
          `;
          })
          .join('')}
      </tbody>
    </table>
  `;

  // 计算表格高度，每行约2.5mm（考虑字体大小调整）
  const tableHeight = (data.orderDetails.length + 1) * lineHeight; // 表头1行 + 数据行，转换为LODOP单位
  // 添加订单项目表格
  lodop.ADD_PRINT_TABLE(yPos, 0, width, tableHeight, tableHtml);
  yPos += tableHeight;
  // 分隔线
  // lodop.ADD_PRINT_TEXT(yPos, 0, width, DIVISION_ROW, DIVISION_LINE);
  yPos += DIVISION_ROW;

  // 房间信息
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `房间编号: ${data.bedName}`);
  yPos += lineHeight;

  // 支付明细
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, '支付明细');
  lodop.SET_PRINT_STYLEA(0, 'Bold', 1);
  yPos += lineHeight;
  data.payments.forEach((pay) => {
    const text = `${pay.paymentName}支付: ¥${pay.totalAmount.toFixed(2)}`;
    lodop.ADD_PRINT_TEXT(yPos, 2 * LODOP_UNIT, width, lineHeight, text);
    yPos += lineHeight;
  });

  // 分隔线
  // lodop.ADD_PRINT_TEXT(yPos, 0, width, DIVISION_ROW, DIVISION_LINE);
  yPos += DIVISION_ROW;

  // 金额统计
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `原价总计: ¥${data.totalAmount.toFixed(2)}`);
  yPos += lineHeight;
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `实付总计: ¥${data.actualAmount.toFixed(2)}`);
  yPos += lineHeight;
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `节省总计: ¥${data.discountAmount.toFixed(2)}`);
  yPos += lineHeight;
  yPos += DIVISION_ROW;

  // 系统单号与收银员
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `系统单号: ${data.orderCode}`);
  yPos += lineHeight;
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `收银员: ${data.userName}`);
  yPos += lineHeight;
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `开单时间: ${data.orderTime}`);
  yPos += lineHeight;

  yPos += DIVISION_ROW;
  // 顾客签名
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, '顾客签名: ______________');
  yPos += lineHeight;

  // 感谢语
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, '恭侯您下次光临');
  yPos += lineHeight;

  // 服务信息
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `服务电话: ${data.servicePhone || data.orgNumber || ''}`);
  yPos += lineHeight;
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, `门店地址: ${data.orgAddress}`);
  yPos += lineHeight;

  yPos += DIVISION_ROW;

  // 加盟信息
  lodop.ADD_PRINT_TEXT(yPos, 0, width, lineHeight, '加盟门店 自主经营');
  // return lodop;
};
