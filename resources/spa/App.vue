<template>
    <v-app>
        <v-main>
            <div class="router-container">
                <router-view v-slot="{ Component, route }">
                    <transition appear name="fade">
                        <component :is="Component" :key="route.path" />
                    </transition>
                </router-view>
            </div>
        </v-main>
    </v-app>
</template>

<script lang="ts" setup>
//
</script>

<style scoped>
/* Router container for smooth transitions */
.router-container {
    position: relative;
    width: 100%;
    height: 100%;
}

/* Router transition animations */
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.fade-enter-from {
    opacity: 0;
}

.fade-leave-to {
    opacity: 0;
}

.fade-enter-to,
.fade-leave-from {
    opacity: 1;
}
</style>
