<template>
    <v-app>
        <!-- Sidebar Navigation -->
        <v-navigation-drawer
            v-model="drawer"
            class="sidebar"
            permanent
            width="270">
            <div class="pa-4">
                <v-list density="compact" nav>
                    <v-list-item
                        v-for="item in navigationItems"
                        :key="item.title"
                        class="mb-1"
                        :class="{
                            'v-list-item--active': isActiveRoute(item.to),
                        }"
                        :to="item.to">
                        <template #prepend>
                            <v-icon :icon="item.icon" size="small" />
                        </template>
                        <v-list-item-title class="text-sm">
                            {{ item.title }}
                        </v-list-item-title>
                    </v-list-item>
                </v-list>
            </div>
        </v-navigation-drawer>

        <!-- Main Content Area -->
        <v-main>
            <div class="main-content">
                <slot />
            </div>
        </v-main>
    </v-app>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const drawer = ref(true)

const navigationItems = [
    { title: 'Dashboard', to: '/dashboard', icon: 'mdi-view-dashboard' },
    { title: 'Deal Pipeline', to: '/deals', icon: 'mdi-pipeline' },
    { title: 'Capital Calls', to: '/capital-calls', icon: 'mdi-phone-outline' },
    {
        title: 'Earnings & Distributions',
        to: '/earnings',
        icon: 'mdi-chart-line',
    },
    { title: 'Investors', to: '/investors', icon: 'mdi-account-group' },
    { title: 'Documents', to: '/documents', icon: 'mdi-file-document' },
    { title: 'Reporting', to: '/reporting', icon: 'mdi-chart-bar' },
    { title: 'Settings', to: '/settings', icon: 'mdi-cog' },
]

const isActiveRoute = (path: string) => {
    return route.path === path
}
</script>

<style scoped>
.sidebar {
    background: linear-gradient(180deg, #1e3a5f 0%, #0f1419 100%) !important;
    border-right: none !important;
}

.sidebar :deep(.v-list-item) {
    color: rgba(255, 255, 255, 0.7) !important;
    border-radius: 6px !important;
    margin: 2px 8px !important;
    min-height: 36px !important;
}

.sidebar :deep(.v-list-item:hover) {
    background: rgba(255, 255, 255, 0.1) !important;
    color: white !important;
}

.sidebar :deep(.v-list-item--active) {
    background: rgba(255, 255, 255, 0.15) !important;
    color: white !important;
}

.sidebar :deep(.v-list-item__prepend) {
    margin-right: 12px !important;
}

.sidebar :deep(.v-icon) {
    color: inherit !important;
}

.main-content {
    background-color: #f5f7fa;
    min-height: 100vh;
    padding: 24px;
}

.text-sm {
    font-size: 14px !important;
    font-weight: 500 !important;
}
</style>
