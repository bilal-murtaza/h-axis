import vuetify from 'eslint-config-vuetify'

export default vuetify({
    rules: {
        // Override all indentation rules to use 4 spaces
        '@stylistic/indent': ['error', 4],
        // eslint-disable-next-line @stylistic/quote-props
        indent: ['error', 4],
        '@stylistic/comma-dangle': ['error', 'always-multiline'],
        '@stylistic/quote-props': ['error', 'consistent-as-needed'],
        // Disable conflicting Vue indentation rules - let Prettier handle this
        'vue/script-indent': 'off',
        'vue/html-indent': 'off',
        'vue/html-closing-bracket-newline': 'off',
    },
})
