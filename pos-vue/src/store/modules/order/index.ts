import Message from '@/components/Message';
import { cloneDeep, isEmpty } from 'lodash';
import { defineStore } from 'pinia';
import { ref, computed } from 'vue';
import {
  reqOrderInfo,
  reqAddOrder,
  reqAddOrderDetail,
  reqSettleOrder,
  reqDeleteOrderDetail,
  reqCancelOrder,
  reqQueryOrder,
  reqQueryOrderByBedId,
} from '@/api/order/index';
import { parseResObj } from '@/utils/parseResponse';
import { mul, div, add } from '@/utils/bigMethods';
import { CustomerType, DiscountType, IsDiscount, OrderDetailType, ResponseCode } from '@/enums';
import { orderResToOrder } from '@/store/modules/order/utils';
import { useSettingStore } from '@/store/modules/acl/setting';
import { useDataEnumStore } from '@/store/modules/enums/index';
import { useMemberStore } from '@/store/modules/member/member';

/**
 * 订单管理模块 - Pinia Store
 * 负责处理订单的创建、修改、重置等操作
 */
export const useOrderStore = defineStore('Order', () => {
  // #region 状态管理
  const settingStore = useSettingStore();
  const enumStore = useDataEnumStore();
  const memberStore = useMemberStore();

  /**
   * 定义服务类型映射
   */
  const serviceMap: any = {
    [OrderDetailType.Product]: enumStore.productList,
    [OrderDetailType.Service]: enumStore.serviceItemList,
    [OrderDetailType.TreatmentCoupon]: enumStore.treatmentCouponList,
  };

  /**
   * 初始化服务类型映射
   */
  const initServiceMap = () => {
    serviceMap[OrderDetailType.Product] = enumStore.productList;
    serviceMap[OrderDetailType.Service] = enumStore.serviceItemList;
    serviceMap[OrderDetailType.TreatmentCoupon] = enumStore.treatmentCouponList;
  };

  /**
   * 订单表单数据
   */
  const orderForm: any = ref({
    vipId: '', // 会员ID
    vipName: '', // 会员姓名
    vipCardNumber: '', // 会员卡号
    vipPhoneNumber: '', // 会员手机号
    customerType: CustomerType.Guest, // 客户类型
    customerName: '散客', // 客户姓名
    bedId: '', // 床位ID
    bedName: '', // 床位名称
    remark: '', // 备注
    orderDetails: [], // 订单明细列表
  });

  /**
   * 订单明细表单数据
   */
  const detailForm: any = ref({
    bid: '', // 订单业务ID（产品ID、服务ID或疗程券ID）
    userId: '', // 用户ID
    userName: '', // 用户姓名
    detailType: 1, // 明细类型
    businessName: '', // 业务名称
    stdPrice: 0, // 标准价格
    truePrice: 0, // 实际价格
    quantity: 1, // 数量
    serverType: 0, // 服务类型
  });

  // 会员信息
  const member: any = ref({});
  // 选中资产信息
  const checkedAssetInfo = ref<any>({
    assetIds: [], // 资产ID
    assetTitle: '', // 资产类型
    assetAmount: 0, // 资产金额
    assetDiscountRate: 0, // 资产折扣率
  });
  const resetCheckedAssetInfo = () => {
    checkedAssetInfo.value = {
      assetIds: [],
      assetTitle: '',
      assetAmount: 0,
      assetDiscountRate: 0,
    };
  };
  // 应付金额
  const payAmount: any = computed(() => {
    let amount = 0;
    order.value.details.forEach((item: any) => {
      amount = add(amount, mul(item.truePrice, item.quantity));
    });
    return amount;
  });
  // 订单折扣金额
  const discountAmount: any = computed(() => {
    let amount = order.value.discountAmount;
    if (order.value.ticketUseList && order.value.ticketUseList.length > 0) {
      for (const item of order.value.ticketUseList) {
        const ticket = member.value.vipTicketVOList.find((ticket: any) => ticket.id === item.ticketId);
        if (ticket) {
          amount += ticket.ticketInfo.ticketValue;
        }
      }
    }
    return amount;
  });
  // 应付金额 = 订单金额 - 订单折扣金额
  const truePayAmount: any = computed(() => {
    const result = payAmount.value - discountAmount.value;
    return result < 0 ? 0 : result;
  });
  // 订单明细数量
  const orderCount: any = computed(() => {
    return order.value.details.length || 0;
  });

  // #endregion

  // #region 订单表单验证
  /**
   * 验证订单表单数据
   * @param params 订单表单参数
   * @returns 验证结果
   */
  const validateOrderForm = (params: any) => {
    // 校验会员信息
    // if (!params.vipId || !params.vipName || !params.vipCardNumber || !params.vipPhoneNumber) {
    //   Message.error('请填写完整会员信息');
    //   return false;
    // }
    console.log('准备校验会员信息：', params);

    if (params.customerType === CustomerType.Member && !params.vipId) {
      Message.warning('请选择会员');
      return;
    } else if (params.customerType === CustomerType.Guest && !params.customerName) {
      Message.warning('请输入散客姓名');
      return;
    }

    // 校验订单明细
    // if (params.orderDetails.length === 0) {
    //   Message.error('请添加订单明细');
    //   return false;
    // } else {
    //   // 校验订单明细
    //   for (const item of params.orderDetails) {
    //     if (validSubmitOrderDetail(item)) {
    //       Message.error('请填写完整订单明细信息');
    //       return false;
    //     }
    //   }
    // }
    return true;
  };

  /**
   * 验证订单明细数据
   * @param params 订单明细参数
   * @returns 验证结果（true表示验证失败，false表示验证成功）
   */
  const validOrderDetail = (params: any) => {
    return !params.bid || params.stdPrice < 0 || params.truePrice < 0 || !params.businessName;
  };
  const validSubmitOrderDetail = (params: any) => {
    return (
      !params.bid ||
      !params.userId ||
      !params.userName ||
      params.stdPrice < 0 ||
      params.truePrice < 0 ||
      !params.businessName
    );
  };
  // #endregion

  // #region 开单操作
  /**
   * 创建订单
   * @param cb 回调函数
   */
  const createOrder = (cb: Function) => {
    if (!validateOrderForm(orderForm.value)) {
      return;
    }

    // 移除索引
    for (const item of orderForm.value.orderDetails) {
      delete item.index;
    }

    settingStore.loading = true;

    // 发送请求创建订单
    reqAddOrder(orderForm.value)
      .then((res) => {
        const result: any = parseResObj(res);
        if (Object.keys(result).length !== 0) {
          Message.success('订单创建成功');
          cb();
          resetOrderForm();
        } else {
          // Message.error(result.message || '订单创建失败');
        }
      })
      .catch((err) => {
        Message.error(err.message || '订单创建失败');
      })
      .finally(() => {
        settingStore.loading = false;
      });
  };

  /**
   * 重置订单表单
   */
  const resetOrderForm = () => {
    orderForm.value = {
      vipId: '',
      vipName: '',
      vipCardNumber: '',
      vipPhoneNumber: '',
      customerType: 0,
      bedId: '',
      bedName: '',
      remark: '',
      orderDetails: [],
    };
  };
  // #endregion

  // #region 订单明细操作
  const parseServiceData = (serviceItem: any) => {
    return {
      name: serviceItem?.name || serviceItem?.productName || serviceItem?.itemName || '',
      stdPrice: serviceItem?.productPrice || serviceItem?.itemPrice || serviceItem?.price || 0,
      vipPrice:
        serviceItem?.vipProductPrice || serviceItem?.vipItemPrice || serviceItem?.vipPrice || serviceItem.price || 0,
    };
  };

  /**
   * 处理订单明细参数
   * @param params 订单明细参数
   * @returns 处理后的订单明细参数
   */
  const handleDetailParam = (params: any) => {
    console.log('订单项原始参数:', params);

    const result: any = {};
    // 查找用户和服务项
    const user = enumStore.staffList.find((item: any) => item.id === params.userId);
    if (user) {
      result.userId = user.id;
      result.userName = user.userName;
    }

    console.log('服务项映射', serviceMap);

    const serviceItem = serviceMap[params.detailType].find((item: any) => item.id === params.bid);
    console.log('服务项:', serviceItem);

    if (isEmpty(serviceItem)) {
      Message.warning('服务项不存在');
      return;
    }
    const serviceData = parseServiceData(serviceItem);

    result.bid = params.bid; // 订单业务ID（产品ID、服务ID或疗程券ID）
    result.detailType = params.detailType; // 明细类型
    result.businessName = serviceData.name; // 业务名称
    result.stdPrice = serviceData.stdPrice; // 标准价格
    result.truePrice = serviceData.stdPrice; // 实际价格
    result.quantity = params.quantity || 1; // 数量
    if (params.serverType !== undefined || params.serverType !== null) {
      result.serverType = params.serverType || 0; // 服务类型
    }
    // 设置价格
    if (orderForm.value.customerType === CustomerType.Member) {
      result.stdPrice = serviceData.stdPrice;
      result.truePrice = serviceData.vipPrice;
    }
    console.log('添加项:', params);
    console.log('添加订单:', result);

    return result;
  };

  /**
   * 添加订单明细
   * @param detail 订单明细数据
   * @returns 操作结果
   */
  const addOrderDetail = (detail: any) => {
    // if (!orderForm.value.vipId || orderForm.value.customerName == '') {
    //   Message.error('请先选择会员或者输入散客姓名');
    //   return false;
    // }

    // 处理订单明细参数
    const data = handleDetailParam(detail);
    console.log('处理后的订单明细:', data);

    // 校验明细是否完整
    if (validOrderDetail(data)) {
      Message.error('请填写完整订单明细');
      return false;
    }
    // 生成订单明细索引
    const index = orderForm.value.orderDetails.length;
    // 添加订单明细
    detail = { index, ...data };
    orderForm.value.orderDetails.push(detail);
    return true;
  };

  /**
   * 更新订单明细
   * @param detail 订单明细数据
   * @returns 操作结果
   */
  const updateOrderDetail = (detail: any) => {
    // 校验明细是否完整
    if (validOrderDetail(detail)) {
      Message.error('请填写完整订单明细');
      return false;
    }

    orderForm.value.orderDetails[detail.index] = detail;
    return true;
  };

  /** 更新订单明细的折扣价格 */
  const updateOrderDetailPrice = () => {
    // 如果未选择会员卡或者订单详情为空则停止
    if (
      checkedAssetInfo.value.assetIds.length === 0 ||
      order.value.details.length === 0 ||
      (member.value && member.value.vipAssetVOList && member.value.vipAssetVOList.length === 0)
    ) {
      console.warn('更新订单明细价格前置条件不满足');
      return;
    }

    try {
      // 查找当前选择的会员卡
      const assets = member.value.vipAssetVOList;
      const asset = assets.find((item: { id: number }) => item.id === checkedAssetInfo.value.assetIds[0]);
      console.log('updateOrderItemPrice - 当前选择会员卡：', asset);

      // 折算基础
      const discountBase = asset.assetDiscountBase;
      // 折算率
      const discountRate = asset.assetDiscountRate / 100;

      // 订单明细
      const details = order.value.details;
      console.log('updateOrderItemPrice - 当前订单明细：', details);

      for (const detail of details) {
        // 获取当前订单项目的原始参数
        const curServiceList = serviceMap[detail.detailType];
        const curService = curServiceList.find((item: { id: number }) => item.id === detail.bid);

        // 如果设置为不打折则不进行更新
        if (curService.isDiscounts === IsDiscount.noDiscount || curService.isDiscount === IsDiscount.noDiscount) {
          continue;
        }
        // 解析参数
        const parseCurService = parseServiceData(curService);
        // console.log();

        // 更新明细价格
        if (curService) {
          const discountPrice =
            discountBase === DiscountType.Member
              ? mul(parseCurService.vipPrice, discountRate)
              : mul(parseCurService.stdPrice, discountRate);
          detail.truePrice = discountPrice;
          console.log('更新订单明细价格：', detail);
        }
      }
    } catch (error) {
      console.error(error);
    }
  };

  /**
   * 重置订单明细表单
   */
  const resetDetailForm = () => {
    detailForm.value = {
      bid: '',
      userId: '',
      userName: '',
      detailType: 1,
      businessName: '',
      stdPrice: 0,
      truePrice: 0,
      quantity: 1,
      serverType: 0,
    };
  };
  // #endregion

  // #region 结算操作

  // 订单结算信息
  const order: any = ref({
    orderId: null,
    vipId: 0,
    bedId: 0,
    bedName: '',
    customerType: CustomerType.Guest,
    customerName: '散客',
    remark: '',
    totalAmount: 0,
    actualAmount: 0,
    discountAmount: 0,
    orderTime: null,
    details: [],
    ticketUseList: [],
    assetIds: [],
    paymentInfoList: [],
  });
  /**
   * 添加订单明细
   * @param detail 订单明细数据
   * @returns 操作结果
   */
  const addOrderItem = (detail: any) => {
    if (
      (order.value.customerType === CustomerType.Member && !order.value.vipId) ||
      (order.value.customerType === CustomerType.Guest && !order.value.customerName)
    ) {
      Message.error('请先选择会员或输入散客名称');
      return false;
    }

    // 处理订单明细参数
    const data = handleDetailParam(detail);

    // 校验明细是否完整
    if (validOrderDetail(data)) {
      Message.error('请填写完整订单明细');
      return false;
    }
    // 生成订单明细索引
    const index = order.value.details.length;
    // 添加订单明细
    detail = { index, ...data };
    order.value.details.push(detail);
    updateOrderDetailPrice();
    return true;
  };

  const settleOrder = async () => {
    // order.value
    // order.value.truePayAmount =
    order.value.assetIds = checkedAssetInfo.value.assetIds;
    order.value.totalAmount = payAmount.value;
    order.value.actualAmount = truePayAmount.value;
    order.value.discountAmount = discountAmount.value;
    console.log('结算订单:', order.value);
    try {
      const res: any = await reqSettleOrder(order.value);
      // parseResObj()
      console.log('结算订单结果：', res);

      if (res.code === ResponseCode.SUCCESS) {
        console.log('结算订单成功:', res);
        Message.success('订单结算成功');
        resetOrderStatus();
        return res.data;
      } else {
        console.log('结算订单失败:', res);
        Message.error(`订单结算失败：${res.message}`);
        return {};
      }
    } catch (error) {
      console.error('结算订单报错', error);
      return {};
    }
  };

  const setOrderByBed = async (bedId: number) => {
    const orderRes = await getOrder(bedId);
    if (Object.keys(orderRes).length <= 0) {
      return;
    }
    order.value = orderResToOrder(orderRes);
    if (order.value.vipId) {
      await getMemberAsset(order.value.vipId);
    }
  };

  const resetOrder = () => {
    order.value = {
      orderId: null,
      vipId: 0,
      bedId: 0,
      bedName: '',
      customerType: CustomerType.Guest,
      customerName: '散客',
      remark: '',
      totalAmount: 0,
      actualAmount: 0,
      discountAmount: 0,
      orderTime: null,
      details: [],
      ticketUseList: [],
      assetIds: [],
      paymentInfoList: [],
    };
  };
  // #endregion 结算操作

  // #region 远程请求数据

  /** 获取会员资产 */
  const getMemberAsset = async (id: number) => {
    const asset = await memberStore.getMemberAssetList(id);
    if (asset && asset?.vipAssetVOList) {
      asset.vipAssetVOList = asset.vipAssetVOList.map((item: any, index: number) => ({
        ...item,
        disabled: false,
        discountValue: `${item.id}-${item?.assetDiscountBase}-${item?.assetDiscountRate}`,
      }));
    }
    if (asset && asset?.vipTicketVOList) {
      asset.vipTicketVOList = asset.vipTicketVOList.filter((item: any) => {
        return item.status != '已使用';
      });
    }
    console.log('会员资产', asset);
    member.value = { ...asset.vipInfoVO, ...asset };
  };

  /** 获取订单信息（请求服务器） */
  const getOrder = async (bedId: number) => {
    if (!bedId) {
      console.error('床位ID无效');
      return {};
    }
    try {
      const { code, data }: any = await reqQueryOrderByBedId(bedId);
      console.log('查询订单:', data);
      if (data) {
        return data;
      }
    } catch (error) {
      Message.error('查询订单失败');
    }
    return {};
  };

  // #endregion 远程请求数据

  // #region 导出状态和方法
  /**
   * 重置订单状态
   */
  const reset = () => {
    resetOrder();
    resetOrderForm();
    resetDetailForm();
    member.value = {};
    resetCheckedAssetInfo();
  };

  const resetOrderStatus = () => {
    resetOrder();
    resetCheckedAssetInfo();
  };

  return {
    // 订单表单状态
    orderForm,
    createOrder,
    resetOrderForm,

    // 订单明细状态
    detailForm,
    resetDetailForm,
    addOrderDetail,
    updateOrderDetail,
    updateOrderDetailPrice,

    // 会员状态
    member,
    getMemberAsset,
    // 应付金额
    payAmount,
    discountAmount,
    truePayAmount,
    // 订单总金额
    orderCount,
    reset,
    checkedAssetInfo,
    initServiceMap,

    order,
    getOrder,
    setOrderByBed,
    addOrderItem,
    resetOrder,
    settleOrder,
    resetCheckedAssetInfo,
  };
  // #endregion
});
