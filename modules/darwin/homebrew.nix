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
    ];

    # Common casks that work well across machines
    casks = [
    ];

    masApps = {
      # Common Mac App Store apps
      # Add machine-specific apps in host configs
    };
  };
}
