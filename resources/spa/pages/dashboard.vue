<template>
    <Layout>
        <div class="dashboard">
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

            <!-- Key Metrics Cards -->
            <v-row class="mb-6">
                <v-col cols="12" md="2">
                    <v-card class="metric-card">
                        <v-card-text>
                            <div class="metric-label">Deals in Pipeline</div>
                            <div class="metric-value">34</div>
                            <div class="metric-change positive">+ 4</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="2">
                    <v-card class="metric-card">
                        <v-card-text>
                            <div class="metric-label">Active Deals</div>
                            <div class="metric-value">28</div>
                            <div class="metric-change positive">+ 2</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="3">
                    <v-card class="metric-card">
                        <v-card-text>
                            <div class="metric-label">AUM</div>
                            <div class="metric-value">$2.12B</div>
                            <div class="metric-change positive">+ $105M</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="2">
                    <v-card class="metric-card">
                        <v-card-text>
                            <div class="metric-label">IRR</div>
                            <div class="metric-value">11.8%</div>
                            <div class="metric-change positive">+ 0.3%</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="3">
                    <v-card class="metric-card">
                        <v-card-text>
                            <div class="metric-label">Default Rate</div>
                            <div class="metric-value">0.6%</div>
                            <div class="metric-change positive">+ 0.1%</div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>

            <!-- Chart Sections -->
            <v-row class="mb-6">
                <v-col cols="12" md="4">
                    <v-card class="chart-card" height="300">
                        <v-card-title class="chart-title">
                            Pipeline by Stage
                        </v-card-title>
                        <v-card-text>
                            <div class="chart-placeholder">
                                <!-- Chart placeholder -->
                                <div class="chart-content">
                                    Chart will be rendered here
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="4">
                    <v-card class="chart-card" height="300">
                        <v-card-title class="chart-title">
                            Portfolio Allocation
                        </v-card-title>
                        <v-card-text>
                            <div class="chart-placeholder">
                                <!-- Chart placeholder -->
                                <div class="chart-content">
                                    Chart will be rendered here
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="4">
                    <v-card class="chart-card" height="300">
                        <v-card-title class="chart-title">
                            Quarterly Earnings
                        </v-card-title>
                        <v-card-text>
                            <div class="chart-placeholder">
                                <!-- Chart placeholder -->
                                <div class="chart-content">
                                    Chart will be rendered here
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>

            <!-- Bottom Section -->
            <v-row>
                <v-col cols="12" md="8">
                    <v-card class="activity-card">
                        <v-card-title class="chart-title">
                            Latest Activity
                        </v-card-title>
                        <v-card-text>
                            <v-list density="compact">
                                <v-list-item class="activity-item">
                                    <template #prepend>
                                        <div class="activity-date">Nov 12</div>
                                    </template>
                                    <v-list-item-title>
                                        Approved $15M Healthcare deal
                                    </v-list-item-title>
                                </v-list-item>
                                <v-list-item class="activity-item">
                                    <template #prepend>
                                        <div class="activity-date">Nov 10</div>
                                    </template>
                                    <v-list-item-title>
                                        Capital Call Notice sent
                                    </v-list-item-title>
                                </v-list-item>
                                <v-list-item class="activity-item">
                                    <template #prepend>
                                        <div class="activity-date">Nov 08</div>
                                    </template>
                                    <v-list-item-title>
                                        Distribution completed for Fund II
                                    </v-list-item-title>
                                </v-list-item>
                                <v-list-item class="activity-item">
                                    <template #prepend>
                                        <div class="activity-date">Nov 05</div>
                                    </template>
                                    <v-list-item-title>
                                        New deal added to pipeline: $22M
                                        Industrials
                                    </v-list-item-title>
                                </v-list-item>
                            </v-list>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="4">
                    <v-card class="quick-links-card">
                        <v-card-title class="chart-title">
                            Quick Links
                        </v-card-title>
                        <v-card-text>
                            <v-btn
                                block
                                class="quick-link-btn mb-2"
                                color="orange"
                                variant="flat">
                                Add New Deal
                            </v-btn>
                            <v-btn
                                block
                                class="quick-link-btn mb-2"
                                color="orange"
                                variant="flat">
                                Run Report
                            </v-btn>
                            <v-btn
                                block
                                class="quick-link-btn mb-4"
                                color="orange"
                                variant="flat">
                                View Capital Calls
                            </v-btn>

                            <div class="top-investments-section">
                                <h4 class="section-title mb-3">
                                    Top Performing Investments
                                </h4>
                                <div class="investment-item">
                                    <div class="investment-info">
                                        <div class="investment-name">
                                            MedSupply ABL
                                        </div>
                                        <div class="investment-metrics">
                                            <span class="investment-return">
                                                14.2%
                                            </span>
                                            <span class="investment-amount">
                                                $210M
                                            </span>
                                            <span class="investment-sector">
                                                Healthcare
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="investment-item">
                                    <div class="investment-info">
                                        <div class="investment-name">
                                            RailCar Leasing SPV
                                        </div>
                                        <div class="investment-metrics">
                                            <span class="investment-return">
                                                13.8%
                                            </span>
                                            <span class="investment-amount">
                                                $175M
                                            </span>
                                            <span class="investment-sector">
                                                Industrials
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="investment-item">
                                    <div class="investment-info">
                                        <div class="investment-name">
                                            Tech Services HoldCo
                                        </div>
                                        <div class="investment-metrics">
                                            <span class="investment-return">
                                                13.3%
                                            </span>
                                            <span class="investment-amount">
                                                $120M
                                            </span>
                                            <span class="investment-sector">
                                                Tech Services
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>
        </div>
    </Layout>
</template>

<script lang="ts" setup>
import Layout from '@/components/ui/layout.vue'
</script>

<style scoped>
.dashboard {
    max-width: 1400px;
    margin: 0 auto;
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

.metric-card {
    padding: 0.5rem;
    text-align: center;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.metric-label {
    font-size: 0.875rem;
    color: #666;
    margin-bottom: 0.5rem;
}

.metric-value {
    font-size: 1.75rem;
    font-weight: 600;
    color: #333;
    margin-bottom: 0.25rem;
}

.metric-change {
    font-size: 0.875rem;
    font-weight: 500;
}

.metric-change.positive {
    color: #059669;
}

.chart-card,
.activity-card,
.quick-links-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.chart-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #333;
    padding: 1rem 1rem 0.5rem 1rem;
}

.chart-placeholder {
    height: 200px;
    background: #f8f9fa;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.chart-content {
    color: #666;
    font-style: italic;
}

.activity-item {
    border-bottom: 1px solid #f0f0f0;
    padding: 0.75rem 0;
}

.activity-item:last-child {
    border-bottom: none;
}

.activity-date {
    font-size: 0.75rem;
    color: #666;
    min-width: 50px;
    margin-right: 1rem;
}

.quick-link-btn {
    text-transform: none;
    font-weight: 500;
}

.top-investments-section {
    margin-top: 1.5rem;
}

.section-title {
    font-size: 1rem;
    font-weight: 600;
    color: #333;
}

.investment-item {
    padding: 0.75rem 0;
    border-bottom: 1px solid #f0f0f0;
}

.investment-item:last-child {
    border-bottom: none;
}

.investment-name {
    font-weight: 500;
    color: #333;
    margin-bottom: 0.25rem;
}

.investment-metrics {
    display: flex;
    gap: 0.75rem;
    font-size: 0.875rem;
}

.investment-return {
    color: #059669;
    font-weight: 500;
}

.investment-amount {
    color: #333;
}

.investment-sector {
    color: #666;
}
</style>
