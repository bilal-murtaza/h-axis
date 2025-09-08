#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Building static site for GitHub Pages...${NC}"

# Clean previous build
if [ -d "dist" ]; then
    echo -e "${YELLOW}🧹 Cleaning previous build...${NC}"
    rm -rf dist
fi

# Run the static build
echo -e "${YELLOW}📦 Building Vue app...${NC}"
pnpm static

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build failed!${NC}"
    exit 1
fi

# Copy public assets to dist
echo -e "${YELLOW}📂 Copying public assets...${NC}"
cp -r public/* dist/ 2>/dev/null || true

# Remove Laravel-specific files from dist if they exist
rm -f dist/index.php 2>/dev/null || true
rm -f dist/.htaccess 2>/dev/null || true

# Create .nojekyll file for GitHub Pages (to handle assets with underscores)
touch dist/.nojekyll

# Create a CNAME file for custom domain
echo "axis.easyapps.io" > dist/CNAME

echo -e "${GREEN}✅ Static site built successfully!${NC}"
echo -e "${GREEN}📁 Output directory: dist/${NC}"
echo -e "${YELLOW}💡 You can preview it locally by running: pnpm static:preview${NC}"
echo -e "${YELLOW}💡 To deploy to GitHub Pages, push the 'dist' folder to a 'gh-pages' branch${NC}"
