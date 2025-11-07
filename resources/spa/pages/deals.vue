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
                            variant="elevated"
                            @click="openAddDealDialog">
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

                        <div
                            :class="[
                                'stage-content',
                                { 'drag-over': dragOverStage === stage.id },
                            ]"
                            @dragenter="onDragEnter($event, stage.id)"
                            @dragleave="onDragLeave($event, stage.id)"
                            @dragover.prevent
                            @drop="onDrop($event, stage.id)">
                            <div
                                v-for="deal in stage.deals"
                                :key="deal.id"
                                class="deal-card mb-4">
                                <v-card class="deal-card-content" elevation="2">
                                    <v-card-text class="pa-4">
                                        <div
                                            class="d-flex justify-space-between align-start deal-title-section mb-3"
                                            draggable="true"
                                            @dragend="onDragEnd"
                                            @dragstart="
                                                onDragStart(
                                                    $event,
                                                    deal,
                                                    stage.id,
                                                )
                                            ">
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

                                        <div
                                            class="deal-details clickable-area mb-3"
                                            @click="
                                                openEditDealDialog(
                                                    deal,
                                                    stage.id,
                                                )
                                            ">
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

                                        <div
                                            class="deal-footer clickable-area"
                                            @click="
                                                openEditDealDialog(
                                                    deal,
                                                    stage.id,
                                                )
                                            ">
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

        <!-- Add Deal Dialog -->
        <v-dialog v-model="showAddDealDialog" max-width="600px">
            <v-card>
                <v-card-title class="text-h5 pa-6">Add New Deal</v-card-title>

                <v-card-text class="pa-6">
                    <v-form ref="dealForm">
                        <v-text-field
                            v-model="newDeal.title"
                            class="mb-4"
                            label="Deal Title"
                            placeholder="e.g., Borrower 1-4"
                            :rules="[rules.required]"
                            variant="outlined" />

                        <v-text-field
                            v-model="newDeal.sector"
                            class="mb-4"
                            label="Sector/Region"
                            placeholder="e.g., North America"
                            :rules="[rules.required]"
                            variant="outlined" />

                        <v-text-field
                            v-model="newDeal.size"
                            class="mb-4"
                            label="Deal Size"
                            placeholder="e.g., $85M"
                            :rules="[rules.required]"
                            variant="outlined" />

                        <v-text-field
                            v-model="newDeal.yield"
                            class="mb-4"
                            label="Yield"
                            placeholder="e.g., 9.2%"
                            :rules="[rules.required]"
                            variant="outlined" />

                        <v-text-field
                            v-model="newDeal.expectedClose"
                            label="Expected Close Date"
                            placeholder="e.g., Nov 15"
                            :rules="[rules.required]"
                            variant="outlined" />
                    </v-form>
                </v-card-text>

                <v-card-actions class="pa-6 pt-0">
                    <v-spacer />
                    <v-btn
                        color="grey"
                        variant="text"
                        @click="closeAddDealDialog">
                        Cancel
                    </v-btn>
                    <v-btn color="primary" variant="elevated" @click="saveDeal">
                        Save Deal
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>

        <!-- Edit Deal Dialog -->
        <v-dialog v-model="showEditDealDialog" max-width="1000px">
            <v-card>
                <v-card-title class="text-h5 pa-6">Edit Deal</v-card-title>

                <v-card-text class="pa-6">
                    <v-row>
                        <!-- Left Column - Deal Information -->
                        <v-col cols="6">
                            <v-form ref="editDealForm">
                                <v-text-field
                                    v-model="editingDeal.title"
                                    class="mb-4"
                                    label="Deal Title"
                                    placeholder="e.g., Borrower 1-4"
                                    :rules="[rules.required]"
                                    variant="outlined" />

                                <v-text-field
                                    v-model="editingDeal.sector"
                                    class="mb-4"
                                    label="Sector/Region"
                                    placeholder="e.g., North America"
                                    :rules="[rules.required]"
                                    variant="outlined" />

                                <v-text-field
                                    v-model="editingDeal.size"
                                    class="mb-4"
                                    label="Deal Size"
                                    placeholder="e.g., $85M"
                                    :rules="[rules.required]"
                                    variant="outlined" />

                                <v-text-field
                                    v-model="editingDeal.yield"
                                    class="mb-4"
                                    label="Yield"
                                    placeholder="e.g., 9.2%"
                                    :rules="[rules.required]"
                                    variant="outlined" />

                                <v-text-field
                                    v-model="editingDeal.expectedClose"
                                    label="Expected Close Date"
                                    placeholder="e.g., Nov 15"
                                    :rules="[rules.required]"
                                    variant="outlined" />
                            </v-form>
                        </v-col>

                        <!-- Right Column - Stage Checklist -->
                        <v-col cols="6">
                            <div class="checklist-section">
                                <h3 class="text-h6 mb-4">
                                    {{ getCurrentStageTitle() }} Checklist
                                </h3>
                                <v-list>
                                    <v-list-item
                                        v-for="(
                                            item, index
                                        ) in getCurrentChecklist()"
                                        :key="item.id"
                                        class="px-0"
                                        :class="{
                                            'clickable-checklist':
                                                isCheckboxEnabled(index),
                                        }"
                                        @click="
                                            toggleChecklistItem(item.id, index)
                                        ">
                                        <template #prepend>
                                            <v-checkbox
                                                v-model="
                                                    editingDeal.checklist![
                                                        item.id
                                                    ]
                                                "
                                                :disabled="
                                                    !isCheckboxEnabled(index)
                                                "
                                                hide-details
                                                readonly />
                                        </template>
                                        <v-list-item-title>
                                            {{ item.label }}
                                        </v-list-item-title>
                                        <v-list-item-subtitle>
                                            {{ item.description }}
                                        </v-list-item-subtitle>
                                    </v-list-item>
                                </v-list>
                            </div>
                        </v-col>
                    </v-row>
                </v-card-text>

                <v-card-actions class="pa-6 pt-0">
                    <v-btn color="error" variant="text" @click="deleteDeal">
                        Delete
                    </v-btn>
                    <v-spacer />
                    <v-btn
                        color="grey"
                        variant="text"
                        @click="closeEditDealDialog">
                        Cancel
                    </v-btn>
                    <v-btn
                        color="primary"
                        variant="elevated"
                        @click="updateDeal">
                        Update Deal
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
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
    checklist?: Record<string, boolean>
}

interface Stage {
    id: string
    title: string
    deals: Deal[]
}

interface ChecklistItem {
    id: string
    label: string
    description: string
}

// State for drag and drop
const draggedDeal = ref<Deal | null>(null)
const draggedFromStage = ref<string | null>(null)
const dragOverStage = ref<string | null>(null)

// Stage checklists
const stageChecklists: Record<string, ChecklistItem[]> = {
    origination: [
        {
            id: 'intake_form',
            label: 'Deal intake form completed',
            description: 'All required borrower information captured',
        },
        {
            id: 'initial_materials',
            label: 'Initial borrower materials received',
            description: 'Financial statements and supporting documents',
        },
        {
            id: 'assign_team',
            label: 'Assign internal owner / deal team',
            description: 'Designate responsible team members',
        },
        {
            id: 'return_model',
            label: 'Preliminary return model created',
            description: 'Initial financial projections and analysis',
        },
    ],
    'under-review': [
        {
            id: 'data_room',
            label: 'Borrower data room established',
            description: 'Secure repository for all deal documents',
        },
        {
            id: 'credit_diligence',
            label: 'Credit diligence completed',
            description: 'Thorough credit risk assessment performed',
        },
        {
            id: 'cash_flow',
            label: 'Cash flow model finalized',
            description: 'Detailed financial projections completed',
        },
        {
            id: 'third_party',
            label: 'Third party reports ordered',
            description: 'Appraisals and external assessments requested',
        },
    ],
    approved: [
        {
            id: 'final_docs',
            label: 'Final documents prepared',
            description: 'All legal agreements drafted and reviewed',
        },
        {
            id: 'closing_checklist',
            label: 'Closing checklist generated',
            description: 'Complete list of closing requirements',
        },
        {
            id: 'legal_review',
            label: 'Legal counsel review complete',
            description: 'All documents approved by legal team',
        },
        {
            id: 'system_setup',
            label: 'Internal system setup',
            description: 'Loan servicing and tracking systems configured',
        },
    ],
    executed: [
        {
            id: 'funding',
            label: 'Funding confirmation',
            description: 'Funds disbursed and confirmed received',
        },
        {
            id: 'docs_archived',
            label: 'Final documentation archived',
            description: 'All signed documents properly stored',
        },
        {
            id: 'post_close',
            label: 'Post-close checklist completed',
            description: 'All post-closing tasks verified',
        },
        {
            id: 'accrual_schedule',
            label: 'Accrual schedule loaded',
            description: 'Payment schedule entered in systems',
        },
    ],
}

// State for add deal dialog
const showAddDealDialog = ref(false)
const dealForm = ref<any>(null)
const newDeal = ref({
    title: '',
    sector: '',
    size: '',
    yield: '',
    expectedClose: '',
})

// State for edit deal dialog
const showEditDealDialog = ref(false)
const editDealForm = ref<any>(null)
const editingDeal = ref<{
    id: string
    title: string
    sector: string
    size: string
    yield: string
    expectedClose: string
    stage: string
    checklist: Record<string, boolean>
}>({
    id: '',
    title: '',
    sector: '',
    size: '',
    yield: '',
    expectedClose: '',
    stage: '',
    checklist: {},
})
const editingDealStageId = ref<string | null>(null)

// Validation rules
const rules = {
    required: (value: string) => !!value || 'This field is required',
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

// Add Deal Dialog Functions
const openAddDealDialog = () => {
    showAddDealDialog.value = true
}

const closeAddDealDialog = () => {
    showAddDealDialog.value = false
    resetNewDeal()
}

const resetNewDeal = () => {
    newDeal.value = {
        title: '',
        sector: '',
        size: '',
        yield: '',
        expectedClose: '',
    }
}

const saveDeal = async () => {
    // Validate form
    if (dealForm.value) {
        const { valid } = await dealForm.value.validate()
        if (!valid) return
    }

    // Generate unique ID
    const timestamp = Date.now()
    const dealId = `deal-${timestamp}`

    // Create new deal object
    const deal: Deal = {
        id: dealId,
        title: newDeal.value.title,
        sector: newDeal.value.sector,
        size: newDeal.value.size,
        yield: newDeal.value.yield,
        expectedClose: newDeal.value.expectedClose,
        stage: 'Origination',
    }

    // Find the Origination stage and add the deal
    const originationStage = stages.value.find((s) => s.id === 'origination')
    if (originationStage) {
        originationStage.deals.push(deal)
    }

    // Close dialog and reset form
    closeAddDealDialog()
}

// Edit Deal Dialog Functions
const openEditDealDialog = (deal: Deal, stageId: string) => {
    // Initialize checklist if it doesn't exist
    if (!deal.checklist) {
        deal.checklist = {}
    }

    editingDeal.value = {
        id: deal.id,
        title: deal.title,
        sector: deal.sector,
        size: deal.size,
        yield: deal.yield,
        expectedClose: deal.expectedClose,
        stage: deal.stage,
        checklist: { ...deal.checklist },
    }
    editingDealStageId.value = stageId
    showEditDealDialog.value = true
}

// Get current stage checklist items
const getCurrentChecklist = () => {
    if (!editingDealStageId.value) return []
    return stageChecklists[editingDealStageId.value] || []
}

// Get current stage title
const getCurrentStageTitle = () => {
    if (!editingDealStageId.value) return ''
    const stage = stages.value.find((s) => s.id === editingDealStageId.value)
    return stage?.title || ''
}

// Check if a checkbox should be enabled (only if previous one is checked)
const isCheckboxEnabled = (index: number) => {
    if (index === 0) return true

    const checklist = getCurrentChecklist()
    const previousItem = checklist[index - 1]
    return editingDeal.value.checklist[previousItem.id] === true
}

// Check if all checklist items are completed
const isChecklistComplete = () => {
    const checklist = getCurrentChecklist()
    return checklist.every(
        (item) => editingDeal.value.checklist[item.id] === true,
    )
}

// Get next stage ID
const getNextStageId = (currentStageId: string): string | null => {
    const stageOrder = ['origination', 'under-review', 'approved', 'executed']
    const currentIndex = stageOrder.indexOf(currentStageId)
    if (currentIndex === -1 || currentIndex === stageOrder.length - 1) {
        return null
    }
    return stageOrder[currentIndex + 1]
}

// Toggle checklist item when label is clicked
const toggleChecklistItem = (itemId: string, index: number) => {
    // Only toggle if the checkbox is enabled
    if (isCheckboxEnabled(index)) {
        editingDeal.value.checklist[itemId] =
            !editingDeal.value.checklist[itemId]
    }
}

const closeEditDealDialog = () => {
    showEditDealDialog.value = false
    editingDealStageId.value = null
    resetEditingDeal()
}

const resetEditingDeal = () => {
    editingDeal.value = {
        id: '',
        title: '',
        sector: '',
        size: '',
        yield: '',
        expectedClose: '',
        stage: '',
        checklist: {},
    }
}

const updateDeal = async () => {
    // Validate form
    if (editDealForm.value) {
        const { valid } = await editDealForm.value.validate()
        if (!valid) return
    }

    if (!editingDealStageId.value) return

    // Find the stage containing the deal
    const stage = stages.value.find((s) => s.id === editingDealStageId.value)
    if (!stage) return

    // Find the deal
    const dealIndex = stage.deals.findIndex(
        (d) => d.id === editingDeal.value.id,
    )
    if (dealIndex === -1) return

    // Check if checklist is complete and should advance to next stage
    let targetStage = stage

    if (isChecklistComplete()) {
        const nextStageId = getNextStageId(editingDealStageId.value)
        if (nextStageId) {
            const nextStage = stages.value.find((s) => s.id === nextStageId)
            if (nextStage) {
                targetStage = nextStage
                // Remove deal from current stage
                const [movedDeal] = stage.deals.splice(dealIndex, 1)
                // Reset checklist for new stage
                movedDeal.checklist = {}
                movedDeal.stage = nextStage.title
                // Update with new values
                movedDeal.title = editingDeal.value.title
                movedDeal.sector = editingDeal.value.sector
                movedDeal.size = editingDeal.value.size
                movedDeal.yield = editingDeal.value.yield
                movedDeal.expectedClose = editingDeal.value.expectedClose
                // Add to next stage
                nextStage.deals.push(movedDeal)
                // Close dialog and reset form
                closeEditDealDialog()
                return
            }
        }
    }

    // Update the deal in the same stage
    targetStage.deals[dealIndex] = {
        id: editingDeal.value.id,
        title: editingDeal.value.title,
        sector: editingDeal.value.sector,
        size: editingDeal.value.size,
        yield: editingDeal.value.yield,
        expectedClose: editingDeal.value.expectedClose,
        stage: targetStage.title,
        checklist: { ...editingDeal.value.checklist },
    }

    // Close dialog and reset form
    closeEditDealDialog()
}

const deleteDeal = () => {
    if (!editingDealStageId.value) return
    if (!confirm('Are you sure you want to delete this deal?')) return

    // Find the stage containing the deal
    const stage = stages.value.find((s) => s.id === editingDealStageId.value)
    if (!stage) return

    // Find and remove the deal
    const dealIndex = stage.deals.findIndex(
        (d) => d.id === editingDeal.value.id,
    )
    if (dealIndex !== -1) {
        stage.deals.splice(dealIndex, 1)
    }

    // Close dialog
    closeEditDealDialog()
}

// Drag and drop handlers
const onDragStart = (event: DragEvent, deal: Deal, stageId: string) => {
    draggedDeal.value = deal
    draggedFromStage.value = stageId
    if (event.dataTransfer) {
        event.dataTransfer.effectAllowed = 'move'
        event.dataTransfer.dropEffect = 'move'
    }
    // Add dragging class to the element
    if (event.target instanceof HTMLElement) {
        event.target.classList.add('dragging')
    }
}

const onDragEnd = (event: DragEvent) => {
    // Remove dragging class
    if (event.target instanceof HTMLElement) {
        event.target.classList.remove('dragging')
    }
    draggedDeal.value = null
    draggedFromStage.value = null
    dragOverStage.value = null
}

const onDragEnter = (event: DragEvent, stageId: string) => {
    event.preventDefault()
    dragOverStage.value = stageId
}

const onDragLeave = (event: DragEvent, stageId: string) => {
    // Only clear if we're actually leaving the stage container
    const target = event.currentTarget as HTMLElement
    const relatedTarget = event.relatedTarget as HTMLElement

    if (!target.contains(relatedTarget) && dragOverStage.value === stageId) {
        dragOverStage.value = null
    }
}

const onDrop = (event: DragEvent, toStageId: string) => {
    event.preventDefault()
    dragOverStage.value = null

    if (!draggedDeal.value || !draggedFromStage.value) return

    const fromStageId = draggedFromStage.value

    // Don't do anything if dropped in the same stage
    if (fromStageId === toStageId) {
        onDragEnd(event)
        return
    }

    // Find the stages
    const fromStage = stages.value.find((s) => s.id === fromStageId)
    const toStage = stages.value.find((s) => s.id === toStageId)

    if (!fromStage || !toStage) return

    // Find and remove the deal from the source stage
    const dealIndex = fromStage.deals.findIndex(
        (d) => d.id === draggedDeal.value!.id,
    )
    if (dealIndex !== -1) {
        const [movedDeal] = fromStage.deals.splice(dealIndex, 1)

        // Update the deal's stage property to match the new stage title
        movedDeal.stage = toStage.title

        // Reset checklist for new stage
        movedDeal.checklist = {}

        // Add the deal to the target stage
        toStage.deals.push(movedDeal)
    }
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
    transition: all 0.15s ease;
    border: 2px solid transparent;
    border-radius: 8px;
    padding: 4px;
    margin: -4px;
}

.stage-content.drag-over {
    background-color: rgba(25, 118, 210, 0.08);
    border: 3px solid #1976d2;
    box-shadow: 0 0 0 4px rgba(25, 118, 210, 0.2);
    outline: 2px dashed #1976d2;
    outline-offset: 4px;
}

.deal-card {
    margin-bottom: 16px;
    transition: opacity 0.2s ease;
}

.deal-card.dragging {
    opacity: 0.5;
}

.deal-card-content {
    border-radius: 8px;
    transition: all 0.2s ease;
}

.deal-card-content:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.deal-title-section {
    cursor: grab;
    padding: 4px;
    margin: -4px;
    border-radius: 4px;
    transition: background-color 0.2s ease;
}

.deal-title-section:hover {
    background-color: rgba(0, 0, 0, 0.02);
}

.deal-title-section:active {
    cursor: grabbing;
}

.clickable-area {
    cursor: pointer;
    transition: background-color 0.2s ease;
    padding: 4px;
    margin: -4px;
    border-radius: 4px;
}

.clickable-area:hover {
    background-color: rgba(25, 118, 210, 0.08);
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

/* Checklist Section */
.checklist-section {
    background: #f5f7fa;
    padding: 20px;
    border-radius: 8px;
    height: 100%;
}

.checklist-section h3 {
    color: #1a1a1a;
    font-weight: 600;
}

.checklist-section .v-list-item {
    border-bottom: 1px solid #e0e0e0;
    padding: 12px 0;
}

.checklist-section .v-list-item:last-child {
    border-bottom: none;
}

.checklist-section .v-list-item-title {
    font-weight: 600;
    color: #1a1a1a;
    margin-bottom: 4px;
}

.checklist-section .v-list-item-subtitle {
    color: #666;
    font-size: 0.875rem;
}

.clickable-checklist {
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.clickable-checklist:hover {
    background-color: rgba(25, 118, 210, 0.04);
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
