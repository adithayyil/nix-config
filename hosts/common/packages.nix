{ pkgs, ... }:
{
  # System-level packages - only essential system tools and applications
  # User packages should go in home-manager configuration
  environment.systemPackages = with pkgs; [
    # Essential system tools
    fish
  ];
}
