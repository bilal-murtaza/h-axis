import Vue from '@vitejs/plugin-vue'
import path from 'node:path'
import Fonts from 'unplugin-fonts/vite'
// Plugins
import Components from 'unplugin-vue-components/vite'
import VueRouter from 'unplugin-vue-router/vite'

// Utilities
import { defineConfig } from 'vite'
import Vuetify, { transformAssetUrls } from 'vite-plugin-vuetify'

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [
        VueRouter({
            dts: 'resources/spa/typed-router.d.ts',
            routesFolder: 'resources/spa/pages',
        }),
        Vue({
            template: { transformAssetUrls },
        }),
        // https://github.com/vuetifyjs/vuetify-loader/tree/master/packages/vite-plugin#readme
        Vuetify({
            autoImport: true,
            styles: {
                configFile: 'resources/spa/styles/settings.scss',
            },
        }),
        Components({
            dts: 'resources/spa/components.d.ts',
            dirs: ['resources/spa/components'],
        }),
        Fonts({
            fontsource: {
                families: [
                    {
                        name: 'Roboto',
                        weights: [100, 300, 400, 500, 700, 900],
                        styles: ['normal', 'italic'],
                    },
                ],
            },
        }),
    ],
    optimizeDeps: {
        exclude: [
            'vuetify',
            'vue-router',
            'unplugin-vue-router/runtime',
            'unplugin-vue-router/data-loaders',
            'unplugin-vue-router/data-loaders/basic',
        ],
    },
    define: { 'process.env': {} },
    resolve: {
        alias: {
            '@': path.resolve(__dirname, 'resources/spa'),
        },
        extensions: ['.js', '.json', '.jsx', '.mjs', '.ts', '.tsx', '.vue'],
    },
    build: {
        outDir: 'dist',
        rollupOptions: {
            input: path.resolve(__dirname, 'index.html'),
        },
    },
    base: './', // Use relative paths for GitHub Pages
    css: {
        preprocessorOptions: {
            sass: {
                api: 'modern-compiler',
            },
            scss: {
                api: 'modern-compiler',
            },
        },
    },
})
