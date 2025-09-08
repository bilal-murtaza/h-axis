<template>
    <Layout>
        <div class="earnings-page">
            <!-- Page Header -->
            <div class="page-header mb-6">
                <h1 class="page-title">Earnings & Distributions</h1>
            </div>

            <!-- Key Metrics Cards -->
            <v-row class="mb-6">
                <v-col cols="12" md="4">
                    <v-card class="metric-card" elevation="2">
                        <v-card-text class="pa-6">
                            <div class="metric-label">
                                Total Distributions YTD
                            </div>
                            <div class="metric-value">$45,200,000</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="4">
                    <v-card class="metric-card" elevation="2">
                        <v-card-text class="pa-6">
                            <div class="metric-label">Avg. Yield</div>
                            <div class="metric-value">8.6%</div>
                        </v-card-text>
                    </v-card>
                </v-col>
                <v-col cols="12" md="4">
                    <v-card class="metric-card" elevation="2">
                        <v-card-text class="pa-6">
                            <div class="metric-label">% Paid On Time</div>
                            <div class="metric-value">96%</div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>

            <v-row>
                <!-- Payment Calendar -->
                <v-col cols="12" lg="8">
                    <v-card elevation="2">
                        <v-card-title class="pa-6 pb-4">
                            <h3>Payment Calendar</h3>
                        </v-card-title>
                        <v-card-text class="pa-6 pt-0">
                            <v-date-picker
                                v-model="selectedDate"
                                class="custom-calendar"
                                event-color="primary"
                                :events="events"
                                show-adjacent-months
                                width="100%" />

                            <!-- Calendar Legend -->
                            <div class="calendar-legend mt-4">
                                <div class="legend-item">
                                    <div
                                        class="legend-dot"
                                        style="background-color: #4caf50" />
                                    <span>Paid</span>
                                </div>
                                <div class="legend-item">
                                    <div
                                        class="legend-dot"
                                        style="background-color: #ff9800" />
                                    <span>Pending</span>
                                </div>
                                <div class="legend-item">
                                    <div
                                        class="legend-dot"
                                        style="background-color: #f44336" />
                                    <span>Late</span>
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>

                    <!-- Upcoming Payments Table -->
                    <v-card class="mt-6" elevation="2">
                        <v-card-title class="pa-6 pb-4">
                            <h3>Upcoming Payments</h3>
                        </v-card-title>
                        <v-card-text class="pa-0">
                            <v-table>
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Fund</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr
                                        v-for="payment in upcomingPayments"
                                        :key="payment.id">
                                        <td>{{ payment.date }}</td>
                                        <td>{{ payment.fund }}</td>
                                        <td class="font-weight-medium">
                                            ${{
                                                payment.amount.toLocaleString()
                                            }}
                                        </td>
                                        <td>
                                            <v-chip
                                                :color="
                                                    getStatusColor(
                                                        payment.status,
                                                    )
                                                "
                                                size="small"
                                                variant="flat">
                                                {{ payment.status }}
                                            </v-chip>
                                        </td>
                                    </tr>
                                </tbody>
                            </v-table>
                        </v-card-text>
                    </v-card>
                </v-col>

                <!-- Distribution Notice Generator -->
                <v-col cols="12" lg="4">
                    <v-card elevation="2">
                        <v-card-title class="pa-6 pb-4">
                            <h3>Distribution Notice Generator</h3>
                        </v-card-title>
                        <v-card-text class="pa-6 pt-0">
                            <div class="notice-form">
                                <div class="form-field mb-4">
                                    <div class="field-label">
                                        Distribution Notice
                                    </div>
                                    <div class="field-value">Fund: Fund I</div>
                                </div>
                                <div class="form-field mb-4">
                                    <div class="field-label">Investor:</div>
                                    <div class="field-value">Group A</div>
                                </div>
                                <div class="form-field mb-4">
                                    <div class="field-label">Amount:</div>
                                    <div class="field-value">$1,250,000</div>
                                </div>
                                <div class="form-field mb-6">
                                    <div class="field-label">Payment Date:</div>
                                    <div class="field-value">Nov 30, 2025</div>
                                </div>

                                <div class="notice-text mb-6">
                                    Please remit to the designated bank account.
                                </div>

                                <div class="export-buttons">
                                    <v-btn
                                        class="mb-2"
                                        color="primary"
                                        variant="tonal"
                                        @click="exportPDF">
                                        Export PDF
                                    </v-btn>
                                    <v-btn
                                        class="mb-2"
                                        color="secondary"
                                        variant="tonal"
                                        @click="exportExcel">
                                        Export Excel
                                    </v-btn>
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

const selectedDate = ref(new Date())

// Sample events for the calendar
const events = ref(['2025-09-05', '2025-09-15', '2025-09-22', '2025-09-29'])

const upcomingPayments = ref([
    {
        id: 1,
        date: 'Nov 9',
        fund: 'Fund I',
        amount: 2_500_000,
        status: 'Pending',
    },
    {
        id: 2,
        date: 'Nov 15',
        fund: 'Fund II',
        amount: 4_800_000,
        status: 'Late',
    },
    {
        id: 3,
        date: 'Nov 22',
        fund: 'Fund I',
        amount: 3_600_000,
        status: 'Paid',
    },
    {
        id: 4,
        date: 'Nov 28',
        fund: 'Fund III',
        amount: 1_750_000,
        status: 'Pending',
    },
])

const getStatusColor = (status: string) => {
    if (status === 'Paid') {
        return 'success'
    }
    if (status === 'Pending') {
        return 'warning'
    }
    if (status === 'Late') {
        return 'error'
    }
    return 'grey'
}

const exportPDF = () => {
    // Implementation for PDF export
    console.log('Exporting PDF...')
}

const exportExcel = () => {
    // Implementation for Excel export
    console.log('Exporting Excel...')
}
</script>

<style scoped>
.earnings-page {
    max-width: 1400px;
    margin: 0 auto;
}

.page-header {
    margin-bottom: 2rem;
}

.page-title {
    font-size: 2.5rem;
    font-weight: 400;
    color: #2c3e50;
    margin: 0;
}

.metric-card {
    background: linear-gradient(135deg, #1e3a5f 0%, #2c5282 100%);
    color: white;
    border-radius: 12px;
}

.metric-label {
    font-size: 0.9rem;
    opacity: 0.9;
    margin-bottom: 0.5rem;
}

.metric-value {
    font-size: 2rem;
    font-weight: 600;
    color: #fbbf24;
}

.custom-calendar {
    width: 100%;
}

.calendar-legend {
    display: flex;
    gap: 1.5rem;
    margin-top: 1rem;
}

.legend-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.9rem;
}

.legend-dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
}

.notice-form .form-field {
    margin-bottom: 1rem;
}

.field-label {
    font-size: 0.85rem;
    color: #64748b;
    margin-bottom: 0.25rem;
}

.field-value {
    font-weight: 500;
    color: #1e293b;
}

.notice-text {
    font-size: 0.9rem;
    color: #64748b;
    font-style: italic;
}

.export-buttons {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.v-table {
    background: transparent;
}

.v-table th {
    background: #f8fafc;
    font-weight: 600;
    color: #475569;
    border-bottom: 1px solid #e2e8f0;
}

.v-table td {
    border-bottom: 1px solid #f1f5f9;
}

.v-card {
    border-radius: 12px;
}

.v-card-title h3 {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1e293b;
}
</style>
