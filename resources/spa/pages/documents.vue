<template>
    <Layout>
        <div class="documents-page">
            <!-- Header Section -->
            <div class="page-header mb-6">
                <h1 class="page-title">Documents</h1>

                <!-- Search and Filters Row -->
                <v-row align="center" class="mb-4">
                    <v-col cols="12" md="4">
                        <v-text-field
                            v-model="searchQuery"
                            clearable
                            density="compact"
                            hide-details
                            placeholder="Search documents..."
                            prepend-inner-icon="mdi-magnify"
                            variant="outlined" />
                    </v-col>

                    <v-col cols="12" md="2">
                        <v-select
                            v-model="selectedFilter"
                            density="compact"
                            hide-details
                            :items="filterOptions"
                            variant="outlined" />
                    </v-col>

                    <v-col cols="12" md="2">
                        <v-select
                            v-model="selectedDateRange"
                            density="compact"
                            hide-details
                            :items="dateRangeOptions"
                            variant="outlined" />
                    </v-col>

                    <v-spacer />

                    <!-- View Toggle and Upload -->
                    <v-col cols="auto">
                        <div class="d-flex align-center gap-2">
                            <v-btn-toggle
                                v-model="viewMode"
                                density="compact"
                                mandatory
                                variant="outlined">
                                <v-btn
                                    :color="
                                        viewMode === 'grid'
                                            ? 'primary'
                                            : 'default'
                                    "
                                    size="small"
                                    value="grid">
                                    <v-icon>mdi-view-grid</v-icon>
                                    Grid View
                                </v-btn>
                                <v-btn
                                    :color="
                                        viewMode === 'list'
                                            ? 'primary'
                                            : 'default'
                                    "
                                    size="small"
                                    value="list">
                                    <v-icon>mdi-view-list</v-icon>
                                    List View
                                </v-btn>
                            </v-btn-toggle>

                            <v-btn
                                color="primary"
                                prepend-icon="mdi-upload"
                                variant="flat">
                                Upload
                            </v-btn>
                        </div>
                    </v-col>
                </v-row>
            </div>

            <!-- Grid View -->
            <div v-if="viewMode === 'grid'" class="grid-view">
                <v-row>
                    <v-col
                        v-for="doc in filteredDocuments"
                        :key="doc.id"
                        cols="12"
                        lg="3"
                        md="4"
                        sm="6">
                        <v-card
                            class="document-card"
                            elevation="2"
                            hover
                            @click="openDocument(doc)">
                            <v-card-text class="pa-4">
                                <div class="d-flex align-center mb-3">
                                    <v-avatar
                                        class="mr-3"
                                        :color="getFileTypeColor(doc.type)"
                                        size="40">
                                        <v-icon color="white" size="20">
                                            {{ getFileTypeIcon(doc.type) }}
                                        </v-icon>
                                    </v-avatar>
                                    <div class="file-info flex-grow-1">
                                        <div
                                            class="file-name text-subtitle-2 font-weight-medium">
                                            {{ doc.name }}
                                        </div>
                                        <div
                                            class="file-date text-caption text-grey">
                                            {{ formatDate(doc.date) }}
                                        </div>
                                    </div>
                                </div>

                                <div class="file-tags">
                                    <v-chip
                                        v-for="tag in doc.tags"
                                        :key="tag"
                                        class="mb-1 mr-1"
                                        color="grey-lighten-2"
                                        size="x-small">
                                        {{ tag }}
                                    </v-chip>
                                </div>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
            </div>

            <!-- List View -->
            <div v-else class="list-view">
                <v-card elevation="1">
                    <v-data-table
                        class="documents-table"
                        :headers="tableHeaders"
                        item-key="id"
                        :items="filteredDocuments"
                        @click:row="openDocument">
                        <template #item.name="{ item }">
                            <div class="d-flex align-center">
                                <v-avatar
                                    class="mr-3"
                                    :color="getFileTypeColor(item.type)"
                                    size="32">
                                    <v-icon color="white" size="16">
                                        {{ getFileTypeIcon(item.type) }}
                                    </v-icon>
                                </v-avatar>
                                <span class="font-weight-medium">
                                    {{ item.name }}
                                </span>
                            </div>
                        </template>

                        <template #item.type="{ item }">
                            <v-chip
                                :color="getFileTypeColor(item.type)"
                                size="small"
                                variant="text">
                                {{ item.type.toUpperCase() }}
                            </v-chip>
                        </template>

                        <template #item.date="{ item }">
                            {{ formatDate(item.date) }}
                        </template>

                        <template #item.tags="{ item }">
                            <div class="tags-container">
                                <v-chip
                                    v-for="tag in item.tags"
                                    :key="tag"
                                    class="mr-1"
                                    color="grey-lighten-2"
                                    size="x-small">
                                    {{ tag }}
                                </v-chip>
                            </div>
                        </template>
                    </v-data-table>
                </v-card>
            </div>
        </div>
    </Layout>
</template>

<script lang="ts" setup>
import { computed, ref } from 'vue'
import Layout from '@/components/ui/layout.vue'

// Reactive data
const searchQuery = ref('')
const selectedFilter = ref('All')
const selectedDateRange = ref('Last 30 days')
const viewMode = ref('grid')

// Filter options
const filterOptions = ['All', 'PDF', 'Excel', 'Word', 'Image']
const dateRangeOptions = [
    'Last 7 days',
    'Last 30 days',
    'Last 90 days',
    'This year',
]

// Table headers for list view
const tableHeaders = [
    { title: 'Name', key: 'name', align: 'start' as const },
    { title: 'Type', key: 'type', align: 'center' as const },
    { title: 'Date', key: 'date', align: 'center' as const },
    { title: 'Tags', key: 'tags', align: 'start' as const },
]

// Sample documents data
const documents = ref([
    {
        id: 1,
        name: 'Loan_Agreement.pdf',
        type: 'pdf',
        date: '2025-10-02',
        tags: ['Loan', 'Legal'],
    },
    {
        id: 2,
        name: 'Investor_List.xlsx',
        type: 'excel',
        date: '2025-10-10',
        tags: ['Investor', 'Data'],
    },
    {
        id: 3,
        name: 'Q3_Report.docx',
        type: 'word',
        date: '2025-10-15',
        tags: ['Report'],
    },
    {
        id: 4,
        name: 'Distribution_Notice.pdf',
        type: 'pdf',
        date: '2025-11-01',
        tags: ['Distribution', 'Notice'],
    },
    {
        id: 5,
        name: 'Investment_Summary.xlsx',
        type: 'excel',
        date: '2025-09-28',
        tags: ['Investment', 'Summary'],
    },
    {
        id: 6,
        name: 'Due_Diligence.pdf',
        type: 'pdf',
        date: '2025-10-20',
        tags: ['Due Diligence', 'Legal'],
    },
])

// Computed filtered documents
const filteredDocuments = computed(() => {
    let filtered = documents.value

    // Filter by search query
    if (searchQuery.value) {
        filtered = filtered.filter(
            doc =>
                doc.name
                    .toLowerCase()
                    .includes(searchQuery.value.toLowerCase())
                    || doc.tags.some(tag =>
                        tag.toLowerCase().includes(searchQuery.value.toLowerCase()),
                    ),
        )
    }

    // Filter by file type
    if (selectedFilter.value !== 'All') {
        filtered = filtered.filter(
            doc =>
                doc.type.toLowerCase() === selectedFilter.value.toLowerCase(),
        )
    }

    return filtered
})

// Utility functions
const getFileTypeIcon = (type: string) => {
    const icons: Record<string, string> = {
        pdf: 'mdi-file-pdf-box',
        excel: 'mdi-file-excel',
        word: 'mdi-file-word',
        image: 'mdi-file-image',
    }
    return icons[type] || 'mdi-file-document'
}

const getFileTypeColor = (type: string) => {
    const colors: Record<string, string> = {
        pdf: 'red',
        excel: 'green',
        word: 'blue',
        image: 'purple',
    }
    return colors[type] || 'grey'
}

const formatDate = (date: string) => {
    return new Date(date).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
    })
}

const openDocument = (doc: any) => {
    console.log('Opening document:', doc.name)
    // Implement document opening logic here
}
</script>

<style scoped>
.documents-page {
    max-width: 1400px;
    margin: 0 auto;
}

.page-header {
    margin-bottom: 2rem;
}

.page-title {
    font-size: 2.5rem;
    font-weight: 600;
    color: #333;
    margin-bottom: 1.5rem;
}

.document-card {
    height: 100%;
    transition: all 0.2s ease;
    cursor: pointer;
}

.document-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
}

.file-info {
    min-width: 0;
}

.file-name {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.file-tags {
    min-height: 24px;
}

.documents-table :deep(.v-data-table__tr:hover) {
    background-color: rgba(0, 0, 0, 0.04);
    cursor: pointer;
}

.tags-container {
    display: flex;
    flex-wrap: wrap;
    gap: 4px;
    max-width: 200px;
}

.gap-2 {
    gap: 8px;
}
</style>
