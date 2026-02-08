<template>
  <div>
    <Form
      :model="store.formData"
      :rules="formRules"
      :showButtons="!disabled"
      :disabled="disabled"
      @submit="handleFormSubmit"
      @reset="handleFormReset"
    >
      <!-- 人员编号 -->
      <el-form-item label="编号" prop="userCode">
        <el-input v-model="store.formData.userCode" placeholder="请输入编号" />
      </el-form-item>

      <!-- 姓名 -->
      <el-form-item label="姓名" prop="userName">
        <el-input v-model="store.formData.userName" placeholder="请输入姓名" />
      </el-form-item>

      <!-- 手机号 -->
      <el-form-item label="手机号" prop="userNumber">
        <el-input v-model="store.formData.userNumber" placeholder="请输入手机号" />
      </el-form-item>

      <!-- 分配角色 -->
      <el-form-item label="人员角色" prop="roleId">
        <div style="width: 100%; display: flex; gap: 10px">
          <el-select v-model="store.formData.roleId" style="width: 200px" placeholder="选择角色">
            <el-option v-for="item in roleList" :key="item.id" :label="item.roleName" :value="item.id" />
          </el-select>
          <el-button link type="primary" @click="goRoleMgr">角色管理</el-button>
        </div>
      </el-form-item>

      <!-- 人员职位 -->
      <el-form-item label="人员职位" prop="userPosition">
        <div style="width: 100%; display: flex; gap: 10px">
          <el-select v-model="store.formData.userPosition" style="width: 200px" placeholder="选择职位">
            <el-option
              v-for="item in positionList"
              :key="item.itemValue"
              :label="item.itemLabel"
              :value="item.itemValue"
            />
          </el-select>
          <div><el-button link type="primary" @click="positionMgr">职位管理</el-button></div>
        </div>
      </el-form-item>

      <!-- 性别 -->
      <el-form-item label="性别" prop="userSex">
        <el-select v-model="store.formData.userSex" style="width: 200px" placeholder="性别">
          <el-option v-for="item in sexOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>

      <!-- 生日 -->
      <el-form-item label="生日" prop="userBirthday">
        <el-date-picker
          v-model="store.formData.userBirthday"
          type="date"
          placeholder="选择生日"
          value-format="YYYY-MM-DD"
          style="width: 200px"
        />
      </el-form-item>

      <!-- 所属部门 -->
      <el-form-item label="所属部门" prop="userDept">
        <div style="width: 100%; display: flex; gap: 10px">
          <el-select v-model="store.formData.deptOptions" style="width: 200px" placeholder="选择职位">
            <el-option v-for="item in deptList" :key="item.itemValue" :label="item.itemLabel" :value="item.itemValue" />
          </el-select>
          <div><el-button link type="primary" @click="deptMgr">部门管理</el-button></div>
        </div>
      </el-form-item>

      <!-- 入职时间 -->
      <el-form-item label="入职时间" prop="userEntryDate">
        <el-date-picker
          v-model="store.formData.userEntryDate"
          type="date"
          placeholder="选择入职时间"
          value-format="YYYY-MM-DD"
          style="width: 200px"
        />
      </el-form-item>

      <!-- 在职状态 -->
      <el-form-item label="在职状态" prop="userStatus">
        <el-select v-model="store.formData.userStatus" style="width: 200px" placeholder="请选择在职状态">
          <el-option v-for="item in employedOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>

      <!-- 身份证号 -->
      <el-form-item label="身份证号" prop="userIdCard">
        <el-input v-model="store.formData.userIdCard" placeholder="请输入身份证号" />
      </el-form-item>

      <!-- 人员地址 -->
      <el-form-item label="人员地址" prop="userAddress">
        <el-input v-model="store.formData.userAddress" placeholder="请输入居住地址" />
      </el-form-item>

      <!-- 婚姻状况 -->
      <el-form-item label="婚姻状况" prop="userMarry">
        <el-select v-model="store.formData.userMarry" style="width: 200px" placeholder="请选择婚姻状况">
          <el-option v-for="item in maritalStatusOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>

      <!-- 学历状况 -->
      <el-form-item label="学历状况" prop="userEdu">
        <el-select v-model="store.formData.userEdu" style="width: 200px" placeholder="请选择学历">
          <el-option v-for="item in educationOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>

      <!-- 健康证到期 -->
      <el-form-item label="健康证到期" prop="userHealth">
        <el-date-picker
          v-model="store.formData.userHealth"
          type="date"
          placeholder="选择健康证到期时间"
          value-format="YYYY-MM-DD"
          style="width: 200px"
        />
      </el-form-item>
    </Form>

    <EnumHandler v-model="enumHandler.visible" :title="enumHandler.title" :dictCode="enumHandler.dictCode" />
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue';
import EnumHandler from '@/components/EnumHandler/index.vue';

// 导入枚举数据
import { sexOptions, employedOptions, maritalStatusOptions, educationOptions } from '@/enums/index';
// 引入数据仓库
import { useStaffStore } from '@/store/modules/staffMain/staff';
import { useEnumStore, Enums } from '@/store/modules/enums/index';
import { useRoleStore } from '@/store/modules/acl/role';

// 引入路由
import { useRouter } from 'vue-router';
const router = useRouter();

const store = useStaffStore();
const enumStore = useEnumStore();
const roleStore = useRoleStore();

const $emit = defineEmits(['close-drawer']);

defineProps(['disabled']);

onMounted(async () => {
  await initEnum();
});

// 表单提交
const handleFormSubmit = async (model: any) => {
  const result = await store.update(model);
  result && $emit('close-drawer');
};

// 表单重置
const handleFormReset = () => {
  store.resetFormData();
};

const roleList = ref<any>([]);
const deptList = ref<any>([]);
const positionList = ref<any>([]);

const initEnum = async () => {
  roleList.value = await roleStore.getRoleList();
  deptList.value = await enumStore.getDeptList();
  positionList.value = await enumStore.getPositionList();
};

const enumHandler = reactive({
  title: '字典管理',
  visible: false,
  dictCode: '',
  defaultData: <any>[],
});

const goRoleMgr = () => {
  router.push({ path: '/acl/role' });
};

const deptMgr = () => {
  enumHandler.title = '部门管理';
  enumHandler.visible = true;
  enumHandler.dictCode = deptList?.value?.[0]?.dictCode || Enums.DEPARTMENT;
};

const positionMgr = () => {
  enumHandler.title = '职位管理';
  enumHandler.visible = true;
  enumHandler.dictCode = positionList?.value?.[0]?.dictCode || Enums.POSITION;
};

// 表单验证规则
const formRules = {
  userCode: [{ required: true, message: '人员编号为必填项', trigger: 'blur' }],
  userName: [
    { required: true, message: '姓名为必填项', trigger: 'blur' },
    { min: 2, max: 20, message: '姓名长度在2到20个字符之间', trigger: 'blur' },
  ],
  userNumber: [
    { required: true, message: '手机号为必填项', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' },
  ],
  roleId: [{ required: true, message: '请选择人员角色', trigger: 'change' }],
  userIdCard: [
    { pattern: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/, message: '请输入正确的身份证号码', trigger: 'blur' },
  ],
  userAddress: [{ max: 200, message: '人员地址长度不能超过200个字符', trigger: 'blur' }],
};
</script>
