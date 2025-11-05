<template>
    <Layout>
        <div class="capital-calls">
            <!-- Header Section -->
            <div
                class="page-header d-flex justify-space-between align-center mb-6">
                <div>
                    <h1 class="page-title">Active Deals</h1>
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
                        <v-card-title
                            class="table-header d-flex justify-space-between align-center">
                            <span class="text-h6 mt-n4">
                                Capital Call Records
                            </span>

                            <v-btn
                                class="mb-4"
                                color="primary"
                                @click="openAddDialog">
                                <v-icon start>mdi-plus</v-icon>
                                Add New Record
                            </v-btn>
                        </v-card-title>

                        <v-tabs v-model="activeTab" class="px-4">
                            <v-tab value="forecasted">
                                Forecasted Activity
                            </v-tab>
                            <v-tab value="actual">Actual Activity</v-tab>
                        </v-tabs>

                        <v-tabs-window v-model="activeTab">
                            <!-- Forecasted Activity Tab -->
                            <v-window-item value="forecasted">
                                <div class="pa-4">
                                    <v-data-table
                                        class="elevation-0"
                                        :headers="headersWithActions"
                                        hide-default-footer
                                        :items="forecastedCalls"
                                        :items-per-page="-1">
                                        <template #item.date="{ item }">
                                            <span class="date-cell">
                                                {{ formatDate(item.date) }}
                                            </span>
                                        </template>

                                        <template #item.amount="{ item }">
                                            <span class="amount-cell">
                                                {{
                                                    formatCurrency(item.amount)
                                                }}
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

                                        <template
                                            #item.investorGroup="{ item }">
                                            <span class="investor-group-cell">
                                                {{ item.investorGroup }}
                                            </span>
                                        </template>

                                        <template #item.status="{ item }">
                                            <v-chip
                                                :color="
                                                    getStatusColor(item.status)
                                                "
                                                size="small"
                                                :variant="
                                                    item.status === 'Completed'
                                                        ? 'flat'
                                                        : 'outlined'
                                                ">
                                                {{ item.status }}
                                            </v-chip>
                                        </template>

                                        <template #item.actions="{ item }">
                                            <v-btn
                                                icon="mdi-pencil"
                                                size="small"
                                                variant="text"
                                                @click="openEditDialog(item)" />
                                        </template>
                                    </v-data-table>
                                </div>
                            </v-window-item>

                            <!-- Actual Activity Tab -->
                            <v-window-item value="actual">
                                <div class="pa-4">
                                    <v-data-table
                                        class="elevation-0"
                                        :headers="headersWithActions"
                                        hide-default-footer
                                        :items="actualCalls"
                                        :items-per-page="-1">
                                        <template #item.date="{ item }">
                                            <span class="date-cell">
                                                {{ formatDate(item.date) }}
                                            </span>
                                        </template>

                                        <template #item.amount="{ item }">
                                            <span class="amount-cell">
                                                {{
                                                    formatCurrency(item.amount)
                                                }}
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

                                        <template
                                            #item.investorGroup="{ item }">
                                            <span class="investor-group-cell">
                                                {{ item.investorGroup }}
                                            </span>
                                        </template>

                                        <template #item.status="{ item }">
                                            <v-chip
                                                :color="
                                                    getStatusColor(item.status)
                                                "
                                                size="small"
                                                :variant="
                                                    item.status === 'Completed'
                                                        ? 'flat'
                                                        : 'outlined'
                                                ">
                                                {{ item.status }}
                                            </v-chip>
                                        </template>

                                        <template #item.actions="{ item }">
                                            <v-btn
                                                icon="mdi-pencil"
                                                size="small"
                                                variant="text"
                                                @click="openEditDialog(item)" />
                                        </template>
                                    </v-data-table>
                                </div>
                            </v-window-item>
                        </v-tabs-window>
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

            <!-- Add/Edit Dialog -->
            <v-dialog v-model="dialog" max-width="600px">
                <v-card>
                    <v-card-title>
                        <span class="text-h5">
                            {{ editingIndex === -1 ? 'Add New' : 'Edit' }}
                            Record
                        </span>
                    </v-card-title>

                    <v-card-text>
                        <v-container>
                            <v-row>
                                <v-col cols="12">
                                    <v-text-field
                                        v-model="formData.date"
                                        label="Date"
                                        required
                                        type="date"
                                        variant="outlined" />
                                </v-col>

                                <v-col cols="12">
                                    <v-text-field
                                        v-model.number="formData.amount"
                                        label="Amount"
                                        prefix="$"
                                        required
                                        type="number"
                                        variant="outlined" />
                                </v-col>

                                <v-col cols="12">
                                    <v-select
                                        v-model="formData.fund"
                                        :items="[
                                            'Fund I',
                                            'Fund II',
                                            'Fund III',
                                        ]"
                                        label="Fund"
                                        required
                                        variant="outlined" />
                                </v-col>

                                <v-col cols="12">
                                    <v-text-field
                                        v-model="formData.investorGroup"
                                        label="Investor Group"
                                        required
                                        variant="outlined" />
                                </v-col>

                                <v-col cols="12">
                                    <v-select
                                        v-model="formData.status"
                                        :items="[
                                            'Pending',
                                            'Completed',
                                            'In Progress',
                                        ]"
                                        label="Status"
                                        required
                                        variant="outlined" />
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-card-text>

                    <v-card-actions>
                        <v-spacer />
                        <v-btn color="grey" variant="text" @click="closeDialog">
                            Cancel
                        </v-btn>
                        <v-btn
                            color="primary"
                            variant="flat"
                            @click="saveRecord">
                            Save
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </div>
    </Layout>
</template>

<script lang="ts" setup>
import Layout from '@/components/ui/layout.vue'
import { computed, ref } from 'vue'

// Types
interface CapitalCall {
    date: string
    amount: number
    fund: string
    investorGroup: string
    status: string
    type: 'forecasted' | 'actual'
}

// Tab state
const activeTab = ref('forecasted')

// Dialog state
const dialog = ref(false)
const editingIndex = ref(-1)
const formData = ref<CapitalCall>({
    date: '',
    amount: 0,
    fund: '',
    investorGroup: '',
    status: 'Pending',
    type: 'forecasted',
})

// Table headers
const headersWithActions = [
    { title: 'Date', value: 'date', sortable: true },
    { title: 'Amount', value: 'amount', sortable: true },
    { title: 'Fund', value: 'fund', sortable: true },
    { title: 'Investor Group', value: 'investorGroup', sortable: true },
    { title: 'Status', value: 'status', sortable: true },
    { title: 'Actions', value: 'actions', sortable: false, width: '100px' },
]

// Capital calls data with type property
const capitalCalls = ref<CapitalCall[]>([
    {
        date: '2024-11-01',
        amount: 5_000_000,
        fund: 'Fund I',
        investorGroup: 'Group A',
        status: 'Pending',
        type: 'forecasted',
    },
    {
        date: '2024-11-03',
        amount: 3_200_000,
        fund: 'Fund II',
        investorGroup: 'Group B',
        status: 'Completed',
        type: 'forecasted',
    },
    {
        date: '2024-11-10',
        amount: 4_500_000,
        fund: 'Fund I',
        investorGroup: 'Group C',
        status: 'Pending',
        type: 'actual',
    },
])

// Computed filtered arrays
const forecastedCalls = computed(() =>
    capitalCalls.value.filter((call) => call.type === 'forecasted'),
)

const actualCalls = computed(() =>
    capitalCalls.value.filter((call) => call.type === 'actual'),
)

// Dialog functions
const openAddDialog = () => {
    editingIndex.value = -1
    formData.value = {
        date: '',
        amount: 0,
        fund: '',
        investorGroup: '',
        status: 'Pending',
        type: 'forecasted',
    }
    dialog.value = true
}

const openEditDialog = (item: CapitalCall) => {
    const index = capitalCalls.value.findIndex(
        (call) =>
            call.date === item.date &&
            call.amount === item.amount &&
            call.fund === item.fund &&
            call.investorGroup === item.investorGroup,
    )
    editingIndex.value = index
    formData.value = { ...item }
    dialog.value = true
}

const closeDialog = () => {
    dialog.value = false
    editingIndex.value = -1
    formData.value = {
        date: '',
        amount: 0,
        fund: '',
        investorGroup: '',
        status: 'Pending',
        type: 'forecasted',
    }
}

const saveRecord = () => {
    if (editingIndex.value === -1) {
        // Add new record
        capitalCalls.value.push({ ...formData.value })
    } else {
        // Edit existing record
        capitalCalls.value[editingIndex.value] = { ...formData.value }
    }
    closeDialog()
}

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
    if (status === 'Completed') {
        return 'success'
    }
    if (status === 'Pending') {
        return 'warning'
    }
    return 'grey'
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
