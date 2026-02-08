<template>
  <div class="row-item">
    <div class="item-top">
      <!-- 商品信息 -->
      <span>
        <span>{{ index }}、{{ data?.businessName || '产品名称' }}</span>
      </span>
      <!-- 优惠券 -->
      <span class="item-coupon-info">
        <CouponSelect @change="selectCoupon"></CouponSelect>
      </span>
      <!-- 平台券 -->
      <!-- <span class="item-coupon-platform">
        <el-popover placement="left" title="请选择平台券" :width="200" trigger="click">
          <template #reference>
            <el-button type="primary" link size="large" icon="GoodsFilled" style="transform: scale(1.3)" />
          </template>
          <div>
            <div class="coupon-platform-base-row">
              实收:
              <el-input-number
                v-model="data.truePrice"
                :min="1"
                :controls="false"
                @change="handleCouponPriceChange"
                style="width: 100px"
              />
              元
            </div>
            <div><div class="coupon-platform-row">美团券</div></div>
            <div class="coupon-platform-row">口碑券</div>
            <div class="coupon-platform-row">抖音券</div>
            <div class="coupon-platform-row">连连券</div>
            <div class="coupon-platform-row">实体体验券</div>
          </div>
        </el-popover>
      </span> -->
      <!-- 自定义价格 -->
      <span class="item-price">
        <el-input-number v-model="data.truePrice" :min="0" controls-position="right" style="width: 120px" />
      </span>
      <!-- 删除按钮 -->
      <span class="item-del">
        <el-icon @click="handleDelete"><Delete /></el-icon>
      </span>
    </div>

    <div class="item-bottom">
      <div class="bottom-left">
        <label>
          <span>销售：</span>
          <el-select v-model="data.userId" value-key="id" @change="handleChangeUser" clearable placeholder="请选择销售">
            <el-option v-for="item in dataEnumStore.staffList" :key="item.id" :label="item.userName" :value="item.id" />
          </el-select>
        </label>
        <label class="m-l-10" style="width: 160px">
          <span class="m-r-5">数量:</span>
          <el-input-number
            v-model="data.quantity"
            :min="1"
            :max="1000"
            :step="1"
            controls-position="right"
            style="width: 120px"
          />
        </label>
      </div>
      <div class="bottom-right">
        <template v-if="data?.coupon">
          <el-tag type="primary" closable @close="handleCloseTag">
            <span>{{ data?.coupon?.ticketName || '无' }}</span>
          </el-tag>
        </template>
      </div>
    </div>

    <!-- 标签 -->
    <div :class="isPT.class">{{ isPT.text }}</div>
  </div>
</template>

<script setup lang="ts">
import CouponSelect from '@/views/saleMain/components/CouponSelect.vue';
import { computed, ref, watch } from 'vue';
import { OrderDetailType } from '@/enums/index';
import { useDataEnumStore } from '@/store/modules/enums/index';
import { useOrderStore } from '@/store/modules/order/index';
const dataEnumStore = useDataEnumStore();
const orderStore = useOrderStore();
/**
 * 订单明细项接口
 */
interface OrderDetailItem {
  bid: number; // 订单业务ID（产品ID、服务ID或疗程券ID）
  userId: number; // 用户ID
  userName: string; // 用户姓名
  detailType: number; // 明细类型
  businessName: string; // 业务名称
  stdPrice: number; // 标准价格
  truePrice: number; // 实际价格
  quantity: number; // 数量
  serverType: number; // 服务类型
  coupon?: any; // 优惠券
}

interface Props {
  index: number; // 订单明细项索引
  data: OrderDetailItem; // 订单明细数据
}

/**
 * 组件属性定义
 */
const props = withDefaults(defineProps<Props>(), {});

const emit = defineEmits(['cancel-coupon', 'delete']);

const isPT = computed(() => {
  const result = { class: '', text: '' };
  if (props.data?.detailType === OrderDetailType.Product) {
    result.class = 'is-pt-prod';
    result.text = '产 品';
  } else if (props.data?.detailType === OrderDetailType.Service) {
    result.class = 'is-pt-svr';
    result.text = '项 目';
  } else if (props.data?.detailType === OrderDetailType.TreatmentCoupon) {
    result.class = 'is-pt-treat';
    result.text = '疗 程';
  }
  return result;
});

const handleChangeUser = (id: number) => {
  const user = dataEnumStore.staffList.find((user: any) => user.id === id);
  if (user) {
    props.data.userId = id;
    props.data.userName = user.userName;
  }
};

const handleCloseTag = () => {
  const index = orderStore.order.ticketUseList.findIndex((item: any) => item.ticketId === props.data.coupon.id);
  if (index !== -1) {
    orderStore.order.ticketUseList.splice(index, 1);
  }
  props.data.coupon = null;
};

const handleDelete = () => {
  // 处理删除事件
  emit('delete', props.data);
};

const selectCoupon = (coupon: any) => {
  if (props.data.coupon) {
    handleCloseTag();
  }
  props.data.coupon = coupon;
  orderStore.order.ticketUseList.push({
    ticketId: coupon.id,
    ticketType: coupon.ticketInfo.ticketType,
  });
};

watch(
  () => orderStore.order.ticketUseList,
  (newVal) => {
    if (newVal.length === 0) {
      handleCloseTag();
    }
  },
);
</script>

<style lang="scss" scoped>
.row-item {
  position: relative;
  background-color: #f7f8fa;
  height: 110px;
  margin-top: 5px;
  margin-bottom: 10px;
  border-radius: 4px;
  padding: 10px 15px;
  transition: box-shadow 0.2s ease-in-out;
  min-width: 360px;
}

.row-item:hover {
  box-shadow: 0 0 10px #ddd;
}

.row-item .item-top {
  position: relative;
  height: 40px;
  border-bottom: 1px solid #e6e6e6;
  color: #666;
  display: flex;
  align-items: center;
  // border: 1px red solid;
}

.item-top .item-discount {
  margin-left: 5px;
  font-size: 12px;
  color: #a1c7c7;
}

.row-item .item-bottom {
  position: relative;
  height: 40px;
  display: flex;
  align-items: center;
}

.order-makesure {
  height: 50px;
  flex: none;
  display: flex;
  align-items: center;
  padding: 15px;
  border-top: 1px solid #ddd;
}

.order-makesure > div {
  flex: 1;
  font-size: 18px;
  color: #666;
}

.item-price {
  position: absolute;
  right: 45px;
  color: #c44f4f;
}

.item-price .edit-price-icon {
  opacity: 0;
  cursor: pointer;
  transition: all 0.3s ease-in-out;
}

.item-price:hover .edit-price-icon {
  opacity: 1;
}

.custom-price {
  color: #37c4a5;
}

.item-coupon-info {
  position: absolute;
  right: 175px;
}

.item-coupon-info .coupon-tag {
  color: #fa2b93;
  cursor: pointer;
  font-size: 18px;
}

.item-coupon-platform {
  position: absolute;
  right: 205px;
}

.item-coupon-platform .coupon-platform {
  color: #e64e12;
  cursor: pointer;
  font-size: 18px;
}

.item-coupon-platform .coupon-platform-disable {
  color: #4d4948;
  cursor: not-allowed;
  font-size: 18px;
}

.coupon-platform-base-row {
  margin: 15px 0;
  margin-left: 10px;
}

.custom-row--btn {
  margin: 15px 0;
  margin-left: 10px;
  margin-bottom: 10px;
  text-align: center;
}

.coupon-platform-row {
  width: 130px;
  height: 30px;
  line-height: 30px;
  font-size: 13px;
  font-weight: 700;
  color: #ba75f1;
  margin: 8px 0;
  border-radius: 3px;
  box-shadow: 0 0 5px #e0cfff;
  cursor: pointer;
  text-align: center;
  margin-left: 10px;
  background-color: #fff;
  transition: all 0.3s ease-in-out;
}

.coupon-platform-row-sel {
  font-size: 14px;
  font-weight: 700;
  color: #e4c7fc;
  background-color: #930cd1;
}

.coupon-off-select {
  margin-top: 15px;
  text-align: center;
}

.item-del {
  position: absolute;
  right: 5px;
  color: #999;
  cursor: pointer;
  transition: color 0.3s ease-in-out;
}

.item-del:hover {
  color: #7254a8;
}

.item-bottom > div {
  flex: 1;
  margin-top: 10px;
}

.bottom-left {
  color: #999;
  font-size: 14px;
  min-width: 260px;
}

.bottom-left .el-select {
  max-width: 140px;
}

.el-select-dropdown__list .item-select-option-panel {
  padding: 10px;
  height: unset;
  line-height: unset;
}

.bottom-right {
  position: absolute;
  right: 15px;
}

.item-svttype-sw .el-switch__label {
  color: #ccc;
}

.item-svttype-sw .el-switch__label.is-active {
  color: #8c70d8;
}

.header-mem-area .member-info-box {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.member-info-box .member-info-item {
  position: relative;
  width: 70%;
  min-width: 340px;
  max-width: 400px;
  height: 50px;
  line-height: 50px;
  text-align: center;
  background-color: #fcf8fc;
  color: #666;
  font-size: 13px;
  border-radius: 4px;
}

.member-info-item > span {
  margin-right: 10px;
}

.member-info-item > .clear-member {
  display: inline-block;
  position: absolute;
  margin-right: unset;
  right: 10px;
  font-size: 18px;
}

.member-info-item > .clear-member:hover {
  color: var(--main-info-color);
}

.header-mem-area .input-with-select {
  width: 70%;
  min-width: 290px;
  max-width: 400px;
  height: 35px;
}

.input-with-select .el-select {
  width: 105px;
  color: #fff;
  background-color: var(--input-color);
  font-size: 16px;
  border-radius: 4px 0 0 4px;
}

.header-mem-area .input-with-select .el-input-group__append {
  color: #fff;
  background-color: var(--input-color);
  font-size: 16px;
  cursor: pointer;
}

.header-mem-area .input-with-select .el-input__inner {
  height: 35px;
  line-height: 35px;
  font-size: 14px;
}

.header-mem-area .input-with-select .el-input-group__append,
.header-mem-area .input-with-select .el-input__inner {
  transition: all 0.2s ease-in-out;
  border-color: var(--input-border-color);
}

.header-mem-area .input-with-select:hover .el-input-group__append,
.header-mem-area .input-with-select:hover .el-input__inner {
  border-color: var(--input-border-hover);
}

.header-mem-area .input-with-select .el-input__inner:focus,
.header-mem-area .input-with-select .el-input__inner:focus ~ .el-input-group__append {
  border-color: var(--input-border-hover);
  box-shadow: 0 0 5px var(--input-shadow);
}

.popover-list-box {
  height: 350px;
  display: flex;
  flex-direction: column;
}

.popover-list-title {
  margin: 10px;
  margin-bottom: 15px;
  color: #999;
  font-size: 18px;
  height: 25px;
  flex: none;
}

.popover-list-view {
  height: 100%;
  flex: auto;
  overflow: auto;
  padding-top: 5px;
}

.popover-item {
  position: relative;
  overflow: hidden;
  margin-bottom: 10px;
  margin-left: 10px;
  margin-right: 10px;
  border-radius: 5px;
  box-shadow: 0 0 5px #dce5fa;
  padding: 10px;
  transition: all 0.3s ease-out;
  background-color: #fff;
  cursor: pointer;
  min-height: 35px;
}

.popover-item:hover {
  background-color: #fcfaff;
}

.popover-item-single {
  cursor: unset;
}

.popover-item-select {
  background: #6043ca;
  color: #fff8dc;
}

.popover-item-select:hover {
  background-color: #8471ca;
}

.popover-item > div {
  margin-bottom: 5px;
}

.popover-list-view .item-bed {
  position: relative;
  line-height: 35px;
  margin-left: 20px;
}

.popover-list-view .item-bed-change {
  position: absolute;
  right: 10px;
  bottom: 0;
}

.more-meminfo {
  width: 100%;
  height: 100%;
}

.more-meminfo .mem-card-container {
  display: flex;
  justify-content: center;
  height: 100%;
  width: 100%;
}

.mem-card-container .no-mem-tips {
  align-self: center;
  margin-bottom: 45px;
  color: #999;
}

.mem-card-form {
  display: flex;
  width: 330px;
  flex-direction: column;
  height: 100%;
}

.settment-card {
  flex: none;
  margin-top: 25px;
  padding: 15px;
  height: 150px;
  width: 300px;
  border-radius: 6px;
  margin-bottom: 10px;
  color: #eee;
}

.settment-card-info > div {
  margin-bottom: 10px;
}

.fins-box {
  width: 300px;
  flex: 1;
  height: 100%;
  overflow: auto;
  padding: 16px;
}

.fins-box .fin-row {
  height: 85px;
  border-radius: 6px;
  box-shadow: 0 0 15px #c2bccc;
  margin-bottom: 10px;
  color: #666;
  padding: 10px 25px;
  position: relative;
  overflow: hidden;
}

.fin-row div {
  margin-top: 10px;
}

.fin-row .is-giving {
  position: absolute;
  background-color: #ff4500;
  right: -48px;
  top: -28px;
  height: 21px;
  width: 100px;
  line-height: 21px;
  color: #fff;
  text-align: center;
  transform-origin: left top;
  transform: rotate(45deg);
  font-size: 14px;
}

.row-item {
  overflow: hidden;
}

.row-item .is-pt-prod {
  background-color: #3408f7;
}

.row-item .is-pt-prod,
.row-item .is-pt-svr {
  position: absolute;
  left: -30px;
  top: 41px;
  height: 15px;
  width: 100px;
  line-height: 15px;
  color: #fff;
  text-align: center;
  transform-origin: left top;
  transform: rotate(-45deg);
  font-size: 10px;
}

.row-item .is-pt-svr {
  background-color: #02af45;
}

.row-item .is-pt-treat {
  position: absolute;
  background-color: #fd5f5f;
  left: -30px;
  top: 41px;
  height: 15px;
  width: 100px;
  line-height: 15px;
  color: #fff;
  text-align: center;
  transform-origin: left top;
  transform: rotate(-45deg);
  font-size: 10px;
}

.fin-row-index {
  font-size: 14px;
}

.fin-row-balance,
.fin-row-disinfo {
  display: inline-block;
  font-weight: 700;
  font-size: 13px;
}

.fin-row-balance {
  margin-left: 10px;
  color: #e94949;
}

.fin-row-amount {
  display: inline-block;
  margin-left: 5px;
  font-size: 13px;
  color: #10da2b;
}

.fin-row-org {
  font-size: 12px;
  color: #888;
}

.order-coupon {
  height: 110px;
  flex: none;
  position: relative;
  width: 100%;
  max-width: 750px;
}

.order-coupon .el-divider--horizontal {
  margin: 8px 0;
}

.coupon-list {
  display: flex;
  padding-left: 15px;
  overflow: auto;
}

.coupon-list-inrow {
  padding-left: 5px;
  overflow-y: auto;
  max-height: 360px;
}

.opt-data-input .el-input {
  width: 50%;
}

.multi-fins {
  color: #58fab6;
  margin-right: 10px;
  font-weight: 700;
  font-size: 18px;
}

.card-type-tip {
  border-radius: 2px;
  padding: 10px;
  margin-bottom: 12px;
  background: #917bffaf;
  color: #f6ffe1;
  font-weight: 700;
  font-size: 13px;
  box-shadow: 0 0 5px #e3d7f7;
}

.card-type-msg {
  color: #8770fd;
  font-weight: 700;
  font-size: 12px;
}

.fin-create-time {
  color: #999;
  font-weight: 700;
  font-size: 12px;
  margin-right: 5px;
}

.member-info {
  flex: none;
  max-height: 200px;
  overflow-y: auto;
  font-size: 12px;
  text-align: center;
  margin-bottom: 5px;
}

.member-info .tag-box {
  display: flex;
  justify-content: flex-start;
  padding: 8px 0;
  margin-bottom: 0;
  flex-wrap: wrap;
  align-items: center;
}

.tag {
  padding: 4px 7px;
  font-size: 12px;
  border-width: 1px;
  border-style: solid;
  border-radius: 5px;
  display: flex;
  justify-content: flex-start;
  margin-left: 10px;
  margin-bottom: 5px;
}

.el-icon-cteam-guanbi {
  cursor: pointer;
  margin-left: 2px;
  font-size: 12px;
}

.add-btn {
  margin-left: 10px;
  margin-bottom: 5px;
}

.goto-rech-btn {
  margin-left: 10px;
  max-height: 28px;
  color: #7affed;
}

.goto-rech-btn:hover {
  margin-left: 10px;
  max-height: 28px;
  color: #3eebd4;
}

.popover-item .mem-other-brand {
  position: absolute;
  background-color: #05f;
  right: -45px;
  top: -15px;
  height: 21px;
  width: 105px;
  line-height: 21px;
  color: #fff;
  text-align: center;
  transform-origin: left top;
  transform: rotate(45deg);
  font-size: 14px;
}
</style>
