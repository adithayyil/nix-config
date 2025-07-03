{ lib, ... }:
{
  # Shell configuration
  programs.fish.enable = true;
  programs.zsh.enable = true;

  # System state version
  system.stateVersion = 5;

  # Default macOS system settings
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      showhidden = true;
      mineffect = "genie";
      launchanim = true;
      show-process-indicators = true;
      tilesize = 30;
      static-only = true;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      CreateDesktop = false; # Don't show icons on desktop
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "clmv"; # Column view
      FXDefaultSearchScope = "SCcf"; # Search current folder
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };


    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;

      # Disable auto-corrections for development
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      # Hide menu bar
      _HIHideMenuBar = true;
    };

    loginwindow = {
      GuestEnabled = false;
      SHOWFULLNAME = false;
    };
  };
}
