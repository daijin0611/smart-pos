<template>
  <div class="error-page">
    <div class="content">
      <img src="@/assets/images/error_images/500.png" alt="500 服务错误" class="error-img" />
      <h1 class="error-title">
        <el-icon size="48" color="var(--el-color-danger)">
          <CircleCloseFilled />
        </el-icon>
        服务器错误
      </h1>
      <p class="error-desc">抱歉，服务器发生错误</p>
      <el-button @click="go" type="primary" size="large" class="return-btn">
        <el-icon><House /></el-icon>
        返回上一页
      </el-button>
      <el-button @click="goLogin" type="primary" size="large" class="return-btn">
        <el-icon><House /></el-icon>
        返回登录页
      </el-button>
    </div>
  </div>
</template>

<script lang="ts">
export default {
  methods: {
    go() {
      this.$router.go(-1);
    },
    goLogin() {
      this.$router.push({ path: '/login' });
    },
  },
};
</script>

<style scoped lang="scss">
.error-page {
  width: 100vw;
  height: 100vh;
  background-color: var(--el-bg-color);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.content {
  text-align: center;
  padding: 3rem;
  max-width: 640px;
  background-color: var(--el-bg-color-overlay);
  border-radius: var(--el-border-radius-xl);
  box-shadow: var(--el-box-shadow-lighter);

  /* 动画效果 */
  animation: fadeIn 0.5s ease-in-out;
}

.error-img {
  max-width: 100%;
  height: auto;
  margin-bottom: 2rem;
  border-radius: var(--el-border-radius-lg);
  filter: drop-shadow(0 4px 6px rgba(0, 0, 0, 0.1));
}

.error-title {
  font-size: clamp(1.75rem, 3vw, 2.5rem);
  color: var(--el-color-danger);
  font-weight: var(--el-font-weight-bold);
  margin-bottom: 1rem;

  .el-icon {
    margin-right: 0.5rem;
    vertical-align: middle;
  }
}

.error-desc {
  font-size: clamp(1rem, 1.5vw, 1.25rem);
  color: var(--el-text-color-primary);
  margin-bottom: 2.5rem;
  line-height: 1.6;
}

.return-btn {
  /* 自定义按钮样式覆盖 */
  --el-button-padding: 0.75rem 2rem;
  --el-button-font-size: 1.125rem;

  /* 动画效果 */
  transition: transform 0.2s ease, box-shadow 0.2s ease;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(var(--el-color-primary-rgb), 0.2);
  }

  .el-icon {
    margin-right: 0.75rem;
  }
}

/* 动画关键帧 */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
