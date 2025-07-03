{ pkgs, ... }:
{
  system.primaryUser = "adi";

  # MacBook Air specific configurations
  
  # Custom dock configuration for this machine
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Safari.app"
      "/Applications/Visual Studio Code.app"
      "/System/Applications/kitty.app"
      "/Applications/Finder.app"
    ];
  };

  # Machine-specific homebrew casks
  homebrew.casks = [
    # Add any MacBook Air specific apps here
    # "battery-toolkit"  # Battery management for laptops
  ];
}
