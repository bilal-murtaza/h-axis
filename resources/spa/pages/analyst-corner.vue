<template>
    <Layout>
        <div class="analyst-corner">
            <!-- Header Section -->
            <div class="page-header mb-6">
                <h1 class="page-title">Analyst Corner</h1>
                <p class="page-subtitle">
                    Tools & resources for conducting investment due diligence
                </p>
            </div>

            <!-- Key Metrics Row -->
            <v-row class="mb-6">
                <v-col cols="12" md="4">
                    <v-card class="metric-card">
                        <v-card-text>
                            <div class="metric-label">Deals Under Review</div>
                            <div class="metric-value">12</div>
                            <div class="metric-change positive">
                                <v-icon class="me-1" size="small">
                                    mdi-trending-up
                                </v-icon>
                                3
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="4">
                    <v-card class="metric-card">
                        <v-card-text>
                            <div class="metric-label">Avg. Review Time</div>
                            <div class="metric-value">15 days</div>
                            <div class="metric-change positive">
                                <v-icon class="me-1" size="small">
                                    mdi-trending-up
                                </v-icon>
                                3
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="4">
                    <v-card class="metric-card">
                        <v-card-text>
                            <div class="metric-label">
                                Approval Rate Post-Review
                            </div>
                            <div class="metric-value">72%</div>
                            <div class="metric-change positive">
                                <v-icon class="me-1" size="small">
                                    mdi-trending-up
                                </v-icon>
                                4%
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>

            <!-- Tools Grid Section -->
            <v-row class="mb-6">
                <v-col cols="12" md="3">
                    <v-card
                        class="tool-card"
                        hover
                        @click="openTool('financial-model')">
                        <v-card-text class="pa-4 text-center">
                            <v-chip
                                class="mb-2"
                                color="success"
                                size="small"
                                variant="flat">
                                New
                            </v-chip>
                            <div class="tool-title">
                                Financial Model Templates
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="3">
                    <v-card
                        class="tool-card"
                        hover
                        @click="openTool('valuation')">
                        <v-card-text class="pa-4 text-center">
                            <v-chip
                                class="mb-2"
                                color="success"
                                size="small"
                                variant="flat">
                                New
                            </v-chip>
                            <div class="tool-title">Valuation Calculator</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="3">
                    <v-card
                        class="tool-card"
                        hover
                        @click="openTool('comparable-deals')">
                        <v-card-text class="pa-4 text-center">
                            <v-chip
                                class="mb-2"
                                color="warning"
                                size="small"
                                variant="flat">
                                Updated
                            </v-chip>
                            <div class="tool-title">Comparable Deals DB</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="3">
                    <v-card
                        class="tool-card"
                        hover
                        @click="openTool('industry-reports')">
                        <v-card-text class="pa-4 text-center">
                            <v-chip
                                class="mb-2"
                                color="warning"
                                size="small"
                                variant="flat">
                                Updated
                            </v-chip>
                            <div class="tool-title">
                                Industry Reports Library
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>

            <!-- Analysis Tools Row -->
            <v-row class="mb-6">
                <v-col cols="12" md="3">
                    <v-card
                        class="tool-card"
                        hover
                        @click="openTool('risk-assessment')">
                        <v-card-text class="pa-4 text-center">
                            <v-chip
                                class="mb-2"
                                color="warning"
                                size="small"
                                variant="flat">
                                Updated
                            </v-chip>
                            <div class="tool-title">Risk Assessment Tool</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="3">
                    <v-card
                        class="tool-card"
                        hover
                        @click="openTool('credit-scoring')">
                        <v-card-text class="pa-4 text-center">
                            <v-chip
                                class="mb-2"
                                color="primary"
                                size="small"
                                variant="flat">
                                Popular
                            </v-chip>
                            <div class="tool-title">Credit Scoring Tool</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="3">
                    <v-card
                        class="tool-card"
                        hover
                        @click="openTool('due-diligence')">
                        <v-card-text class="pa-4 text-center">
                            <v-chip
                                class="mb-2"
                                color="primary"
                                size="small"
                                variant="flat">
                                Popular
                            </v-chip>
                            <div class="tool-title">
                                Due Diligence Checklist
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="3">
                    <v-card
                        class="tool-card"
                        hover
                        @click="openTool('document-request')">
                        <v-card-text class="pa-4 text-center">
                            <v-chip
                                class="mb-2"
                                color="primary"
                                size="small"
                                variant="flat">
                                Popular
                            </v-chip>
                            <div class="tool-title">
                                Document Request Templates
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>

            <!-- Bottom Section -->
            <v-row>
                <v-col cols="12" md="5">
                    <v-card class="info-card">
                        <v-card-title class="card-title">
                            Market Data Feed
                        </v-card-title>
                        <v-card-text>
                            <div class="market-data-section">
                                <div class="market-item">
                                    <span class="sector">Healthcare</span>
                                    <span class="change positive">+1.2%</span>
                                </div>
                                <div class="market-item">
                                    <span class="sector">Industrials</span>
                                    <span class="change positive">+0.8%</span>
                                </div>
                                <div class="market-item">
                                    <span class="sector">Tech</span>
                                    <span class="change negative">-0.5%</span>
                                </div>
                                <div class="market-item">
                                    <span class="sector">Energy</span>
                                    <span class="change positive">+0.4%</span>
                                </div>
                            </div>

                            <v-divider class="my-4" />

                            <div class="regulatory-section">
                                <h4 class="section-subtitle mb-3">
                                    Regulatory News
                                </h4>
                                <div class="news-item">
                                    SEC updates reporting requirements
                                </div>
                                <div class="news-item">
                                    New AML compliance guidelines
                                </div>
                                <div class="news-item">
                                    EU market access changes
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>

                <v-col cols="12" md="7">
                    <v-card class="info-card">
                        <v-card-title class="card-title">
                            Recent Due Diligence Reports
                        </v-card-title>
                        <v-card-text>
                            <v-list density="compact">
                                <v-list-item
                                    v-for="report in recentReports"
                                    :key="report.id"
                                    class="report-item"
                                    @click="openReport(report.id)">
                                    <v-list-item-title class="report-name">
                                        {{ report.name }}
                                    </v-list-item-title>
                                    <v-list-item-subtitle
                                        class="report-details">
                                        <span class="report-date">
                                            {{ report.date }}
                                        </span>
                                        <span class="report-analyst">
                                            {{ report.analyst }}
                                        </span>
                                        <v-chip
                                            class="ml-2"
                                            :color="
                                                getStatusColor(report.status)
                                            "
                                            size="x-small"
                                            variant="flat">
                                            {{ report.status }}
                                        </v-chip>
                                    </v-list-item-subtitle>
                                </v-list-item>
                            </v-list>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>
        </div>
    </Layout>
</template>

<script lang="ts" setup>
import Layout from '@/components/ui/layout.vue'
import { ref } from 'vue'

interface Report {
    id: string
    name: string
    date: string
    analyst: string
    status: 'Completed' | 'In Review' | 'Pending'
}

const recentReports = ref<Report[]>([
    {
        id: '1',
        name: 'MedSupply ABL',
        date: 'Nov 11',
        analyst: 'J. Smith',
        status: 'Completed',
    },
    {
        id: '2',
        name: 'RailCar Leasing SPV',
        date: 'Nov 9',
        analyst: 'A. Johnson',
        status: 'In Review',
    },
    {
        id: '3',
        name: 'Tech Services HoldCo',
        date: 'Nov 5',
        analyst: 'L. Wang',
        status: 'Completed',
    },
])

const openTool = (toolId: string) => {
    console.log(`Opening tool: ${toolId}`)
    // Add navigation logic here
}

const openReport = (reportId: string) => {
    console.log(`Opening report: ${reportId}`)
    // Add navigation logic here
}

const getStatusColor = (status: string) => {
    if (status === 'Completed') return 'success'
    if (status === 'In Review') return 'warning'
    if (status === 'Pending') return 'orange'
    return 'grey'
}
</script>

<style scoped>
.analyst-corner {
    max-width: 1400px;
    margin: 0 auto;
}

.page-header {
    text-align: left;
}

.page-title {
    font-size: 2.5rem;
    font-weight: 600;
    color: #1e3a5f;
    margin-bottom: 0.5rem;
}

.page-subtitle {
    font-size: 1.125rem;
    color: #666;
    margin: 0;
}

.metric-card {
    padding: 0.5rem;
    text-align: center;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    height: 140px;
    display: flex;
    align-items: center;
}

.metric-label {
    font-size: 0.9rem;
    color: #666;
    margin-bottom: 0.75rem;
    font-weight: 500;
}

.metric-value {
    font-size: 2.25rem;
    font-weight: 700;
    color: #1e3a5f;
    margin-bottom: 0.5rem;
}

.metric-change {
    font-size: 0.875rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
}

.metric-change.positive {
    color: #059669;
}

.metric-change.negative {
    color: #dc2626;
}

.tool-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    transition: all 0.2s ease;
    cursor: pointer;
    height: 120px;
    display: flex;
    align-items: center;
}

.tool-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
}

.tool-title {
    font-size: 1rem;
    font-weight: 600;
    color: #333;
    line-height: 1.3;
}

.info-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    height: 100%;
}

.card-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1e3a5f;
    padding: 1.5rem 1.5rem 0.5rem 1.5rem;
}

.market-data-section {
    margin-bottom: 1rem;
}

.market-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.5rem 0;
    border-bottom: 1px solid #f0f0f0;
}

.market-item:last-child {
    border-bottom: none;
}

.sector {
    font-weight: 500;
    color: #333;
}

.change {
    font-weight: 600;
    font-size: 0.875rem;
}

.change.positive {
    color: #059669;
}

.change.negative {
    color: #dc2626;
}

.section-subtitle {
    font-size: 1rem;
    font-weight: 600;
    color: #333;
}

.news-item {
    padding: 0.5rem 0;
    color: #666;
    font-size: 0.9rem;
    border-bottom: 1px solid #f0f0f0;
}

.news-item:last-child {
    border-bottom: none;
}

.report-item {
    padding: 0.75rem 0;
    border-bottom: 1px solid #f0f0f0;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.report-item:hover {
    background-color: #f8f9fa;
}

.report-item:last-child {
    border-bottom: none;
}

.report-name {
    font-weight: 600;
    color: #333;
    margin-bottom: 0.25rem;
}

.report-details {
    display: flex;
    align-items: center;
    gap: 1rem;
    font-size: 0.875rem;
}

.report-date {
    color: #666;
    min-width: 60px;
}

.report-analyst {
    color: #666;
}
</style>
