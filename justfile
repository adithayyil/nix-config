# 🍎 Adi's Nix Darwin - Task Runner

# Show available commands
default:
    @just --list

# 🚀 Daily Commands

# Apply configuration changes
switch:
    darwin-rebuild switch --flake .#Adis-MacBook-Air

# Build without applying (test first!)
build:
    darwin-rebuild build --flake .#Adis-MacBook-Air

# Validate configuration
check:
    nix flake check

# Update dependencies
update:
    nix flake update

# 🧹 Maintenance

# Clean old generations and optimize store
cleanup:
    sudo nix-collect-garbage -d
    nix-collect-garbage -d
    nix store optimise

# Show what would change
diff:
    darwin-rebuild build --flake .#Adis-MacBook-Air
    nvd diff /run/current-system ./result

# Rollback to previous generation
rollback:
    sudo nix-env -p /nix/var/nix/profiles/system --rollback
    sudo /nix/var/nix/profiles/system/activate

# Format nix files
fmt:
    nixpkgs-fmt **/*.nix

# Backup current configuration
backup:
    cp -r /etc/nix-darwin ~/nix-darwin-backup-$(date +%Y%m%d-%H%M%S)
    @echo "✅ Backup created: ~/nix-darwin-backup-$(date +%Y%m%d-%H%M%S)"

# 📊 Information

# Show system info
info:
    @echo "🖥️  System: $(hostname) ($(uname -m))"
    @echo "🍎 macOS: $(sw_vers -productVersion)"
    @echo "❄️  Nix: $(nix --version | head -1)"
    @echo "📦 Flake: $(nix flake metadata --json | jq -r .lastModified | xargs -I {} date -r {})"

# Show flake metadata
meta:
    nix flake metadata

# Check for system issues
doctor:
    nix-doctor

# 🛠️ Development

# Enter development shell
dev:
    nix develop

# Search for packages
search package:
    nix search nixpkgs {{package}}

# Install a package temporarily
shell package:
    nix shell nixpkgs#{{package}}
