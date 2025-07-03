{ pkgs, lib, ... }:
{
  # MacBook Air specific configurations

  # Custom dock configuration for this machine
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Zen.app"
      "/Applications/Visual Studio Code.app"
      "/Applications/Nix Trampolines/kitty.app"
      "/Applications/Spotify.app"
      "/Applications/Finder.app"
    ];
  };

  # MacBook Air specific system preferences
  system.defaults = {
    NSGlobalDomain = {
      # Faster animations for better battery life
      NSWindowResizeTime = 0.001;

      # Faster key repeat for coding (override common config)
      InitialKeyRepeat = lib.mkForce 10;
      KeyRepeat = lib.mkForce 1;
    };

    # Trackpad optimizations for MacBook Air
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
  };

  # Machine-specific homebrew casks for MacBook Air
  homebrew.casks = [
    # Add MacBook Air specific apps here
    # "visual-studio-code"
    # "spotify"
    # "zen-browser"
  ];

  # MacBook Air specific environment variables
  environment.variables = {
    # Optimize for SSD
    HOMEBREW_NO_AUTO_UPDATE = "1"; # Reduce SSD writes

    # Development optimizations for 8GB RAM
    NODE_OPTIONS = "--max-old-space-size=4096";
  };
}
