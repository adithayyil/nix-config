{ inputs, outputs, config, lib, hostname, system, username, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  users.users.${username}.home = "/Users/${username}";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    optimise.automatic = true;
    channel.enable = false;
    gc = {
      automatic = true;
      interval = { Hour = 3; Minute = 15; };
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = 5;
  
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "${system}";
  };

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.hack
  ];

  # Shell configuration
  programs.fish.enable = true;
  programs.zsh.enable = true;

  # macOS system settings
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      showhidden = true;
      mineffect = "genie";
      launchanim = true;
      show-process-indicators = true;
      tilesize = 48;
      static-only = true;
    };
    
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      CreateDesktop = false;  # Don't show icons on desktop
    };
    
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };
    
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };
  };

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
      "mas"  # Mac App Store CLI
    ];
    
    casks = [
      #   # Browsers
      #   "firefox"
      #   "google-chrome"
      
      #   # Development
      #   "visual-studio-code"
      #   "iterm2"
      #   "docker"
      
      #   # Productivity
      #   "notion"
      
      #   # Media
      #   "vlc"
      #   "spotify"
      
      #   # Communication
      #   "discord"
      
      #   # Utilities
      #   "the-unarchiver"
      #   "appcleaner"
    ];
    
    masApps = {
    #   "Xcode" = 497799835;
    };
  };
}
