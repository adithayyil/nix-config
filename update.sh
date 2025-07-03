#!/usr/bin/env bash
# update.sh - Easy script to rebuild and switch to the new configuration

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Updating nix-darwin configuration...${NC}"

# Move to the configuration directory
cd /etc/nix-darwin

# Check if there are uncommitted changes
if [[ -n $(git status --porcelain) ]]; then
    echo -e "${YELLOW}Uncommitted changes detected, committing...${NC}"
    git add .
    git commit -m "Auto-update $(date '+%Y-%m-%d %H:%M:%S')"
fi

# Update flake inputs
echo -e "${GREEN}Updating flake inputs...${NC}"
nix flake update

# Rebuild and switch to the new configuration
echo -e "${GREEN}Rebuilding and switching to the new configuration...${NC}"
darwin-rebuild switch --flake .

echo -e "${GREEN}Done! Configuration updated successfully.${NC}"
