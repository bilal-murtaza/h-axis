#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Deploying to GitHub Pages...${NC}"

# Make sure we're on master branch
if [ "$(git branch --show-current)" != "master" ]; then
    echo -e "${RED}❌ You must be on the master branch to deploy${NC}"
    exit 1
fi

# Make sure there are no uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${RED}❌ You have uncommitted changes. Please commit or stash them first.${NC}"
    exit 1
fi

# Build the static site
echo -e "${YELLOW}📦 Building static site...${NC}"
./build-static.sh

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build failed!${NC}"
    exit 1
fi

# Check if dist directory exists and has content
if [ ! -d "dist" ] || [ -z "$(ls -A dist)" ]; then
    echo -e "${RED}❌ dist directory is empty or doesn't exist${NC}"
    exit 1
fi

# Save the current commit hash
CURRENT_COMMIT=$(git rev-parse HEAD)
CURRENT_BRANCH=$(git branch --show-current)

echo -e "${YELLOW}💾 Deploying from commit: ${CURRENT_COMMIT}${NC}"

# Create a temporary directory for gh-pages content
TEMP_DIR=$(mktemp -d)
echo -e "${YELLOW}📂 Using temporary directory: ${TEMP_DIR}${NC}"

# Copy dist contents to temp directory
cp -r dist/* "${TEMP_DIR}/"

# Switch to gh-pages branch (create if it doesn't exist)
if git show-ref --verify --quiet refs/heads/gh-pages; then
    echo -e "${YELLOW}🔄 Switching to existing gh-pages branch${NC}"
    git checkout gh-pages
else
    echo -e "${YELLOW}🆕 Creating new gh-pages branch${NC}"
    git checkout --orphan gh-pages
    # Remove all files from the new orphan branch
    git rm -rf . 2>/dev/null || true
fi

# Clear the working directory (except .git)
find . -maxdepth 1 -not -name '.git' -not -name '.' -exec rm -rf {} + 2>/dev/null || true

# Copy files from temp directory
cp -r "${TEMP_DIR}"/* ./ 2>/dev/null || true

# Clean up temp directory
rm -rf "${TEMP_DIR}"

# Add all files
git add .

# Check if there are any changes to commit
if git diff --staged --quiet; then
    echo -e "${YELLOW}⏭️  No changes to deploy${NC}"
else
    # Commit the changes
    echo -e "${YELLOW}💾 Committing changes...${NC}"
    git commit -m "Deploy from ${CURRENT_COMMIT} - $(date)"

    # Push to gh-pages
    echo -e "${YELLOW}🚀 Pushing to gh-pages...${NC}"
    git push origin gh-pages

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Successfully deployed to GitHub Pages!${NC}"
        echo -e "${GREEN}🌐 Your site should be available at: https://axis.easyapps.io${NC}"
        echo -e "${YELLOW}⏱️  Note: It may take a few minutes for changes to appear${NC}"
    else
        echo -e "${RED}❌ Failed to push to gh-pages branch${NC}"
        git checkout "${CURRENT_BRANCH}"
        exit 1
    fi
fi

# Switch back to the original branch
git checkout "${CURRENT_BRANCH}"

echo -e "${GREEN}🎉 Deployment completed!${NC}"
echo -e "${YELLOW}💡 Check your site at: https://axis.easyapps.io${NC}"
