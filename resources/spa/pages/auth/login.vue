<template>
    <div class="login-container">
        <div class="login-card">
            <!-- Logo Section -->
            <div class="logo-section">
                <img alt="H&H Axis" class="logo" :src="logoImage" />
            </div>

            <!-- Form Section -->
            <v-form
                ref="form"
                v-model="valid"
                class="login-form"
                lazy-validation
            >
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <v-text-field
                        v-model="email"
                        class="custom-input"
                        hide-details="auto"
                        placeholder="name@company.com"
                        required
                        :rules="emailRules"
                        type="email"
                        variant="outlined"
                    />
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <v-text-field
                        v-model="password"
                        :append-inner-icon="
                            showPassword ? 'mdi-eye' : 'mdi-eye-off'
                        "
                        class="custom-input"
                        hide-details="auto"
                        placeholder="••••••••"
                        required
                        :rules="passwordRules"
                        :type="showPassword ? 'text' : 'password'"
                        variant="outlined"
                        @click:append-inner="showPassword = !showPassword"
                    />
                </div>

                <div class="form-options">
                    <v-checkbox
                        v-model="rememberMe"
                        class="remember-checkbox"
                        hide-details
                        label="Remember me"
                    />
                    <v-btn
                        class="forgot-password-link"
                        size="small"
                        variant="text"
                        @click="forgotPassword"
                    >
                        Forgot password?
                    </v-btn>
                </div>

                <v-btn
                    block
                    class="sign-in-btn"
                    color="#D4AF37"
                    :disabled="!valid || loading"
                    :loading="loading"
                    size="large"
                    variant="flat"
                    @click="login"
                >
                    Sign in
                </v-btn>
            </v-form>
        </div>

        <!-- Footer -->
        <div class="footer">© 2025 H&H Axis - Private Fund Finance</div>

        <!-- Success/Error Snackbar -->
        <v-snackbar
            v-model="snackbar"
            :color="snackbarColor"
            :timeout="4000"
            top
        >
            {{ snackbarText }}
            <template #actions>
                <v-btn color="white" variant="text" @click="snackbar = false">
                    Close
                </v-btn>
            </template>
        </v-snackbar>
    </div>
</template>

<script lang="ts" setup>
import logoImage from '@/assets/logo-lg.png'
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// Form validation
const form = ref(null)
const valid = ref(false)

// Form data
const email = ref('')
const password = ref('')
const rememberMe = ref(false)
const showPassword = ref(false)
const loading = ref(false)

// Snackbar for notifications
const snackbar = ref(false)
const snackbarText = ref('')
const snackbarColor = ref('success')

// Validation rules
const emailRules = [
    (v: string) => !!v || 'Email is required',
    (v: string) => /.+@.+\..+/.test(v) || 'Email must be valid',
]

const passwordRules = [
    (v: string) => !!v || 'Password is required',
    (v: string) => v.length >= 6 || 'Password must be at least 6 characters',
]

// Methods
const login = async () => {
    if (!form.value) return

    // Validate form
    const { valid: isValid } = await (form.value as any).validate()
    if (!isValid) return

    loading.value = true

    try {
        // Simulate API call - replace with actual authentication logic
        await new Promise((resolve) => setTimeout(resolve, 1500))

        // For demo purposes, accept any email/password combination
        if (email.value && password.value) {
            showSnackbar('Login successful! Redirecting...', 'success')

            // Redirect after successful login
            setTimeout(() => {
                router.push('/dashboard')
            }, 1000)
        } else {
            throw new Error('Invalid credentials')
        }
    } catch {
        showSnackbar('Login failed. Please check your credentials.', 'error')
    } finally {
        loading.value = false
    }
}

const forgotPassword = () => {
    router.push('/auth/forgot-password')
}

const showSnackbar = (text: string, color: string) => {
    snackbarText.value = text
    snackbarColor.value = color
    snackbar.value = true
}

// Auto-fill demo credentials (remove in production)
const fillDemoCredentials = () => {
    email.value = 'demo@example.com'
    password.value = 'password123'
}

// Expose for potential debugging
defineExpose({
    fillDemoCredentials,
})
</script>

<style scoped>
.login-container {
    min-height: 100vh;
    background: #1a2332;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    padding: 20px;
}

.login-card {
    background: #000000;
    border-radius: 20px;
    padding: 40px;
    width: 100%;
    max-width: 400px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.logo-section {
    text-align: center;
    margin-bottom: 40px;

    background: none #fff;
    border-radius: 10px 10px 0px 0px;
    padding: 25px 0px;
}

.logo {
    max-width: 200px;
    height: auto;
}

.login-form {
    width: 100%;
}

.form-group {
    margin-bottom: 24px;
}

.form-label {
    color: #ffffff;
    font-size: 14px;
    font-weight: 500;
    margin-bottom: 8px;
    display: block;
}

.custom-input :deep(.v-field) {
    background-color: #2d3748;
    border-radius: 8px;
}

.custom-input :deep(.v-field__input) {
    color: #ffffff;
    padding: 12px 16px;
}

.custom-input :deep(.v-field__input)::placeholder {
    color: #a0a0a0;
}

.custom-input :deep(.v-field__outline) {
    --v-field-border-opacity: 0.3;
}

.custom-input :deep(.v-field--focused .v-field__outline) {
    --v-field-border-opacity: 1;
    color: #4299e1;
}

.form-options {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 32px;
}

.remember-checkbox :deep(.v-selection-control__wrapper) {
    color: #ffffff;
}

.remember-checkbox :deep(.v-label) {
    color: #ffffff;
    font-size: 14px;
}

.forgot-password-link {
    color: #4299e1;
    text-decoration: underline;
    font-size: 14px;
    padding: 0;
    min-width: auto;
    height: auto;
}

.forgot-password-link:hover {
    color: #63b3ed;
}

.sign-in-btn {
    background-color: #d4af37 !important;
    color: #000000 !important;
    font-weight: 600;
    font-size: 16px;
    border-radius: 8px;
    height: 48px;
    text-transform: none;
    letter-spacing: normal;
}

.sign-in-btn:hover {
    background-color: #b8941f !important;
}

.footer {
    margin-top: 40px;
    color: #8a92a5;
    font-size: 12px;
    text-align: center;
}

/* Responsive design */
@media (max-width: 480px) {
    .login-card {
        padding: 30px 20px;
        margin: 20px;
    }

    .logo {
        max-width: 150px;
    }
}
</style>
