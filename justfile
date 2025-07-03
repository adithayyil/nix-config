# Justfile for nix-darwin management
# Usage: just <command>

# Default recipe to display help
default:
    @just --list

# Build and switch the system configuration
switch:
    darwin-rebuild switch --flake /etc/nix-darwin

# Build without switching
build:
    darwin-rebuild build --flake /etc/nix-darwin

# Check the configuration for syntax errors
check:
    darwin-rebuild check --flake /etc/nix-darwin

# Update flake inputs
update:
    nix flake update /etc/nix-darwin

# Update a specific input
update-input input:
    nix flake lock --update-input {{input}} /etc/nix-darwin

# Garbage collect old generations
gc:
    sudo nix-collect-garbage -d
    sudo nix-store --optimize

# Show system generations
generations:
    sudo nix-env -p /nix/var/nix/profiles/system --list-generations

# Delete old generations (keep last 3)
clean-generations:
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3

# Show what would be updated
diff:
    darwin-rebuild build --flake /etc/nix-darwin
    nvd diff /run/current-system ./result

# Rollback to previous generation
rollback:
    sudo nix-env -p /nix/var/nix/profiles/system --rollback
    sudo /nix/var/nix/profiles/system/activate

# Show flake info
info:
    nix flake show /etc/nix-darwin

# Check for issues
doctor:
    nix-doctor

# Search for packages
search package:
    nix search nixpkgs {{package}}

# Install a package temporarily
shell package:
    nix shell nixpkgs#{{package}}

# Format nix files
fmt:
    find /etc/nix-darwin -name "*.nix" -exec nixpkgs-fmt {} \;

# Backup current configuration
backup:
    cp -r /etc/nix-darwin ~/nix-darwin-backup-$(date +%Y%m%d-%H%M%S)
    echo "Backup created in ~/nix-darwin-backup-$(date +%Y%m%d-%H%M%S)"
