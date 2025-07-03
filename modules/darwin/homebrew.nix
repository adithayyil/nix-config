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
      "homebrew/cask-fonts"
      "homebrew/services"
    ];

    brews = [
      "mas" # Mac App Store CLI
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
