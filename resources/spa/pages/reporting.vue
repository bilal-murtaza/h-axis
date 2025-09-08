<template>
    <layout>
        <div class="reporting-page">
            <!-- Header Section -->
            <div class="page-header mb-6">
                <h2 class="page-title">Reporting</h2>

                <!-- Tab Navigation -->
                <v-tabs
                    v-model="activeTab"
                    class="reporting-tabs"
                    color="#d4a574"
                    slider-color="#d4a574">
                    <v-tab value="track-record">Track Record</v-tab>
                    <v-tab value="portfolio-summary">Portfolio Summary</v-tab>
                    <v-tab value="pipeline-analysis">Pipeline Analysis</v-tab>
                </v-tabs>
            </div>

            <v-row>
                <v-col cols="12" lg="8">
                    <!-- Filter Controls -->
                    <div class="filter-section mb-6">
                        <v-row align="center" class="mb-4">
                            <v-col cols="auto">
                                <div class="filter-group">
                                    <label class="filter-label">
                                        Date Range
                                    </label>
                                    <v-chip
                                        class="filter-chip"
                                        color="#f5f5f5"
                                        text-color="#333">
                                        Jan 2020 - Dec 2025
                                    </v-chip>
                                </div>
                            </v-col>
                            <v-col cols="auto">
                                <div class="filter-group">
                                    <label class="filter-label">Fund</label>
                                    <v-chip
                                        class="filter-chip"
                                        color="#f5f5f5"
                                        text-color="#333">
                                        All Funds
                                    </v-chip>
                                </div>
                            </v-col>
                            <v-col cols="auto">
                                <div class="filter-group">
                                    <label class="filter-label">
                                        Deal Type
                                    </label>
                                    <v-chip
                                        class="filter-chip"
                                        color="#f5f5f5"
                                        text-color="#333">
                                        Private Credit
                                    </v-chip>
                                </div>
                            </v-col>
                            <v-col cols="auto">
                                <v-btn
                                    class="run-report-btn"
                                    color="#d4a574"
                                    size="small">
                                    Run Report
                                </v-btn>
                            </v-col>
                        </v-row>
                    </div>

                    <!-- KPI Cards -->
                    <v-row class="kpi-section mb-6">
                        <v-col cols="12" md="3">
                            <v-card class="kpi-card">
                                <v-card-text class="pa-4">
                                    <div class="kpi-label">Total Deals</div>
                                    <div class="kpi-value">128</div>
                                </v-card-text>
                            </v-card>
                        </v-col>
                        <v-col cols="12" md="3">
                            <v-card class="kpi-card">
                                <v-card-text class="pa-4">
                                    <div class="kpi-label">AUM</div>
                                    <div class="kpi-value kpi-highlight">
                                        $1.85B
                                    </div>
                                </v-card-text>
                            </v-card>
                        </v-col>
                        <v-col cols="12" md="3">
                            <v-card class="kpi-card">
                                <v-card-text class="pa-4">
                                    <div class="kpi-label">Avg. IRR</div>
                                    <div class="kpi-value kpi-highlight">
                                        12.2%
                                    </div>
                                </v-card-text>
                            </v-card>
                        </v-col>
                        <v-col cols="12" md="3">
                            <v-card class="kpi-card">
                                <v-card-text class="pa-4">
                                    <div class="kpi-label">Default Rate</div>
                                    <div class="kpi-value">0.7%</div>
                                </v-card-text>
                            </v-card>
                        </v-col>
                    </v-row>

                    <!-- Main Content Row with Charts/Table and Saved Reports -->
                    <v-row class="main-content-row">
                        <!-- Left Column: Charts and Table -->
                        <v-col cols="12">
                            <!-- Charts Section -->
                            <v-row class="charts-section">
                                <!-- Deals by Year Chart -->
                                <v-col cols="12" md="4">
                                    <v-card class="chart-card">
                                        <v-card-title class="chart-title">
                                            Deals by Year
                                        </v-card-title>
                                        <v-card-text>
                                            <apexchart
                                                height="300"
                                                :options="dealsChartOptions"
                                                :series="dealsChartSeries"
                                                type="bar" />
                                        </v-card-text>
                                    </v-card>
                                </v-col>

                                <!-- Allocation by Sector Chart -->
                                <v-col cols="12" md="4">
                                    <v-card class="chart-card">
                                        <v-card-title class="chart-title">
                                            Allocation by Sector
                                        </v-card-title>
                                        <v-card-text>
                                            <apexchart
                                                height="300"
                                                :options="sectorChartOptions"
                                                :series="sectorChartSeries"
                                                type="donut" />
                                        </v-card-text>
                                    </v-card>
                                </v-col>

                                <!-- Quarterly IRR Chart -->
                                <v-col cols="12" md="4">
                                    <v-card class="chart-card">
                                        <v-card-title class="chart-title">
                                            Quarterly IRR
                                        </v-card-title>
                                        <v-card-text>
                                            <apexchart
                                                height="300"
                                                :options="irrChartOptions"
                                                :series="irrChartSeries"
                                                type="line" />
                                        </v-card-text>
                                    </v-card>
                                </v-col>
                            </v-row>

                            <!-- Report Output Table -->
                            <v-card class="table-card mt-6">
                                <v-card-title class="table-title">
                                    Report Output
                                </v-card-title>
                                <v-card-text class="pa-0">
                                    <div class="table-actions pa-4 pb-2">
                                        <v-btn
                                            class="mr-2"
                                            color="#333"
                                            size="small"
                                            variant="outlined">
                                            Export CSV
                                        </v-btn>
                                        <v-btn
                                            color="#d4a574"
                                            size="small"
                                            variant="outlined">
                                            Export Excel
                                        </v-btn>
                                    </div>
                                    <v-data-table
                                        class="reporting-table"
                                        density="compact"
                                        :headers="tableHeaders"
                                        hide-default-footer
                                        :items="tableData">
                                        <template #item.irr="{ item }">
                                            <span class="irr-value">
                                                {{ item.irr }}
                                            </span>
                                        </template>
                                        <template #item.status="{ item }">
                                            <v-chip
                                                :color="
                                                    getStatusColor(item.status)
                                                "
                                                size="small"
                                                variant="flat">
                                                {{ item.status }}
                                            </v-chip>
                                        </template>
                                    </v-data-table>
                                </v-card-text>
                            </v-card>
                        </v-col>
                    </v-row>
                </v-col>
                <!-- Right Column: Saved Reports -->
                <v-col cols="12" lg="4">
                    <v-card class="saved-reports-card">
                        <v-card-title class="saved-reports-title">
                            Saved Reports
                        </v-card-title>
                        <v-card-text class="pa-0">
                            <div class="saved-reports-list">
                                <div
                                    v-for="report in savedReports"
                                    :key="report.id"
                                    class="saved-report-item">
                                    <div class="report-info">
                                        <div class="report-date">
                                            {{ report.date }}
                                        </div>
                                        <div class="report-name">
                                            {{ report.name }}
                                        </div>
                                    </div>
                                    <v-btn
                                        class="re-run-btn"
                                        color="#1e3a5f"
                                        size="small"
                                        variant="flat">
                                        Re-run
                                    </v-btn>
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>
        </div>
    </layout>
</template>

<script lang="ts" setup>
import Layout from '@/components/ui/layout.vue'
import { ref } from 'vue'

const activeTab = ref('track-record')

// Deals by Year Chart Configuration
const dealsChartOptions = {
    chart: {
        type: 'bar',
        toolbar: { show: false },
        background: 'transparent',
    },
    plotOptions: {
        bar: {
            borderRadius: 4,
            columnWidth: '60%',
        },
    },
    colors: ['#d4a574'],
    dataLabels: { enabled: false },
    xaxis: {
        categories: ['2020', '2021', '2022', '2023', '2024'],
        labels: {
            style: { colors: '#666', fontSize: '12px' },
        },
        axisBorder: { show: false },
        axisTicks: { show: false },
    },
    yaxis: {
        labels: {
            style: { colors: '#666', fontSize: '12px' },
        },
    },
    grid: {
        borderColor: '#f0f0f0',
        strokeDashArray: 3,
    },
    tooltip: {
        theme: 'light',
        style: { fontSize: '12px' },
    },
}

const dealsChartSeries = [
    {
        name: 'Deals',
        data: [15, 20, 25, 32, 45],
    },
]

// Allocation by Sector Chart Configuration
const sectorChartOptions = {
    chart: {
        type: 'donut',
        background: 'transparent',
    },
    colors: ['#1e3a5f', '#3a5f7f', '#5a7f9f', '#7a9fbf', '#9abfdf', '#d4a574'],
    dataLabels: { enabled: false },
    legend: {
        position: 'bottom',
        fontSize: '12px',
        markers: { width: 8, height: 8 },
    },
    plotOptions: {
        pie: {
            donut: {
                size: '60%',
            },
        },
    },
    tooltip: {
        theme: 'light',
        style: { fontSize: '12px' },
    },
}

const sectorChartSeries = [25, 20, 18, 15, 12, 10]

// Quarterly IRR Chart Configuration
const irrChartOptions = {
    chart: {
        type: 'line',
        toolbar: { show: false },
        background: 'transparent',
    },
    stroke: {
        curve: 'smooth',
        width: 3,
        colors: ['#d4a574'],
    },
    markers: {
        size: 6,
        colors: ['#d4a574'],
        strokeColors: '#fff',
        strokeWidth: 2,
    },
    dataLabels: { enabled: false },
    xaxis: {
        categories: [
            'Q1 2023',
            'Q2 2023',
            'Q3 2023',
            'Q4 2023',
            'Q1 2024',
            'Q2 2024',
            'Q3 2024',
            'Q4 2024',
        ],
        labels: {
            style: { colors: '#666', fontSize: '10px' },
            rotate: -45,
        },
        axisBorder: { show: false },
        axisTicks: { show: false },
    },
    yaxis: {
        labels: {
            style: { colors: '#666', fontSize: '12px' },
            formatter: (value: number) => `${value}%`,
        },
    },
    grid: {
        borderColor: '#f0f0f0',
        strokeDashArray: 3,
    },
    tooltip: {
        theme: 'light',
        style: { fontSize: '12px' },
        y: {
            formatter: (value: number) => `${value}%`,
        },
    },
}

const irrChartSeries = [
    {
        name: 'IRR',
        data: [10.5, 11.2, 11.8, 12.1, 12.5, 12.8, 12.3, 12.6],
    },
]

// Table Configuration
const tableHeaders = [
    { title: 'Deal', key: 'deal', sortable: false },
    { title: 'Fund', key: 'fund', sortable: false },
    { title: 'Commitment', key: 'commitment', sortable: false },
    { title: 'Funded', key: 'funded', sortable: false },
    { title: 'IRR', key: 'irr', sortable: false },
    { title: 'Status', key: 'status', sortable: false },
]

const tableData = [
    {
        deal: 'MedSupply ABL',
        fund: 'Fund I',
        commitment: '$20,000,000',
        funded: '$18,000,000',
        irr: '11.8%',
        status: 'Active',
    },
    {
        deal: 'Retailer Leasing SPV',
        fund: 'Fund II',
        commitment: '$25,000,000',
        funded: '$20,000,000',
        irr: '13.1%',
        status: 'Active',
    },
    {
        deal: 'Tech Services HoldCo',
        fund: 'Fund I',
        commitment: '$15,000,000',
        funded: '$12,000,000',
        irr: '10.5%',
        status: 'Exited',
    },
    {
        deal: 'Fastport Logistics',
        fund: 'Fund III',
        commitment: '$30,000,000',
        funded: '$24,000,000',
        irr: '12.7%',
        status: 'Active',
    },
]

const savedReports = [
    { id: 1, date: 'Aug 01, 2025', name: 'Track Record' },
    { id: 2, date: 'Aug 15, 2025', name: 'Portfolio Summary' },
    { id: 3, date: 'Sep 02, 2025', name: 'Pipeline Analysis' },
    { id: 4, date: 'Oct 05, 2025', name: 'Track Record' },
    { id: 5, date: 'Nov 10, 2025', name: 'Portfolio Summary' },
]

const getStatusColor = (status: string) => {
    if (status === 'Active') return '#4caf50'
    if (status === 'Exited') return '#ff9800'
    return '#757575'
}
</script>

<style scoped>
.reporting-page {
    padding: 0;
}

.page-header {
    margin-bottom: 1.5rem;
}

.page-title {
    font-size: 2rem;
    font-weight: 500;
    color: #333;
    margin-bottom: 1rem;
}

.reporting-tabs :deep(.v-tab) {
    text-transform: none;
    font-weight: 500;
    color: #666;
}

.reporting-tabs :deep(.v-tab--selected) {
    color: #d4a574;
}

.filter-section {
    background: white;
    border-radius: 8px;
    padding: 1rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.filter-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.filter-label {
    font-size: 0.875rem;
    color: #666;
    font-weight: 500;
}

.filter-chip {
    text-transform: none;
    font-weight: 500;
}

.run-report-btn {
    text-transform: none;
    font-weight: 500;
    color: white;
}

.kpi-section .v-col {
    padding: 0.5rem;
}

.kpi-card {
    background: #1e3a5f;
    color: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.kpi-label {
    font-size: 0.875rem;
    color: rgba(255, 255, 255, 0.7);
    margin-bottom: 0.5rem;
}

.kpi-value {
    font-size: 1.75rem;
    font-weight: 600;
    color: white;
}

.kpi-highlight {
    color: #d4a574;
}

.main-content-row {
    margin-top: 0;
}

.main-content-row .v-col {
    padding: 0.5rem;
}

.charts-section .v-col {
    padding: 0.5rem;
}

.chart-card {
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    height: 100%;
}

.chart-title {
    font-size: 1.125rem;
    font-weight: 500;
    color: #333;
    padding: 1rem 1rem 0.5rem;
}

.table-card {
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.table-title {
    font-size: 1.125rem;
    font-weight: 500;
    color: #333;
    padding: 1rem;
    border-bottom: 1px solid #f0f0f0;
}

.table-actions {
    border-bottom: 1px solid #f0f0f0;
}

.reporting-table :deep(.v-data-table__th) {
    background-color: #f8f9fa;
    font-weight: 600;
    color: #333;
    font-size: 0.875rem;
    padding: 12px 16px;
}

.reporting-table :deep(.v-data-table__td) {
    padding: 12px 16px;
    font-size: 0.875rem;
}

.irr-value {
    font-weight: 600;
    color: #d4a574;
}

.saved-reports-card {
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    height: fit-content;
    position: sticky;
    top: 1rem;
}

.saved-reports-title {
    font-size: 1.125rem;
    font-weight: 500;
    color: #333;
    padding: 1rem;
    border-bottom: 1px solid #f0f0f0;
}

.saved-reports-list {
    display: flex;
    flex-direction: column;
    padding: 1rem;
    gap: 0.75rem;
}

.saved-report-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem;
    background: #f8f9fa;
    border-radius: 6px;
    border: 1px solid #e9ecef;
}

.report-info {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.report-date {
    font-size: 0.75rem;
    color: #666;
    font-weight: 500;
}

.report-name {
    font-size: 0.875rem;
    color: #333;
    font-weight: 500;
}

.re-run-btn {
    text-transform: none;
    font-weight: 500;
    color: white;
    min-width: 70px;
}
</style>
