<template>
    <Layout>
        <div class="closed-deals">
            <!-- Header Section -->
            <div class="page-header mb-6">
                <h1 class="page-title">Active Deals</h1>
            </div>

            <v-row class="mb-6">
                <!-- Summary Stats -->
                <v-col cols="12" md="4">
                    <v-card class="stats-card">
                        <v-card-text>
                            <div class="stats-label">Closed / Exited</div>
                            <div class="stats-value">{{ totalDeals }}</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="4">
                    <v-card class="stats-card">
                        <v-card-text>
                            <div class="stats-label">Outstanding (AJM)</div>
                            <div class="stats-value stats-currency">
                                {{ formatLargeCurrency(totalOutstanding) }}
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="4">
                    <v-card class="stats-card">
                        <v-card-text>
                            <div class="stats-label">Defaults</div>
                            <div class="stats-value">{{ totalDefaults }}</div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>

            <!-- Filter Bar -->
            <v-row class="mb-4">
                <v-col cols="12" md="3">
                    <v-select
                        v-model="statusFilter"
                        density="compact"
                        hide-details
                        :items="['Closed', 'All sectors']"
                        label="Status"
                        variant="outlined" />
                </v-col>
                <v-col cols="12" md="3">
                    <v-select
                        v-model="sectorFilter"
                        density="compact"
                        hide-details
                        :items="[
                            'All sectors',
                            'Healthcare',
                            'Tech',
                            'Industrials',
                        ]"
                        label="Sector"
                        variant="outlined" />
                </v-col>
                <v-col cols="12" md="6">
                    <v-text-field
                        v-model="searchQuery"
                        append-inner-icon="mdi-magnify"
                        density="compact"
                        hide-details
                        placeholder="Search deals, manager, sector..."
                        variant="outlined"
                        @click:append-inner="handleSearch" />
                </v-col>
            </v-row>

            <!-- Sector Chart and Deals Table -->
            <v-row>
                <!-- Deals Table -->
                <v-col cols="12" md="9">
                    <v-card class="deals-table-card">
                        <v-data-table
                            class="deals-table"
                            :headers="tableHeaders"
                            hide-default-footer
                            hover
                            :items="deals"
                            :items-per-page="-1"
                            @click:row="handleRowClick">
                            <template #item.deal="{ item }">
                                <span class="deal-name">{{ item.deal }}</span>
                            </template>

                            <template #item.commitment="{ item }">
                                <span class="amount-cell">
                                    {{ formatCurrency(item.commitment) }}
                                </span>
                            </template>

                            <template #item.close="{ item }">
                                <span class="date-cell">{{ item.close }}</span>
                            </template>

                            <template #item.maturity="{ item }">
                                <span class="date-cell">
                                    {{ item.maturity }}
                                </span>
                            </template>

                            <template #item.irr="{ item }">
                                <span class="metric-cell">
                                    {{ formatPercentage(item.irr) }}
                                </span>
                            </template>

                            <template #item.tvpi="{ item }">
                                <span class="metric-cell">
                                    {{ item.tvpi.toFixed(1) }}
                                </span>
                            </template>
                        </v-data-table>
                    </v-card>
                </v-col>
                <!-- Outstanding by Sector Chart -->
                <v-col cols="12" md="3">
                    <v-card class="sector-chart-card">
                        <v-card-title class="chart-title">
                            Outstanding by Sector
                        </v-card-title>
                        <v-card-text>
                            <div class="sector-bars">
                                <div
                                    v-for="sector in sectorData"
                                    :key="sector.name"
                                    class="sector-item">
                                    <div class="sector-name">
                                        {{ sector.name }}
                                    </div>
                                    <div class="sector-bar-container">
                                        <div
                                            class="sector-bar"
                                            :style="{
                                                width: sector.percentage + '%',
                                            }" />
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
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// Types
interface Deal {
    id: number
    deal: string
    manager: string
    sector: string
    country: string
    commitment: number
    close: string
    maturity: string
    irr: number
    tvpi: number
}

interface SectorData {
    name: string
    value: number
    percentage: number
}

// State
const deals = ref<Deal[]>([])
const statusFilter = ref('Closed')
const sectorFilter = ref('All sectors')
const searchQuery = ref('')

// Computed values
const totalDeals = ref(32)
const totalOutstanding = ref(84_500_000)
const totalDefaults = ref(0)

// Sector data for chart
const sectorData = ref<SectorData[]>([
    { name: 'Healthcare', value: 30, percentage: 100 },
    { name: 'Tech', value: 20, percentage: 67 },
    { name: 'Industrials', value: 15, percentage: 50 },
])

// Table headers
const tableHeaders = [
    { title: 'Deal', value: 'deal', sortable: true },
    { title: 'Manager', value: 'manager', sortable: true },
    { title: 'Sector', value: 'sector', sortable: true },
    { title: 'Country', value: 'country', sortable: true },
    { title: 'Commitment', value: 'commitment', sortable: true },
    { title: 'Close', value: 'close', sortable: true },
    { title: 'Maturity', value: 'maturity', sortable: true },
    { title: 'IRR', value: 'irr', sortable: true },
    { title: 'TVPI', value: 'tvpi', sortable: true },
]

// Load deals data
onMounted(async () => {
    try {
        const response = await fetch('/data/deals.json')
        const data = await response.json()
        deals.value = data.deals
    } catch (error) {
        console.error('Error loading deals:', error)
    }
})

// Helper functions
const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
    }).format(amount)
}

const formatLargeCurrency = (amount: number) => {
    const millions = amount / 1_000_000
    return `$${millions.toFixed(1)}M`
}

const formatPercentage = (value: number) => {
    return `${value.toFixed(2)}%`
}

// Event handlers
const handleRowClick = (_event: any, row: any) => {
    const dealId = row.item.id
    router.push(`/deal-details/${dealId}`)
}

const handleSearch = () => {
    console.log('Searching for:', searchQuery.value)
    // Implement search logic here
}
</script>

<style scoped>
.closed-deals {
    max-width: 1600px;
    margin: 0 auto;
}

.page-header {
    margin-bottom: 1.5rem;
}

.page-title {
    font-size: 2rem;
    font-weight: 600;
    color: #333;
    margin-bottom: 0.5rem;
}

/* Stats Cards */
.stats-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    height: 100%;
}

.stats-card .v-card-text {
    padding: 1.5rem;
}

.stats-label {
    font-size: 0.875rem;
    color: #666;
    margin-bottom: 0.5rem;
    font-weight: 500;
}

.stats-value {
    font-size: 2rem;
    font-weight: 700;
    color: #333;
}

.stats-currency {
    color: #d4a574;
}

/* Sector Chart Card */
.sector-chart-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    height: 100%;
}

.chart-title {
    font-size: 1rem;
    font-weight: 600;
    color: #333;
    padding: 1.5rem 1.5rem 1rem;
}

.sector-bars {
    padding: 1rem 0;
}

.sector-item {
    margin-bottom: 2rem;
}

.sector-item:last-child {
    margin-bottom: 0;
}

.sector-name {
    font-size: 0.875rem;
    color: #666;
    margin-bottom: 0.5rem;
}

.sector-bar-container {
    width: 100%;
    height: 32px;
    background: #e5e7eb;
    border-radius: 4px;
    overflow: hidden;
}

.sector-bar {
    height: 100%;
    background: linear-gradient(90deg, #3b82f6 0%, #1e40af 100%);
    transition: width 0.3s ease;
}

/* Deals Table Card */
.deals-table-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.deals-table {
    background: transparent;
}

:deep(.v-data-table) {
    background: transparent;
}

:deep(.v-data-table-header) {
    background: #f8f9fa;
}

:deep(.v-data-table-header th) {
    font-weight: 600 !important;
    color: #333 !important;
    font-size: 0.875rem !important;
    padding: 1rem 0.75rem !important;
}

:deep(.v-data-table__td) {
    padding: 0.75rem !important;
}

:deep(.v-data-table__tr:hover) {
    background-color: #f8f9fa !important;
    cursor: pointer;
}

.deal-name {
    font-weight: 600;
    color: #333;
}

.amount-cell {
    font-weight: 500;
    color: #333;
    font-family: 'Roboto Mono', monospace;
}

.date-cell {
    color: #666;
    font-size: 0.875rem;
}

.metric-cell {
    font-weight: 500;
    color: #333;
}

/* Filter inputs */
:deep(.v-select),
:deep(.v-text-field) {
    background: white;
}

:deep(.v-field) {
    border-radius: 6px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* Responsive design */
@media (max-width: 960px) {
    .page-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem;
    }

    .stats-value {
        font-size: 1.5rem;
    }

    .sector-chart-card {
        margin-bottom: 1rem;
    }
}
</style>
