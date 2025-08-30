<template>
    <v-container class="fill-height" fluid>
        <v-row align="center" justify="center">
            <v-col cols="12" md="4" sm="8">
                <v-card class="elevation-12">
                    <v-toolbar color="primary" dark flat>
                        <v-toolbar-title>Easy Reviews - Login</v-toolbar-title>
                    </v-toolbar>

                    <v-card-text>
                        <v-form ref="form" v-model="valid" lazy-validation>
                            <v-text-field
                                v-model="email"
                                class="mb-3"
                                label="Email"
                                prepend-icon="mdi-email"
                                required
                                :rules="emailRules"
                                type="email"
                                variant="outlined"
                            />

                            <v-text-field
                                v-model="password"
                                :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                                class="mb-3"
                                label="Password"
                                prepend-icon="mdi-lock"
                                required
                                :rules="passwordRules"
                                :type="showPassword ? 'text' : 'password'"
                                variant="outlined"
                                @click:append="showPassword = !showPassword"
                            />

                            <v-checkbox v-model="rememberMe" class="mb-3" color="primary" label="Remember me" />
                        </v-form>
                    </v-card-text>

                    <v-card-actions>
                        <v-spacer />
                        <v-btn color="primary" :disabled="!valid || loading" :loading="loading" size="large" variant="flat" @click="login">
                            Login
                        </v-btn>
                    </v-card-actions>

                    <v-divider class="mx-4" />

                    <v-card-text class="text-center">
                        <v-btn color="primary" variant="text" @click="goToRegister"> Don't have an account? Sign up </v-btn>

                        <br />

                        <v-btn color="secondary" size="small" variant="text" @click="forgotPassword"> Forgot password? </v-btn>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- Success/Error Snackbar -->
        <v-snackbar v-model="snackbar" :color="snackbarColor" :timeout="4000" top>
            {{ snackbarText }}
            <template #actions>
                <v-btn color="white" variant="text" @click="snackbar = false"> Close </v-btn>
            </template>
        </v-snackbar>
    </v-container>
</template>

<script lang="ts" setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

// Form validation
const form = ref(null);
const valid = ref(false);

// Form data
const email = ref('');
const password = ref('');
const rememberMe = ref(false);
const showPassword = ref(false);
const loading = ref(false);

// Snackbar for notifications
const snackbar = ref(false);
const snackbarText = ref('');
const snackbarColor = ref('success');

// Validation rules
const emailRules = [(v: string) => !!v || 'Email is required', (v: string) => /.+@.+\..+/.test(v) || 'Email must be valid'];

const passwordRules = [(v: string) => !!v || 'Password is required', (v: string) => v.length >= 6 || 'Password must be at least 6 characters'];

// Methods
const login = async () => {
    if (!form.value) return;

    // Validate form
    const { valid: isValid } = await (form.value as any).validate();
    if (!isValid) return;

    loading.value = true;

    try {
        // Simulate API call - replace with actual authentication logic
        await new Promise((resolve) => setTimeout(resolve, 1500));

        // For demo purposes, accept any email/password combination
        if (email.value && password.value) {
            showSnackbar('Login successful! Redirecting...', 'success');

            // Redirect after successful login
            setTimeout(() => {
                router.push('/dashboard');
            }, 1000);
        } else {
            throw new Error('Invalid credentials');
        }
    } catch {
        showSnackbar('Login failed. Please check your credentials.', 'error');
    } finally {
        loading.value = false;
    }
};

const goToRegister = () => {
    router.push('/auth/register');
};

const forgotPassword = () => {
    router.push('/auth/forgot-password');
};

const showSnackbar = (text: string, color: string) => {
    snackbarText.value = text;
    snackbarColor.value = color;
    snackbar.value = true;
};

// Auto-fill demo credentials (remove in production)
const fillDemoCredentials = () => {
    email.value = 'demo@example.com';
    password.value = 'password123';
};

// Expose for potential debugging
defineExpose({
    fillDemoCredentials,
});
</script>

<style scoped>
.v-container {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
}

.v-card {
    border-radius: 12px;
}

.v-toolbar {
    border-radius: 12px 12px 0 0;
}
</style>
