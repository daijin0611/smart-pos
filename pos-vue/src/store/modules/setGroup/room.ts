import { defineStore } from 'pinia';
import { ref } from 'vue';
import { parseResList, parseResMsg } from '@/utils/parseResponse';
import {
  reqRoomList,
  reqAddRoom,
  reqUpdateRoom,
  reqBedListAll,
  reqBedList,
  reqAddBed,
  reqUpdateBed,
  reqUpdateBedStatus,
} from '@/api/setGroup/room';

import { useSettingStore } from '@/store/modules/acl/setting';
const settingStore = useSettingStore();

export const useRoomStore = defineStore('Room', () => {
  // 搜索参数
  const searchParams = ref({
    storeId: 0,
    roomName: '',
  });

  /**
   * 所有床位列表
   */
  const allBedList: any = ref([]);
  /**
   * 所有床位列表
   */
  const setAllBedList = async () => {
    settingStore.loading = true;
    const res = await reqBedListAll();
    const data = parseResList(res);
    allBedList.value = data
      .filter((item: any) => item.status !== 2)
      .sort((a: any, b: any) => a.roomInfoId - b.roomInfoId);
    settingStore.loading = false;
  };

  /**
   * 所有床位列表
   */
  const getAllBedList = async () => {
    const res = await reqBedListAll();
    const data = parseResList(res);
    return data.filter((item: any) => item.status !== 2).sort((a: any, b: any) => a.roomInfoId - b.roomInfoId);
  };

  /**
   * 房间列表
   */
  const roomList: any = ref([]);
  /**
   * 获取房间列表
   */
  const setRoomList = async () => {
    settingStore.loading = true;
    // 获取房间列表
    const res = await reqRoomList(searchParams.value);
    let data = parseResList(res);
    // 处理数据
    roomList.value = data;
    settingStore.loading = false;
  };

  /**
   * 更新房间信息
   * @param { object } data - 房间信息
   * @returns 是否成功
   */
  const updateRoom = async (data: any) => {
    // 浅拷贝避免修改原数据
    data = { ...data };
    // 发送请求
    const res = await (data?.id ? reqUpdateRoom(data) : reqAddRoom(data));
    const result = parseResMsg(res);
    // 刷新数据
    result && setRoomList();
    return result;
  };

  /**
   * 床位列表
   */
  const bedList: any = ref([]);
  /**
   * 获取床位列表
   * @param { number } id - 房间id
   */
  const setBedList = async (id: number) => {
    settingStore.loading = true;
    // 获取床位列表
    const res = await reqBedList({ roomId: id });
    const data = parseResList(res);
    // 处理数据
    bedList.value = data;
    settingStore.loading = false;
  };

  /**
   * 更新床位信息
   * @param { object } data - 床位信息
   * @returns 是否成功
   */
  const updateBed = async (data: any) => {
    // 处理请求参数
    data = { ...data };
    data.status = data?.id ? data.status : 0;
    // 发送请求
    const res = await (data?.id ? reqUpdateBed(data) : reqAddBed(data));
    const result = parseResMsg(res);
    // 刷新数据
    result && setBedList(data.roomInfoId || data.roomId);
    result && setRoomList();
    return result;
  };

  /**
   * 更新床位状态
   * @param { object } data - 床位id、状态、房间id
   * @returns 是否成功
   */
  const updateBedStatus = async (data: { id: number; status: number; roomInfoId: number }) => {
    // 处理请求参数
    const bedId = data.id;
    let status = data.status;
    status !== 1 && (status = status === 0 ? 2 : 0);
    const params = { bedId, status };
    // 发送请求
    const res = await reqUpdateBedStatus(params);
    const result = parseResMsg(res);
    // 刷新数据
    result && setBedList(data.roomInfoId);
    result && setRoomList();
    return result;
  };

  return {
    searchParams,
    roomList,
    setRoomList,
    updateRoom,
    bedList,
    setBedList,
    updateBed,
    updateBedStatus,
    allBedList,
    setAllBedList,
    getAllBedList,
  };
});
