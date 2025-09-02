<template>
    <div class="landing-page">
        <!-- Hero Section -->
        <v-container class="hero-section" fluid>
            <!-- Animated SVG Background -->
            <div class="animated-bg">
                <svg
                    class="animated-svg"
                    viewBox="0 0 1200 800"
                    xmlns="http://www.w3.org/2000/svg"
                >
                    <defs>
                        <linearGradient
                            id="bgGradient"
                            x1="0%"
                            x2="100%"
                            y1="0%"
                            y2="100%"
                        >
                            <stop
                                offset="0%"
                                style="stop-color: #1a237e; stop-opacity: 1"
                            />
                            <stop
                                offset="50%"
                                style="stop-color: #3949ab; stop-opacity: 1"
                            />
                            <stop
                                offset="100%"
                                style="stop-color: #5e35b1; stop-opacity: 1"
                            />
                        </linearGradient>
                        <linearGradient
                            id="accentGradient"
                            x1="0%"
                            x2="100%"
                            y1="0%"
                            y2="100%"
                        >
                            <stop
                                offset="0%"
                                style="stop-color: #ffc107; stop-opacity: 0.8"
                            />
                            <stop
                                offset="100%"
                                style="stop-color: #ff8f00; stop-opacity: 0.4"
                            />
                        </linearGradient>
                    </defs>

                    <!-- Background -->
                    <rect fill="url(#bgGradient)" height="100%" width="100%" />

                    <!-- Floating geometric shapes -->
                    <g class="floating-shapes">
                        <!-- Large circles -->
                        <circle
                            cx="200"
                            cy="150"
                            fill="url(#accentGradient)"
                            opacity="0.3"
                            r="80"
                        >
                            <animateTransform
                                attributeName="transform"
                                attributeType="XML"
                                dur="8s"
                                repeatCount="indefinite"
                                type="translate"
                                values="0,0; 20,30; 0,0"
                            />
                        </circle>
                        <circle
                            cx="1000"
                            cy="600"
                            fill="rgba(255,255,255,0.1)"
                            r="60"
                        >
                            <animateTransform
                                attributeName="transform"
                                attributeType="XML"
                                dur="6s"
                                repeatCount="indefinite"
                                type="translate"
                                values="0,0; -15,25; 0,0"
                            />
                        </circle>

                        <!-- Hexagons -->
                        <polygon
                            fill="rgba(255,193,7,0.2)"
                            points="100,300 130,320 130,360 100,380 70,360 70,320"
                        >
                            <animateTransform
                                attributeName="transform"
                                attributeType="XML"
                                dur="20s"
                                repeatCount="indefinite"
                                type="rotate"
                                values="0 100 340; 360 100 340"
                            />
                        </polygon>
                        <polygon
                            fill="rgba(255,255,255,0.1)"
                            points="1050,100 1080,120 1080,160 1050,180 1020,160 1020,120"
                        >
                            <animateTransform
                                attributeName="transform"
                                attributeType="XML"
                                dur="15s"
                                repeatCount="indefinite"
                                type="rotate"
                                values="360 1050 140; 0 1050 140"
                            />
                        </polygon>

                        <!-- Triangles -->
                        <polygon
                            fill="rgba(255,193,7,0.3)"
                            points="900,200 920,240 880,240"
                        >
                            <animateTransform
                                attributeName="transform"
                                attributeType="XML"
                                dur="7s"
                                repeatCount="indefinite"
                                type="translate"
                                values="0,0; 10,-20; 0,0"
                            />
                        </polygon>
                        <polygon
                            fill="rgba(255,255,255,0.15)"
                            points="300,500 320,540 280,540"
                        >
                            <animateTransform
                                attributeName="transform"
                                attributeType="XML"
                                dur="9s"
                                repeatCount="indefinite"
                                type="translate"
                                values="0,0; -8,15; 0,0"
                            />
                        </polygon>

                        <!-- Lines and connections -->
                        <line
                            stroke="rgba(255,193,7,0.3)"
                            stroke-width="2"
                            x1="200"
                            x2="300"
                            y1="150"
                            y2="200"
                        >
                            <animate
                                attributeName="opacity"
                                dur="4s"
                                repeatCount="indefinite"
                                values="0.3; 0.7; 0.3"
                            />
                        </line>
                        <line
                            stroke="rgba(255,255,255,0.2)"
                            stroke-width="1"
                            x1="900"
                            x2="1050"
                            y1="200"
                            y2="100"
                        >
                            <animate
                                attributeName="opacity"
                                dur="5s"
                                repeatCount="indefinite"
                                values="0.2; 0.5; 0.2"
                            />
                        </line>

                        <!-- Dots -->
                        <circle cx="150" cy="250" fill="#ffc107" r="4">
                            <animate
                                attributeName="opacity"
                                dur="3s"
                                repeatCount="indefinite"
                                values="0.5; 1; 0.5"
                            />
                        </circle>
                        <circle
                            cx="850"
                            cy="350"
                            fill="rgba(255,255,255,0.8)"
                            r="3"
                        >
                            <animate
                                attributeName="opacity"
                                dur="4s"
                                repeatCount="indefinite"
                                values="0.3; 0.8; 0.3"
                            />
                        </circle>
                        <circle
                            cx="600"
                            cy="100"
                            fill="rgba(255,193,7,0.6)"
                            r="5"
                        >
                            <animate
                                attributeName="opacity"
                                dur="2.5s"
                                repeatCount="indefinite"
                                values="0.4; 1; 0.4"
                            />
                        </circle>
                    </g>
                </svg>
            </div>
            <v-container class="punch">
                <v-row align="center" class="min-height-50vh" justify="center">
                    <v-col class="text-center" cols="12" md="8">
                        <div class="hero-logo mb-6">
                            <div class="d-flex justify-center">
                                <v-img
                                    alt="H&H AXIS"
                                    class="hero-logo-image mb-4"
                                    src="@/assets/logo-lg.png"
                                />
                            </div>
                            <div class="subtitle text-h6 text-grey-lighten-2">
                                Private Fund Finance Suite
                            </div>
                        </div>
                        <p class="text-h5 text-grey-lighten-1 mb-8">
                            Streamline your private fund operations with our
                            comprehensive financial management platform
                        </p>
                        <v-btn
                            class="text-h6 px-8 py-3"
                            color="amber"
                            rounded="lg"
                            size="x-large"
                            to="/auth/login"
                            variant="flat"
                        >
                            Get Started
                            <v-icon end>mdi-arrow-right</v-icon>
                        </v-btn>
                    </v-col>
                </v-row>
            </v-container>
        </v-container>

        <!-- Features Overview -->
        <v-container class="py-16">
            <v-row>
                <v-col class="mb-8 text-center" cols="12">
                    <h2
                        class="text-h3 font-weight-bold text-blue-grey-darken-3 mb-4"
                    >
                        Complete Fund Management Solution
                    </h2>
                    <p class="text-h6 text-grey-darken-1 max-width-600 mx-auto">
                        Everything you need to manage your private fund
                        operations, from deal pipeline to investor relations
                    </p>
                </v-col>
            </v-row>

            <v-row class="mb-12">
                <v-col
                    v-for="feature in primaryFeatures"
                    :key="feature.title"
                    cols="12"
                    md="4"
                >
                    <v-card
                        class="feature-card h-100"
                        elevation="2"
                        rounded="lg"
                    >
                        <v-card-text class="pa-6 text-center">
                            <v-avatar
                                class="mb-4"
                                :color="feature.color"
                                size="80"
                            >
                                <v-icon color="white" size="40">{{
                                    feature.icon
                                }}</v-icon>
                            </v-avatar>
                            <h3 class="text-h5 font-weight-bold mb-3">
                                {{ feature.title }}
                            </h3>
                            <p class="text-body-1 text-grey-darken-1">
                                {{ feature.description }}
                            </p>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>

        <!-- Core Modules Section -->
        <v-container class="modules-section" fluid>
            <v-container class="py-16">
                <v-row>
                    <v-col class="mb-12 text-center" cols="12">
                        <h2 class="text-h3 font-weight-bold mb-4 text-white">
                            Powerful Core Modules
                        </h2>
                        <p class="text-h6 text-grey-lighten-2">
                            Integrated tools designed for modern fund management
                        </p>
                    </v-col>
                </v-row>

                <v-row>
                    <v-col
                        v-for="module in coreModules"
                        :key="module.title"
                        cols="12"
                        lg="3"
                        md="6"
                    >
                        <v-card
                            class="module-card h-100"
                            elevation="4"
                            rounded="lg"
                        >
                            <v-card-text class="pa-6">
                                <div class="d-flex align-center mb-4">
                                    <v-avatar
                                        class="mr-3"
                                        :color="module.color"
                                        size="50"
                                    >
                                        <v-icon color="white">{{
                                            module.icon
                                        }}</v-icon>
                                    </v-avatar>
                                    <h4 class="text-h6 font-weight-bold">
                                        {{ module.title }}
                                    </h4>
                                </div>
                                <p class="text-body-2 text-grey-darken-1 mb-4">
                                    {{ module.description }}
                                </p>
                                <v-chip-group>
                                    <v-chip
                                        v-for="feature in module.features"
                                        :key="feature"
                                        color="primary"
                                        size="small"
                                        variant="outlined"
                                    >
                                        {{ feature }}
                                    </v-chip>
                                </v-chip-group>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
            </v-container>
        </v-container>

        <!-- Analytics & Reporting -->
        <v-container class="py-16">
            <v-row align="center">
                <v-col cols="12" md="6">
                    <h2
                        class="text-h3 font-weight-bold text-blue-grey-darken-3 mb-4"
                    >
                        Advanced Analytics & Reporting
                    </h2>
                    <p class="text-h6 text-grey-darken-1 mb-6">
                        Make data-driven decisions with comprehensive reporting
                        and real-time analytics
                    </p>
                    <v-list class="bg-transparent">
                        <v-list-item
                            v-for="feature in analyticsFeatures"
                            :key="feature"
                        >
                            <template #prepend>
                                <v-icon color="green">mdi-check-circle</v-icon>
                            </template>
                            <v-list-item-title class="text-body-1">{{
                                feature
                            }}</v-list-item-title>
                        </v-list-item>
                    </v-list>
                </v-col>
                <v-col cols="12" md="6">
                    <v-card
                        class="analytics-preview"
                        elevation="8"
                        rounded="lg"
                    >
                        <v-card-text class="pa-0">
                            <div class="analytics-mockup pa-6">
                                <div class="d-flex justify-space-between mb-4">
                                    <div class="metric-card">
                                        <div class="text-caption text-grey">
                                            Total Pipeline
                                        </div>
                                        <div
                                            class="text-h4 font-weight-bold text-primary"
                                        >
                                            $520M
                                        </div>
                                    </div>
                                    <div class="metric-card">
                                        <div class="text-caption text-grey">
                                            Avg. IRR
                                        </div>
                                        <div
                                            class="text-h4 font-weight-bold text-green"
                                        >
                                            12.8%
                                        </div>
                                    </div>
                                </div>
                                <v-progress-linear
                                    class="mb-2"
                                    color="amber"
                                    height="8"
                                    rounded
                                    value="75"
                                />
                                <div class="text-caption text-grey text-center">
                                    Portfolio Performance
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>

        <!-- Analyst Corner Section -->
        <v-container class="analyst-section" fluid>
            <v-container class="py-16">
                <v-row>
                    <v-col class="mb-8 text-center" cols="12">
                        <h2 class="text-h3 font-weight-bold mb-4 text-white">
                            Analyst Corner
                        </h2>
                        <p class="text-h6 text-grey-lighten-2">
                            Tools & resources for conducting investment due
                            diligence
                        </p>
                    </v-col>
                </v-row>

                <v-row>
                    <v-col
                        v-for="tool in analystTools"
                        :key="tool.name"
                        cols="12"
                        lg="4"
                        md="6"
                    >
                        <v-card
                            class="analyst-tool-card h-100"
                            elevation="4"
                            rounded="lg"
                        >
                            <v-card-text class="pa-6 text-center">
                                <v-chip
                                    class="mb-3"
                                    :color="tool.status"
                                    variant="flat"
                                >
                                    {{ tool.label }}
                                </v-chip>
                                <h4 class="text-h6 font-weight-bold mb-2">
                                    {{ tool.name }}
                                </h4>
                                <p class="text-body-2 text-grey-darken-1">
                                    {{ tool.description }}
                                </p>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
            </v-container>
        </v-container>

        <!-- CTA Section -->
        <v-container class="py-16">
            <v-row justify="center">
                <v-col class="text-center" cols="12" md="8">
                    <v-card
                        class="cta-card pa-8"
                        color="blue-grey-darken-4"
                        elevation="8"
                        rounded="xl"
                    >
                        <v-card-text>
                            <h2
                                class="text-h3 font-weight-bold mb-4 text-white"
                            >
                                Ready to Transform Your Fund Operations?
                            </h2>
                            <p class="text-h6 text-grey-lighten-2 mb-6">
                                Join leading private fund managers who trust H&H
                                Axis for their financial operations
                            </p>
                            <div
                                class="d-flex flex-column flex-sm-row justify-center gap-4"
                            >
                                <v-btn
                                    class="px-8"
                                    color="amber"
                                    rounded="lg"
                                    size="large"
                                    to="/auth/login"
                                    variant="flat"
                                >
                                    Start Free Trial
                                </v-btn>
                                <v-btn
                                    class="px-8"
                                    color="white"
                                    rounded="lg"
                                    size="large"
                                    variant="outlined"
                                >
                                    Schedule Demo
                                </v-btn>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>

        <!-- Footer -->
        <v-footer class="bg-blue-grey-darken-4 pa-6 text-center">
            <div class="text-grey-lighten-1">
                © 2025 H&H Axis • Private Fund Finance
            </div>
        </v-footer>
    </div>
</template>

<script lang="ts" setup>
const asd = 'yooooooooooo'
const primaryFeatures = [
    {
        title: 'Deal Pipeline Management',
        description:
            'Track and manage your investment pipeline from origination to execution with advanced stage management and yield tracking.',
        icon: 'mdi-chart-line',
        color: 'blue',
    },
    {
        title: 'Capital Call Management',
        description:
            'Streamline capital calls with automated notice generation, investor tracking, and payment processing.',
        icon: 'mdi-cash-multiple',
        color: 'green',
    },
    {
        title: 'Earnings & Distributions',
        description:
            'Manage distributions with payment calendars, yield calculations, and automated notice generation.',
        icon: 'mdi-trending-up',
        color: 'amber',
    },
]

const coreModules = [
    {
        title: 'Deal Pipeline',
        description:
            'Comprehensive deal tracking with stage management, borrower information, and expected close dates.',
        icon: 'mdi-pipeline',
        color: 'blue',
        features: [
            'Stage Tracking',
            'Yield Analysis',
            'Kanban View',
            'Export Tools',
        ],
    },
    {
        title: 'Capital Calls',
        description:
            'Efficient capital call management with notice generation and fund tracking.',
        icon: 'mdi-account-cash',
        color: 'green',
        features: [
            'Notice Generation',
            'Fund Tracking',
            'PDF Export',
            'Status Management',
        ],
    },
    {
        title: 'Investor Relations',
        description:
            'Complete investor management with profiles, commitments, and communication tracking.',
        icon: 'mdi-account-group',
        color: 'purple',
        features: [
            'Investor Profiles',
            'Capital Tracking',
            'IRR Analysis',
            'Document Management',
        ],
    },
    {
        title: 'Document Center',
        description:
            'Centralized document management with categorization and search capabilities.',
        icon: 'mdi-file-document-multiple',
        color: 'orange',
        features: [
            'File Organization',
            'Search & Filter',
            'Grid/List View',
            'Tag Management',
        ],
    },
    {
        title: 'Reporting Suite',
        description:
            'Advanced reporting with portfolio analysis, pipeline tracking, and custom reports.',
        icon: 'mdi-chart-box',
        color: 'red',
        features: [
            'Portfolio Analysis',
            'Pipeline Reports',
            'Custom Dashboards',
            'Export Options',
        ],
    },
    {
        title: 'Distributions',
        description:
            'Automated distribution management with payment tracking and notice generation.',
        icon: 'mdi-bank-transfer',
        color: 'teal',
        features: [
            'Payment Calendar',
            'Distribution Notices',
            'Yield Tracking',
            'Status Management',
        ],
    },
]

const analyticsFeatures = [
    'Real-time portfolio performance tracking',
    'Pipeline analysis with stage progression',
    'IRR and yield calculations',
    'Sector allocation analysis',
    'Monthly distribution tracking',
    'Custom report generation',
    'Export to Excel and PDF',
    'Interactive dashboards',
]

const analystTools = [
    {
        name: 'Financial Model Templates',
        description: 'Pre-built financial models for investment analysis',
        status: 'amber',
        label: 'New',
    },
    {
        name: 'Valuation Calculator',
        description: 'Advanced valuation tools for deal assessment',
        status: 'amber',
        label: 'New',
    },
    {
        name: 'Risk Assessment Tool',
        description: 'Comprehensive risk analysis framework',
        status: 'orange',
        label: 'Updated',
    },
    {
        name: 'Credit Scoring Tool',
        description: 'Automated credit scoring and analysis',
        status: 'blue',
        label: 'Popular',
    },
    {
        name: 'Due Diligence Checklist',
        description: 'Standardized due diligence workflows',
        status: 'blue',
        label: 'Popular',
    },
    {
        name: 'Comparable Deals DB',
        description: 'Database of comparable transactions',
        status: 'orange',
        label: 'Updated',
    },
]
</script>

<style scoped>
.landing-page {
    overflow-x: hidden;
}

.hero-section {
    background: linear-gradient(135deg, #1a237e 0%, #3949ab 50%, #5e35b1 100%);
    min-height: 100vh;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
}

.hero-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
    opacity: 0.1;
}

.hero-logo-image {
    max-height: 150px;
    max-width: 510px;
    width: auto;
    height: auto;
    filter: brightness(1.1);
}

.min-height-50vh {
    min-height: 50vh;
}

.max-width-600 {
    max-width: 600px;
}

.feature-card {
    transition: all 0.3s ease;
    border: 1px solid rgba(0, 0, 0, 0.05);
}

.feature-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15) !important;
}

.modules-section {
    background: linear-gradient(135deg, #263238 0%, #37474f 100%);
}

.module-card {
    transition: all 0.3s ease;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
}

.module-card:hover {
    transform: translateY(-5px);
    background: rgba(255, 255, 255, 1);
}

.analytics-preview {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.analytics-mockup {
    background: white;
    border-radius: 8px;
}

.metric-card {
    text-align: center;
    padding: 16px;
    background: rgba(0, 0, 0, 0.02);
    border-radius: 8px;
    min-width: 120px;
}

.analyst-section {
    background: linear-gradient(135deg, #424242 0%, #616161 100%);
}

.analyst-tool-card {
    transition: all 0.3s ease;
    background: rgba(255, 255, 255, 0.95);
}

.analyst-tool-card:hover {
    transform: translateY(-5px);
    background: rgba(255, 255, 255, 1);
}

.cta-card {
    background: linear-gradient(135deg, #1a237e 0%, #3949ab 100%) !important;
}

.gap-4 {
    gap: 1rem;
}

@media (max-width: 600px) {
    .hero-section {
        min-height: 80vh;
    }

    .text-h2 {
        font-size: 2rem !important;
    }

    .text-h3 {
        font-size: 1.5rem !important;
    }
}
.animated-bg {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    z-index: 0;
    pointer-events: none;
}
.punch {
    z-index: 10;
    position: relative;
}
</style>
