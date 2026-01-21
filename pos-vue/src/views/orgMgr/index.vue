<template>
  <div class="org-container">
    <ul>
      <li>
        <span>机构全称：</span>
        <span>
          {{ org.orgName }}
          <el-button type="primary" link size="small" @click="showDrawer">编辑</el-button>
        </span>
      </li>
      <li>
        <span>机构简称：</span>
        <span>{{ org.orgShortName }}</span>
      </li>
      <li>
        <span>机构编码：</span>
        <span>{{ org.orgCode }}</span>
      </li>
      <li>
        <span>机构性质：</span>
        <span>{{ org.orgProperty }}</span>
      </li>
      <li>
        <span>机构类型：</span>
        <span>{{ org.orgType }}</span>
      </li>
      <li>
        <span>行政区域：</span>
        <span>{{ org.orgAreaStr }}</span>
      </li>
      <li>
        <span>详细地址：</span>
        <span>{{ org.orgAddress }}</span>
      </li>
      <li>
        <span>联系电话：</span>
        <span>{{ org.orgNumber }}</span>
      </li>
      <li>
        <span>负责人：</span>
        <span>{{ org.orgLeader }}</span>
      </li>
      <li>
        <span>负责人电话：</span>
        <span>{{ org.orgLeaderNum }}</span>
      </li>
      <li>
        <span>备注信息：</span>
        <span>{{ org.remark }}</span>
      </li>
    </ul>
    <ul>
      <li>
        <span>机构状态：</span>
        <span>
          <el-tag :type="org.orgState === 0 ? 'success' : 'danger'">
            {{ org.orgState === 0 ? '正常' : '停用' }}
          </el-tag>
        </span>
      </li>
      <li>
        <span>创建日期：</span>
        <span>{{ org.createTime }}</span>
      </li>
      <li>
        <span>修改日期：</span>
        <span>{{ org.updateTime }}</span>
      </li>
    </ul>
  </div>
  <!-- 抽屉表单 -->
  <Drawer v-model="drawer.visible" :title="drawer.title" width="450">
    <!-- 表单 -->
    <OrgForm @close-drawer="closeDrawer" />
  </Drawer>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue';
import { getUserInfo } from '@/utils/localStorageTools';

import OrgForm from '@/views/acl/orgMgr/form.vue';

import { useOrgStore } from '@/store/modules/acl/org';
const store = useOrgStore();

onMounted(() => {
  init();
});

const org = ref<any>({});

const init = async () => {
  const userInfo = getUserInfo();
  org.value = await store.getOrgInfo(userInfo.orgId);
  org.value.orgAreaStr = org.value.orgArea.join('/');
};

const drawer: any = reactive({
  title: '编辑门店信息',
  visible: false,
});

const showDrawer = () => {
  store.formData = { ...org.value };
  drawer.visible = true;
};

const closeDrawer = () => {
  init();
  drawer.visible = false;
};
</script>

<style scoped lang="scss">
.org-container {
  display: flex;
  height: 100%;
  gap: 2px;
  background-color: var(--el-color-primary-light-5);

  > ul {
    background-color: $base-main-bg;
    flex: 1;
    padding: 15px 20px;
    li {
      line-height: 40px;
      display: flex;
      letter-spacing: 0.1rem;

      > span:first-child {
        display: inline-block;
        width: 120px;
        text-align: right;
        color: var(--el-text-color-placeholder);
      }
      > span:last-child {
        flex: 1;
        color: var(--el-text-color-regular);
      }
    }
  }
}
</style>
