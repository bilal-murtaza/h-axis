# Static Site Deployment for GitHub Pages

This project automatically deploys the Vue.js SPA as a static site to GitHub Pages using GitHub Actions.

## Quick Start

The deployment is **fully automated** via GitHub Actions. Simply push to the master branch and your site will be built and deployed automatically.

## What happens during automated deployment?

1. **Vite Build**: Uses the `vite.static.config.mts` configuration to build the Vue app for static deployment
2. **Asset Copying**: Copies all public assets (favicon, images, etc.) to the dist folder  
3. **Laravel Cleanup**: Removes Laravel-specific files like `index.php`
4. **GitHub Pages Optimization**: Creates `.nojekyll` file to handle assets with underscores
5. **Custom Domain**: Creates `CNAME` file with `axis.easyapps.io`
6. **Deployment**: Automatically deploys to GitHub Pages

## Manual Build (Development Only)

For local development and testing, you can build the static site manually:

```bash
pnpm static
```

## Files Used for Deployment

- `vite.static.config.mts` - Vite configuration for static builds
- `static.html` - HTML template for the static site
- `.github/workflows/deploy.yml` - GitHub Actions workflow for automatic deployment

## Automatic Deployment

The GitHub Actions workflow (`.github/workflows/deploy.yml`) will automatically:

- **Trigger**: Runs on every push to master branch
- **Build**: Builds the Vue app using `pnpm static`
- **Process**: Handles asset copying, cleanup, and GitHub Pages optimization
- **Deploy**: Uses GitHub Pages native deployment (no need for gh-pages branch)
- **Domain**: Automatically sets up custom domain `axis.easyapps.io`

### To enable automatic deployment:

1. Go to your repository settings
2. Navigate to Pages  
3. Set Source to "GitHub Actions"
4. Push to master branch - deployment will happen automatically!

## Preview Locally

After building manually, you can preview the static site locally:

```bash
pnpm static:preview
```

## Customization

### Custom Domain

The deployment automatically sets up the custom domain `axis.easyapps.io`. To change this, modify the CNAME creation step in `.github/workflows/deploy.yml`.

### Base Path

If deploying to a subdirectory, modify the `base` option in `vite.static.config.mts`:

```js
base: '/your-repo-name/', // For GitHub Pages repository pages
```

## Configuration Details

### vite.static.config.mts

- Removes Laravel Vite plugin
- Sets base path to `./` for relative URLs
- Uses `static.html` as entry point
- Outputs to `dist` directory

### static.html

- Based on your Laravel Blade template
- Removes Laravel-specific Blade syntax
- Directly references the Vue app entry point

### .github/workflows/deploy.yml

- Triggered on push to master branch
- Uses pnpm for dependency management
- Builds static site with proper asset handling
- Creates `.nojekyll` and `CNAME` files
- Deploys using GitHub Pages Actions

## Troubleshooting

### Assets not loading

- Check that the `base` path in `vite.static.config.mts` is correct
- Ensure `.nojekyll` file exists in the dist folder (automatically created by GitHub Actions)

### Vue Router issues

- Make sure your Vue Router is configured for hash mode or has proper fallback handling
- For history mode, you may need to configure your server for SPA routing

### Font loading issues

- Fonts from external sources (like Google Fonts) should work fine
- Local fonts need to be in the public directory or properly imported

### Deployment not triggering

- Check that GitHub Pages source is set to "GitHub Actions" in repository settings
- Ensure you're pushing to the master branch
- Check the Actions tab in your GitHub repository for workflow status

## Scripts Reference

- `pnpm static` - Build static site only (for local development)
- `pnpm static:preview` - Preview built static site locally

**Note**: All deployment is now handled automatically by GitHub Actions when you push to master!
