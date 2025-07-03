#!/usr/bin/env bash
# Bootstrap script for setting up nix-darwin configuration

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    error "This script is for macOS only"
    exit 1
fi

# Install Nix if not present
if ! command -v nix &> /dev/null; then
    log "Installing Nix..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Install nix-darwin if not present
if ! command -v darwin-rebuild &> /dev/null; then
    log "Installing nix-darwin..."
    nix run nix-darwin -- switch --flake /etc/nix-darwin
fi

# Install just for easier management
if ! command -v just &> /dev/null; then
    log "Installing just..."
    nix profile install nixpkgs#just
fi

# Update flake lock
log "Updating flake inputs..."
cd /etc/nix-darwin
nix flake update

# Initial build and switch
log "Building and switching to new configuration..."
darwin-rebuild switch --flake /etc/nix-darwin

log "Setup complete! You can now use 'just switch' to rebuild your system."
log "Run 'just' to see available commands."

# Remind user to update their email in home-manager config
warn "Don't forget to update your email in /etc/nix-darwin/home/adi.nix"
