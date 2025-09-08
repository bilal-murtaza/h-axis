<template>
    <Layout>
        <div class="investors-page">
            <!-- Page Header -->
            <div class="page-header mb-6">
                <h1 class="page-title">Investors</h1>
            </div>

            <!-- Controls Section -->
            <div class="controls-section mb-6">
                <v-row align="center" justify="space-between">
                    <v-col cols="12" md="8">
                        <v-row align="center">
                            <v-col cols="12" md="4" sm="6">
                                <v-text-field
                                    v-model="searchQuery"
                                    clearable
                                    density="compact"
                                    hide-details
                                    placeholder="Search investors..."
                                    prepend-inner-icon="mdi-magnify"
                                    variant="outlined" />
                            </v-col>
                            <v-col cols="6" md="2" sm="3">
                                <v-select
                                    v-model="fundFilter"
                                    density="compact"
                                    hide-details
                                    :items="fundOptions"
                                    placeholder="Fund"
                                    variant="outlined" />
                            </v-col>
                            <v-col cols="6" md="2" sm="3">
                                <v-select
                                    v-model="irrFilter"
                                    density="compact"
                                    hide-details
                                    :items="irrOptions"
                                    placeholder="IRR"
                                    variant="outlined" />
                            </v-col>
                            <v-col cols="6" md="2" sm="3">
                                <v-select
                                    v-model="statusFilter"
                                    density="compact"
                                    hide-details
                                    :items="statusOptions"
                                    placeholder="Status"
                                    variant="outlined" />
                            </v-col>
                        </v-row>
                    </v-col>
                    <v-col class="text-right" cols="12" md="4">
                        <v-btn
                            class="mr-2"
                            color="grey-darken-1"
                            variant="tonal">
                            Export
                        </v-btn>
                        <v-btn color="secondary" variant="tonal">
                            Add Investor
                        </v-btn>
                    </v-col>
                </v-row>
            </div>

            <!-- Investors Table -->
            <v-card elevation="2" rounded="lg">
                <v-data-table
                    class="investors-table"
                    :headers="headers"
                    item-value="id"
                    :items="filteredInvestors"
                    :loading="loading"
                    no-data-text="No investors found"
                    @click:row="openInvestorProfile">
                    <template #item.name="{ item }">
                        <div class="investor-name">
                            {{ item.name }}
                        </div>
                    </template>

                    <template #item.commitment="{ item }">
                        <div class="amount-cell">
                            {{ formatCurrency(item.commitment) }}
                        </div>
                    </template>

                    <template #item.capitalCalled="{ item }">
                        <div class="amount-cell">
                            {{ formatCurrency(item.capitalCalled) }}
                        </div>
                    </template>

                    <template #item.remainingCommitment="{ item }">
                        <div class="amount-cell">
                            {{ formatCurrency(item.remainingCommitment) }}
                        </div>
                    </template>

                    <template #item.irr="{ item }">
                        <v-chip
                            :color="getIrrColor(item.irr)"
                            size="small"
                            variant="flat">
                            {{ item.irr }}%
                        </v-chip>
                    </template>

                    <template #item.actions="{ item }">
                        <v-btn
                            icon="mdi-eye"
                            size="small"
                            variant="text"
                            @click.stop="openInvestorProfile(item)" />
                    </template>
                </v-data-table>
            </v-card>

            <!-- Investor Profile Dialog -->
            <v-dialog
                v-model="profileDialog"
                max-width="1200"
                persistent
                scrollable>
                <v-card v-if="selectedInvestor" class="investor-profile-dialog">
                    <!-- Dialog Header -->
                    <v-card-title class="dialog-header">
                        <div
                            class="d-flex align-center justify-space-between w-100">
                            <h2 class="profile-title">
                                Investor Profile — {{ selectedInvestor.name }}
                            </h2>
                            <v-btn
                                icon="mdi-close"
                                variant="text"
                                @click="closeProfile" />
                        </div>
                    </v-card-title>

                    <!-- Metrics Cards -->
                    <v-card-text class="pa-6">
                        <v-row class="mb-6">
                            <v-col cols="6" md="3">
                                <div class="metric-card commitment">
                                    <div class="metric-label">Commitment</div>
                                    <div class="metric-value">
                                        {{
                                            formatCurrency(
                                                selectedInvestor.commitment,
                                            )
                                        }}
                                    </div>
                                </div>
                            </v-col>
                            <v-col cols="6" md="3">
                                <div class="metric-card capital-called">
                                    <div class="metric-label">
                                        Capital Called
                                    </div>
                                    <div class="metric-value">
                                        {{
                                            formatCurrency(
                                                selectedInvestor.capitalCalled,
                                            )
                                        }}
                                    </div>
                                </div>
                            </v-col>
                            <v-col cols="6" md="3">
                                <div class="metric-card remaining">
                                    <div class="metric-label">Remaining</div>
                                    <div class="metric-value">
                                        {{
                                            formatCurrency(
                                                selectedInvestor.remainingCommitment,
                                            )
                                        }}
                                    </div>
                                </div>
                            </v-col>
                            <v-col cols="6" md="3">
                                <div class="metric-card irr">
                                    <div class="metric-label">IRR</div>
                                    <div class="metric-value irr-value">
                                        {{ selectedInvestor.irr }}%
                                    </div>
                                </div>
                            </v-col>
                        </v-row>

                        <!-- Tabs -->
                        <v-tabs v-model="activeTab" class="profile-tabs">
                            <v-tab value="investments">Investments</v-tab>
                            <v-tab value="contacts">Contacts</v-tab>
                            <v-tab value="documents">Documents</v-tab>
                        </v-tabs>

                        <!-- Tab Content -->
                        <v-tabs-window v-model="activeTab" class="mt-4">
                            <!-- Investments Tab -->
                            <v-tabs-window-item value="investments">
                                <v-data-table
                                    class="investments-table"
                                    density="compact"
                                    :headers="investmentHeaders"
                                    :items="selectedInvestor.investments"
                                    no-data-text="No investments found">
                                    <template #item.deal="{ item }">
                                        <div class="deal-name">
                                            {{ item.deal }}
                                        </div>
                                    </template>

                                    <template #item.type="{ item }">
                                        <v-chip
                                            :color="getTypeColor(item.type)"
                                            size="small"
                                            variant="outlined">
                                            {{ item.type }}
                                        </v-chip>
                                    </template>

                                    <template #item.committed="{ item }">
                                        <div class="amount-cell">
                                            {{ formatCurrency(item.committed) }}
                                        </div>
                                    </template>

                                    <template #item.funded="{ item }">
                                        <div class="amount-cell">
                                            {{ formatCurrency(item.funded) }}
                                        </div>
                                    </template>

                                    <template #item.irr="{ item }">
                                        <div class="irr-cell">
                                            {{ item.irr }}%
                                        </div>
                                    </template>
                                </v-data-table>
                            </v-tabs-window-item>

                            <!-- Contacts Tab -->
                            <v-tabs-window-item value="contacts">
                                <div class="contacts-content">
                                    <v-row>
                                        <v-col
                                            v-for="contact in selectedInvestor.contacts"
                                            :key="contact.id"
                                            cols="12"
                                            md="6">
                                            <v-card
                                                class="contact-card"
                                                elevation="1">
                                                <v-card-text>
                                                    <div class="contact-name">
                                                        {{ contact.name }}
                                                    </div>
                                                    <div class="contact-title">
                                                        {{ contact.title }}
                                                    </div>
                                                    <div class="contact-email">
                                                        {{ contact.email }}
                                                    </div>
                                                    <div class="contact-phone">
                                                        {{ contact.phone }}
                                                    </div>
                                                </v-card-text>
                                            </v-card>
                                        </v-col>
                                    </v-row>
                                </div>
                            </v-tabs-window-item>

                            <!-- Documents Tab -->
                            <v-tabs-window-item value="documents">
                                <div class="documents-content">
                                    <v-list>
                                        <v-list-item
                                            v-for="document in selectedInvestor.documents"
                                            :key="document.id"
                                            class="document-item">
                                            <template #prepend>
                                                <v-icon
                                                    :icon="
                                                        getDocumentIcon(
                                                            document.type,
                                                        )
                                                    " />
                                            </template>
                                            <v-list-item-title>
                                                {{ document.name }}
                                            </v-list-item-title>
                                            <v-list-item-subtitle>
                                                {{ document.date }}
                                            </v-list-item-subtitle>
                                            <template #append>
                                                <v-btn
                                                    icon="mdi-download"
                                                    size="small"
                                                    variant="text" />
                                            </template>
                                        </v-list-item>
                                    </v-list>
                                </div>
                            </v-tabs-window-item>
                        </v-tabs-window>
                    </v-card-text>
                </v-card>
            </v-dialog>
        </div>
    </Layout>
</template>

<script lang="ts" setup>
import { computed, onMounted, ref } from 'vue'

// Reactive data
const searchQuery = ref('')
const fundFilter = ref('')
const irrFilter = ref('')
const statusFilter = ref('Active')
const loading = ref(false)
const profileDialog = ref(false)
const selectedInvestor = ref<Investor | null>(null)
const activeTab = ref('investments')

// Interfaces
interface Investment {
    id: number
    deal: string
    type: string
    committed: number
    funded: number
    irr: number
}

interface Contact {
    id: number
    name: string
    title: string
    email: string
    phone: string
}

interface Document {
    id: number
    name: string
    type: string
    date: string
}

interface Investor {
    id: number
    name: string
    commitment: number
    capitalCalled: number
    remainingCommitment: number
    irr: number
    investments: Investment[]
    contacts: Contact[]
    documents: Document[]
}

// Filter options
const fundOptions = ['All', '10%+', '15%+', '20%+']
const irrOptions = ['All', '10%+', '15%+', '20%+']
const statusOptions = ['All', 'Active', 'Inactive']

// Table headers
const headers = [
    { title: 'Name', key: 'name', sortable: true },
    { title: 'Commitment', key: 'commitment', sortable: true },
    { title: 'Capital Called', key: 'capitalCalled', sortable: true },
    {
        title: 'Remaining Commitment',
        key: 'remainingCommitment',
        sortable: true,
    },
    { title: 'IRR', key: 'irr', sortable: true },
    { title: 'Actions', key: 'actions', sortable: false },
]

const investmentHeaders = [
    { title: 'Deal', key: 'deal', sortable: true },
    { title: 'Type', key: 'type', sortable: true },
    { title: 'Committed', key: 'committed', sortable: true },
    { title: 'Funded', key: 'funded', sortable: true },
    { title: 'IRR', key: 'irr', sortable: true },
]

// Sample data
const investors = ref<Investor[]>([
    {
        id: 1,
        name: 'Alpha Capital Partners',
        commitment: 100_000_000,
        capitalCalled: 60_000_000,
        remainingCommitment: 40_000_000,
        irr: 12.4,
        investments: [
            {
                id: 1,
                deal: 'MedSupply ABL',
                type: 'Senior Debt',
                committed: 20_000_000,
                funded: 18_000_000,
                irr: 11.8,
            },
            {
                id: 2,
                deal: 'Railcar Leasing SPV',
                type: 'Unitranche',
                committed: 25_000_000,
                funded: 20_000_000,
                irr: 13.1,
            },
            {
                id: 3,
                deal: 'Tech Services HoldCo',
                type: 'Mezzanine',
                committed: 15_000_000,
                funded: 12_000_000,
                irr: 10.5,
            },
        ],
        contacts: [
            {
                id: 1,
                name: 'John Smith',
                title: 'Managing Partner',
                email: 'john.smith@alpha.com',
                phone: '+1 555-0123',
            },
            {
                id: 2,
                name: 'Sarah Johnson',
                title: 'Investment Director',
                email: 'sarah.johnson@alpha.com',
                phone: '+1 555-0124',
            },
        ],
        documents: [
            {
                id: 1,
                name: 'Subscription Agreement',
                type: 'pdf',
                date: '2024-01-15',
            },
            {
                id: 2,
                name: 'Capital Call Notice Q1',
                type: 'pdf',
                date: '2024-03-01',
            },
            {
                id: 3,
                name: 'Financial Statements',
                type: 'excel',
                date: '2024-06-30',
            },
        ],
    },
    {
        id: 2,
        name: 'Bluecrest Capital',
        commitment: 75_000_000,
        capitalCalled: 45_000_000,
        remainingCommitment: 30_000_000,
        irr: 15.2,
        investments: [
            {
                id: 4,
                deal: 'Healthcare REIT',
                type: 'Senior Debt',
                committed: 30_000_000,
                funded: 28_000_000,
                irr: 14.5,
            },
            {
                id: 5,
                deal: 'Energy Infrastructure',
                type: 'Mezzanine',
                committed: 15_000_000,
                funded: 12_000_000,
                irr: 16.8,
            },
        ],
        contacts: [
            {
                id: 3,
                name: 'Michael Chen',
                title: 'Principal',
                email: 'michael.chen@bluecrest.com',
                phone: '+1 555-0125',
            },
        ],
        documents: [
            {
                id: 4,
                name: 'Investment Agreement',
                type: 'pdf',
                date: '2024-02-01',
            },
            {
                id: 5,
                name: 'Quarterly Report Q2',
                type: 'pdf',
                date: '2024-07-15',
            },
        ],
    },
    {
        id: 3,
        name: 'Cedar Ridge Investments',
        commitment: 50_000_000,
        capitalCalled: 30_000_000,
        remainingCommitment: 20_000_000,
        irr: 9.8,
        investments: [
            {
                id: 6,
                deal: 'Manufacturing Buyout',
                type: 'Unitranche',
                committed: 25_000_000,
                funded: 20_000_000,
                irr: 9.2,
            },
            {
                id: 7,
                deal: 'Retail Portfolio',
                type: 'Senior Debt',
                committed: 5_000_000,
                funded: 5_000_000,
                irr: 11.1,
            },
        ],
        contacts: [
            {
                id: 4,
                name: 'Lisa Williams',
                title: 'Managing Director',
                email: 'lisa.williams@cedar.com',
                phone: '+1 555-0126',
            },
        ],
        documents: [
            {
                id: 6,
                name: 'Partnership Agreement',
                type: 'pdf',
                date: '2024-01-30',
            },
        ],
    },
    {
        id: 4,
        name: 'Dovetail Private Equity',
        commitment: 125_000_000,
        capitalCalled: 75_000_000,
        remainingCommitment: 50_000_000,
        irr: 18.7,
        investments: [
            {
                id: 8,
                deal: 'Software Acquisition',
                type: 'Growth Capital',
                committed: 40_000_000,
                funded: 35_000_000,
                irr: 22.1,
            },
            {
                id: 9,
                deal: 'Logistics Platform',
                type: 'Mezzanine',
                committed: 35_000_000,
                funded: 30_000_000,
                irr: 16.4,
            },
        ],
        contacts: [
            {
                id: 5,
                name: 'Robert Davis',
                title: 'Partner',
                email: 'robert.davis@dovetail.com',
                phone: '+1 555-0127',
            },
        ],
        documents: [
            { id: 7, name: 'Fund Agreement', type: 'pdf', date: '2024-03-15' },
        ],
    },
    {
        id: 5,
        name: 'Everstone Capital',
        commitment: 80_000_000,
        capitalCalled: 48_000_000,
        remainingCommitment: 32_000_000,
        irr: 14.1,
        investments: [
            {
                id: 10,
                deal: 'Infrastructure Debt',
                type: 'Senior Debt',
                committed: 30_000_000,
                funded: 28_000_000,
                irr: 13.8,
            },
            {
                id: 11,
                deal: 'Real Estate Fund',
                type: 'Preferred Equity',
                committed: 18_000_000,
                funded: 15_000_000,
                irr: 14.9,
            },
        ],
        contacts: [
            {
                id: 6,
                name: 'Amanda Taylor',
                title: 'Investment Manager',
                email: 'amanda.taylor@everstone.com',
                phone: '+1 555-0128',
            },
        ],
        documents: [
            {
                id: 8,
                name: 'Investor Letter Q1',
                type: 'pdf',
                date: '2024-04-01',
            },
        ],
    },
])

// Computed properties
const filteredInvestors = computed(() => {
    let filtered = investors.value

    if (searchQuery.value) {
        filtered = filtered.filter(investor =>
            investor.name
                .toLowerCase()
                .includes(searchQuery.value.toLowerCase()),
        )
    }

    if (statusFilter.value && statusFilter.value !== 'All') {
        // Implement status filtering logic here
    }

    if (irrFilter.value && irrFilter.value !== 'All') {
        const minIrr = Number.parseInt(irrFilter.value.replace('%+', ''))
        filtered = filtered.filter(investor => investor.irr >= minIrr)
    }

    return filtered
})

// Methods
const formatCurrency = (amount: number): string => {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
    }).format(amount)
}

const getIrrColor = (irr: number): string => {
    if (irr >= 15) return 'green'
    if (irr >= 10) return 'amber'
    return 'red'
}

const getTypeColor = (type: string): string => {
    const colorMap: Record<string, string> = {
        'Senior Debt': 'blue',
        'Unitranche': 'purple',
        'Mezzanine': 'orange',
        'Growth Capital': 'green',
        'Preferred Equity': 'teal',
    }
    return colorMap[type] || 'grey'
}

const getDocumentIcon = (type: string): string => {
    const iconMap: Record<string, string> = {
        pdf: 'mdi-file-pdf-box',
        excel: 'mdi-file-excel-box',
        word: 'mdi-file-word-box',
    }
    return iconMap[type] || 'mdi-file-document'
}

const openInvestorProfile = (investor: Investor) => {
    selectedInvestor.value = investor
    profileDialog.value = true
    activeTab.value = 'investments'
}

const closeProfile = () => {
    profileDialog.value = false
    selectedInvestor.value = null
}

// Lifecycle
onMounted(() => {
    // Load data
})
</script>

<style scoped>
.investors-page {
    padding: 0;
}

.page-header {
    margin-bottom: 2rem;
}

.page-title {
    font-size: 2rem;
    font-weight: 600;
    color: #333;
}

.controls-section {
    margin-bottom: 1.5rem;
}

.investors-table :deep(.v-data-table__tr) {
    cursor: pointer;
}

.investors-table :deep(.v-data-table__tr:hover) {
    background-color: rgba(0, 0, 0, 0.02);
}

.investor-name {
    font-weight: 500;
    color: #333;
}

.amount-cell {
    font-weight: 500;
    color: #666;
}

.investor-profile-dialog {
    max-height: 90vh;
}

.dialog-header {
    background-color: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
    padding: 1rem 1.5rem;
}

.profile-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #333;
    margin: 0;
}

.metric-card {
    background: #f8f9fa;
    border-radius: 8px;
    padding: 1rem;
    text-align: center;
    height: 100%;
    border-left: 4px solid #dee2e6;
}

.metric-card.commitment {
    border-left-color: #4a90e2;
}

.metric-card.capital-called {
    border-left-color: #7ed321;
}

.metric-card.remaining {
    border-left-color: #f5a623;
}

.metric-card.irr {
    border-left-color: #bd10e0;
}

.metric-label {
    font-size: 0.875rem;
    color: #666;
    margin-bottom: 0.5rem;
    font-weight: 500;
}

.metric-value {
    font-size: 1.5rem;
    font-weight: 700;
    color: #333;
}

.metric-value.irr-value {
    color: #bd10e0;
}

.profile-tabs :deep(.v-tab) {
    font-weight: 500;
    text-transform: none;
}

.investments-table {
    background-color: transparent;
}

.deal-name {
    font-weight: 500;
    color: #333;
}

.irr-cell {
    font-weight: 500;
    color: #666;
}

.contacts-content {
    padding: 1rem 0;
}

.contact-card {
    height: 100%;
}

.contact-name {
    font-weight: 600;
    font-size: 1rem;
    color: #333;
    margin-bottom: 0.25rem;
}

.contact-title {
    font-size: 0.875rem;
    color: #666;
    margin-bottom: 0.5rem;
}

.contact-email,
.contact-phone {
    font-size: 0.875rem;
    color: #888;
    margin-bottom: 0.25rem;
}

.documents-content {
    padding: 1rem 0;
}

.document-item {
    border-bottom: 1px solid #f0f0f0;
}

.document-item:last-child {
    border-bottom: none;
}
</style>
