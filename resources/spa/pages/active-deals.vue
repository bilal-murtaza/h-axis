<template>
    <Layout>
        <div class="capital-calls">
            <!-- Header Section -->
            <div
                class="page-header d-flex justify-space-between align-center mb-6">
                <div>
                    <h1 class="page-title">Capital Calls</h1>
                    <div class="date-range-info">
                        <v-chip
                            class="mr-2"
                            color="grey-lighten-2"
                            size="small">
                            <v-icon size="16" start>mdi-calendar</v-icon>
                            Date Range: Oct 1 – Dec 31
                        </v-chip>
                        <v-chip
                            class="mr-2"
                            color="orange-lighten-4"
                            size="small">
                            <v-icon size="16" start>mdi-folder</v-icon>
                            Fund: Fund I
                        </v-chip>
                        <v-chip color="orange-lighten-4" size="small">
                            <v-icon size="16" start>mdi-clock-outline</v-icon>
                            Status: Pending
                        </v-chip>
                    </div>
                </div>
                <div class="action-buttons">
                    <v-btn
                        class="mr-2"
                        color="orange"
                        variant="outlined"
                        @click="generateNotice">
                        <v-icon start>mdi-file-document-plus</v-icon>
                        Generate Notice
                    </v-btn>
                    <v-btn
                        class="mr-2"
                        color="primary"
                        variant="outlined"
                        @click="exportPDF">
                        <v-icon start>mdi-file-pdf-box</v-icon>
                        Export PDF
                    </v-btn>
                    <v-btn
                        color="success"
                        variant="outlined"
                        @click="exportExcel">
                        <v-icon start>mdi-file-excel</v-icon>
                        Export Excel
                    </v-btn>
                </div>
            </div>

            <v-row>
                <!-- Capital Calls Table -->
                <v-col cols="12" md="8">
                    <v-card class="capital-calls-table">
                        <v-card-title class="table-header">
                            <span class="text-h6">Capital Call Records</span>
                        </v-card-title>

                        <v-data-table
                            class="elevation-0"
                            :headers="headers"
                            hide-default-footer
                            :items="capitalCalls"
                            :items-per-page="-1">
                            <template #item.date="{ item }">
                                <span class="date-cell">
                                    {{ formatDate(item.date) }}
                                </span>
                            </template>

                            <template #item.amount="{ item }">
                                <span class="amount-cell">
                                    {{ formatCurrency(item.amount) }}
                                </span>
                            </template>

                            <template #item.fund="{ item }">
                                <v-chip
                                    :color="getFundColor(item.fund)"
                                    size="small"
                                    variant="outlined">
                                    {{ item.fund }}
                                </v-chip>
                            </template>

                            <template #item.investorGroup="{ item }">
                                <span class="investor-group-cell">
                                    {{ item.investorGroup }}
                                </span>
                            </template>

                            <template #item.status="{ item }">
                                <v-chip
                                    :color="getStatusColor(item.status)"
                                    size="small"
                                    :variant="
                                        item.status === 'Completed'
                                            ? 'flat'
                                            : 'outlined'
                                    ">
                                    {{ item.status }}
                                </v-chip>
                            </template>
                        </v-data-table>
                    </v-card>
                </v-col>

                <!-- Notice Preview Panel -->
                <v-col cols="12" md="4">
                    <v-card class="notice-preview">
                        <v-card-title class="notice-header">
                            <span class="text-h6">Notice Preview</span>
                        </v-card-title>

                        <v-card-text class="notice-content">
                            <div class="notice-title mb-4">
                                <h3>Capital Call Notice</h3>
                            </div>

                            <div class="notice-details">
                                <div class="detail-row mb-2">
                                    <span class="detail-label">Fund:</span>
                                    <span class="detail-value">Fund I</span>
                                </div>
                                <div class="detail-row mb-2">
                                    <span class="detail-label">Investor:</span>
                                    <span class="detail-value">Group A</span>
                                </div>
                                <div class="detail-row mb-2">
                                    <span class="detail-label">
                                        Amount Due:
                                    </span>
                                    <span class="detail-value font-weight-bold">
                                        $5,000,000
                                    </span>
                                </div>
                                <div class="detail-row mb-4">
                                    <span class="detail-label">Due Date:</span>
                                    <span class="detail-value">
                                        Nov 15, 2025
                                    </span>
                                </div>

                                <v-divider class="my-4" />

                                <div class="bank-details">
                                    <h4 class="mb-3">Banking Instructions</h4>
                                    <p class="mb-2">
                                        Please remit funds to the account listed
                                        below:
                                    </p>
                                    <div class="bank-info">
                                        <div class="bank-row">
                                            <span class="bank-label">
                                                Bank:
                                            </span>
                                            <span class="bank-value">
                                                ABC Bank
                                            </span>
                                        </div>
                                        <div class="bank-row">
                                            <span class="bank-label">
                                                Account #:
                                            </span>
                                            <span class="bank-value">
                                                123456789
                                            </span>
                                        </div>
                                        <div class="bank-row">
                                            <span class="bank-label">
                                                Routing #:
                                            </span>
                                            <span class="bank-value">
                                                987654321
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
import { ref } from 'vue'
import Layout from '@/components/ui/layout.vue'

// Table headers
const headers = [
    { title: 'Date', value: 'date', sortable: true },
    { title: 'Amount', value: 'amount', sortable: true },
    { title: 'Fund', value: 'fund', sortable: true },
    { title: 'Investor Group', value: 'investorGroup', sortable: true },
    { title: 'Status', value: 'status', sortable: true },
]

// Capital calls data (matching the design)
const capitalCalls = ref([
    {
        date: '2024-11-01',
        amount: 5_000_000,
        fund: 'Fund I',
        investorGroup: 'Group A',
        status: 'Pending',
    },
    {
        date: '2024-11-03',
        amount: 3_200_000,
        fund: 'Fund II',
        investorGroup: 'Group B',
        status: 'Completed',
    },
    {
        date: '2024-11-10',
        amount: 4_500_000,
        fund: 'Fund I',
        investorGroup: 'Group C',
        status: 'Pending',
    },
])

// Helper functions
const formatDate = (dateString: string) => {
    const date = new Date(dateString)
    return date.toLocaleDateString('en-US', {
        month: 'short',
        day: 'numeric',
    })
}

const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
    }).format(amount)
}

const getFundColor = (fund: string) => {
    return fund === 'Fund I' ? 'blue' : 'purple'
}

const getStatusColor = (status: string) => {
    switch (status) {
    case 'Completed': {
        return 'success'
    }
    case 'Pending': {
        return 'warning'
    }
    default: {
        return 'grey'
    }
    }
}

// Action handlers
const generateNotice = () => {
    console.log('Generating notice...')
    // Add notice generation logic here
}

const exportPDF = () => {
    console.log('Exporting PDF...')
    // Add PDF export logic here
}

const exportExcel = () => {
    console.log('Exporting Excel...')
    // Add Excel export logic here
}
</script>

<style scoped>
.capital-calls {
    max-width: 1400px;
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

.date-range-info {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.action-buttons {
    display: flex;
    align-items: center;
}

.capital-calls-table,
.notice-preview {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    height: fit-content;
}

.table-header,
.notice-header {
    padding: 1.5rem 1.5rem 0.5rem 1.5rem;
    border-bottom: 1px solid #f0f0f0;
}

.notice-preview {
    position: sticky;
    top: 24px;
}

.notice-content {
    padding: 1.5rem;
}

.notice-title h3 {
    color: #333;
    font-weight: 600;
    margin-bottom: 1rem;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
}

.detail-label {
    color: #666;
    font-weight: 500;
}

.detail-value {
    color: #333;
    text-align: right;
}

.bank-details h4 {
    color: #333;
    font-weight: 600;
    font-size: 1.1rem;
}

.bank-details p {
    color: #666;
    line-height: 1.5;
}

.bank-info {
    background: #f8f9fa;
    padding: 1rem;
    border-radius: 8px;
    margin-top: 0.5rem;
}

.bank-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 0.5rem;
}

.bank-row:last-child {
    margin-bottom: 0;
}

.bank-label {
    color: #666;
    font-weight: 500;
}

.bank-value {
    color: #333;
    font-family: 'Courier New', monospace;
}

/* Table styling */
:deep(.v-data-table) {
    background: transparent;
}

:deep(.v-data-table-header) {
    background: #f8f9fa;
}

:deep(.v-data-table-header th) {
    font-weight: 600 !important;
    color: #333 !important;
}

.date-cell {
    font-weight: 500;
    color: #333;
}

.amount-cell {
    font-weight: 600;
    color: #333;
    font-family: 'Roboto Mono', monospace;
}

.investor-group-cell {
    color: #333;
}

/* Responsive design */
@media (max-width: 960px) {
    .page-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem;
    }

    .action-buttons {
        width: 100%;
        justify-content: flex-start;
        flex-wrap: wrap;
        gap: 0.5rem;
    }

    .notice-preview {
        position: static;
        margin-top: 1rem;
    }
}
</style>
