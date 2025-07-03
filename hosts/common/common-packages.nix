{ inputs, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Modern CLI tools
    bat          # Better cat
    btop         # Better top
    delta        # Better diff
    du-dust      # Better du
    duf          # Better df
    eza          # Better ls
    fd           # Better find
    fzf          # Fuzzy finder
    git          # Version control
    git-lfs      # Git Large File Storage
    gh           # GitHub CLI
    jq           # JSON processor
    lazygit      # Git TUI
    neovim       # Text editor
    ripgrep      # Better grep
    starship     # Shell prompt
    tmux         # Terminal multiplexer
    wget         # Download tool
    zoxide       # Better cd
    
    # Development tools
    nodejs       # Node.js runtime
    python3      # Python runtime
    rustc        # Rust compiler
    cargo        # Rust package manager
    
    # System tools
    htop         # Process viewer
    tree         # Directory tree
    unzip        # Archive tool
    zip          # Archive tool
    
    # Fonts
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Hack" ]; })
  ];
}
