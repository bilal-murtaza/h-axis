<template>
    <v-app>
        <!-- Sidebar Navigation -->
        <v-navigation-drawer
            v-model="drawer"
            app
            class="sidebar"
            permanent
            persistent
            width="280">
            <!-- Logo Section -->
            <div
                class="logo-section pa-4 d-flex align-center justify-center pb-2">
                <img alt="H-Axis Logo" class="logo" src="@/assets/logo.png" />
            </div>

            <div class="pa-4 pt-2">
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
                <!-- Header Section -->
                <div class="welcome-section mb-8">
                    <h1 class="welcome-title">Welcome, John Doe</h1>
                    <div class="assets-section">
                        <div class="assets-amount">
                            $2.12B Assets Under Management
                        </div>
                        <div class="assets-subtitle">
                            Up 5.2% from last quarter — 34 Active Deals
                        </div>
                    </div>
                </div>

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
    { title: 'Deal Pipeline', to: '/deals', icon: 'mdi-handshake' },
    { title: 'Capital Calls', to: '/capital-calls', icon: 'mdi-phone-outline' },
    {
        title: 'Earnings & Distributions',
        to: '/earnings',
        icon: 'mdi-chart-line',
    },
    { title: 'Investors', to: '/investors', icon: 'mdi-account-group' },
    { title: 'Documents', to: '/documents', icon: 'mdi-file-document' },
    { title: 'Reporting', to: '/reporting', icon: 'mdi-chart-bar' },
    { title: 'Analyst Corner', to: '/analyst-corner', icon: 'mdi-chart-donut' },
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
    margin-right: -7px !important;
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

.welcome-section {
    margin-bottom: 2rem;
}

.welcome-title {
    font-size: 2rem;
    font-weight: 400;
    color: #333;
    margin-bottom: 0.5rem;
}

.assets-section {
    margin-top: 0.5rem;
}

.assets-amount {
    font-size: 2.5rem;
    font-weight: 600;
    color: #d4a574;
    margin-bottom: 0.25rem;
}

.assets-subtitle {
    font-size: 1rem;
    color: #666;
}
</style>
