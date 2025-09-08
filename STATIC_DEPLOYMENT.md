# Static Site Deployment for GitHub Pages

This project includes scripts and configurations to deploy the Vue.js SPA as a static site to GitHub Pages.

## Quick Start

### Option 1: Using the build script (Recommended)

```bash
./build-static.sh
```

### Option 2: Using pnpm directly

```bash
pnpm static
```

### Option 3: Using the complete build script via pnpm

```bash
pnpm static:build
```

## What happens during the build?

1. **Vite Build**: Uses the `vite.static.config.mts` configuration to build the Vue app for static deployment
2. **Asset Copying**: Copies all public assets (favicon, images, etc.) to the dist folder
3. **Laravel Cleanup**: Removes Laravel-specific files like `index.php`
4. **GitHub Pages Optimization**: Creates `.nojekyll` file to handle assets with underscores

## Files Created/Modified

- `vite.static.config.mts` - Vite configuration for static builds
- `static.html` - HTML template for the static site
- `build-static.sh` - Shell script that handles the complete build process
- `.github/workflows/deploy.yml` - GitHub Actions workflow for automatic deployment
- `package.json` - Added static build scripts

## Manual Deployment to GitHub Pages

1. Build the static site:

    ```bash
    ./build-static.sh
    ```

2. Create and switch to a gh-pages branch:

    ```bash
    git checkout --orphan gh-pages
    git rm -rf .
    cp -r dist/* .
    git add .
    git commit -m "Deploy static site"
    git push origin gh-pages
    ```

3. In your GitHub repository settings, set the Pages source to the `gh-pages` branch.

## Automatic Deployment

The included GitHub Actions workflow (`.github/workflows/deploy.yml`) will automatically:

- Build and deploy your site when you push to master/main
- Use GitHub Pages native deployment (no need for gh-pages branch)
- Handle all the build steps automatically

To enable automatic deployment:

1. Go to your repository settings
2. Navigate to Pages
3. Set Source to "GitHub Actions"
4. Push to master/main branch

## Preview Locally

After building, you can preview the static site locally:

```bash
pnpm static:preview
```

## Customization

### Custom Domain

If you have a custom domain, uncomment and modify this line in `build-static.sh`:

```bash
echo "your-domain.com" > dist/CNAME
```

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

## Troubleshooting

### Assets not loading

- Check that the `base` path in `vite.static.config.mts` is correct
- Ensure `.nojekyll` file exists in the dist folder

### Vue Router issues

- Make sure your Vue Router is configured for hash mode or has proper fallback handling
- For history mode, you may need to configure your server for SPA routing

### Font loading issues

- Fonts from external sources (like Google Fonts) should work fine
- Local fonts need to be in the public directory or properly imported

## Scripts Reference

- `pnpm static` - Build static site only
- `pnpm static:preview` - Preview built static site
- `pnpm static:build` - Complete build with asset copying and cleanup
- `./build-static.sh` - Same as above, direct script execution
