<template>
    <v-container class="fill-height" fluid>
        <v-row align="center" justify="center">
            <v-col class="text-center" cols="12" md="6">
                <v-card class="pa-8">
                    <v-card-title class="text-h3 mb-4"> Easy Reviews </v-card-title>
                    <v-card-text>
                        <p class="text-h6 mb-6">A simple review management system</p>
                        <v-btn color="primary" size="large" to="/auth/login" variant="flat"> Get Started </v-btn>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script lang="ts" setup>
// Landing page component
</script>

<style scoped>
.v-container {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    min-height: 100vh;
}
</style>
