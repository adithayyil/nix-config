# Adi's Nix Darwin Configuration

This repository contains my personal nix-darwin system configuration, managing packages, dotfiles, and system settings in a declarative way.

## 🚀 Quick Start

### Prerequisites
- macOS (tested on macOS Monterey+)
- Admin access to install Nix

### Installation

1. **Clone or copy this configuration to `/etc/nix-darwin`**
2. **Run the installation script:**
   ```bash
   sudo /etc/nix-darwin/install.sh
   ```
3. **Update your personal information in `home/adi.nix`** (email, name, etc.)

### Daily Usage

This configuration uses [just](https://just.systems/) for easy management:

```bash
# Rebuild and switch to new configuration
just switch

# Build without switching (useful for testing)
just build

# Update all flake inputs
just update

# Garbage collect old generations
just gc

# See all available commands
just
```

## 📁 Repository Structure

```
/etc/nix-darwin/
├── flake.nix                 # Main flake configuration
├── justfile                  # Task runner for common operations
├── install.sh               # Bootstrap script
├── lib/                     # Helper functions
│   ├── default.nix          # Library exports
│   └── helpers.nix          # Darwin system builders
├── hosts/                   # Host-specific configurations
│   ├── common/              # Shared configurations
│   │   ├── common-packages.nix
│   │   └── darwin-common.nix
│   └── darwin/              # macOS specific hosts
│       └── Adis-MacBook-Air/
│           └── default.nix
├── home/                    # Home Manager configurations
│   └── adi.nix             # Personal user configuration
├── modules/                 # Custom NixOS/nix-darwin modules
└── data/                   # Static configuration files
```

## 🛠 Key Features

### Package Management
- **Nix packages**: Managed declaratively in `common-packages.nix`
- **Homebrew integration**: Casks and Mac App Store apps
- **Development tools**: Modern CLI replacements (bat, eza, ripgrep, etc.)

### Dotfiles Management
- **Shell configuration**: Fish shell with modern plugins
- **Git configuration**: Sensible defaults with diff-so-fancy
- **Terminal tools**: Tmux, Neovim, Starship prompt
- **Development environment**: Direnv for project-specific environments

### System Configuration
- **macOS defaults**: Dock, Finder, trackpad settings
- **Fonts**: Nerd Fonts for better terminal experience
- **Services**: Automated garbage collection, system optimization

## 🔧 Customization

### Adding New Packages

**System packages** (available to all users):
Add to `hosts/common/common-packages.nix`

**User packages** (home-manager):
Add to `home/adi.nix` in the home-manager configuration

**GUI applications**:
Add to `hosts/common/darwin-common.nix` in the homebrew section

### Adding New Hosts

1. Create a new directory under `hosts/darwin/your-hostname/`
2. Add a `default.nix` with host-specific configuration
3. Add the host to `flake.nix` in `darwinConfigurations`

### Shell Aliases

Edit the `shellAliases` section in `home/adi.nix`:

```nix
programs.fish = {
  shellAliases = {
    # Your custom aliases here
    myalias = "my command";
  };
};
```

## 🔄 Backup and Recovery

### Creating Backups
```bash
just backup  # Creates timestamped backup in home directory
```

### Recovery
If something breaks:
```bash
just rollback  # Rollback to previous generation
```

## 📚 Learning Resources

- [Nix Darwin Documentation](https://github.com/LnL7/nix-darwin)
- [Home Manager Options](https://nix-community.github.io/home-manager/options.html)
- [Nixpkgs Manual](https://nixos.org/manual/nixpkgs/stable/)
- [Nix Language Guide](https://nix.dev/manual/nix/2.18/language/index.html)

## 🚨 Troubleshooting

### Common Issues

**Build fails after macOS update:**
```bash
just update
just switch
```

**Homebrew conflicts:**
```bash
brew uninstall --cask <conflicting-app>
just switch
```

**Permission issues:**
```bash
sudo chown -R $(whoami) /etc/nix-darwin
```

### Getting Help

1. Check the build output for specific errors
2. Use `just doctor` to diagnose common issues
3. Search [Nix Darwin Issues](https://github.com/LnL7/nix-darwin/issues)
4. Ask on [NixOS Discourse](https://discourse.nixos.org/)

## 📝 TODO

- [ ] Add secrets management with sops-nix
- [ ] Set up automatic system updates
- [ ] Add more development environments
- [ ] Create dotfiles for additional tools
- [ ] Add system monitoring and logging

## 🤝 Contributing

This is a personal configuration, but feel free to:
- Use it as inspiration for your own setup
- Suggest improvements via issues
- Share your own configurations

## 📄 License

This configuration is provided as-is under the MIT license. Use at your own risk.
