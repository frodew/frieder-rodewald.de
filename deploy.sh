#!/bin/bash

# Deployment script for frieder-rodewald.de
# This script builds the Astro site and deploys it to the remote server

# Note: Not using 'set -e' because rsync can return exit code 23
# (partial transfer with warnings) which we want to treat as success

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REMOTE_CONNECTION="manitu"
REMOTE_PATH="/home/sites/site100001767/web/frieder-rodewald.de"
LOCAL_BUILD_DIR="dist/"

echo -e "${YELLOW}🚀 Starting deployment...${NC}"

# Step 1: Build the site
echo -e "${YELLOW}📦 Building Astro site...${NC}"
if npm run build; then
    echo -e "${GREEN}✓ Build successful${NC}"
else
    echo -e "${RED}✗ Build failed${NC}"
    exit 1
fi

# Step 2: Deploy to server
echo -e "${YELLOW}🔄 Syncing to server...${NC}"
rsync -avz --delete \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='.DS_Store' \
    "${LOCAL_BUILD_DIR}" \
    "${REMOTE_CONNECTION}:${REMOTE_PATH}"

RSYNC_EXIT=$?

# Exit codes: 0 = success, 23 = partial transfer (files transferred but some warnings)
if [ $RSYNC_EXIT -eq 0 ] || [ $RSYNC_EXIT -eq 23 ]; then
    echo -e "${GREEN}✓ Deployment successful!${NC}"
    echo -e "${GREEN}🌐 Your site is live at https://frieder-rodewald.de${NC}"
    exit 0
else
    echo -e "${RED}✗ Deployment failed with exit code $RSYNC_EXIT${NC}"
    exit 1
fi
