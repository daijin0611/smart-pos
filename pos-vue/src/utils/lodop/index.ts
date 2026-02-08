// src/utils/lodop.ts
// @ts-ignore 忽略js文件检查
import { getLodop } from './LodopFuncs.js';
import { OrderData, RechargeData, Config } from './types';
import { generateOrderHtmlTemplate, generateRechargeHtmlTemplate } from './GenerateTemplate';
import { orderTemplate } from './GenerateLodopTemplate';
import { getOrgInfo } from '@/utils/localStorageTools';
import ElMessage from '@/components/Message'; // 若使用Element Plus，可用于提示

export class LodopPrinter {
  private LODOP: LODOP | null = null;

  constructor() {
    this.init();
  }

  /** 初始化Lodop控件 */
  private init(): void {
    this.LODOP = getLodop();
    if (!this.LODOP) {
      setTimeout(() => {
        this.LODOP = getLodop();
        if (!this.LODOP) {
          ElMessage.error('Lodop打印控件未安装或未启动');
        }
      }, 300);
    }
  }

  /**
   * 获取打印机列表
   * @returns 打印机列表
   */
  getPrinters(): string[] {
    if (!this.LODOP) return [];
    const count = this.LODOP.GET_PRINTER_COUNT();
    return Array.from({ length: count }, (_, i) => this.LODOP!.GET_PRINTER_NAME(i));
  }

  /** 设置打印机 */
  setPrinter(index: number): void {
    this.LODOP?.SET_PRINTER_INDEX(index);
  }

  /**
   * 获取打印配置（单位：毫米）
   * @param data 数据
   * @param type 1:订单 2:充值单
   * @returns 打印配置
   */
  getPrintConfig(data: OrderData | RechargeData, type: 1 | 2) {
    const config: Config = {
      width: 58,
      height: 0,
    };

    // 从门店信息里获取默认打印宽度
    const org = getOrgInfo();
    if (org) {
      config.width = org.printWidth || 58;
    }

    // 计算打印高度
    if (type === 1) {
      config.height = this.calculateOrderPrintHeight(data as OrderData) || 0;
    } else if (type === 2) {
      config.height = this.calculateRechargePrintHeight(data as RechargeData) || 0;
    }

    return config;
  }

  /**
   * 打开打印设计窗口
   */
  printDesign() {
    if (!this.LODOP) {
      ElMessage.error('Lodop控件初始化失败');
      return;
    }

    this.LODOP.PRINT_INIT(new Date().getTime().toString());
    this.LODOP.PRINT_DESIGN();
  }

  /**
   * 打印HTML模板
   * @param data 订单数据
   * @param preview 是否预览
   */
  printOrderByHTML(data: OrderData, preview = false): void {
    if (!this.LODOP) {
      ElMessage.error('Lodop控件初始化失败');
      return;
    }

    // 开启预览打印
    // preview = true;

    // 获取打印配置（单位：毫米）
    const { width, height } = this.getPrintConfig(data, 1);
    // LODOP的打印页面宽度
    const printWidth = `${width - 10}mm`;
    // LODOP的打印页面高度
    // const printHeight = `${height ? height - 20 : height}mm`;
    const printHeight = `${height}mm`;

    console.log('打印尺寸：', { printWidth, printHeight });

    // LODOP的打印任务名称
    const taskName = `${data.orderCode}-${data.orgName}消费单`;
    // 初始化打印任务
    this.LODOP.PRINT_INIT(taskName);
    // 设置打印页面大小
    this.LODOP.SET_PRINT_PAGESIZE(0, printWidth, printHeight);
    // 按纸张定位，而非屏幕
    this.LODOP.SET_PRINT_MODE('POS_BASEON_PAPER', 1);
    // 关闭自动缩放，强制1:1打印
    this.LODOP.SET_PRINT_MODE('PRINT_PAGE_PERCENT', 100);

    // 生成HTML模板
    const html = generateOrderHtmlTemplate(data, printWidth);
    // 添加HTML模板
    this.LODOP.ADD_PRINT_HTM(0, 0, printWidth, printHeight, html);
    // 执行打印或预览
    preview ? this.LODOP.PREVIEW() : this.LODOP.PRINT();
  }

  /**
   * 打印HTML模板
   * @param data 充值数据
   * @param preview 是否预览
   */
  printRechargeByHTML(data: RechargeData, preview = false): void {
    if (!this.LODOP) {
      ElMessage.error('Lodop控件初始化失败');
      return;
    }

    // 开启预览打印
    // preview = true;

    // 获取打印配置（单位：毫米）
    const { width, height } = this.getPrintConfig(data, 2);
    // LODOP的打印页面宽度
    const printWidth = `${width - 10}mm`;
    // LODOP的打印页面高度
    // const printHeight = `${height ? height - 10 : height}mm`;
    const printHeight = `${height}mm`;

    // console.log('打印尺寸：', { printWidth, printHeight });

    // 打印任务名称
    const taskName = `${data.historyCode}-${data.orgName}充值单`;
    // 初始化打印任务
    this.LODOP.PRINT_INIT(taskName);
    // 设置打印页面大小
    this.LODOP.SET_PRINT_PAGESIZE(0, printWidth, printHeight);
    // 按纸张定位，而非屏幕
    this.LODOP.SET_PRINT_MODE('POS_BASEON_PAPER', 1);
    // 关闭自动缩放，强制1:1打印
    this.LODOP.SET_PRINT_MODE('PRINT_PAGE_PERCENT', 100);

    // 生成HTML模板
    const html = generateRechargeHtmlTemplate(data, printWidth);
    // 添加HTML模板
    this.LODOP.ADD_PRINT_HTM(0, 0, printWidth, printHeight, html);
    // 执行打印或预览
    preview ? this.LODOP.PREVIEW() : this.LODOP.PRINT();
  }

  /**
   * 打印订单（基于Lodop ADD_PRINT_TEXT() 方法）
   * @param data 订单数据
   * @param preview 是否预览
   */
  printReceipt(data: OrderData, preview = false): void {
    if (!this.LODOP) {
      ElMessage.error('Lodop控件初始化失败');
      return;
    }

    // 获取打印配置（单位：毫米）
    const config = this.getPrintConfig(data, 1);
    console.log('打印配置:', config);

    // 生成订单打印模板
    orderTemplate(this.LODOP, data, config);
    // 执行打印或预览
    preview ? this.LODOP.PREVIEW() : this.LODOP.PRINT();
  }

  /**
   * 生成订单HTML模板字符串
   * @param data 订单数据
   * @returns 完整的HTML模板
   */
  generateOrderHtmlTemplate: (data: OrderData) => string = generateOrderHtmlTemplate;

  /**
   * 生成充值单HTML模板字符串
   * @param data 充值数据
   * @returns 完整的HTML模板
   */
  generateRechargeHtmlTemplate: (data: RechargeData) => string = generateRechargeHtmlTemplate;

  /**
   * 计算订单打印所需的高度（单位：毫米）
   * @param data 订单数据
   * @returns 估算的打印高度（毫米）
   */
  private calculateOrderPrintHeight(data: OrderData): number {
    let baseHeight = 120; // 基础内容高度（固定部分）
    const detailRowHeight = 6; // 每行订单明细的高度（毫米）
    const paymentRowHeight = 6; // 每行支付明细的高度（毫米）
    const faultTolerance = 0; // 容错空间

    // 动态部分高度
    const detailHeight = data.orderDetails.length * detailRowHeight;
    const paymentHeight = data.payments.length * paymentRowHeight;

    // 总高度 = 基础高度 + 动态部分高度 + 容错空间
    return baseHeight + detailHeight + paymentHeight + faultTolerance;
  }

  /**
   * 计算充值单打印所需的高度（单位：毫米）
   * @param data 充值数据
   * @returns 估算的打印高度（毫米）
   */
  private calculateRechargePrintHeight(data: RechargeData): number {
    let baseHeight = 140; // 基础内容高度（固定部分）
    const paymentRowHeight = 6; // 每行支付明细的高度（毫米）
    const kpiRowHeight = 6; // 每行业绩归属的高度（毫米）
    const faultTolerance = 5; // 容错空间

    // 动态部分高度
    const paymentHeight = data.paymentInfoList.length * paymentRowHeight;
    const kpiHeight = data.userKpiList.length * kpiRowHeight;

    // 总高度 = 基础高度 + 动态部分高度 + 容错空间
    return baseHeight + paymentHeight + kpiHeight + faultTolerance;
  }
}
