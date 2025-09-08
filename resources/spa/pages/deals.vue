<template>
    <Layout>
        <div class="deal-pipeline">
            <!-- Header Section -->
            <div class="pipeline-header mb-6">
                <div class="d-flex justify-space-between align-center mb-4">
                    <h1 class="page-title">Deal Pipeline</h1>
                    <div class="header-actions">
                        <v-btn
                            color="primary"
                            prepend-icon="mdi-plus"
                            variant="elevated">
                            Add Deal
                        </v-btn>
                        <v-btn class="ml-2" variant="outlined">Kanban</v-btn>
                        <v-btn class="ml-2" variant="outlined">Export</v-btn>
                    </div>
                </div>

                <!-- Filter Section -->
                <div class="filter-section">
                    <v-row>
                        <v-col cols="3">
                            <v-select
                                v-model="filters.region"
                                density="compact"
                                :items="[
                                    'North America',
                                    'Europe',
                                    'Asia Pacific',
                                ]"
                                label="Region"
                                variant="outlined" />
                        </v-col>
                        <v-col cols="3">
                            <v-select
                                v-model="filters.sector"
                                density="compact"
                                :items="[
                                    'Healthcare',
                                    'Technology',
                                    'Energy',
                                    'Real Estate',
                                ]"
                                label="Sector"
                                variant="outlined" />
                        </v-col>
                        <v-col cols="3">
                            <v-select
                                v-model="filters.dealSize"
                                density="compact"
                                :items="['$50-150M', '$150-300M', '$300M+']"
                                label="Deal Size"
                                variant="outlined" />
                        </v-col>
                        <v-col cols="3">
                            <v-select
                                v-model="filters.status"
                                density="compact"
                                :items="[
                                    'Under Review',
                                    'Approved',
                                    'Executed',
                                ]"
                                label="Status"
                                variant="outlined" />
                        </v-col>
                    </v-row>
                </div>
            </div>

            <!-- Pipeline Stages -->
            <div class="pipeline-stages">
                <v-row class="no-gutters">
                    <v-col
                        v-for="stage in stages"
                        :key="stage.id"
                        class="stage-column"
                        cols="3">
                        <div class="stage-header">
                            <h3 class="stage-title">{{ stage.title }}</h3>
                        </div>

                        <div class="stage-content">
                            <div
                                v-for="deal in stage.deals"
                                :key="deal.id"
                                class="deal-card mb-4">
                                <v-card class="deal-card-content" elevation="2">
                                    <v-card-text class="pa-4">
                                        <div
                                            class="d-flex justify-space-between align-start mb-3">
                                            <h4 class="deal-title">
                                                {{ deal.title }}
                                            </h4>
                                            <v-chip
                                                :color="
                                                    getStageColor(deal.stage)
                                                "
                                                size="small"
                                                variant="flat">
                                                {{ deal.stage }}
                                            </v-chip>
                                        </div>

                                        <div class="deal-details mb-3">
                                            <div class="detail-row">
                                                <span class="detail-label">
                                                    Sector:
                                                </span>
                                                <span class="detail-value">
                                                    {{ deal.sector }}
                                                </span>
                                            </div>
                                            <div class="detail-row">
                                                <span class="detail-label">
                                                    Size:
                                                </span>
                                                <span class="detail-value">
                                                    {{ deal.size }}
                                                </span>
                                            </div>
                                            <div class="detail-row">
                                                <span class="detail-label">
                                                    Yield:
                                                </span>
                                                <span
                                                    class="detail-value text-success">
                                                    {{ deal.yield }}
                                                </span>
                                            </div>
                                        </div>

                                        <div class="deal-footer">
                                            <div class="expected-close">
                                                <span class="detail-label">
                                                    Expected Close:
                                                </span>
                                                <span class="detail-value">
                                                    {{ deal.expectedClose }}
                                                </span>
                                            </div>
                                        </div>
                                    </v-card-text>
                                </v-card>
                            </div>
                        </div>
                    </v-col>
                </v-row>
            </div>
        </div>
    </Layout>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import Layout from '../components/ui/layout.vue'

interface Deal {
    id: string
    title: string
    sector: string
    size: string
    yield: string
    expectedClose: string
    stage: string
}

interface Stage {
    id: string
    title: string
    deals: Deal[]
}

const filters = ref({
    region: 'North America',
    sector: 'Healthcare',
    dealSize: '$50-150M',
    status: 'Under Review',
})

const stages = ref<Stage[]>([
    {
        id: 'origination',
        title: 'Origination',
        deals: [
            {
                id: 'borrower-1-1',
                title: 'Borrower 1-1',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
            {
                id: 'borrower-1-2',
                title: 'Borrower 1-2',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
            {
                id: 'borrower-1-3',
                title: 'Borrower 1-3',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
        ],
    },
    {
        id: 'under-review',
        title: 'Under Review',
        deals: [
            {
                id: 'borrower-2-1',
                title: 'Borrower 2-1',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
            {
                id: 'borrower-2-2',
                title: 'Borrower 2-2',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
            {
                id: 'borrower-2-3',
                title: 'Borrower 2-3',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
        ],
    },
    {
        id: 'approved',
        title: 'Approved',
        deals: [
            {
                id: 'borrower-3-1',
                title: 'Borrower 3-1',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
            {
                id: 'borrower-3-2',
                title: 'Borrower 3-2',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
            {
                id: 'borrower-3-3',
                title: 'Borrower 3-3',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
        ],
    },
    {
        id: 'executed',
        title: 'Executed',
        deals: [
            {
                id: 'borrower-4-1',
                title: 'Borrower 4-1',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
            {
                id: 'borrower-4-2',
                title: 'Borrower 4-2',
                sector: 'Region',
                size: '$85M',
                yield: '9.2%',
                expectedClose: 'Nov 15',
                stage: 'Stage',
            },
        ],
    },
])

const getStageColor = (stage: string) => {
    const colors: Record<string, string> = {
        Stage: 'warning',
    }
    return colors[stage] || 'grey'
}
</script>

<style scoped>
.deal-pipeline {
    background-color: #f5f7fa;
    min-height: calc(100vh - 48px);
}

.page-title {
    font-size: 2rem;
    font-weight: 600;
    color: #1a1a1a;
    margin: 0;
}

.header-actions {
    display: flex;
    gap: 8px;
}

.filter-section {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.pipeline-stages {
    margin-top: 24px;
}

.stage-column {
    padding: 0 8px;
}

.stage-header {
    background: white;
    padding: 16px;
    border-radius: 8px 8px 0 0;
    border-bottom: 2px solid #e0e0e0;
    margin-bottom: 16px;
}

.stage-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1a1a1a;
    margin: 0;
    text-align: center;
}

.stage-content {
    min-height: 600px;
}

.deal-card {
    margin-bottom: 16px;
}

.deal-card-content {
    border-radius: 8px;
    transition: all 0.2s ease;
    cursor: pointer;
}

.deal-card-content:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.deal-title {
    font-size: 1rem;
    font-weight: 600;
    color: #1a1a1a;
    margin: 0;
}

.deal-details {
    border-bottom: 1px solid #f0f0f0;
    padding-bottom: 12px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 4px;
}

.detail-label {
    font-size: 0.875rem;
    color: #666;
    font-weight: 500;
}

.detail-value {
    font-size: 0.875rem;
    color: #1a1a1a;
    font-weight: 600;
}

.deal-footer {
    margin-top: 12px;
}

.expected-close {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* Stage-specific styling */
.stage-column:nth-child(1) .stage-header {
    background: linear-gradient(135deg, #fff3e0 0%, #ffe0b2 100%);
}

.stage-column:nth-child(2) .stage-header {
    background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
}

.stage-column:nth-child(3) .stage-header {
    background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c8 100%);
}

.stage-column:nth-child(4) .stage-header {
    background: linear-gradient(135deg, #f3e5f5 0%, #e1bee7 100%);
}

/* Responsive adjustments */
@media (max-width: 1200px) {
    .pipeline-stages .v-col {
        flex: 0 0 50%;
        max-width: 50%;
    }
}

@media (max-width: 768px) {
    .pipeline-stages .v-col {
        flex: 0 0 100%;
        max-width: 100%;
    }

    .header-actions {
        flex-direction: column;
        width: 100%;
    }

    .d-flex.justify-space-between {
        flex-direction: column;
        gap: 16px;
    }
}
</style>
