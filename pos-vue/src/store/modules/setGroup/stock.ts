import { defineStore } from 'pinia';
import {
  reqInStockAdd,
  reqInStockInfo,
  reqInStockList,
  reqOutStockAdd,
  reqOutStockInfo,
  reqOutStockList,
  reqStockLogList,
} from '@/api/setGroup/stock';
import { parseResMsg, parseResList, parseResObj } from '@/utils/parseResponse';

import {
  SearchParams,
  InStockAddRequest,
  InStockItemCreateDTO,
  OutStockAddRequest,
  OutStockItemCreateDTO,
} from '@/api/setGroup/stock/type';

export const useStockStore = defineStore('Stock', () => {
  /**
   * 获取入库信息
   * @param orderCode
   * @returns
   */
  const getInStockInfo = async (orderCode: string) => {
    const res = await reqInStockInfo(orderCode);
    const result = parseResObj(res);
    return result;
  };

  /**
   * 获取入库列表
   * @param params
   * @returns
   */
  const getInStockList = async (params: SearchParams) => {
    const res = await reqInStockList(params);
    const data = parseResObj(res);
    return data;
  };

  /**
   * 新增入库
   * @param params
   * @returns
   */
  const addInStock = async (params: InStockAddRequest) => {
    const res = await reqInStockAdd(params);
    const result = parseResMsg(res, '新增入库成功');
    return result;
  };

  /**
   * 获取出库信息
   * @param orderCode
   * @returns
   */
  const getOutStockInfo = async (orderCode: string) => {
    const res = await reqOutStockInfo({ orderCode });
    const result = parseResObj(res);
    return result;
  };

  /**
   * 获取出库列表
   * @param params
   * @returns
   */
  const getOutStockList = async (params: SearchParams) => {
    const res = await reqOutStockList(params);
    const data = parseResObj(res);
    return data;
  };

  /**
   * 新增出库
   * @param params
   * @returns
   */
  const addOutStock = async (params: OutStockAddRequest) => {
    const res = await reqOutStockAdd(params);
    const result = parseResMsg(res, '新增出库成功');
    return result;
  };

  /**
   * 获取库存流水列表
   * @param params
   * @returns
   */
  const getStockLogList = async (params: SearchParams) => {
    const res = await reqStockLogList(params);
    const data = parseResObj(res);
    return data;
  };

  return {
    getInStockInfo,
    getInStockList,
    addInStock,
    getOutStockInfo,
    getOutStockList,
    addOutStock,
    getStockLogList,
  };
});
