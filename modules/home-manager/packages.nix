{ pkgs, unstablePkgs, ... }:
{
  # User packages
  home.packages = with unstablePkgs; [
    # Development tools
    helix
    just
    tree
    nodejs_20
    go

    # Language Servers
    nixd
    tinymist    

    # File utilities
    zathura
    ffmpeg_6-full

    # Version control
    git

    # GUI Applications
    kitty
    aerospace
    iina
    vesktop

    # Utils
    tmux
    scdl
    yt-dlp
  ];

  # Enable fontconfig for home-manager
  fonts.fontconfig.enable = true;
}
