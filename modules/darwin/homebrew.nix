{ ... }:
{
  # Homebrew configuration
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    taps = [
      # Note: homebrew/cask-fonts and homebrew/services have been deprecated
      # Font casks are now available directly without the tap
      # Services functionality has been integrated into Homebrew core
    ];

    brews = [
      "mas" # Mac App Store CLI
      "blackhole-2ch" # Audio routing
    ];

    # Common casks that work well across machines
    casks = [
      # Development tools that aren't in nixpkgs or work better via Homebrew
      # Add machine-specific casks in host configs
    ];

    masApps = {
      # Common Mac App Store apps
      # Add machine-specific apps in host configs
    };
  };
}
