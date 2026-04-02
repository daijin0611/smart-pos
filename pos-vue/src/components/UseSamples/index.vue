<template>
  <div class="container">
    <!-- <header>
      <router-link to="/samples/all">全部</router-link>
      <router-link to="/samples/messageBox">MessageBox</router-link>
      <router-link to="/samples/multipleSelect">MultipleSelect</router-link>
    </header>
    <hr />
    <div>
      <router-view></router-view>
    </div> -->
    <Print></Print>
  </div>
</template>

<script setup lang="ts">
import Print from '@/components/Print/index.vue';
</script>

<style lang="scss" scoped>
.container {
  position: relative;
  background-color: #fff;
  width: 100%;
  height: 100%;

  header {
    font-size: 18px;
    display: flex;
    gap: 30px;
    align-items: center;
    justify-content: center;
    line-height: 50px;
    position: sticky;
  }
}
</style>
