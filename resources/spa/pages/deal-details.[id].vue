<template>
    <Layout>
        <div v-if="deal" class="deal-details">
            <!-- Back Button -->
            <v-btn class="mb-4" color="primary" variant="text" @click="goBack">
                <v-icon start>mdi-arrow-left</v-icon>
                Back to Active Deals
            </v-btn>

            <!-- Header Section -->
            <div class="page-header mb-6">
                <h1 class="page-title">Deal Details</h1>
            </div>

            <!-- Deal Overview Tabs -->
            <v-card class="mb-6">
                <v-tabs v-model="activeTab">
                    <v-tab value="overview">Overview</v-tab>
                    <v-tab value="performance">Performance</v-tab>
                    <v-tab value="capital-call-history">
                        Capital Call History
                    </v-tab>
                </v-tabs>
            </v-card>

            <v-row>
                <!-- Left Side - Main Content -->
                <v-col cols="12" md="8">
                    <v-tabs-window v-model="activeTab">
                        <!-- Overview Tab -->
                        <v-window-item value="overview">
                            <v-card class="deal-overview-card">
                                <v-card-title class="card-header">
                                    Overview
                                </v-card-title>
                                <v-card-text>
                                    <div class="overview-grid">
                                        <div class="overview-item">
                                            <span class="item-label">
                                                Manager
                                            </span>
                                            <span class="item-value">
                                                {{ deal.manager }}
                                            </span>
                                        </div>
                                        <div class="overview-item">
                                            <span class="item-label">
                                                Sector
                                            </span>
                                            <span class="item-value">
                                                {{ deal.sector }}
                                            </span>
                                        </div>
                                        <div class="overview-item">
                                            <span class="item-label">
                                                Country
                                            </span>
                                            <span class="item-value">
                                                {{ deal.country }}
                                            </span>
                                        </div>
                                        <div class="overview-item">
                                            <span class="item-label">
                                                Commitment
                                            </span>
                                            <span class="item-value">
                                                {{
                                                    formatCurrency(
                                                        deal.commitment,
                                                    )
                                                }}
                                            </span>
                                        </div>
                                        <div class="overview-item">
                                            <span class="item-label">
                                                Close Date
                                            </span>
                                            <span class="item-value">
                                                {{ deal.close }}
                                            </span>
                                        </div>
                                        <div class="overview-item">
                                            <span class="item-label">
                                                Maturity
                                            </span>
                                            <span class="item-value">
                                                {{ deal.maturity }}
                                            </span>
                                        </div>
                                    </div>
                                </v-card-text>
                            </v-card>
                        </v-window-item>

                        <!-- Performance Tab -->
                        <v-window-item value="performance">
                            <v-card class="performance-card">
                                <v-card-title class="card-header">
                                    Performance
                                </v-card-title>
                                <v-card-text>
                                    <div class="performance-metrics">
                                        <div class="metric-card">
                                            <div class="metric-label">IRR</div>
                                            <div class="metric-value">
                                                {{ formatPercentage(deal.irr) }}
                                            </div>
                                            <div class="metric-subtitle">
                                                Internal Rate of Return
                                            </div>
                                        </div>
                                        <div class="metric-card">
                                            <div class="metric-label">TVPI</div>
                                            <div class="metric-value">
                                                {{ deal.tvpi.toFixed(1) }}
                                            </div>
                                            <div class="metric-subtitle">
                                                Total Value to Paid-In
                                            </div>
                                        </div>
                                    </div>
                                </v-card-text>
                            </v-card>
                        </v-window-item>

                        <!-- Capital Call History Tab -->
                        <v-window-item value="capital-call-history">
                            <v-card class="capital-call-card">
                                <v-card-title
                                    class="card-header d-flex justify-space-between align-center">
                                    <span>Capital Call History</span>
                                    <v-btn
                                        color="primary"
                                        size="small"
                                        @click="openAddDialog">
                                        <v-icon start>mdi-plus</v-icon>
                                        Add New Record
                                    </v-btn>
                                </v-card-title>

                                <v-tabs v-model="capitalCallTab" class="px-4">
                                    <v-tab value="forecasted">
                                        Forecasted Activity
                                    </v-tab>
                                    <v-tab value="actual">
                                        Actual Activity
                                    </v-tab>
                                </v-tabs>

                                <v-tabs-window v-model="capitalCallTab">
                                    <!-- Forecasted Activity Tab -->
                                    <v-window-item value="forecasted">
                                        <div class="pa-4">
                                            <v-data-table
                                                class="capital-call-table"
                                                :headers="capitalCallHeaders"
                                                hide-default-footer
                                                :items="forecastedCalls"
                                                :items-per-page="-1">
                                                <template #item.date="{ item }">
                                                    <span class="date-cell">
                                                        {{
                                                            formatDate(
                                                                item.date,
                                                            )
                                                        }}
                                                    </span>
                                                </template>

                                                <template
                                                    #item.amount="{ item }">
                                                    <span class="amount-cell">
                                                        {{
                                                            formatCurrency(
                                                                item.amount,
                                                            )
                                                        }}
                                                    </span>
                                                </template>

                                                <template #item.type="{ item }">
                                                    <v-chip
                                                        :color="
                                                            item.type ===
                                                            'Capital Call'
                                                                ? 'blue'
                                                                : 'green'
                                                        "
                                                        size="small"
                                                        variant="outlined">
                                                        {{ item.type }}
                                                    </v-chip>
                                                </template>

                                                <template
                                                    #item.status="{ item }">
                                                    <v-chip
                                                        :color="
                                                            getStatusColor(
                                                                item.status,
                                                            )
                                                        "
                                                        size="small"
                                                        variant="flat">
                                                        {{ item.status }}
                                                    </v-chip>
                                                </template>

                                                <template
                                                    #item.actions="{ item }">
                                                    <v-btn
                                                        icon="mdi-pencil"
                                                        size="small"
                                                        variant="text"
                                                        @click="
                                                            openEditDialog(item)
                                                        " />
                                                </template>
                                            </v-data-table>
                                        </div>
                                    </v-window-item>

                                    <!-- Actual Activity Tab -->
                                    <v-window-item value="actual">
                                        <div class="pa-4">
                                            <v-data-table
                                                class="capital-call-table"
                                                :headers="capitalCallHeaders"
                                                hide-default-footer
                                                :items="actualCalls"
                                                :items-per-page="-1">
                                                <template #item.date="{ item }">
                                                    <span class="date-cell">
                                                        {{
                                                            formatDate(
                                                                item.date,
                                                            )
                                                        }}
                                                    </span>
                                                </template>

                                                <template
                                                    #item.amount="{ item }">
                                                    <span class="amount-cell">
                                                        {{
                                                            formatCurrency(
                                                                item.amount,
                                                            )
                                                        }}
                                                    </span>
                                                </template>

                                                <template #item.type="{ item }">
                                                    <v-chip
                                                        :color="
                                                            item.type ===
                                                            'Capital Call'
                                                                ? 'blue'
                                                                : 'green'
                                                        "
                                                        size="small"
                                                        variant="outlined">
                                                        {{ item.type }}
                                                    </v-chip>
                                                </template>

                                                <template
                                                    #item.status="{ item }">
                                                    <v-chip
                                                        :color="
                                                            getStatusColor(
                                                                item.status,
                                                            )
                                                        "
                                                        size="small"
                                                        variant="flat">
                                                        {{ item.status }}
                                                    </v-chip>
                                                </template>

                                                <template
                                                    #item.actions="{ item }">
                                                    <v-btn
                                                        icon="mdi-pencil"
                                                        size="small"
                                                        variant="text"
                                                        @click="
                                                            openEditDialog(item)
                                                        " />
                                                </template>
                                            </v-data-table>
                                        </div>
                                    </v-window-item>
                                </v-tabs-window>
                            </v-card>
                        </v-window-item>
                    </v-tabs-window>
                </v-col>

                <!-- Right Side - Deal Sidebar -->
                <v-col cols="12" md="4">
                    <v-card class="deal-sidebar">
                        <v-card-title class="sidebar-header">
                            <v-icon class="mr-2">mdi-information</v-icon>
                            Deal Information
                        </v-card-title>
                        <v-card-text>
                            <div class="sidebar-section">
                                <h4 class="section-title">Key Metrics</h4>
                                <div class="detail-row">
                                    <span class="detail-label">IRR:</span>
                                    <span class="detail-value highlight">
                                        {{ formatPercentage(deal.irr) }}
                                    </span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">TVPI:</span>
                                    <span class="detail-value highlight">
                                        {{ deal.tvpi.toFixed(1) }}
                                    </span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">
                                        Commitment:
                                    </span>
                                    <span class="detail-value">
                                        {{ formatCurrency(deal.commitment) }}
                                    </span>
                                </div>
                            </div>

                            <v-divider class="my-4" />

                            <div class="sidebar-section">
                                <h4 class="section-title">Documents</h4>
                                <v-list density="compact">
                                    <v-list-item class="px-0">
                                        <template #prepend>
                                            <v-icon size="20">
                                                mdi-file-document
                                            </v-icon>
                                        </template>
                                        <v-list-item-title>
                                            Lean Agreement
                                        </v-list-item-title>
                                        <v-list-item-subtitle>
                                            12/01/2022
                                        </v-list-item-subtitle>
                                    </v-list-item>
                                </v-list>
                            </div>

                            <v-divider class="my-4" />

                            <div class="sidebar-section">
                                <h4 class="section-title">
                                    Distribution Summary
                                </h4>
                                <div class="detail-row">
                                    <span class="detail-label">
                                        Total Distributions:
                                    </span>
                                    <span class="detail-value">
                                        {{ formatCurrency(totalDistributions) }}
                                    </span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">
                                        Total Capital Calls:
                                    </span>
                                    <span class="detail-value">
                                        {{ formatCurrency(totalCapitalCalls) }}
                                    </span>
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>

            <!-- Add/Edit Dialog -->
            <v-dialog
                v-model="dialog"
                :max-width="
                    formData.activityType === 'forecasted' &&
                    editingIndex !== -1
                        ? '900px'
                        : '600px'
                ">
                <v-card>
                    <v-card-title>
                        <span class="text-h5">
                            {{ editingIndex === -1 ? 'Add New' : 'Edit' }}
                            Capital Call Record
                        </span>
                    </v-card-title>

                    <v-card-text>
                        <v-container>
                            <v-row>
                                <!-- Left Column - Form Fields -->
                                <v-col
                                    :cols="
                                        formData.activityType ===
                                            'forecasted' && editingIndex !== -1
                                            ? 6
                                            : 12
                                    ">
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
                                            <v-text-field
                                                v-model="formData.description"
                                                label="Description"
                                                required
                                                variant="outlined" />
                                        </v-col>

                                        <v-col cols="12">
                                            <v-select
                                                v-model="formData.type"
                                                :items="[
                                                    'Capital Call',
                                                    'Distribution',
                                                ]"
                                                label="Type"
                                                required
                                                variant="outlined" />
                                        </v-col>

                                        <v-col cols="12">
                                            <v-select
                                                v-model="formData.status"
                                                :items="[
                                                    'Pending',
                                                    'Completed',
                                                ]"
                                                label="Status"
                                                required
                                                variant="outlined" />
                                        </v-col>
                                    </v-row>
                                </v-col>

                                <!-- Right Column - Workflow Checklist (only for forecasted edits) -->
                                <v-col
                                    v-if="
                                        formData.activityType ===
                                            'forecasted' && editingIndex !== -1
                                    "
                                    cols="6">
                                    <div class="workflow-checklist">
                                        <h3 class="checklist-title mb-4">
                                            Review Workflow
                                        </h3>

                                        <v-list>
                                            <!-- Initial Review Complete -->
                                            <v-list-item class="px-0">
                                                <template #prepend>
                                                    <v-checkbox
                                                        v-model="
                                                            workflowChecklist.initialReview
                                                        "
                                                        color="primary"
                                                        hide-details />
                                                </template>
                                                <v-list-item-title
                                                    class="font-weight-medium">
                                                    Initial Review Complete
                                                </v-list-item-title>
                                                <v-list-item-subtitle>
                                                    Preliminary review and
                                                    validation of capital call
                                                    details
                                                </v-list-item-subtitle>
                                            </v-list-item>

                                            <v-divider class="my-2" />

                                            <!-- Second Review -->
                                            <v-list-item
                                                class="px-0"
                                                :disabled="
                                                    !isSecondReviewEnabled
                                                ">
                                                <template #prepend>
                                                    <v-checkbox
                                                        v-model="
                                                            workflowChecklist.secondReview
                                                        "
                                                        color="primary"
                                                        :disabled="
                                                            !isSecondReviewEnabled
                                                        "
                                                        hide-details />
                                                </template>
                                                <v-list-item-title
                                                    class="font-weight-medium">
                                                    Second Review
                                                </v-list-item-title>
                                                <v-list-item-subtitle>
                                                    Secondary verification and
                                                    cross-check of all
                                                    information
                                                </v-list-item-subtitle>
                                            </v-list-item>

                                            <v-divider class="my-2" />

                                            <!-- Deal Team Approval -->
                                            <v-list-item
                                                class="px-0"
                                                :disabled="
                                                    !isDealTeamApprovalEnabled
                                                ">
                                                <template #prepend>
                                                    <v-checkbox
                                                        v-model="
                                                            workflowChecklist.dealTeamApproval
                                                        "
                                                        color="primary"
                                                        :disabled="
                                                            !isDealTeamApprovalEnabled
                                                        "
                                                        hide-details />
                                                </template>
                                                <v-list-item-title
                                                    class="font-weight-medium">
                                                    Deal Team Approval
                                                </v-list-item-title>
                                                <v-list-item-subtitle>
                                                    Final approval from deal
                                                    team before execution
                                                </v-list-item-subtitle>
                                            </v-list-item>

                                            <v-divider class="my-2" />

                                            <!-- Executed -->
                                            <v-list-item
                                                class="px-0"
                                                :disabled="!isExecutedEnabled">
                                                <template #prepend>
                                                    <v-checkbox
                                                        v-model="
                                                            workflowChecklist.executed
                                                        "
                                                        color="primary"
                                                        :disabled="
                                                            !isExecutedEnabled
                                                        "
                                                        hide-details />
                                                </template>
                                                <v-list-item-title
                                                    class="font-weight-medium">
                                                    Executed
                                                </v-list-item-title>
                                                <v-list-item-subtitle>
                                                    Capital call has been
                                                    executed and processed
                                                </v-list-item-subtitle>
                                            </v-list-item>
                                        </v-list>

                                        <v-alert
                                            v-if="allChecklistComplete"
                                            class="mt-4"
                                            color="success"
                                            density="compact"
                                            type="success"
                                            variant="tonal">
                                            All reviews complete. This record
                                            will be moved to "Actual Activity"
                                            when saved.
                                        </v-alert>
                                    </div>
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

        <!-- Loading State -->
        <div v-else class="loading-container">
            <v-progress-circular color="primary" indeterminate size="64" />
            <p class="mt-4">Loading deal details...</p>
        </div>
    </Layout>
</template>

<script lang="ts" setup>
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'

import Layout from '@/components/ui/layout.vue'

const route = useRoute()
const router = useRouter()

// Types
interface CapitalCall {
    id: number
    date: string
    amount: number
    description: string
    type: string
    status: string
    activityType?: 'forecasted' | 'actual'
}

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
    capitalCalls: CapitalCall[]
}

// State
const deal = ref<Deal | null>(null)
const capitalCalls = ref<CapitalCall[]>([])
const activeTab = ref('overview')
const capitalCallTab = ref('forecasted')

// Dialog state
const dialog = ref(false)
const editingIndex = ref(-1)
const formData = ref<CapitalCall>({
    id: 0,
    date: '',
    amount: 0,
    description: '',
    type: 'Capital Call',
    status: 'Pending',
    activityType: 'forecasted',
})

// Workflow checklist state
const workflowChecklist = ref({
    initialReview: false,
    secondReview: false,
    dealTeamApproval: false,
    executed: false,
})

// Capital Call Table Headers
const capitalCallHeaders = [
    { title: 'Date', value: 'date', sortable: true },
    { title: 'Amount', value: 'amount', sortable: true },
    { title: 'Description', value: 'description', sortable: false },
    { title: 'Type', value: 'type', sortable: true },
    { title: 'Status', value: 'status', sortable: true },
    { title: 'Actions', value: 'actions', sortable: false, width: '100px' },
]

// Computed Values - Workflow checklist enablement
const isSecondReviewEnabled = computed(
    () => workflowChecklist.value.initialReview,
)
const isDealTeamApprovalEnabled = computed(
    () =>
        workflowChecklist.value.initialReview &&
        workflowChecklist.value.secondReview,
)
const isExecutedEnabled = computed(
    () =>
        workflowChecklist.value.initialReview &&
        workflowChecklist.value.secondReview &&
        workflowChecklist.value.dealTeamApproval,
)
const allChecklistComplete = computed(() => {
    return (
        workflowChecklist.value.initialReview &&
        workflowChecklist.value.secondReview &&
        workflowChecklist.value.dealTeamApproval &&
        workflowChecklist.value.executed
    )
})

const forecastedCalls = computed(() => {
    return capitalCalls.value.filter(
        (call) => call.activityType === 'forecasted',
    )
})

const actualCalls = computed(() => {
    return capitalCalls.value.filter((call) => call.activityType === 'actual')
})

const totalDistributions = computed(() => {
    return capitalCalls.value
        .filter((call) => call.type === 'Distribution')
        .reduce((sum, call) => sum + call.amount, 0)
})

const totalCapitalCalls = computed(() => {
    return capitalCalls.value
        .filter((call) => call.type === 'Capital Call')
        .reduce((sum, call) => sum + call.amount, 0)
})

// Load deal data
onMounted(async () => {
    // Get the id from route params
    const params = route.params as Record<string, string | string[]>
    const dealId = Array.isArray(params.id) ? params.id[0] : params.id

    console.log('Route params:', route.params)
    console.log('Deal ID:', dealId)

    if (!dealId) {
        console.error('No deal ID provided')
        router.push('/active-deals')
        return
    }

    try {
        const response = await fetch('/data/deals.json')
        const data = await response.json()
        console.log('Loaded deals data:', data)

        const foundDeal = data.deals.find((d: Deal) => d.id === Number(dealId))
        console.log('Found deal:', foundDeal)

        if (foundDeal) {
            deal.value = foundDeal
            // Add activityType to existing capital calls if not present
            capitalCalls.value = (foundDeal.capitalCalls || []).map(
                (call: CapitalCall, index: number) => ({
                    ...call,
                    activityType:
                        call.activityType ||
                        (index % 2 === 0 ? 'forecasted' : 'actual'),
                }),
            )
        } else {
            console.error('Deal not found with ID:', dealId)
            router.push('/active-deals')
        }
    } catch (error) {
        console.error('Error loading deal:', error)
        router.push('/active-deals')
    }
})

// Dialog functions
const openAddDialog = () => {
    editingIndex.value = -1
    formData.value = {
        id: Date.now(), // Generate a temporary ID
        date: '',
        amount: 0,
        description: '',
        type: 'Capital Call',
        status: 'Pending',
        activityType: capitalCallTab.value as 'forecasted' | 'actual',
    }
    // Reset workflow checklist
    workflowChecklist.value = {
        initialReview: false,
        secondReview: false,
        dealTeamApproval: false,
        executed: false,
    }
    dialog.value = true
}

const openEditDialog = (item: CapitalCall) => {
    const index = capitalCalls.value.findIndex(
        (call) =>
            call.id === item.id ||
            (call.date === item.date &&
                call.amount === item.amount &&
                call.description === item.description),
    )
    editingIndex.value = index
    formData.value = { ...item }
    // Reset workflow checklist for forecasted items
    if (item.activityType === 'forecasted') {
        workflowChecklist.value = {
            initialReview: false,
            secondReview: false,
            dealTeamApproval: false,
            executed: false,
        }
    }
    dialog.value = true
}

const closeDialog = () => {
    dialog.value = false
    editingIndex.value = -1
    formData.value = {
        id: 0,
        date: '',
        amount: 0,
        description: '',
        type: 'Capital Call',
        status: 'Pending',
        activityType: 'forecasted',
    }
    workflowChecklist.value = {
        initialReview: false,
        secondReview: false,
        dealTeamApproval: false,
        executed: false,
    }
}

const saveRecord = () => {
    // If editing a forecasted capital call and all checklist items are complete, change to actual
    if (
        formData.value.activityType === 'forecasted' &&
        allChecklistComplete.value
    ) {
        formData.value.activityType = 'actual'
    }

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
const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
    }).format(amount)
}

const formatPercentage = (value: number) => {
    return `${value.toFixed(2)}%`
}

const formatDate = (dateString: string) => {
    const date = new Date(dateString)
    return date.toLocaleDateString('en-US', {
        month: '2-digit',
        day: '2-digit',
        year: 'numeric',
    })
}

const getStatusColor = (status: string) => {
    return status === 'Completed' ? 'success' : 'warning'
}

const goBack = () => {
    router.push('/active-deals')
}
</script>

<style scoped>
.deal-details {
    max-width: 1600px;
    margin: 0 auto;
}

.loading-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 400px;
}

.page-header {
    margin-bottom: 1.5rem;
}

.page-title {
    font-size: 2rem;
    font-weight: 600;
    color: #333;
}

/* Card Styling */
.deal-overview-card,
.performance-card,
.capital-call-card,
.deal-sidebar {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    height: 100%;
}

.card-header,
.sidebar-header {
    font-size: 1.125rem;
    font-weight: 600;
    color: #333;
    padding: 1.5rem;
    border-bottom: 1px solid #f0f0f0;
}

/* Overview Grid */
.overview-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
    padding: 1rem 0;
}

.overview-item {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.item-label {
    font-size: 0.875rem;
    color: #666;
    font-weight: 500;
}

.item-value {
    font-size: 1.125rem;
    color: #333;
    font-weight: 600;
}

/* Performance Metrics */
.performance-metrics {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 2rem;
    padding: 1rem 0;
}

.metric-card {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 2rem;
    border-radius: 12px;
    color: white;
    text-align: center;
}

.metric-label {
    font-size: 0.875rem;
    opacity: 0.9;
    margin-bottom: 0.5rem;
}

.metric-value {
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}

.metric-subtitle {
    font-size: 0.75rem;
    opacity: 0.8;
}

/* Capital Call Table */
.capital-call-table {
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
}

.date-cell {
    color: #666;
    font-size: 0.875rem;
}

.amount-cell {
    font-weight: 600;
    color: #333;
    font-family: 'Roboto Mono', monospace;
}

/* Sidebar */
.deal-sidebar {
    position: sticky;
    top: 24px;
}

.sidebar-section {
    margin-bottom: 1rem;
}

.section-title {
    font-size: 0.875rem;
    font-weight: 600;
    color: #333;
    margin-bottom: 1rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.75rem;
}

.detail-label {
    font-size: 0.875rem;
    color: #666;
    font-weight: 500;
}

.detail-value {
    font-size: 0.875rem;
    color: #333;
    font-weight: 600;
}

.detail-value.highlight {
    color: #d4a574;
    font-size: 1rem;
}

/* Responsive */
@media (max-width: 960px) {
    .overview-grid,
    .performance-metrics {
        grid-template-columns: 1fr;
    }

    .deal-sidebar {
        position: static;
        margin-top: 1rem;
    }

    .metric-card {
        padding: 1.5rem;
    }

    .metric-value {
        font-size: 2rem;
    }
}

/* Workflow Checklist Styles */
.workflow-checklist {
    background: #f8f9fa;
    border-radius: 8px;
    padding: 1.5rem;
    height: 100%;
}

.checklist-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #333;
}

:deep(.v-list-item--disabled) {
    opacity: 0.5;
}

:deep(.v-list-item-title) {
    margin-bottom: 4px;
}

:deep(.v-list-item-subtitle) {
    font-size: 0.75rem;
    line-height: 1.3;
    white-space: normal;
}
</style>
