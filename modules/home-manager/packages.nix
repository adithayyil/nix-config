{ pkgs, unstablePkgs, ... }:

{
  home.packages = with unstablePkgs; [
    # ─── Core Development ──────────────────────────────────────────
    git 
    go
    nodejs_20
    just

    # ─── Editors & Language Support ───────────────────────────────
    helix
    nixd
    tinymist

    # ─── Media & Content Tools ────────────────────────────────────
    ffmpeg_6-full
    scdl
    yt-dlp
    iina

    # ─── Terminal Environment ─────────────────────────────────────
    kitty
    alacritty
    tmux

    # ─── Desktop & Productivity ───────────────────────────────────
    aerospace
    vesktop
    zathura
  ];

  # ─── Font Configuration ───────────────────────────────────────────
  fonts.fontconfig.enable = true;
}
