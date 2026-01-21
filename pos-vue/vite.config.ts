// https://vitejs.dev/config/
import { defineConfig, loadEnv } from 'vite';
import vue from '@vitejs/plugin-vue';
import path from 'path';
//引入svg需要用到插件
import { createSvgIconsPlugin } from 'vite-plugin-svg-icons';
//mock插件提供方法
import { viteMockServe } from 'vite-plugin-mock';
export default defineConfig(({ command, mode }) => {
  //获取各种环境下的对应的变量
  const env = loadEnv(mode, process.cwd());
  return {
    publicPath: 'http://localhost:8080',
    plugins: [
      vue(),
      createSvgIconsPlugin({
        iconDirs: [path.resolve(process.cwd(), 'src/assets/icons')],
        symbolId: 'icon-[dir]-[name]',
      }),
      viteMockServe({
        localEnabled: command === 'serve', //保证开发阶段可以使用mock接口
      }),
    ],
    resolve: {
      alias: {
        '@': path.resolve('./src'), // 相对路径别名配置，使用 @ 代替 src
      },
    },
    //scss全局变量一个配置
    css: {
      preprocessorOptions: {
        scss: {
          javascriptEnabled: true,
          additionalData: '@import "./src/styles/variable.scss"; @import "./src/styles/mixins.scss";',
        },
      },
    },
    //代理跨域
    server: {
      host: '0.0.0.0', // 允许局域网访问
      proxy: {
        [env.VITE_APP_BASE_API]: {
          //获取数据的服务器地址设置
          target: env.VITE_SERVE,
          //需要代理跨域
          changeOrigin: true,
          //路径重写
          rewrite: (path) => path.replace(/^\/api/, ''),
        },
      },
    },
    build: {
      target: ['es2022', 'edge89', 'firefox97', 'chrome97', 'safari15'],
    },
  };
});
