{ pkgs, unstablePkgs, ... }:
{
  # User packages - tools and applications for development and daily use
  home.packages = with unstablePkgs; [
    # Development tools
    helix
    just
    # htop
    # fd
    # ripgrep
    # dust
    # duf
    # btop
    tree
    # jq
    # yq
    # gh


    # Language Servers
    nixd

    # File utilities
    zathura
    # unzip
    # p7zip

    # Network tools
    # curl
    # wget

    # Version control
    git

    # GUI Applications (these will be linked to /Applications/Nix Apps)
    kitty
    aerospace
    iina

    scdl
  ];
}
