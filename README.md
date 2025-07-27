# adi's nix-darwin flake

> *Clean, modular macOS system configuration using nix-darwin + home-manager*

## Structure
```
├── lib/helpers.nix # Core system builder
├── modules/
│ ├── darwin/homebrew.nix # System-level modules
│ └── home-manager/ # User-level modules
├── hosts/darwin/ # Machine-specific configs
└── home/ # Dotfiles
```


## Key Design

**System Level** (nix-darwin):
- Fonts, homebrew, system settings
- Inline in `helpers.nix` for reliability
- Uses `specialArgs`

**User Level** (home-manager):  
- Packages, programs, dotfiles
- Separate modules in `modules/home-manager/`
- Uses `extraSpecialArgs`

## Core Builder

```nix
mkDarwin = { hostname, username, system }:
  darwinSystem {
    modules = [
      # Inline system config
      { /* system-level options here */ }

      # Homebrew module
      ./../modules/darwin/homebrew.nix

      # Host-specific config
      hostConfig

      # Home Manager integration
      {
        home-manager = {
          extraSpecialArgs = { inherit inputs outputs unstablePkgs; };
          users.${username} = {
            imports = [ ./../modules/home-manager/default.nix ];
          };
        };
      }
    ];
  };
```

## Commands

```
just switch  # Apply changes
just build   # Test build
just check   # Validate flake
```

## Key Rules

- **System modules** → Import at top level
- **User modules** → Import via `users.${username}.imports`
- **Never mix** → System options in home-manager = error
- **Arguments** → System gets `specialArgs`, HM gets `extraSpecialArgs`