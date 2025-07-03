# 🍎 adi's `nix-darwin` flake

> *Clean, modular macOS system configuration using nix-darwin + home-manager*

## 🏗️ Flake Architecture

This configuration follows a **modular, composable design** that separates concerns and maximizes reusability.

### 📦 Flake Structure

```nix
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  nix-darwin.url = "github:LnL7/nix-darwin/master";
  home-manager.url = "github:nix-community/home-manager/master";
  mac-app-util.url = "github:hraban/mac-app-util";
};

outputs = { ... }: {
  darwinConfigurations."Adis-MacBook-Air" = lib.mkDarwin {
    hostname = "Adis-MacBook-Air";
    username = "adi";
    system = "aarch64-darwin";
  };
};
```

### 🧩 Module System

```
├── 🛠️  lib/helpers.nix       → mkDarwin() system builder
├── 📦 modules/               → Composable components
│   ├── darwin/              → 🖥️  System-level (fonts, homebrew, nix, system)
│   └── home-manager/        → 🏠 User-level (packages, programs, dotfiles)
├── 💻 hosts/                → Machine-specific overrides
└── ⚙️  home/                → Dotfiles and user configurations
```

## 🔧 Design Principles

### **🧩 Modular Composition**
Each module handles one concern:
- `modules/darwin/nix.nix` → Nix daemon configuration
- `modules/darwin/system.nix` → macOS system defaults
- `modules/home-manager/packages.nix` → User package definitions

### **🔄 Layered Configuration**
Configuration flows in layers with clear override hierarchy:
```
Common Base → Darwin Modules → Host Specific → User Config
```

### **⚡ Single Entry Point**
Everything flows through `lib/helpers.nix::mkDarwin()`:
```nix
mkDarwin = { hostname, username, system }: 
  nix-darwin.lib.darwinSystem {
    modules = [
      # Inline system configuration
      # Host-specific overrides  
      # Home Manager integration
    ];
  };
```

### **🎯 Inline vs External Modules**
**Inline Configuration**: Core system settings embedded directly in `helpers.nix` to avoid Nix store path issues

**External Modules**: Host-specific and user customizations in separate files for maintainability

## 📁 Directory Design

### **`lib/` - Builder Functions**
- `helpers.nix` → Core system builder with inline configuration
- `default.nix` → Library exports and utilities

### **`modules/` - Reusable Components**
- **darwin/** → System-level modules (fonts, homebrew, etc.)
- **home-manager/** → User environment modules (packages, programs)

### **`hosts/` - Machine Configurations**
- **common/** → Shared host settings
- **darwin/Adis-MacBook-Air/** → This machine's specific tweaks

### **`home/` - User Environment**
- **users/adi.nix** → User-specific settings
- **[app-dirs]/** → Application dotfiles and configs

## ⚡ Quick Commands

```bash
# Core workflow
just switch    # Apply configuration changes
just build     # Test build without applying
just check     # Validate flake syntax
just update    # Update all inputs

# Maintenance  
just cleanup   # Clean old generations
just diff      # Show what would change
just rollback  # Revert to previous generation

# Development
just fmt       # Format all .nix files
just dev       # Enter development shell
```

## 🔄 Configuration Flow

```
1. flake.nix → Entry point, defines inputs/outputs
2. lib/helpers.nix → mkDarwin() builds complete system
3. Inline config → Core system settings (users, nix, fonts, etc.)
4. hosts/darwin/Adis-MacBook-Air/ → Machine-specific overrides
5. Home Manager → User environment with dotfile management
```

## 🎯 Customization Points

| **What** | **Where** | **Why** |
|----------|-----------|---------|
| Add packages | `modules/home-manager/packages.nix` | User-level packages |
| System tweaks | `hosts/darwin/Adis-MacBook-Air/` | Machine-specific |
| Dotfiles | `home/[app]/` | Application configurations |
| Core system | `lib/helpers.nix` | Fundamental system settings |

## 🧪 Testing Strategy

```bash
# Always test before applying
just build     # Verify configuration builds
just check     # Validate flake structure
just switch    # Apply if tests pass
```

## 🔮 Extensibility

This flake design supports:
- **Multiple machines** → Add to `hosts/darwin/`
- **Multiple users** → Add to `home/users/`
- **Cross-platform** → Add `hosts/nixos/` for Linux
- **Custom overlays** → Extend `lib/default.nix`

---

*Architecture focused on **composability**, **maintainability**, and **reproducibility***
